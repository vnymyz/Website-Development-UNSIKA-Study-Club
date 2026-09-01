# Kuis & Latihan 5 — Update, Delete, Relasi Tabel & Autentikasi

## Identitas Peserta

- **Nama lengkap:** ........................................................
- **Jurusan:** ........................................................
- **Kelas:** ........................................................
- **Tanggal:** ........................................................

> Kerjakan mandiri terlebih dahulu. AI boleh dipakai untuk memahami error, tetapi kamu harus dapat menjelaskan jawabanmu.

## Bagian A — Pemahaman Konsep

1. Kenapa `.eq("id", id)` sangat penting saat melakukan `update()` atau `delete()`?

   **Jawaban:**

   ........................................................................................

2. Jelaskan apa itu foreign key dengan contoh selain yang ada di materi.

   **Jawaban:**

   ........................................................................................

3. Apa perbedaan autentikasi dan otorisasi?

   **Jawaban:**

   ........................................................................................

4. Apa itu session, dan kenapa aplikasi butuh session setelah login?

   **Jawaban:**

   ........................................................................................

5. Kenapa policy RLS untuk SELECT boleh dibiarkan terbuka untuk semua orang, sementara INSERT/UPDATE/DELETE dibatasi?

   **Jawaban:**

   ........................................................................................

## Bagian B — Praktik Coding

6. Tulis kode untuk mengubah kolom `nama` pada tabel `produk` menjadi "Kaos Polos V2", hanya untuk baris dengan `id` sama dengan 1.

   ```javascript
   // Tulis jawaban di sini
   ```

7. Tulis kode untuk menghapus baris pada tabel `produk` dengan `id` sama dengan 3.

   ```javascript
   // Tulis jawaban di sini
   ```

8. Tulis kode query `select` yang mengambil semua kolom tabel `produk` beserta `nama` dari tabel relasinya `kategori`.

   ```javascript
   // Tulis jawaban di sini
   ```

9. Tulis kode untuk mendaftarkan user baru memakai Supabase Auth dengan email dan password.

   ```javascript
   // Tulis jawaban di sini
   ```

10. Tulis kode untuk mengecek apakah user sedang login, lalu menampilkan emailnya di console jika iya.

    ```javascript
    // Tulis jawaban di sini
    ```

## Target Hasil untuk Bagian Coding

**Nomor 6 — Output yang diharapkan:**

```text
Hanya baris dengan id = 1 yang berubah namanya menjadi "Kaos Polos V2".
Baris lain tidak terpengaruh.
```

**Nomor 7 — Output yang diharapkan:**

```text
Baris dengan id = 3 hilang dari tabel "produk".
Baris lain tetap ada.
```

**Nomor 8 — Output yang diharapkan** (contoh isi):

```text
[
  { id: 1, nama: "Kaos Polos", kategori: { nama: "Fashion" } }
]
```

**Nomor 9 — Output yang diharapkan:**

```text
User baru terdaftar di Supabase Authentication > Users.
```

**Nomor 10 — Output yang diharapkan** (jika sedang login):

```text
budi@example.com
```
