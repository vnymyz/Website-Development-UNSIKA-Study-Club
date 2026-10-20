-- ======================================================
-- 04-uji-serangan.sql — simulasi penyerang, lalu cek apakah database menolak
-- Jalankan di Supabase > SQL Editor SETELAH 01 atau 02.
--
-- AMAN untuk data aslimu: semua uji berjalan di dalam satu perintah yang di akhir
-- SENGAJA dibatalkan (raise exception), jadi akun dan data uji tidak pernah tersimpan.
-- Hasilnya muncul sebagai pesan error berjudul "UJI SELESAI" — itu normal, bukan kegagalan.
-- Baca laporannya: tiap baris LULUS atau GAGAL. Yang diharapkan: "0 gagal".
--
-- Cara kerja: skrip membuat 3 akun palsu (Andi, Budi, Citra), lalu berpura-pura jadi
-- pengunjung (anon) atau user login (authenticated) dan mencoba hal-hal yang tidak boleh.
-- ======================================================

do $uji$
declare
  a uuid := 'aaaaaaaa-0000-4000-8000-000000000001';  -- akun palsu Andi
  b uuid := 'bbbbbbbb-0000-4000-8000-000000000002';  -- akun palsu Budi
  c uuid := 'cccccccc-0000-4000-8000-000000000003';  -- akun palsu Citra (untuk uji batas 20)
  t        record;
  sql_uji  text;
  baris    integer;
  ok       boolean;
  lulus    boolean;
  catatan  text;
  laporan  text := '';
  gagal    integer := 0;
  total    integer := 0;
begin
  -- Persiapan (sebagai admin): 3 akun palsu + 1 data bawaan tanpa pemilik
  insert into auth.users (id, email) values
    (a, 'andi.uji@contoh.test'), (b, 'budi.uji@contoh.test'), (c, 'citra.uji@contoh.test');
  insert into public.umkm (nama, kategori, alamat, jam, wa, foto)
    values ('UJI-BAWAAN', 'Kuliner', 'alamat', 'jam', '0800', 'https://contoh.test/x.jpg');

  -- Daftar uji: (no, uji, sebagai, akun, perintah, harapan)
  --   sebagai : anon = pengunjung, authenticated = user login, admin = pemeriksa
  --   harapan : ditolak = harus error | nol = tidak error tapi 0 baris berubah
  --             sukses = minimal 1 baris | benar = query pemeriksa harus bernilai true
  --             bebas = boleh ditolak atau berhasil (hasilnya diperiksa uji berikutnya)
  for t in
    select * from (values
      -- ----- Pengunjung belum login -----
      (1,  'Pengunjung menambah data',                   'anon', null, $q$insert into public.umkm (nama,kategori,alamat,jam,wa,foto) values ('UJI-1','Kuliner','a','b','c','https://contoh.test/x.jpg')$q$, 'ditolak'),
      (2,  'Pengunjung mengubah semua data',             'anon', null, $q$update public.umkm set nama = 'DIRETAS'$q$, 'nol'),
      (3,  'Pengunjung menghapus semua data',            'anon', null, $q$delete from public.umkm$q$, 'nol'),
      (4,  'Pengunjung membaca data (memang boleh)',     'anon', null, $q$select count(*) from public.umkm$q$, 'sukses'),
      (5,  'Pengunjung memanggil fungsi trigger lewat API', 'anon', null, $q$select public.umkm_amankan()$q$, 'ditolak'),
      -- ----- Andi menambah data -----
      (6,  'Andi menambah data dengan benar (harus bisa)', 'authenticated', a, $q$insert into public.umkm (nama,kategori,alamat,jam,wa,foto,user_id) values ('UJI-6','Fashion','a','b','c','https://contoh.test/x.jpg','aaaaaaaa-0000-4000-8000-000000000001')$q$, 'sukses'),
      (7,  'Andi memalsukan dibuat_oleh = admin',        'authenticated', a, $q$insert into public.umkm (nama,kategori,alamat,jam,wa,foto,dibuat_oleh,user_id) values ('UJI-7','Fashion','a','b','c','https://contoh.test/x.jpg','admin','aaaaaaaa-0000-4000-8000-000000000001')$q$, 'sukses'),
      (8,  'Hasil uji 7: dibuat_oleh tetap nama Andi',   'admin', null, $q$select dibuat_oleh = 'andi.uji' from public.umkm where nama = 'UJI-7'$q$, 'benar'),
      (9,  'Andi mencoba menambah data atas nama Budi (user_id = Budi)', 'authenticated', a, $q$insert into public.umkm (nama,kategori,alamat,jam,wa,foto,user_id) values ('UJI-9','Fashion','a','b','c','https://contoh.test/x.jpg','bbbbbbbb-0000-4000-8000-000000000002')$q$, 'bebas'),
      (10, 'Hasil uji 9: tidak ada data yang jadi milik Budi', 'admin', null, $q$select not exists (select 1 from public.umkm where nama = 'UJI-9' and user_id <> 'aaaaaaaa-0000-4000-8000-000000000001')$q$, 'benar'),
      -- ----- Isian jahat -----
      (11, 'Nama 101 karakter',                          'authenticated', a, $q$insert into public.umkm (nama,kategori,alamat,jam,wa,foto,user_id) values (repeat('x',101),'Kuliner','a','b','c','https://contoh.test/x.jpg','aaaaaaaa-0000-4000-8000-000000000001')$q$, 'ditolak'),
      (12, 'Link foto javascript: (XSS lewat link)',     'authenticated', a, $q$insert into public.umkm (nama,kategori,alamat,jam,wa,foto,user_id) values ('UJI-12','Kuliner','a','b','c','javascript:alert(1)','aaaaaaaa-0000-4000-8000-000000000001')$q$, 'ditolak'),
      (13, 'Kategori palsu',                             'authenticated', a, $q$insert into public.umkm (nama,kategori,alamat,jam,wa,foto,user_id) values ('UJI-13','Hacker','a','b','c','https://contoh.test/x.jpg','aaaaaaaa-0000-4000-8000-000000000001')$q$, 'ditolak'),
      (14, 'Nama berisi tag script (disimpan sebagai teks biasa)', 'authenticated', a, $q$insert into public.umkm (nama,kategori,alamat,jam,wa,foto,user_id) values ('<script>alert(1)</script>','Kuliner','a','b','c','https://contoh.test/x.jpg','aaaaaaaa-0000-4000-8000-000000000001')$q$, 'sukses'),
      -- ----- Budi menyerang data Andi -----
      (15, 'Budi mengubah data milik Andi',              'authenticated', b, $q$update public.umkm set nama = 'DIRETAS' where nama = 'UJI-6'$q$, 'nol'),
      (16, 'Budi menghapus data milik Andi',             'authenticated', b, $q$delete from public.umkm where nama = 'UJI-6'$q$, 'nol'),
      (17, 'Budi mengubah SEMUA data (tanpa filter)',    'authenticated', b, $q$update public.umkm set nama = 'DIRETAS' where nama like 'UJI-%'$q$, 'nol'),
      (18, 'Andi mengubah data bawaan tanpa pemilik',    'authenticated', a, $q$update public.umkm set nama = 'DIRETAS' where nama = 'UJI-BAWAAN'$q$, 'nol'),
      (19, 'Andi menghapus data bawaan tanpa pemilik',   'authenticated', a, $q$delete from public.umkm where nama = 'UJI-BAWAAN'$q$, 'nol'),
      -- ----- Andi mengubah data sendiri -----
      (20, 'Andi mencoba mengganti pemilik dan pembuat di data miliknya', 'authenticated', a, $q$update public.umkm set dibuat_oleh = 'admin', user_id = 'bbbbbbbb-0000-4000-8000-000000000002' where nama = 'UJI-6'$q$, 'bebas'),
      (21, 'Hasil uji 20: pemilik dan pembuat tidak berubah', 'admin', null, $q$select not exists (select 1 from public.umkm where nama = 'UJI-6' and (user_id <> 'aaaaaaaa-0000-4000-8000-000000000001' or dibuat_oleh <> 'andi.uji'))$q$, 'benar'),
      (22, 'Andi menghapus data sendiri (harus bisa)',   'authenticated', a, $q$delete from public.umkm where nama = 'UJI-6'$q$, 'sukses'),
      -- ----- Batas 20 data per akun -----
      (23, 'Citra menambah 20 data (batas, harus bisa)', 'authenticated', c, $q$insert into public.umkm (nama,kategori,alamat,jam,wa,foto,user_id) select 'UJI-C'||g,'Kuliner','a','b','c','https://contoh.test/x.jpg','cccccccc-0000-4000-8000-000000000003' from generate_series(1,20) g$q$, 'sukses'),
      (24, 'Citra menambah data ke-21',                  'authenticated', c, $q$insert into public.umkm (nama,kategori,alamat,jam,wa,foto,user_id) values ('UJI-C21','Kuliner','a','b','c','https://contoh.test/x.jpg','cccccccc-0000-4000-8000-000000000003')$q$, 'ditolak')
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
    if t.sebagai <> 'admin' then
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
      -- error = database menolak. Itu yang diharapkan untuk uji "ditolak".
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
