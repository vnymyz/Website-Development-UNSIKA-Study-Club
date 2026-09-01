# Bonus — Multipage HTML (Opsional)

Versi lanjutan dari `pert1-code`. Kalau `pert1-code/index.html` cuma satu halaman dengan navigasi lompat ke section (`href="#kontak"`), versi ini benar-benar **tiga file HTML terpisah** yang saling terhubung lewat link asli.

**Ini bonus, bukan materi wajib pertemuan 1.** Cocok untuk peserta yang sudah selesai duluan atau ingin eksplor sendiri di rumah.

## Isi

```text
pert1-code-bonus-multipage/
├── home.html      # Daftar UMKM
├── about.html     # Tentang
└── contact.html   # Form kontak
```

## Cara menjalankan

Buka `home.html` lewat Live Server, lalu klik menu navigasi — browser benar-benar pindah file, bukan cuma scroll.

## Langkah singkat (untuk yang selesai duluan)

File di folder ini sudah lengkap — langkah di bawah untuk membuat ulang dari nol kalau mau latihan sendiri, bukan wajib diikuti kalau cuma mau lihat hasil jadi.

1. Buat tiga file baru: `home.html`, `about.html`, `contact.html` (bukan `index.html`).
2. Di ketiganya, tulis kerangka HTML dasar yang sama persis, lalu isi `<nav>` yang sama di ketiga file:

   ```html
   <nav>
     <a href="home.html">Beranda</a>
     <a href="about.html">Tentang</a>
     <a href="contact.html">Kontak</a>
   </nav>
   ```

3. Di `home.html`, isi `<main>` dengan section "Daftar UMKM" (boleh salin dari `pert1-code/index.html`).
4. Di `about.html`, isi `<main>` dengan section "Tentang".
5. Di `contact.html`, isi `<main>` dengan form kontak.
6. Buka `home.html` lewat Live Server, klik tiap link nav, pastikan pindah ke file yang benar.

**Cek hasil:** dari `home.html` bisa klik ke `about.html` dan `contact.html`, lalu balik lagi ke `home.html` lewat nav yang sama — tanpa halaman ke-refresh atau blank.

**Kalau error:** halaman blank/404 → cek nama file di `href` sama persis (huruf besar/kecil, ekstensi `.html`) dengan nama file yang benar-benar ada di folder.

## Kenapa ini "bonus", bukan materi utama

- **Relative path** — `href="about.html"` cuma jalan kalau nama file dan lokasi persis sama; ini sumber bug klasik pemula (typo nama file, salah folder).
- **Nav diulang manual** di setiap file. Kalau menu diubah, harus edit di 3 tempat — belum ada cara "reuse component" di HTML murni. Masalah ini nanti kelihatan jelas kenapa framework/component itu berguna, tapi belum saatnya dijelaskan di pertemuan 1.
- Kelas ini menuju arah **single-page app** (satu `index.html`, data dari Supabase, render dinamis lewat JavaScript) — bukan multi-page klasik. Jadi pola ini tidak dipakai lagi mulai pertemuan 3 dan seterusnya.

## Kalau mau coba sendiri

1. Ubah teks navigasi di `home.html`, lalu bandingkan: kamu harus ubah juga di `about.html` dan `contact.html` biar konsisten.
2. Coba typo nama file di salah satu `href` (misal `About.html` huruf besar), lihat errornya di browser.
