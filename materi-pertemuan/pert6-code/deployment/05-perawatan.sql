-- ======================================================
-- 05-perawatan.sql — query perawatan harian (opsional)
-- Bagian A bisa langsung dijalankan (hanya membaca).
-- Bagian B sampai D MENGUBAH data: hapus tanda "--" di depan satu blok saja,
-- ganti nilai contohnya, lalu Run. Jalankan satu blok per satu kali.
-- Dari SQL Editor kamu berperan sebagai admin, jadi RLS dan trigger tidak menghalangi.
-- ======================================================

-- ---------- A. Lihat jumlah data per akun (membaca saja) ----------
-- Baris dengan pemilik "(tanpa pemilik)" = data bawaan atau data dari pertemuan 4.
select coalesce(u.email, '(tanpa pemilik)') as pemilik,
       count(*)                              as jumlah_data,
       max(m.created_at)                     as terakhir_menambah
from public.umkm m
left join auth.users u on u.id = m.user_id
group by u.email
order by jumlah_data desc;

-- ---------- B. Klaim data tanpa pemilik jadi milik akunmu ----------
-- Supaya data lama (misalnya dari pertemuan 4) bisa diedit dan dihapus lewat aplikasi.
-- Ganti email dan nama dengan akun yang kamu pakai login.
-- update public.umkm
-- set user_id = (select id from auth.users where email = 'emailkamu@contoh.com'),
--     dibuat_oleh = 'namakamu'
-- where user_id is null and nama in ('Vanya Shop', 'Ambasushi');

-- ---------- C. Hapus data uji atau spam ----------
-- Hapus berdasarkan nama. Cek dulu dengan "select" yang sama sebelum menghapus.
-- select id, nama, dibuat_oleh from public.umkm where nama ilike '%spam%';
-- delete from public.umkm where nama ilike '%spam%';

-- ---------- D. Hapus akun palsu yang tidak pernah konfirmasi email ----------
-- Berguna kalau katalog dibanjiri akun spam. Data milik akun itu tidak ikut terhapus,
-- hanya kolom pemiliknya jadi kosong (on delete set null).
-- Cek dulu daftarnya:
-- select id, email, created_at from auth.users
-- where email_confirmed_at is null and created_at < now() - interval '7 days';
-- Baru hapus:
-- delete from auth.users
-- where email_confirmed_at is null and created_at < now() - interval '7 days';

-- ---------- E. Mengubah batas 20 data per akun ----------
-- Angka 20 ada di fungsi umkm_amankan() di file 02-supabase-secure.sql
-- (baris "if jumlah >= 20"). Ganti angkanya di file itu, lalu jalankan ulang file tersebut.
