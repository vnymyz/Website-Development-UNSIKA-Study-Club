-- ======================================================
-- supabase-setup.sql — jalankan SEKALI di Supabase > SQL Editor
-- Membuat tabel "umkm" dan mengisi 6 data awal.
-- ======================================================

-- 1. Hapus tabel lama kalau ada (supaya script ini bisa dijalankan ulang).
--    PERHATIAN: semua data di tabel umkm ikut terhapus.
drop table if exists public.umkm;

-- 2. Buat tabel. Satu baris = satu UMKM.
create table public.umkm (
  id          bigint generated always as identity primary key, -- nomor otomatis 1, 2, 3, ...
  created_at  timestamptz not null default now(),              -- waktu dibuat, diisi otomatis
  nama        text not null,
  kategori    text not null,
  alamat      text not null,
  jam         text not null,
  wa          text not null,
  foto        text not null,
  dibuat_oleh text not null default 'sistem'                   -- username yang menambahkan
);

-- 3. Aktifkan Row Level Security (RLS).
--    Setelah ini tabel DITUTUP untuk semua orang, kecuali ada policy yang mengizinkan.
alter table public.umkm enable row level security;

-- 4. Policy: boleh membaca (select) dan menambah (insert) untuk pengunjung (role "anon").
--    Sengaja terbuka karena belum ada login asli. Diperketat di pertemuan berikutnya.
create policy "umkm boleh dibaca"
  on public.umkm for select to anon
  using (true);

create policy "umkm boleh ditambah"
  on public.umkm for insert to anon
  with check (true);

-- 5. Isi data awal: 6 UMKM yang sama seperti di pertemuan 3.
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
