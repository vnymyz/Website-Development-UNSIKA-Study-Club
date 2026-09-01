# Kuis & Latihan 6 — Deploy, README & Proyek Akhir

## Identitas Peserta

- **Nama lengkap:** ........................................................
- **Jurusan:** ........................................................
- **Kelas:** ........................................................
- **Tanggal:** ........................................................

> Kerjakan mandiri terlebih dahulu. AI boleh dipakai untuk memahami error, tetapi kamu harus dapat menjelaskan jawabanmu.

## Bagian A — Pemahaman Konsep

1. Kenapa aplikasi yang hanya berjalan di `localhost` belum bisa disebut "selesai" untuk portofolio?

   **Jawaban:**

   ........................................................................................

2. Jelaskan alur singkat bagaimana Vercel men-deploy proyek dari GitHub.

   **Jawaban:**

   ........................................................................................

3. Sebutkan tiga bagian penting yang harus ada dalam README yang layak portofolio.

   **Jawaban:**

   ........................................................................................

4. Apa fungsi tab Network di DevTools browser saat debugging?

   **Jawaban:**

   ........................................................................................

5. Kenapa perubahan kode otomatis ter-deploy ulang setelah `git push` ke repo yang terhubung Vercel?

   **Jawaban:**

   ........................................................................................

## Bagian B — Praktik Coding

6. Tulis tiga perintah Git berurutan untuk push perubahan terbaru ke GitHub (asumsikan repo sudah ada remote).

   ```bash
   # Tulis jawaban di sini
   ```

7. Tulis kerangka README (judul, deskripsi, fitur, tech stack) untuk aplikasi katalog produk sederhana.

   ```markdown
   <!-- Tulis jawaban di sini -->
   ```

8. Sebutkan langkah-langkah (poin, tanpa kode) untuk menghubungkan repository GitHub ke project baru di Vercel.

   ```text
   // Tulis jawaban di sini
   ```

9. Tulis contoh isi bagian "Cara Menjalankan Secara Lokal" pada README untuk proyek berbasis Live Server.

   ```markdown
   <!-- Tulis jawaban di sini -->
   ```

10. Jelaskan langkah debugging yang kamu lakukan kalau data dari Supabase tidak muncul di URL Vercel padahal muncul normal di localhost.

    **Jawaban:**

    ```text
    // Tulis jawaban di sini
    ```

## Target Hasil untuk Bagian Coding

**Nomor 6 — Output yang diharapkan:**

```text
$ git add .
$ git commit -m "Update fitur pencarian"
$ git push
```

**Nomor 7 — Output yang diharapkan** (contoh struktur):

```text
# Katalog Produk Sederhana

Deskripsi singkat aplikasi.

## Fitur
- ...

## Tech Stack
- ...
```

**Nomor 8 — Output yang diharapkan:**

```text
1. Login ke Vercel dengan akun GitHub
2. Klik Add New > Project
3. Pilih repository yang sesuai
4. Klik Import lalu Deploy
```

**Nomor 9 — Output yang diharapkan:**

```text
## Cara Menjalankan Secara Lokal
1. Clone repository ini
2. Buka folder di VS Code
3. Klik kanan index.html, pilih "Open with Live Server"
```

**Nomor 10 — Output yang diharapkan** (contoh langkah):

```text
1. Cek Console di URL Vercel untuk pesan error
2. Cek pengaturan Site URL/Redirect URL di Supabase Authentication
3. Pastikan anon key dan project URL benar di kode yang di-deploy
```
