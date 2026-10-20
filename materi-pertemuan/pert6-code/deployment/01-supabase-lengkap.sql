-- ======================================================
-- 01-supabase-lengkap.sql — SATU script untuk SEMUA setup database
-- Jalankan SEKALI di Supabase > SQL Editor, lalu klik Run.
--
-- Isinya (urut):
--   1. Tabel umkm
--   2. RLS (Row Level Security) dan 4 policy
--   3. Role admin: admin boleh ubah/hapus semua data, user biasa hanya miliknya
--   4. 6 data awal
--   5. Pengaman: batas panjang isian, dibuat_oleh otomatis, batas 20 data per akun
--   6. Mengangkat emailmu jadi admin (GANTI email di bagian 6)
--   7. Hasil audit keamanan (tabel hasil di bagian bawah, semua harus AMAN atau INFO)
--
-- PERHATIAN: script ini menghapus tabel "umkm" lama beserta isinya (juga tabel admin lama).
-- Akun login (Authentication > Users) TIDAK ikut terhapus.
-- Aman dijalankan ulang kapan pun, hasilnya selalu kembali ke kondisi awal yang sama.
-- ======================================================

-- ---------- 1. Tabel ----------
drop table if exists public.umkm;
drop table if exists public.admin;

create table public.umkm (
  id          bigint generated always as identity primary key, -- nomor otomatis 1, 2, 3, ...
  created_at  timestamptz not null default now(),              -- waktu dibuat, diisi otomatis
  nama        text not null,
  kategori    text not null,
  alamat      text not null,
  jam         text not null,
  wa          text not null,
  foto        text not null,
  dibuat_oleh text not null default 'sistem',                  -- diisi otomatis oleh trigger
  -- id pemilik data (dari Supabase Auth). Kosong = data bawaan "milik sistem".
  user_id     uuid default auth.uid() references auth.users (id) on delete set null
);

-- ---------- 2. Row Level Security (RLS) ----------
-- Setelah ini tabel DITUTUP untuk semua orang, kecuali ada policy yang mengizinkan.
alter table public.umkm enable row level security;

-- ---------- 3a. Role admin: tabel daftar admin ----------
-- Isinya id user yang jadi admin. RLS aktif dan sengaja TANPA policy,
-- jadi tidak ada yang bisa membaca atau menulis lewat API. Hanya bisa diubah dari SQL Editor.
create table public.admin (
  user_id uuid primary key references auth.users (id) on delete cascade
);
alter table public.admin enable row level security;
revoke all on public.admin from anon, authenticated;

-- ---------- 3b. Role admin: fungsi is_admin() ----------
-- Menjawab: "apakah user yang sedang login adalah admin?"
-- "security definer" dipakai supaya fungsi ini bisa membaca tabel admin yang tertutup.
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

-- ---------- 3c. Policy tabel umkm ----------
-- Baca: semua orang, baik belum login (anon) maupun sudah login (authenticated).
create policy "umkm boleh dibaca"
  on public.umkm for select to anon, authenticated
  using (true);

-- Tambah: hanya yang login, dan baris harus atas nama user itu sendiri.
-- auth.uid() = id user yang sedang login (dibaca dari token login yang sudah diverifikasi).
create policy "umkm login boleh menambah"
  on public.umkm for insert to authenticated
  with check (user_id = (select auth.uid()));

-- Ubah: pemilik baris ATAU admin.
-- "using" memeriksa baris lama, "with check" memeriksa hasil ubahannya.
create policy "umkm pemilik boleh mengubah"
  on public.umkm for update to authenticated
  using (user_id = (select auth.uid()) or public.is_admin())
  with check (user_id = (select auth.uid()) or public.is_admin());

-- Hapus: pemilik baris ATAU admin.
create policy "umkm pemilik boleh menghapus"
  on public.umkm for delete to authenticated
  using (user_id = (select auth.uid()) or public.is_admin());

-- ---------- 4. Data awal: 6 UMKM ----------
-- Data bawaan tidak punya pemilik (user_id kosong): hanya admin yang bisa mengubah atau menghapusnya.
insert into public.umkm (nama, kategori, alamat, jam, wa, foto) values
  ('Warung Bu Sari', 'Kuliner', 'Jl. Merdeka No. 10, Karawang', 'Buka 07.00 – 21.00', '0812-3456-7810',
   'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&q=60&auto=format&fit=crop'),
  ('Batik Karawang Asli', 'Fashion', 'Jl. Kertabumi No. 5, Karawang', 'Buka 09.00 – 17.00', '0813-2345-6705',
   'https://images.unsplash.com/photo-1761515315375-1315503bb3ce?w=400&q=60&auto=format&fit=crop'),
  ('Anyaman Bambu Pak Jaya', 'Kerajinan', 'Jl. Tuparev No. 22, Karawang', 'Buka 08.00 – 16.00', '0857-1234-9902',
   'https://images.unsplash.com/photo-1696574727184-a8cdb758d3bf?w=400&q=60&auto=format&fit=crop'),
  ('Kopi Rawa Gede', 'Kuliner', 'Jl. Ahmad Yani No. 3, Karawang', 'Buka 10.00 – 23.00', '0821-9988-2214',
   'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&q=60&auto=format&fit=crop'),
  ('Konveksi Sinar Tani', 'Fashion', 'Jl. Pangkal Perjuangan No. 18, Karawang', 'Buka 08.00 – 17.00', '0838-4567-3321',
   'https://images.unsplash.com/photo-1445205170230-053b83016050?w=400&q=60&auto=format&fit=crop'),
  ('Gerabah Cikampek', 'Kerajinan', 'Jl. Ir. H. Juanda No. 45, Karawang', 'Buka 08.00 – 16.00', '0896-7712-0043',
   'https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=400&q=60&auto=format&fit=crop');

-- ---------- 5a. Batas isian ----------
-- Aturan ini berlaku untuk semua data, termasuk 6 data awal di atas.
alter table public.umkm
  add constraint umkm_panjang_isian check (
    char_length(nama)   between 1 and 100 and
    char_length(alamat) between 1 and 200 and
    char_length(jam)    between 1 and 50  and
    char_length(wa)     between 1 and 20  and
    char_length(foto)   between 1 and 500
  );

-- Foto wajib link https (menolak javascript:, data:, dan sejenisnya).
alter table public.umkm
  add constraint umkm_foto_https check (foto ~* '^https://');

-- Kategori hanya tiga pilihan yang ada di form.
alter table public.umkm
  add constraint umkm_kategori_valid check (kategori in ('Kuliner', 'Fashion', 'Kerajinan'));

-- ---------- 5b. Trigger pengaman ----------
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
  -- auth.uid() kosong kalau perintah dijalankan dari SQL Editor (kamu sebagai admin database).
  -- Di kasus itu aturan di bawah dilewati. Lewat API, auth.uid() selalu terisi.
  if auth.uid() is null then
    return new;
  end if;

  if tg_op = 'INSERT' then
    -- Batas jumlah data per akun (admin dikecualikan)
    if not public.is_admin() then
      select count(*) into jumlah from public.umkm where user_id = auth.uid();
      if jumlah >= 20 then
        raise exception 'Batas 20 UMKM per akun sudah tercapai.';
      end if;
    end if;

    -- Pemilik dan nama pembuat diisi database, bukan dari kiriman browser
    select email into email_user from auth.users where id = auth.uid();
    new.user_id     := auth.uid();
    new.dibuat_oleh := split_part(coalesce(email_user, 'pengguna'), '@', 1);
  else
    -- Saat mengubah data, pemilik dan nama pembuat tidak boleh berganti.
    -- Berlaku juga untuk admin: admin mengedit data orang lain, tapi data itu tetap milik pembuatnya.
    new.user_id     := old.user_id;
    new.dibuat_oleh := old.dibuat_oleh;
  end if;

  return new;
end;
$$;

-- Fungsi ini hanya boleh dipanggil sebagai trigger, bukan lewat API.
revoke execute on function public.umkm_amankan() from public, anon, authenticated;

create trigger umkm_amankan
  before insert or update on public.umkm
  for each row execute function public.umkm_amankan();

-- ---------- 6. Angkat emailmu jadi admin ----------
-- GANTI 'GANTI-DENGAN-EMAILMU@contoh.com' dengan email akun yang kamu pakai login.
-- Akunnya harus sudah terdaftar (Authentication > Users). Kalau belum, daftar dulu lewat
-- aplikasi, lalu jalankan SELURUH script ini lagi, atau cukup jalankan baris insert ini saja.
-- Kalau emailnya tidak ditemukan, tidak terjadi apa-apa dan tidak ada error.
insert into public.admin (user_id)
select id from auth.users where email = 'mayazurav@gmail.com'
on conflict do nothing;

-- Mencabut status admin (hapus tanda -- di depan kalau mau dipakai):
-- delete from public.admin
-- where user_id = (select id from auth.users where email = 'emailkamu@contoh.com');

-- ---------- 7. Audit keamanan (hanya membaca) ----------
-- Hasil terakhir ini yang tampil di bawah SQL Editor.
-- Tiap baris = satu pemeriksaan. AMAN = sesuai harapan, PERIKSA = perlu dibenahi, INFO = informasi.

select * from (

  -- 1. Tabel di schema public yang RLS-nya belum aktif (RLS mati = tabel terbuka untuk siapa saja yang punya key)
  select 1 as no, 'RLS aktif di semua tabel public' as pemeriksaan,
    coalesce((select string_agg(tablename, ', ') from pg_tables
              where schemaname = 'public' and rowsecurity = false), 'semua tabel aktif') as hasil,
    case when exists (select 1 from pg_tables where schemaname = 'public' and rowsecurity = false)
         then 'PERIKSA' else 'AMAN' end as status

  union all
  -- 2. Tabel umkm harus punya tepat 4 policy: select, insert, update, delete
  select 2, 'Tabel umkm punya 4 policy',
    (select count(*) from pg_policies where schemaname = 'public' and tablename = 'umkm')::text || ' policy',
    case when (select count(*) from pg_policies where schemaname = 'public' and tablename = 'umkm') = 4
         then 'AMAN' else 'PERIKSA' end

  union all
  -- 3. Pengunjung belum login (anon) hanya boleh membaca, tidak boleh menulis
  select 3, 'Policy tulis untuk anon / public (harus 0)',
    coalesce((select string_agg(policyname, ', ') from pg_policies
              where schemaname = 'public' and tablename = 'umkm' and cmd <> 'SELECT'
                and roles::text ~ '(anon|public)'), '0'),
    case when exists (select 1 from pg_policies where schemaname = 'public' and tablename = 'umkm'
                      and cmd <> 'SELECT' and roles::text ~ '(anon|public)')
         then 'PERIKSA' else 'AMAN' end

  union all
  -- 4. Policy tulis tidak boleh "using (true)" / "with check (true)" (artinya semua orang lolos)
  select 4, 'Policy tulis yang meloloskan semua orang (harus 0)',
    coalesce((select string_agg(policyname, ', ') from pg_policies
              where schemaname = 'public' and tablename = 'umkm' and cmd <> 'SELECT'
                and (qual = 'true' or with_check = 'true')), '0'),
    case when exists (select 1 from pg_policies where schemaname = 'public' and tablename = 'umkm'
                      and cmd <> 'SELECT' and (qual = 'true' or with_check = 'true'))
         then 'PERIKSA' else 'AMAN' end

  union all
  -- 5. Insert, update, delete harus memeriksa pemilik lewat auth.uid() (3 policy)
  select 5, 'Insert/update/delete memeriksa pemilik (auth.uid())',
    (select count(*) from pg_policies where schemaname = 'public' and tablename = 'umkm'
       and cmd in ('INSERT', 'UPDATE', 'DELETE')
       and (coalesce(qual, '') || coalesce(with_check, '')) like '%auth.uid()%')::text || ' dari 3 policy',
    case when (select count(*) from pg_policies where schemaname = 'public' and tablename = 'umkm'
                 and cmd in ('INSERT', 'UPDATE', 'DELETE')
                 and (coalesce(qual, '') || coalesce(with_check, '')) like '%auth.uid()%') = 3
         then 'AMAN' else 'PERIKSA' end

  union all
  -- 6. Aturan batas isian (dibuat oleh 02-supabase-secure.sql)
  select 6, 'Constraint batas isian ada (3 constraint)',
    (select count(*) from pg_constraint where conrelid = 'public.umkm'::regclass
       and conname in ('umkm_panjang_isian', 'umkm_foto_https', 'umkm_kategori_valid'))::text || ' dari 3',
    case when (select count(*) from pg_constraint where conrelid = 'public.umkm'::regclass
                 and conname in ('umkm_panjang_isian', 'umkm_foto_https', 'umkm_kategori_valid')) = 3
         then 'AMAN' else 'PERIKSA' end

  union all
  -- 7. Trigger yang mengisi dibuat_oleh otomatis dan membatasi 20 data per akun
  select 7, 'Trigger umkm_amankan terpasang',
    case when exists (select 1 from pg_trigger where tgrelid = 'public.umkm'::regclass
                      and tgname = 'umkm_amankan' and not tgisinternal) then 'ada' else 'tidak ada' end,
    case when exists (select 1 from pg_trigger where tgrelid = 'public.umkm'::regclass
                      and tgname = 'umkm_amankan' and not tgisinternal) then 'AMAN' else 'PERIKSA' end

  union all
  -- 8. Fungsi "security definer" berjalan dengan hak admin, jadi wajib mengunci search_path
  select 8, 'Fungsi security definer tanpa search_path terkunci (harus 0)',
    coalesce((select string_agg(p.proname, ', ') from pg_proc p
              join pg_namespace n on n.oid = p.pronamespace
              where n.nspname = 'public' and p.prosecdef
                and not exists (select 1 from unnest(coalesce(p.proconfig, '{}')) c where c like 'search_path=%')), '0'),
    case when exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace
                      where n.nspname = 'public' and p.prosecdef
                        and not exists (select 1 from unnest(coalesce(p.proconfig, '{}')) c where c like 'search_path=%'))
         then 'PERIKSA' else 'AMAN' end

  union all
  -- 9. Fungsi security definer tidak boleh bisa dipanggil pengunjung lewat API (/rpc)
  select 9, 'Fungsi security definer yang bisa dipanggil anon (harus 0)',
    coalesce((select string_agg(p.proname, ', ') from pg_proc p
              join pg_namespace n on n.oid = p.pronamespace
              where n.nspname = 'public' and p.prosecdef
                and has_function_privilege('anon', p.oid, 'execute')), '0'),
    case when exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace
                      where n.nspname = 'public' and p.prosecdef
                        and has_function_privilege('anon', p.oid, 'execute'))
         then 'PERIKSA' else 'AMAN' end

  union all
  -- 10. View biasa melewati RLS milik tabelnya, jadi view di schema public perlu diperiksa manual
  select 10, 'View / materialized view di schema public (idealnya 0)',
    coalesce((select string_agg(viewname, ', ') from pg_views where schemaname = 'public'), '')
      || coalesce((select string_agg(matviewname, ', ') from pg_matviews where schemaname = 'public'), '') || '0',
    case when exists (select 1 from pg_views where schemaname = 'public')
           or exists (select 1 from pg_matviews where schemaname = 'public')
         then 'PERIKSA' else 'AMAN' end

  union all
  -- 11. Data bawaan tanpa pemilik (user_id kosong) tidak bisa diedit/dihapus lewat aplikasi
  select 11, 'Baris umkm tanpa pemilik',
    (select count(*) from public.umkm where user_id is null)::text || ' baris',
    'INFO'

  union all
  -- 12. Data lama yang tidak memenuhi aturan baru (aman disimpan, tapi ditolak kalau diedit)
  select 12, 'Baris umkm yang melanggar aturan isian',
    (select count(*) from public.umkm
       where char_length(nama) > 100 or char_length(alamat) > 200 or char_length(jam) > 50
          or char_length(wa) > 20 or char_length(foto) > 500
          or foto !~* '^https://' or kategori not in ('Kuliner', 'Fashion', 'Kerajinan'))::text || ' baris',
    'INFO'

  union all
  -- 13. Jumlah akun terdaftar dan yang belum konfirmasi email (lonjakan mendadak = tanda spam)
  select 13, 'Akun terdaftar / belum konfirmasi email',
    (select count(*) from auth.users)::text || ' akun / '
      || (select count(*) from auth.users where email_confirmed_at is null)::text || ' belum konfirmasi',
    'INFO'

  union all
  -- 14. Jumlah data terbanyak yang dimiliki satu akun (batas wajar: 20)
  select 14, 'Data terbanyak milik satu akun',
    coalesce((select max(n) from (select count(*) as n from public.umkm
                                  where user_id is not null group by user_id) x), 0)::text || ' baris',
    case when coalesce((select max(n) from (select count(*) as n from public.umkm
                                            where user_id is not null group by user_id) x), 0) > 20
         then 'PERIKSA' else 'AMAN' end

  union all
  -- 15. Tabel admin (role admin) harus tertutup dari API: RLS aktif dan tanpa policy
  select 15, 'Tabel admin tertutup dari API (RLS aktif, 0 policy)',
    case when to_regclass('public.admin') is null then 'tidak dipasang'
         else (select case when c.relrowsecurity then 'RLS aktif' else 'RLS MATI' end
                      || ', ' || (select count(*) from pg_policies where schemaname = 'public' and tablename = 'admin')::text || ' policy'
               from pg_class c where c.oid = to_regclass('public.admin')) end,
    case when to_regclass('public.admin') is null then 'INFO'
         when (select c.relrowsecurity from pg_class c where c.oid = to_regclass('public.admin'))
              and not exists (select 1 from pg_policies where schemaname = 'public' and tablename = 'admin')
              then 'AMAN' else 'PERIKSA' end

  union all
  -- 16. Jumlah admin. Biasanya 1 atau 2. Lebih banyak dari yang kamu kenal = periksa
  select 16, 'Jumlah akun admin',
    case when to_regclass('public.admin') is null then 'tidak dipasang'
         else (xpath('/row/c/text()', query_to_xml('select count(*) as c from public.admin', false, true, '')))[1]::text || ' akun' end,
    'INFO'

) hasil
order by no;
