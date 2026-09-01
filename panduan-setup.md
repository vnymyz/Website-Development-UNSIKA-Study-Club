# Panduan Setup Tools

Semua tools di bawah ini dipakai sejak pertemuan pertama. Siapkan sebelum kelas dimulai supaya waktu 90 menit terpakai untuk belajar, bukan instalasi.

## 1. VS Code dan Live Server

1. Unduh dan instal [VS Code](https://code.visualstudio.com/Download).
2. Buka VS Code, masuk ke tab **Extensions** (ikon kotak di sidebar kiri, atau `Ctrl + Shift + X`).
3. Cari **Live Server** (oleh Ritwick Dey), klik **Install**.
4. Buat folder proyek, misalnya `website-umkm`, lalu buka folder itu di VS Code (**File > Open Folder**).
5. Untuk menjalankan halaman: klik kanan file `index.html` di sidebar, pilih **Open with Live Server**. Browser akan terbuka otomatis dan halaman ikut ter-refresh setiap ada perubahan yang disimpan.

## 2. Git

1. Unduh dan instal [Git](https://git-scm.com/downloads). Saat instalasi Windows, opsi default umumnya sudah aman untuk dipilih terus (Next).
2. Buka terminal VS Code (**Terminal > New Terminal**), lalu atur identitas Git sekali saja:

```bash
git config --global user.name "Nama Kamu"
git config --global user.email "email-kamu@example.com"
```

3. Cek versi untuk memastikan instalasi berhasil:

```bash
git --version
```

## 3. Akun GitHub

1. Buat akun di [GitHub](https://github.com/) memakai email aktif.
2. Aktifkan two-factor authentication (opsional tapi disarankan).
3. Siapkan nama repository yang rapi untuk tiap proyek, misalnya `website-umkm-kelompok1`.

Git dan GitHub mulai dipakai pada **pertemuan 2**.

## 4. Akun Supabase

1. Buka [Supabase](https://supabase.com/) dan daftar (bisa langsung pakai akun GitHub).
2. Klik **New Project**, isi nama project dan password database (simpan password ini baik-baik).
3. Tunggu beberapa menit sampai project selesai dibuat.
4. Buka menu **Project Settings > API** untuk melihat:
   - **Project URL**
   - **anon public key**

Kedua nilai ini dipakai di kode frontend mulai pertemuan 4. Ada juga **service_role key** di halaman yang sama — **jangan pernah dipakai di kode frontend atau di-commit ke repository**, karena key itu bisa membaca dan menghapus semua data tanpa batasan.

## 5. Akun Vercel

1. Buka [Vercel](https://vercel.com/) dan daftar memakai akun GitHub (supaya nanti bisa import repository langsung).
2. Tidak perlu membuat project dulu — project baru dibuat saat deploy di pertemuan 6.

## Ringkasan akun yang perlu disiapkan

| Akun | Kegunaan | Kapan dipakai |
|---|---|---|
| GitHub | Menyimpan kode, versi, kolaborasi | Pertemuan 2 dan seterusnya |
| Supabase | Database Postgres, autentikasi | Pertemuan 4 dan seterusnya |
| Vercel | Hosting/deploy aplikasi | Pertemuan 6 |

## Menggunakan AI dengan bijak

AI boleh dipakai sebagai teman berpikir: meminta penjelasan error, alternatif struktur kode, atau review hasil kerja. Jangan langsung menyalin hasilnya. Baca, jalankan, ubah sesuai studi kasus, dan pastikan kamu dapat menjelaskan logika setiap baris penting.

Jangan pernah menempelkan **service_role key**, password database, atau data pribadi peserta lain ke layanan AI maupun ke repository publik.
