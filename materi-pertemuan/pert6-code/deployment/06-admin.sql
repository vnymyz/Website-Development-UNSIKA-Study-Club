-- ======================================================
-- 06-admin.sql — BONUS: role admin
-- Admin boleh mengubah dan menghapus SEMUA data. User biasa tetap hanya data miliknya.
-- Jalankan SEKALI di Supabase > SQL Editor, SETELAH 01 atau 02.
-- Aman dijalankan ulang, dan TIDAK menghapus data.
--
-- Cara kerjanya:
--   1. Tabel "admin" berisi daftar id user yang jadi admin.
--      Tabel ini tertutup dari API, jadi user biasa tidak bisa menambah dirinya sendiri.
--   2. Fungsi is_admin() menjawab: "apakah user yang sedang login adalah admin?"
--   3. Policy ubah dan hapus diperluas: pemilik data ATAU admin.
--   4. Admin dikecualikan dari batas 20 data per akun.
--   5. Cara mengangkat akun jadi admin ada di bagian paling bawah.
-- ======================================================

-- ---------- 1. Tabel admin ----------
create table if not exists public.admin (
  user_id uuid primary key references auth.users (id) on delete cascade
);

-- RLS aktif dan sengaja TANPA policy = tidak ada yang bisa membaca atau menulis lewat API.
-- Isinya hanya bisa diubah dari SQL Editor (kamu sebagai pemilik project).
alter table public.admin enable row level security;
revoke all on public.admin from anon, authenticated;

-- ---------- 2. Fungsi is_admin() ----------
-- "security definer" dipakai supaya fungsi ini bisa membaca tabel admin yang tertutup.
-- "stable" artinya hasilnya tidak berubah dalam satu perintah, jadi database boleh menghemat panggilan.
create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (select 1 from public.admin where user_id = (select auth.uid()));
$$;

-- Hanya user yang login yang boleh bertanya "apakah saya admin?". Pengunjung tidak.
revoke execute on function public.is_admin() from public, anon;
grant execute on function public.is_admin() to authenticated;

-- ---------- 3. Policy ubah dan hapus: pemilik ATAU admin ----------
drop policy if exists "umkm pemilik boleh mengubah" on public.umkm;
create policy "umkm pemilik boleh mengubah"
  on public.umkm for update to authenticated
  using (user_id = (select auth.uid()) or public.is_admin())
  with check (user_id = (select auth.uid()) or public.is_admin());

drop policy if exists "umkm pemilik boleh menghapus" on public.umkm;
create policy "umkm pemilik boleh menghapus"
  on public.umkm for delete to authenticated
  using (user_id = (select auth.uid()) or public.is_admin());

-- Policy tambah (insert) tidak berubah: siapa pun yang login hanya bisa menambah atas namanya sendiri.

-- ---------- 4. Trigger: admin bebas dari batas 20 data ----------
-- Fungsi yang sama dengan di 02-supabase-secure.sql, ditambah satu pengecualian untuk admin.
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
  -- auth.uid() kosong kalau dijalankan dari SQL Editor (kamu sebagai admin database)
  if auth.uid() is null then
    return new;
  end if;

  if tg_op = 'INSERT' then
    -- Batas jumlah data per akun, kecuali admin
    if not public.is_admin() then
      select count(*) into jumlah from public.umkm where user_id = auth.uid();
      if jumlah >= 20 then
        raise exception 'Batas 20 UMKM per akun sudah tercapai.';
      end if;
    end if;

    select email into email_user from auth.users where id = auth.uid();
    new.user_id     := auth.uid();
    new.dibuat_oleh := split_part(coalesce(email_user, 'pengguna'), '@', 1);
  else
    -- Saat mengubah, pemilik dan nama pembuat tidak boleh berganti.
    -- Berlaku juga untuk admin: admin mengedit data orang lain, tapi data itu tetap milik pembuatnya.
    new.user_id     := old.user_id;
    new.dibuat_oleh := old.dibuat_oleh;
  end if;

  return new;
end;
$$;

-- ---------- 5. Mengangkat akun jadi admin ----------
-- Langkah: (1) daftar dulu lewat aplikasi dengan emailmu, (2) ganti email di bawah,
-- (3) hapus tanda "--" di depan baris insert, lalu Run.
--
-- insert into public.admin (user_id)
-- select id from auth.users where email = 'emailkamu@contoh.com'
-- on conflict do nothing;

-- Mencabut status admin:
-- delete from public.admin
-- where user_id = (select id from auth.users where email = 'emailkamu@contoh.com');

-- Melihat siapa saja admin sekarang:
select u.email as admin_saat_ini
from public.admin a
join auth.users u on u.id = a.user_id;
