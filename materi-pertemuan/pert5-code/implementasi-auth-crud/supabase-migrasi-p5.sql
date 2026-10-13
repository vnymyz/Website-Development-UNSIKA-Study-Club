-- ======================================================
-- supabase-migrasi-p5.sql — jalankan SEKALI di Supabase > SQL Editor
-- Dijalankan SESUDAH script pertemuan 4 (supabase-setup.sql).
-- Isinya: menambah kolom pemilik data dan mengganti aturan (policy)
-- supaya hanya user yang login yang boleh menambah, mengubah, dan menghapus.
-- ======================================================

-- 1. Kolom pemilik data: menyimpan id user (dari Supabase Auth) yang menambahkan baris.
--    Data bawaan dari pertemuan 4 isinya kosong (null), artinya "milik sistem".
alter table public.umkm
  add column if not exists user_id uuid references auth.users (id) on delete set null;

-- 2. Hapus aturan lama dari pertemuan 4.
--    Aturan baca lama hanya untuk "anon" (pengunjung belum login), sehingga user yang
--    sudah login tidak bisa membaca data. Aturan tambah lama terlalu longgar.
drop policy if exists "umkm boleh dibaca" on public.umkm;
drop policy if exists "umkm boleh ditambah" on public.umkm;

-- 3. Baca: boleh untuk SEMUA orang, baik belum login (anon) maupun sudah login (authenticated).
create policy "umkm boleh dibaca"
  on public.umkm for select to anon, authenticated
  using (true);

-- 4. Tambah: hanya user yang login, dan baris yang ditambah harus atas namanya sendiri.
--    auth.uid() = id user yang sedang login.
create policy "umkm login boleh menambah"
  on public.umkm for insert to authenticated
  with check (user_id = (select auth.uid()));

-- 5. Ubah: hanya pemilik baris.
--    "using" memeriksa baris yang mau diubah, "with check" memeriksa hasil perubahannya.
create policy "umkm pemilik boleh mengubah"
  on public.umkm for update to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

-- 6. Hapus: hanya pemilik baris.
create policy "umkm pemilik boleh menghapus"
  on public.umkm for delete to authenticated
  using (user_id = (select auth.uid()));
