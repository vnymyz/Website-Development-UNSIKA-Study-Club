-- ======================================================
-- 02-supabase-secure.sql — pengaman tambahan untuk project yang SUDAH jalan
-- Jalankan SEKALI di Supabase > SQL Editor, setelah script pertemuan 4 dan 5.
-- Aman dijalankan ulang, dan TIDAK menghapus data.
--
-- Isinya:
--   1. Batas panjang dan format isian (nama, alamat, jam, wa, foto, kategori)
--   2. user_id terisi otomatis dengan id user yang login
--   3. dibuat_oleh diisi otomatis oleh database, jadi tidak bisa dipalsukan
--   4. Batas 20 UMKM per akun, supaya katalog tidak dibanjiri spam
--
-- Kalau project Supabase-mu baru dan masih kosong, pakai 01-supabase-lengkap.sql saja.
-- ======================================================

-- ---------- 1. Batas isian ----------
-- "not valid" artinya aturan berlaku untuk data BARU. Data lama tidak diperiksa,
-- jadi script tidak gagal kalau ada data lama yang tidak sesuai.
alter table public.umkm drop constraint if exists umkm_panjang_isian;
alter table public.umkm
  add constraint umkm_panjang_isian check (
    char_length(nama)   between 1 and 100 and
    char_length(alamat) between 1 and 200 and
    char_length(jam)    between 1 and 50  and
    char_length(wa)     between 1 and 20  and
    char_length(foto)   between 1 and 500
  ) not valid;

-- Foto wajib link https (menolak javascript:, data:, dan sejenisnya).
alter table public.umkm drop constraint if exists umkm_foto_https;
alter table public.umkm
  add constraint umkm_foto_https check (foto ~* '^https://') not valid;

-- Kategori hanya tiga pilihan yang ada di form.
alter table public.umkm drop constraint if exists umkm_kategori_valid;
alter table public.umkm
  add constraint umkm_kategori_valid check (kategori in ('Kuliner', 'Fashion', 'Kerajinan')) not valid;

-- ---------- 2. user_id otomatis ----------
-- Kalau user_id tidak dikirim, database mengisinya dengan id user yang login.
alter table public.umkm alter column user_id set default auth.uid();

-- ---------- 3. Trigger pengaman ----------
-- Trigger = fungsi yang dijalankan database otomatis SEBELUM baris disimpan.
-- Ini berjalan di database, jadi tidak bisa dilewati lewat browser atau API.
-- "security definer" dipakai karena fungsi ini perlu membaca tabel auth.users.
create or replace function public.umkm_amankan()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  email_user text;
  jumlah     integer;
begin
  -- auth.uid() kosong kalau perintah dijalankan dari SQL Editor (kamu sebagai admin).
  -- Di kasus itu aturan di bawah dilewati. Lewat API, auth.uid() selalu terisi.
  if auth.uid() is null then
    return new;
  end if;

  if tg_op = 'INSERT' then
    -- Batas jumlah data per akun
    select count(*) into jumlah from public.umkm where user_id = auth.uid();
    if jumlah >= 20 then
      raise exception 'Batas 20 UMKM per akun sudah tercapai.';
    end if;

    -- Pemilik dan nama pembuat diisi database, bukan dari kiriman browser
    select email into email_user from auth.users where id = auth.uid();
    new.user_id     := auth.uid();
    new.dibuat_oleh := split_part(coalesce(email_user, 'pengguna'), '@', 1);
  else
    -- Saat mengubah data, pemilik dan nama pembuat tidak boleh berganti
    new.user_id     := old.user_id;
    new.dibuat_oleh := old.dibuat_oleh;
  end if;

  return new;
end;
$$;

-- Fungsi ini hanya boleh dipanggil sebagai trigger, bukan lewat API.
revoke execute on function public.umkm_amankan() from public, anon, authenticated;

drop trigger if exists umkm_amankan on public.umkm;
create trigger umkm_amankan
  before insert or update on public.umkm
  for each row execute function public.umkm_amankan();

-- ---------- Selesai ----------
-- Cek hasilnya dengan 03-cek-keamanan.sql (semua baris harus AMAN atau INFO).
