# Kuis & Latihan 4 — Database & Supabase (Create + Read)

## Identitas Peserta

- **Nama lengkap:** ........................................................
- **Jurusan:** ........................................................
- **Kelas:** ........................................................
- **Tanggal:** ........................................................

> Kerjakan mandiri terlebih dahulu. AI boleh dipakai untuk memahami error, tetapi kamu harus dapat menjelaskan jawabanmu.

## Bagian A — Pemahaman Konsep

1. Kenapa data yang disimpan di array JavaScript tidak cukup untuk aplikasi sungguhan?

   **Jawaban:**

   ........................................................................................

2. Apa itu primary key, dan mengapa setiap tabel membutuhkannya?

   **Jawaban:**

   ........................................................................................

3. Jelaskan perbedaan `anon key` dan `service_role key`.

   **Jawaban:**

   ........................................................................................

4. Apa fungsi kata kunci `await` dalam JavaScript?

   **Jawaban:**

   ........................................................................................

5. Kenapa hasil query Supabase selalu berbentuk `{ data, error }`?

   **Jawaban:**

   ........................................................................................

## Bagian B — Praktik Coding

6. Tulis kode untuk membuat koneksi Supabase Client memakai `SUPABASE_URL` dan `SUPABASE_ANON_KEY`.

   ```javascript
   // Tulis jawaban di sini
   ```

7. Tulis kode untuk mengambil semua data dari tabel `produk`, diurutkan berdasarkan `id` naik.

   ```javascript
   // Tulis jawaban di sini
   ```

8. Tulis kode untuk menyimpan satu data baru ke tabel `produk` dengan kolom `nama` dan `harga`.

   ```javascript
   // Tulis jawaban di sini
   ```

9. Tulis kode untuk mengecek apakah query menghasilkan error, lalu menampilkannya di console jika ada.

   ```javascript
   // Tulis jawaban di sini
   ```

10. Jelaskan langkah membuat policy RLS "Enable read access for all users" lewat Supabase Table Editor (tanpa menuliskan kode SQL).

    **Jawaban dan langkah:**

    ```text
    // Tulis jawaban di sini
    ```

## Target Hasil untuk Bagian Coding

**Nomor 6 — Output yang diharapkan:**

```text
Variabel supabaseClient siap dipakai untuk query ke Supabase.
```

**Nomor 7 — Output yang diharapkan** (contoh isi tabel produk):

```text
[
  { id: 1, nama: "Kaos Polos", harga: 75000 },
  { id: 2, nama: "Celana Jeans", harga: 150000 }
]
```

**Nomor 8 — Output yang diharapkan:**

```text
Baris baru bertambah di tabel "produk" dengan id otomatis terisi.
```

**Nomor 9 — Output yang diharapkan** (jika ada error):

```text
Pesan error tampil di console, contoh:
"new row violates row-level security policy"
```

**Nomor 10 — Output yang diharapkan:**

```text
Tabel "produk" memiliki policy SELECT yang mengizinkan
semua orang (anon dan authenticated) membaca datanya.
```
