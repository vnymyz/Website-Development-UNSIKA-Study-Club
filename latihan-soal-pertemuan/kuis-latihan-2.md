# Kuis & Latihan 2 — CSS, Responsive Design & Git/GitHub

## Identitas Peserta

- **Nama lengkap:** ........................................................
- **Jurusan:** ........................................................
- **Kelas:** ........................................................
- **Tanggal:** ........................................................

> Kerjakan mandiri terlebih dahulu. AI boleh dipakai untuk memahami error, tetapi kamu harus dapat menjelaskan jawabanmu.

## Bagian A — Pemahaman Konsep

1. Sebutkan tiga cara menghubungkan CSS ke HTML, dan mana yang paling disarankan untuk proyek nyata.

   **Jawaban:**

   ........................................................................................

2. Jelaskan urutan lapisan pada box model dari dalam ke luar.

   **Jawaban:**

   ........................................................................................

3. Apa fungsi `flex-wrap: wrap` pada Flexbox?

   **Jawaban:**

   ........................................................................................

4. Apa itu media query, dan kapan biasanya dipakai?

   **Jawaban:**

   ........................................................................................

5. Apa perbedaan `git commit` dan `git push`?

   **Jawaban:**

   ........................................................................................

## Bagian B — Praktik Coding

6. Buat selector CSS untuk semua elemen dengan `class="kartu"` yang memberi padding 16px dan border radius 8px.

   ```css
   /* Tulis jawaban di sini */
   ```

7. Buat aturan CSS untuk `.daftar-produk` agar elemen di dalamnya berjajar horizontal dengan jarak 12px antar elemen memakai Flexbox.

   ```css
   /* Tulis jawaban di sini */
   ```

8. Buat media query yang mengubah `.daftar-produk` menjadi tersusun vertikal (`column`) saat lebar layar 600px atau kurang.

   ```css
   /* Tulis jawaban di sini */
   ```

9. Tulis elemen `<div>` dengan tiga class Tailwind: padding, warna latar putih, dan bayangan (shadow).

   ```html
   <!-- Tulis jawaban di sini -->
   ```

10. Tulis tiga perintah terminal berurutan untuk menyimpan perubahan pertama kali ke Git lokal (tanpa push).

    ```bash
    # Tulis jawaban di sini
    ```

## Target Hasil untuk Bagian Coding

**Nomor 6 — Output yang diharapkan** (perilaku, bukan tampilan teks):

```text
Setiap elemen dengan class "kartu" memiliki jarak dalam 16px
dan sudut yang membulat.
```

**Nomor 7 — Output yang diharapkan:**

```text
Elemen di dalam .daftar-produk tersusun berjajar ke samping
dengan jarak 12px antar elemen.
```

**Nomor 8 — Output yang diharapkan:**

```text
Pada layar lebar (misalnya laptop): elemen berjajar ke samping.
Pada layar sempit (<=600px, misalnya HP): elemen tersusun ke bawah.
```

**Nomor 9 — Output yang diharapkan** (contoh class, boleh berbeda):

```text
<div class="p-4 bg-white shadow">...</div>
```

**Nomor 10 — Output yang diharapkan:**

```text
$ git init
$ git add .
$ git commit -m "Commit pertama"
```
