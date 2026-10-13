-- ======================================================
-- supabase-bonus-kategori.sql — BONUS pertemuan 5
-- Memisahkan kategori jadi tabel sendiri, dihubungkan lewat foreign key.
-- Jalankan SESUDAH supabase-migrasi-p5.sql.
-- ======================================================

-- 1. Tabel kategori: nama kategori ditulis sekali saja di sini.
create table public.kategori (
  id   bigint generated always as identity primary key,
  nama text not null unique
);

-- 2. Kunci tabel (RLS), lalu izinkan semua orang membaca.
alter table public.kategori enable row level security;

create policy "kategori boleh dibaca"
  on public.kategori for select to anon, authenticated
  using (true);

-- 3. Isi tiga kategori yang sudah dipakai.
insert into public.kategori (nama) values ('Kuliner'), ('Fashion'), ('Kerajinan');

-- 4. Kolom foreign key di tabel umkm: menyimpan id kategori, bukan teksnya.
alter table public.umkm
  add column kategori_id bigint references public.kategori (id);

-- 5. Isi kolom baru dari teks kategori yang lama (cocokkan nama).
update public.umkm u
  set kategori_id = k.id
  from public.kategori k
  where k.nama = u.kategori;

-- 6. Setiap UMKM wajib punya kategori.
alter table public.umkm alter column kategori_id set not null;

-- 7. Hapus kolom teks lama. Namanya sama dengan tabel kategori, jadi kalau dibiarkan
--    akan bentrok saat tabel digabung (join).
alter table public.umkm drop column kategori;
