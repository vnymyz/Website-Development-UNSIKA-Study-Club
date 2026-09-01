# Pertemuan 2 — CSS, Responsive Design & Git/GitHub

> Kode untuk sesi ini belum dibuat — folder ini baru berisi materi. File kode (`index.html`, `style.css`, dst.) akan ditambahkan menjelang/pada pertemuan 2, mengikuti pola `pert1-code`.

**Durasi:** 19.30–21.00 WIB
**Tools:** VS Code, Live Server, Tailwind CDN, Git, GitHub
**Output:** Peserta dapat menata tampilan halaman dengan CSS/Tailwind yang responsif, serta menyimpan proyek di repository GitHub.

## Tujuan belajar

- Memahami cara CSS menempel ke HTML dan cara kerja selector.
- Memahami box model dan tata letak Flexbox.
- Membuat halaman responsif dengan media query dan Tailwind CDN.
- Memahami kegunaan Git sebagai sistem versi.
- Melakukan commit dan push pertama ke GitHub.

## Rundown

| Waktu | Aktivitas |
|---|---|
| 19.30–19.40 | Pembukaan, ice breaking: "pernah nggak buka website yang berantakan di HP?" |
| 19.40–19.55 | Teori: CSS, selector, box model, Flexbox |
| 19.55–20.10 | Hands-on: styling halaman dengan CSS murni |
| 20.10–20.25 | Hands-on: migrasi sebagian ke Tailwind + responsive |
| 20.25–20.40 | Teori + hands-on: Git dan GitHub |
| 20.40–20.55 | Push proyek ke GitHub |
| 20.55–21.00 | Rangkuman dan pengantar kuis 2 |

## Teori

### Bagaimana CSS menempel ke HTML

Ada tiga cara menghubungkan CSS ke HTML:

1. **Inline** — ditulis langsung di atribut `style` pada tag. Cepat tapi berantakan kalau dipakai banyak.
   ```html
   <h1 style="color: blue;">Judul</h1>
   ```
2. **Internal** — ditulis dalam tag `<style>` di bagian `<head>`. Cocok untuk halaman kecil.
3. **Eksternal** — ditulis di file terpisah `style.css`, lalu dihubungkan lewat `<link>`. **Ini yang kita pakai**, karena rapi dan bisa dipakai ulang di banyak halaman.

```html
<head>
  <link rel="stylesheet" href="style.css">
</head>
```

> Slide visual: tiga kotak (inline, internal, eksternal) dengan tanda centang di eksternal.

### Selector: memilih elemen mana yang mau distyle

CSS ditulis dengan pola: `selector { properti: nilai; }`

| Selector | Contoh | Kegunaan |
|---|---|---|
| Tag | `p { }` | Semua tag `<p>` di halaman |
| Class | `.kartu { }` | Semua elemen dengan `class="kartu"` |
| ID | `#header { }` | Elemen dengan `id="header"` (harus unik, cuma 1 per halaman) |

```css
p {
  color: #333;
}

.kartu {
  background-color: white;
  border-radius: 8px;
}

#header {
  background-color: #1e293b;
}
```

Aturan praktis: pakai **class** untuk sebagian besar styling (bisa dipakai berkali-kali), pakai **ID** untuk hal yang benar-benar unik.

### Box Model: setiap elemen itu seperti kotak berbungkus

Analogi: bayangkan kamu mengirim barang lewat paket.

- **Content** — barangnya sendiri (teks/gambar).
- **Padding** — bantalan/bubble wrap di dalam kotak, jarak antara barang dan dinding kotak.
- **Border** — dinding kotaknya.
- **Margin** — jarak antara kotak ini dengan kotak lain di sebelahnya.

```text
┌───────────── margin ─────────────┐
│  ┌─────────── border ─────────┐  │
│  │  ┌──────── padding ─────┐  │  │
│  │  │      content         │  │  │
│  │  └───────────────────────┘  │  │
│  └─────────────────────────────┘  │
└────────────────────────────────────┘
```

```css
.kartu {
  padding: 16px;
  border: 1px solid #ddd;
  margin: 12px;
}
```

> Slide visual: diagram box model di atas, dengan warna berbeda tiap lapisan.

### Warna dan tipografi dasar

- Warna bisa ditulis dengan nama (`red`), kode HEX (`#ff0000`), atau `rgb(255, 0, 0)`.
- Font diatur dengan `font-family`, ukuran dengan `font-size`, ketebalan dengan `font-weight`.

```css
body {
  font-family: Arial, sans-serif;
  color: #1f2937;
}

h1 {
  font-size: 32px;
  font-weight: bold;
}
```

### Flexbox: menata elemen sejajar dengan mudah

Sebelum Flexbox, menyusun elemen berjajar itu merepotkan. Flexbox menyederhanakannya dengan konsep dua sumbu:

- **Sumbu utama (main axis)** — arah barisan elemen (default: horizontal, kiri ke kanan).
- **Sumbu silang (cross axis)** — arah tegak lurus dari sumbu utama.

```css
.daftar-umkm {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
}
```

- `display: flex` — mengaktifkan Flexbox pada elemen ini; anak-anaknya otomatis berjajar.
- `gap` — jarak antar elemen anak.
- `flex-wrap: wrap` — kalau tempat tidak cukup, elemen pindah ke baris berikutnya (penting untuk HP).
- `justify-content` — mengatur posisi di sumbu utama (`center`, `space-between`, dst).
- `align-items` — mengatur posisi di sumbu silang (`center`, `flex-start`, dst).

> Slide visual: tiga kartu UMKM sebelum Flexbox (bertumpuk vertikal) vs sesudah (berjajar rapi dengan jarak sama).

### Responsive design: kenapa tampilan HP beda dari laptop

Layar HP jauh lebih sempit dari laptop. Kalau tidak diatur, 3 kartu yang tadinya berjajar bisa jadi kepotong atau kekecilan di HP.

**Media query** memungkinkan CSS berubah tergantung lebar layar:

```css
.daftar-umkm {
  display: flex;
  flex-wrap: wrap;
}

@media (max-width: 640px) {
  .daftar-umkm {
    flex-direction: column;
  }
}
```

Artinya: "kalau lebar layar 640px atau kurang (kira-kira ukuran HP), susun kartu jadi vertikal (`column`) alih-alih berjajar."

### Tailwind CSS: styling lebih cepat dengan utility class

Menulis CSS manual untuk setiap detail (padding, warna, ukuran font) memakan waktu. **Tailwind** menyediakan class siap pakai langsung di HTML, tanpa perlu bolak-balik ke file CSS terpisah.

```html
<div class="p-4 bg-white rounded-lg shadow flex gap-4 flex-wrap">
  ...
</div>
```

Artinya:
- `p-4` → padding di semua sisi
- `bg-white` → warna latar putih
- `rounded-lg` → sudut membulat besar
- `shadow` → bayangan halus
- `flex gap-4 flex-wrap` → Flexbox dengan jarak dan boleh membungkus

Tailwind juga punya prefix responsif, misalnya `md:flex-row` artinya "pakai `flex-row` mulai ukuran layar medium ke atas". Ini menggantikan media query manual.

Untuk kelas ini kita memasang Tailwind lewat **CDN** (tinggal tempel satu baris `<script>`), tanpa instalasi Node.js atau file konfigurasi.

> Slide visual: perbandingan kode CSS manual vs class Tailwind untuk hasil visual yang sama.

### Git: kenapa kita butuh sistem versi

Analogi: bayangkan main game tanpa fitur *save*. Kalau salah langkah, harus mulai dari awal lagi. Git itu seperti fitur *save* untuk kode — kamu bisa menyimpan "titik aman" kapan saja dan kembali ke sana kalau ada yang rusak.

Istilah dasar:

- **Repository (repo)** — folder proyek yang dilacak oleh Git.
- **Commit** — "titik simpan" berisi catatan perubahan apa saja yang terjadi.
- **Remote** — salinan repo yang disimpan online (di GitHub).
- **Push** — mengirim commit dari komputer ke remote (GitHub).

Alur kerja dasar:

```text
Ubah file  →  git add  →  git commit  →  git push
(kerja)      (tandai)      (simpan)      (kirim ke GitHub)
```

> Slide visual: diagram alur di atas sebagai 4 kotak berurutan dengan panah.

### GitHub: tempat menyimpan repo secara online

GitHub adalah layanan untuk menyimpan repository Git di internet. Fungsinya:

- Backup kode — kalau laptop rusak, kode tetap aman.
- Kolaborasi — anggota tim bisa kerja di repo yang sama.
- Portofolio — recruiter sering melihat GitHub calon karyawan.

## Hands-on: Langkah demi Langkah

### Langkah 1 — Membuat file CSS eksternal

1. Di folder `website-umkm`, buat file baru `style.css`.
2. Di `index.html`, tambahkan di dalam `<head>`, setelah `<title>`:

```html
<link rel="stylesheet" href="style.css">
```

**Cek hasil:** belum ada perubahan visual (file CSS masih kosong), tapi tidak ada error di Console (`F12 > Console`).

### Langkah 2 — Styling dasar dengan CSS murni

Isi `style.css`:

```css
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: Arial, sans-serif;
  color: #1f2937;
}

header {
  background-color: #1e293b;
  color: white;
  padding: 16px;
}

header nav a {
  color: white;
  margin-right: 12px;
  text-decoration: none;
}

section {
  padding: 24px 16px;
}
```

Simpan, lihat perubahan di browser (Live Server otomatis refresh).

**Cek hasil:** header berwarna gelap dengan teks putih, ada jarak antar section.

### Langkah 3 — Membuat kartu UMKM berjajar dengan Flexbox

1. Di `index.html`, bungkus tiga `<article>` di dalam `<div class="daftar-umkm">`:

```html
<div class="daftar-umkm">
  <article class="kartu">...</article>
  <article class="kartu">...</article>
  <article class="kartu">...</article>
</div>
```

2. Tambahkan di `style.css`:

```css
.daftar-umkm {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
}

.kartu {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 16px;
  flex: 1;
  min-width: 220px;
}
```

**Cek hasil:** tiga kartu UMKM berjajar horizontal dengan jarak rapi.

### Langkah 4 — Menambahkan media query untuk HP

Tambahkan di akhir `style.css`:

```css
@media (max-width: 640px) {
  .daftar-umkm {
    flex-direction: column;
  }

  header nav {
    display: flex;
    flex-direction: column;
    gap: 4px;
  }
}
```

3. Buka `Inspect` (`F12`), klik ikon perangkat mobile di kiri atas panel DevTools untuk simulasi layar HP.

**Cek hasil:** pada lebar layar kecil, kartu tersusun vertikal dan menu navigasi berubah jadi tumpukan.

### Langkah 5 — Memasang Tailwind lewat CDN

Tambahkan baris ini di `<head>`, sebelum `<link rel="stylesheet" href="style.css">`:

```html
<script src="https://cdn.tailwindcss.com"></script>
```

**Cek hasil:** tidak ada perubahan visual dulu (Tailwind baru aktif kalau class-nya dipakai), tapi cek Console tidak ada error merah.

**Kalau error:** kalau script gagal dimuat, pastikan koneksi internet aktif — Tailwind CDN butuh internet karena filenya diambil online.

### Langkah 6 — Refactor section "Tentang" pakai Tailwind

Ganti section Tentang dengan versi Tailwind:

```html
<section id="tentang" class="p-6 bg-slate-50">
  <h2 class="text-2xl font-bold mb-2">Tentang</h2>
  <p class="text-gray-700">Katalog ini dibuat untuk membantu warga menemukan UMKM lokal di Karawang.</p>
</section>
```

**Cek hasil:** section Tentang punya padding, latar abu-abu muda, judul lebih besar dan tebal — semua tanpa menulis CSS tambahan di `style.css`.

### Langkah 7 — Instal Git dan inisialisasi repo

1. Cek Git sudah terpasang: buka terminal VS Code, ketik `git --version`.
2. Di terminal, pastikan posisi di folder `website-umkm`, lalu jalankan:

```bash
git init
```

3. Buat file `.gitignore` di folder yang sama, isi:

```text
.vscode/
*.log
```

**Cek hasil:** muncul folder tersembunyi `.git` (bisa dicek lewat `ls -a` di terminal), tanda repo sudah aktif.

### Langkah 8 — Commit pertama

```bash
git add .
git commit -m "Tampilan awal katalog UMKM dengan CSS dan Tailwind"
```

**Cek hasil:** terminal menampilkan ringkasan file yang di-commit, tanpa pesan error.

**Kalau error:** kalau muncul pesan minta `user.name`/`user.email`, jalankan dulu perintah `git config` dari `panduan-setup.md`.

### Langkah 9 — Membuat repo di GitHub dan push

1. Buka GitHub, klik **New repository**, beri nama `website-umkm`, biarkan kosong (jangan centang "Add README").
2. Salin URL repo yang muncul (bentuknya `https://github.com/username/website-umkm.git`).
3. Di terminal VS Code:

```bash
git branch -M main
git remote add origin https://github.com/username/website-umkm.git
git push -u origin main
```

**Cek hasil:** refresh halaman repo di GitHub, file `index.html` dan `style.css` sudah muncul di sana.

**Kalau error:** kalau diminta login, ikuti proses autentikasi GitHub (browser popup atau token). Kalau muncul "remote origin already exists", jalankan `git remote remove origin` dulu baru ulangi langkah `git remote add`.

### Hasil akhir sesi ini

Struktur folder:

```text
website-umkm/
├── index.html
├── style.css
└── .gitignore
```

Halaman sudah responsif dan sebagian memakai Tailwind. Proyek sudah tersimpan di GitHub dengan minimal 2 commit.

## Catatan AI

Contoh prompt yang baik: "Jelaskan kapan sebaiknya pakai Flexbox `row` vs `column`, dengan contoh kartu produk. Jangan tuliskan CSS lengkap punyaku, cukup jelaskan konsepnya." Selalu cek hasil di browser — AI bisa saja memberi kode yang sebenarnya tidak sesuai kebutuhan tampilanmu.

## Latihan mandiri

Tambahkan `class="kartu"` styling dengan Tailwind (misalnya `shadow-md`, `rounded-xl`) pada salah satu kartu UMKM, lalu bandingkan hasilnya dengan kartu yang masih pakai CSS manual. Commit perubahan ini dengan pesan commit yang jelas.

## Rangkuman

CSS menata tampilan lewat selector, box model, dan Flexbox; Tailwind mempercepat proses itu lewat utility class. Git menyimpan riwayat perubahan kode, GitHub menyimpannya online. Minggu depan kita membuat halaman jadi hidup dengan JavaScript: klik tombol, filter data, dan validasi form.

## Istilah penting

| Istilah | Artinya |
|---|---|
| Selector | Penanda elemen HTML mana yang ingin distyle di CSS |
| Box model | Susunan content, padding, border, margin pada setiap elemen |
| Flexbox | Metode CSS untuk menata elemen sejajar dengan mudah |
| Media query | Aturan CSS yang berubah tergantung lebar layar |
| Utility class | Class siap pakai di Tailwind untuk satu properti styling |
| Repository | Folder proyek yang dilacak riwayat perubahannya oleh Git |
| Commit | Titik simpan berisi catatan perubahan kode |
| Push | Mengirim commit dari komputer ke GitHub |

## Isi folder

- Belum ada kode — akan ditambahkan menjelang pertemuan 2, melanjutkan dari `pert1-code/index.html`.
