-- ======================================================
-- 07-uji-admin.sql — BONUS: uji role admin
-- Jalankan SETELAH 06-admin.sql. Cara kerja dan keamanannya sama dengan 04-uji-serangan.sql:
-- semua uji berjalan di satu perintah yang di akhir SENGAJA dibatalkan, jadi akun dan data
-- uji tidak pernah tersimpan. Hasilnya muncul sebagai pesan error berjudul "UJI SELESAI".
-- Yang diharapkan: "0 gagal".
--
-- Akun palsu: Andi (user biasa) dan Dewi (admin).
-- ======================================================

do $uji$
declare
  a uuid := 'aaaaaaaa-0000-4000-8000-000000000001';  -- Andi, user biasa
  d uuid := 'dddddddd-0000-4000-8000-000000000004';  -- Dewi, admin
  t        record;
  baris    integer;
  ok       boolean;
  lulus    boolean;
  catatan  text;
  laporan  text := '';
  gagal    integer := 0;
  total    integer := 0;
begin
  -- Persiapan (sebagai admin database): 2 akun palsu, Dewi diangkat jadi admin,
  -- 1 data milik Andi, 1 data bawaan tanpa pemilik
  insert into auth.users (id, email) values (a, 'andi.uji@contoh.test'), (d, 'dewi.uji@contoh.test');
  insert into public.admin (user_id) values (d);
  insert into public.umkm (nama, kategori, alamat, jam, wa, foto, user_id, dibuat_oleh)
    values ('UJI-A1', 'Kuliner', 'alamat', 'jam', '0800', 'https://contoh.test/x.jpg', a, 'andi.uji');
  insert into public.umkm (nama, kategori, alamat, jam, wa, foto)
    values ('UJI-BAWAAN', 'Kuliner', 'alamat', 'jam', '0800', 'https://contoh.test/x.jpg');

  -- sebagai : anon = pengunjung, authenticated = user login, pemeriksa = admin database (hanya untuk memeriksa)
  -- harapan : ditolak = harus error | nol = tidak error tapi 0 baris berubah | sukses = minimal 1 baris
  --           benar = query pemeriksa harus bernilai true | bebas = boleh ditolak atau berhasil
  for t in
    select * from (values
      -- ----- Tabel admin harus tertutup -----
      (1,  'Pengunjung membaca tabel admin',              'anon', null, $q$select * from public.admin$q$, 'ditolak'),
      (2,  'Pengunjung memanggil is_admin() lewat API',   'anon', null, $q$select public.is_admin()$q$, 'ditolak'),
      (3,  'Andi membaca tabel admin',                    'authenticated', a, $q$select * from public.admin$q$, 'ditolak'),
      (4,  'Andi mengangkat dirinya jadi admin',          'authenticated', a, $q$insert into public.admin (user_id) values ('aaaaaaaa-0000-4000-8000-000000000001')$q$, 'ditolak'),
      (5,  'Andi bertanya is_admin(): harus false',       'authenticated', a, $q$select not public.is_admin()$q$, 'benar'),
      (6,  'Dewi bertanya is_admin(): harus true',        'authenticated', d, $q$select public.is_admin()$q$, 'benar'),
      -- ----- User biasa tetap terbatas -----
      (7,  'Andi mengubah data miliknya (harus bisa)',    'authenticated', a, $q$update public.umkm set jam = 'jam baru' where nama = 'UJI-A1'$q$, 'sukses'),
      (8,  'Andi mengubah data bawaan tanpa pemilik',     'authenticated', a, $q$update public.umkm set nama = 'DIRETAS' where nama = 'UJI-BAWAAN'$q$, 'nol'),
      (9,  'Andi menghapus data bawaan tanpa pemilik',    'authenticated', a, $q$delete from public.umkm where nama = 'UJI-BAWAAN'$q$, 'nol'),
      -- ----- Admin boleh mengubah semua -----
      (10, 'Dewi (admin) mengubah data milik Andi',       'authenticated', d, $q$update public.umkm set nama = 'UJI-A1 diedit-admin' where nama = 'UJI-A1'$q$, 'sukses'),
      (11, 'Hasil uji 10: pemilik dan pembuat tetap Andi', 'pemeriksa', null, $q$select user_id = 'aaaaaaaa-0000-4000-8000-000000000001' and dibuat_oleh = 'andi.uji' from public.umkm where nama = 'UJI-A1 diedit-admin'$q$, 'benar'),
      (12, 'Dewi mengubah data bawaan tanpa pemilik',     'authenticated', d, $q$update public.umkm set jam = 'jam admin' where nama = 'UJI-BAWAAN'$q$, 'sukses'),
      (13, 'Dewi mencoba mengalihkan data Andi jadi miliknya', 'authenticated', d, $q$update public.umkm set user_id = 'dddddddd-0000-4000-8000-000000000004' where nama = 'UJI-A1 diedit-admin'$q$, 'bebas'),
      (14, 'Hasil uji 13: data tetap milik Andi',         'pemeriksa', null, $q$select user_id = 'aaaaaaaa-0000-4000-8000-000000000001' from public.umkm where nama = 'UJI-A1 diedit-admin'$q$, 'benar'),
      -- ----- Admin boleh menghapus semua -----
      (15, 'Dewi menghapus data milik Andi',              'authenticated', d, $q$delete from public.umkm where nama = 'UJI-A1 diedit-admin'$q$, 'sukses'),
      (16, 'Dewi menghapus data bawaan tanpa pemilik',    'authenticated', d, $q$delete from public.umkm where nama = 'UJI-BAWAAN'$q$, 'sukses'),
      -- ----- Batas 20 data: user biasa kena, admin bebas -----
      (17, 'Dewi (admin) menambah 25 data (tanpa batas)', 'authenticated', d, $q$insert into public.umkm (nama,kategori,alamat,jam,wa,foto,user_id) select 'UJI-D'||g,'Kuliner','a','b','c','https://contoh.test/x.jpg','dddddddd-0000-4000-8000-000000000004' from generate_series(1,25) g$q$, 'sukses'),
      (18, 'Andi menambah 20 data (batas, harus bisa)',   'authenticated', a, $q$insert into public.umkm (nama,kategori,alamat,jam,wa,foto,user_id) select 'UJI-N'||g,'Kuliner','a','b','c','https://contoh.test/x.jpg','aaaaaaaa-0000-4000-8000-000000000001' from generate_series(1,20) g$q$, 'sukses'),
      (19, 'Andi menambah data ke-21',                    'authenticated', a, $q$insert into public.umkm (nama,kategori,alamat,jam,wa,foto,user_id) values ('UJI-N21','Kuliner','a','b','c','https://contoh.test/x.jpg','aaaaaaaa-0000-4000-8000-000000000001')$q$, 'ditolak'),
      (20, 'Andi menghapus data milik Dewi',             'authenticated', a, $q$delete from public.umkm where nama like 'UJI-D%'$q$, 'nol')
    ) as v(no, uji, sebagai, akun, perintah, harapan)
    order by no
  loop
    total := total + 1;
    lulus := false;
    catatan := '';

    -- Berpura-pura menjadi pengguna: atur role dan "token login" (claims)
    perform set_config('request.jwt.claims',
      case when t.akun is null then '' else json_build_object('sub', t.akun, 'role', t.sebagai)::text end, true);
    perform set_config('request.jwt.claim.sub', coalesce(t.akun::text, ''), true);
    if t.sebagai <> 'pemeriksa' then
      execute format('set local role %I', t.sebagai);
    end if;

    begin
      if t.harapan = 'benar' then
        execute t.perintah into ok;
        lulus := coalesce(ok, false);
        catatan := case when lulus then '' else 'nilai pemeriksa false' end;
      else
        execute t.perintah;
        get diagnostics baris = row_count;
        if t.harapan = 'ditolak' then
          lulus := false; catatan := 'perintah malah berhasil';
        elsif t.harapan = 'nol' then
          lulus := (baris = 0); catatan := baris || ' baris ikut berubah';
        elsif t.harapan = 'bebas' then
          lulus := true;
        else
          lulus := (baris >= 1); catatan := 'tidak ada baris';
        end if;
        if lulus then catatan := ''; end if;
      end if;
    exception when others then
      if t.harapan in ('ditolak', 'bebas') then
        lulus := true;
        catatan := 'ditolak: ' || left(sqlerrm, 60);
      else
        lulus := false;
        catatan := 'error tak terduga: ' || left(sqlerrm, 60);
      end if;
    end;

    reset role;
    if not lulus then gagal := gagal + 1; end if;
    laporan := laporan || format(E'\n%s  #%s  %s%s',
      case when lulus then 'LULUS' else 'GAGAL' end, t.no, t.uji,
      case when catatan = '' then '' else '  [' || catatan || ']' end);
  end loop;

  -- Pesan error ini DISENGAJA: membatalkan seluruh akun dan data uji supaya database tetap bersih.
  raise exception E'UJI SELESAI (data uji dibatalkan, ini bukan kegagalan)\n%\n\nTOTAL: % uji, % gagal', laporan, total, gagal;
end;
$uji$;
