-- ======================================================
-- 03-cek-keamanan.sql — audit keamanan database (HANYA MEMBACA)
-- Jalankan kapan saja di Supabase > SQL Editor (setelah pertemuan 5). Tidak mengubah data apa pun.
-- Hasilnya satu tabel: tiap baris = satu pemeriksaan.
--   status AMAN    = sesuai harapan
--   status PERIKSA = ada yang perlu dibenahi (lihat kolom hasil)
--   status INFO    = hanya informasi, bukan masalah
-- ======================================================

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
