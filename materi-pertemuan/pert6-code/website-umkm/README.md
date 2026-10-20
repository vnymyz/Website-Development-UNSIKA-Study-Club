# Katalog UMKM Karawang

Aplikasi web untuk menampilkan, menambah, mengubah, dan menghapus data UMKM di Karawang. Pengunjung bisa melihat dan mencari UMKM tanpa login. Pemilik UMKM masuk dengan akun email untuk mengelola datanya sendiri lewat dashboard.

Dibuat sebagai proyek latihan kelas Website UNSIKA Study Club.

<!-- Tambahkan screenshot di sini setelah folder screenshot/ dibuat:
![Halaman utama](screenshot/halaman-utama.png)
![Dashboard](screenshot/dashboard.png)
-->

## Demo

<!-- Ganti dengan link Vercel-mu -->
https://nama-project-kamu.vercel.app

## Fitur

- Menampilkan daftar UMKM dari database Supabase.

- Pencarian dan filter kategori (Kuliner, Fashion, Kerajinan).

- Daftar dan login dengan email dan password (Supabase Auth).

- Dashboard: ringkasan jumlah data, tabel daftar UMKM, tambah, edit, dan hapus.

- Hak akses per role: user biasa hanya bisa mengubah dan menghapus data miliknya sendiri, admin bisa semua data. Aturan itu dijaga langsung oleh database (Row Level Security).

## Tech Stack

- HTML, CSS, dan JavaScript (tanpa framework)

- Supabase (database Postgres dan autentikasi)

- Vercel (hosting)

## Struktur Folder

```text
website-umkm/
├── index.html           halaman utama (direktori UMKM)
├── login.html           halaman login dan daftar
├── dashboard.html       dashboard (butuh login)
├── css/
│   ├── style.css
│   └── dashboard.css
├── js/
│   ├── common.js        koneksi Supabase, sesi login, navbar
│   ├── app.js           halaman utama
│   ├── login.js
│   └── dashboard.js
├── supabase/            (opsional) salinan file SQL setup database
├── .gitignore
└── README.md
```

## Cara Menjalankan Secara Lokal

1. Clone repository ini.

2. Siapkan project Supabase sendiri, lalu jalankan `supabase/01-supabase-lengkap.sql` (ganti email admin di bagiannya) di SQL Editor. File ini ada di folder `deployment/` materi pertemuan 6. Salin ke folder `supabase/` di repo-mu supaya dokumentasinya lengkap.

3. Buka `js/common.js`, ganti `SUPABASE_URL` dan `SUPABASE_KEY` dengan milik project-mu (pakai **Publishable key**, jangan Secret key).

4. Buka folder di VS Code, klik kanan `index.html`, lalu pilih **Open with Live Server**.

## Keamanan

- Semua teks dari database ditampilkan lewat `escapeHtml()`, jadi tidak bisa menyisipkan kode ke halaman (XSS).

- Tidak ada query SQL yang dirangkai dari isian pengguna (tidak ada celah SQL injection).

- Row Level Security aktif: semua orang boleh membaca, tapi hanya pemilik yang boleh mengubah dan menghapus.

- Batas panjang isian, nama pembuat yang diisi otomatis oleh database, dan batas 20 data per akun ada di `01-supabase-lengkap.sql`.

## Anggota

- Nama kamu
