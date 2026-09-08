# Pertemuan 2 — CSS, Responsive Design & Git/GitHub

`index.html` dan `style.css` di folder ini adalah **hasil akhir** hands-on sesi ini. Buka lewat Live Server (klik kanan `index.html` di VS Code → **Open with Live Server**). Kalau ikut kelas dari awal, jangan buka file ini dulu — ikuti dulu bagian Hands-on di bawah dan lanjutkan dari `index.html` pertemuan 1; file ini jadi jaring pengaman kalau tertinggal.

**Durasi:** 19.30–21.00 WIB
**Tools:** VS Code, Live Server, Git, GitHub
**Output:** Peserta dapat menata tampilan halaman dengan CSS yang responsif, serta (kalau sempat) menyimpan proyek di repository GitHub.

## Tujuan belajar

- Memahami cara CSS menempel ke HTML dan cara kerja selector.
- Memahami box model dan tata letak Flexbox serta CSS Grid.
- Membuat halaman responsif dengan media query.
- Memahami kegunaan Git sebagai sistem versi.
- Melakukan commit dan push pertama ke GitHub (kalau waktu masih cukup).

## Rundown

| Waktu | Aktivitas |
|---|---|
| 19.30–19.40 | Pembukaan, ice breaking: "pernah nggak buka website yang berantakan di HP?" |
| 19.40–19.55 | Teori: CSS, selector, box model, Flexbox, Grid |
| 19.55–20.15 | Hands-on: styling halaman dengan CSS murni (box model, Flexbox, badge, hover) |
| 20.15–20.35 | Hands-on: media query + CSS Grid biar responsif dan tertata rapi |
| 20.35–20.55 | Teori + hands-on: Git dan GitHub, push ke GitHub (kalau sempat) |
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

### Display: Bagaimana Elemen Mengambil Ruang

Setiap elemen HTML punya "kepribadian" bawaan soal cara mengambil ruang di halaman — disebut `display`. Bayangkan rak buku: sebagian buku harus dapat satu rak sendiri (block), sebagian bisa nyempil sejajar dengan buku lain (inline).

- **`block`** — elemen ambil satu baris penuh, elemen berikutnya otomatis turun ke bawah. Default punya `<div>`, `<p>`, `<h1>`, `<section>`, dan sejenisnya.
- **`inline`** — elemen cuma ambil selebar isinya, sejajar dengan teks di sekitarnya, dan **tidak bisa** diatur `width`/`height`/margin atas-bawah. Default punya `<span>`, `<a>`, `<img>`.
- **`inline-block`** — gabungan keduanya: sejajar seperti inline, tapi bisa diatur `width`/`height`/padding seperti block. Berguna untuk tombol atau kartu kecil yang mau sejajar tapi tetap punya ukuran presisi.
- **`none`** — elemen dihilangkan total dari halaman, tidak makan tempat sama sekali. Beda dengan `visibility: hidden` yang cuma bikin tidak kelihatan tapi tempatnya tetap ada.

```css
.kotak-block { display: block; }
.kotak-inline { display: inline; }
.kotak-inline-block { display: inline-block; width: 100px; }
```

Tiga `<div>` dengan `display: block` akan bertumpuk ke bawah; ubah jadi `display: inline` atau `inline-block`, ketiganya jadi sejajar ke samping.

> Slide visual: tiga kotak warna berbeda — versi block (bertumpuk vertikal), versi inline (sejajar horizontal, ukuran ikut isi), versi inline-block (sejajar horizontal, ukuran seragam).

### Position: Menempatkan Elemen Secara Presisi

Analoginya seperti antrian: posisi normal (`static`) itu duduk sesuai urutan antrian. `relative` itu geser dikit dari kursi tanpa keluar antrian — kursimu tetap "dijatah". `absolute` itu keluar total dari antrian, langsung nempel ke titik tertentu.

- **`static`** — default, mengikuti alur normal dokumen. `top`/`left`/`right`/`bottom` tidak berpengaruh.
- **`relative`** — elemen bisa digeser dari posisi normalnya pakai `top`/`left`/`right`/`bottom`, tapi ruang aslinya tetap dijaga — elemen lain tidak ikut geser.
- **`absolute`** — elemen dilepas total dari alur normal, posisinya dihitung relatif terhadap **parent terdekat yang sudah diberi `position` selain static**. Kalau tidak ada, dia nempel ke seluruh halaman. Ini sebabnya pola **"relative parent + absolute child"** selalu berpasangan.

```css
.kartu {
  position: relative;
}

.badge {
  position: absolute;
  top: 8px;
  right: 8px;
}
```

Bonus: `position: fixed` dan `sticky` dipakai buat navbar yang "nempel" saat halaman di-scroll — pola umum di web sungguhan, lebih masuk akal dipraktikkan setelah belajar JavaScript/scroll behavior nanti.

> Slide visual: tiga kartu berdampingan dengan anotasi — "static: ikut baris", "relative: geser tapi jatahnya tetap", "absolute: lepas total, nempel ke parent".

### Pseudo-class `:hover`: Bereaksi Saat Disentuh Kursor

Seperti lampu otomatis yang menyala saat ada yang mendekat — `:hover` bikin CSS bereaksi **selagi** kursor ada di atas sebuah elemen, lalu otomatis kembali normal saat kursor pergi. Tanpa butuh JavaScript sama sekali.

- Ditambahkan ke selector manapun: `.tombol:hover { }`.
- Dipakai luas di web sungguhan: warna tombol berubah, link berubah underline, kartu sedikit membesar saat disorot.
- Tips kecil yang sering kelewat: tambahkan `cursor: pointer` di elemen yang bisa diklik, supaya kursor berubah jadi ikon tangan — sinyal visual bahwa elemen itu bisa diklik.

```css
header nav a:hover {
  text-decoration: underline;
}

button:hover {
  background-color: #334155;
  cursor: pointer;
}
```

> Slide visual: satu tombol digambar dua kondisi berdampingan — normal vs saat di-hover (warna beda), dengan ikon kursor di atas versi hover.

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

### CSS Grid: menata dalam baris DAN kolom sekaligus

Analogi: Flexbox itu kayak nyusun barang di satu rak — cuma satu arah, baris **atau** kolom. CSS Grid itu kayak rak susun berkotak-kotak: baris **dan** kolom sekaligus, jadi cocok buat tata letak yang lebih rumit dari sekadar "berjajar".

- `display: grid` — mengaktifkan Grid pada elemen ini.
- `grid-template-columns` — menentukan ada berapa kolom dan selebar apa masing-masing.
- `gap` — jarak antar sel grid (sama seperti di Flexbox).
- Unit `fr` (*fraction*) — bagian relatif dari ruang yang tersedia. `1fr 1fr` artinya 2 kolom sama lebar; `2fr 1fr` artinya kolom pertama dua kali lebih lebar dari kolom kedua.

```css
.dua-kolom {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;
}
```

Kapan pakai yang mana? Aturan praktis: **Flexbox buat menyusun 1 baris/kolom** (misalnya kartu UMKM berjajar horizontal), **Grid buat tata letak yang punya baris dan kolom sekaligus** (misalnya section dibagi 2: teks di kiri, gambar di kanan).

> Slide visual: satu section dibagi 2 kolom rapi (garis putus-putus menandai batas kolom), dengan label "1fr" di masing-masing kolom.

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
:root {
  --matcha-dark: #33422b;
  --matcha-mid: #7c9473;
  --sage-pale: #e9efe1;
  --cream: #f6f3e7;
  --gold: #c9a66b;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: "Segoe UI", system-ui, Arial, sans-serif;
  color: #1f2937;
  background-color: var(--cream);
  line-height: 1.6;
}

header {
  background-color: var(--matcha-dark);
  color: white;
  padding: 20px max(24px, calc((100% - 960px) / 2));
}

header nav a {
  color: white;
  margin-right: 16px;
  text-decoration: none;
}

section {
  padding: 40px max(24px, calc((100% - 960px) / 2));
}

section h2 {
  color: var(--matcha-dark);
  font-size: 1.6rem;
}
```

Simpan, lihat perubahan di browser (Live Server otomatis refresh).

- `:root { }` — tempat mendefinisikan **CSS variable** (`--nama-variabel`), dipakai berkali-kali lewat `var(--nama-variabel)` supaya warna konsisten dan gampang diganti dari satu tempat.
- `max(24px, calc((100% - 960px) / 2))` — trik supaya konten di dalam `header`/`section` tidak mepet ke tepi layar lebar, tapi tetap ada jarak minimum 24px di layar sempit. Tidak perlu dihafal detail rumusnya, cukup paham fungsinya: bikin konten "terpusat" dengan lebar maksimum.

**Cek hasil:** header berwarna hijau matcha gelap dengan teks putih, konten section tidak mepet ke tepi layar di laptop, ada jarak antar section.

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
  gap: 20px;
  flex-wrap: wrap;
}

.kartu {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  padding: 20px;
  flex: 1;
  min-width: 220px;
  box-shadow: 0 2px 6px rgba(51, 66, 43, 0.06);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.kartu:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 24px rgba(51, 66, 43, 0.12);
}
```

- `box-shadow` — bayangan halus di bawah kartu, bikin kartu terasa "terangkat" dari background.
- `.kartu:hover` — memakai pseudo-class `:hover` yang sudah dipelajari; kartu naik sedikit (`translateY(-4px)`) dan bayangannya membesar saat disorot kursor, transisinya halus berkat `transition`.

**Cek hasil:** tiga kartu UMKM berjajar horizontal dengan jarak rapi, bayangan halus di bawah tiap kartu, dan kartu terasa "terangkat" saat kursor diarahkan ke atasnya.

### Langkah 4 — Menambahkan Badge Kategori (Display + Position)

1. Di tiap `<article class="kartu">`, tambahkan `<span class="badge">` berisi nama kategorinya, sebelum `<h3>`. Untuk kartu "Warung Bu Sari":

```html
<article class="kartu">
  <span class="badge">Kuliner</span>
  <h3>Warung Bu Sari</h3>
  <p>Kategori: Kuliner</p>
  <p>Alamat: Jl. Merdeka No. 10, Karawang</p>
</article>
```

Lakukan hal sama untuk dua kartu lainnya (`Fashion` untuk Batik Karawang Asli, `Kerajinan` untuk Anyaman Bambu Pak Jaya).

2. Tambahkan di `style.css`:

```css
.kartu {
  position: relative;
}

.badge {
  position: absolute;
  top: 12px;
  right: 12px;
  display: inline-block;
  padding: 4px 12px;
  background-color: var(--gold);
  color: var(--matcha-dark);
  border-radius: 999px;
  font-size: 11px;
  font-weight: bold;
  text-transform: uppercase;
  letter-spacing: 0.03em;
}
```

**Cek hasil:** badge kecil warna gold muncul nempel presisi di pojok kanan-atas tiap kartu, berisi nama kategorinya dalam huruf kapital.

**Kalau error:** kalau badge malah nempel di pojok halaman (bukan pojok kartu), berarti `.kartu` lupa diberi `position: relative` — tanpa itu, `.badge` mencari parent lain yang punya `position` sampai ke `<html>`.

### Langkah 5 — Menambahkan Efek Hover

Tambahkan di `style.css`:

```css
header nav a:hover {
  text-decoration: underline;
}

button:hover {
  background-color: #334155;
  cursor: pointer;
}
```

**Cek hasil:** arahkan kursor ke link navigasi (tanpa klik) — muncul garis bawah. Arahkan kursor ke tombol "Kirim" — warnanya berubah dan kursor jadi ikon tangan.

**Kalau error:** kalau efek tidak muncul, cek selector `:hover` nempel langsung ke elemen yang benar (`a` di dalam `header nav`, bukan ke `header` saja).

### Langkah 6 — Menambahkan media query untuk HP

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

### Langkah 7 — Menata section Tentang jadi 2 kolom dengan CSS Grid

1. Di `index.html`, bungkus judul+paragraf section Tentang dalam satu `<div>`, dan gambar dalam `<div>` lain:

```html
<section id="tentang">
  <div class="tentang-teks">
    <h2>Tentang</h2>
    <p>Katalog ini dibuat untuk membantu warga menemukan UMKM lokal di Karawang.</p>
  </div>
  <div class="tentang-gambar">
    <img src="..." alt="Suasana pasar UMKM Karawang" />
  </div>
</section>
```

2. Tambahkan di `style.css`:

```css
#tentang {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
  align-items: center;
}

.tentang-gambar img {
  width: 100%;
  border-radius: 12px;
}
```

**Cek hasil:** teks dan gambar sekarang sejajar berdampingan dalam 2 kolom sama lebar, bukan bertumpuk vertikal seperti sebelumnya.

**Kalau error:** kalau gambar dan teks masih bertumpuk ke bawah, cek `<div class="tentang-teks">` dan `<div class="tentang-gambar">` posisinya harus jadi **anak langsung** dari `#tentang` — Grid cuma mengatur anak langsungnya, bukan cucu-cucunya.

### Langkah 8 — Merapikan Form Kontak

Form yang sudah dibuat pertemuan 1 masih tampilan bawaan browser — polos dan kurang enak dilihat. Tambahkan di `style.css`:

```css
form {
  display: flex;
  flex-direction: column;
  gap: 12px;
  max-width: 420px;
}

form label {
  font-weight: bold;
  color: var(--matcha-dark);
  font-size: 0.9rem;
}

form input,
form textarea {
  border: 1px solid #d8d2bf;
  border-radius: 8px;
  padding: 10px 12px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
  transition: border-color 0.2s, box-shadow 0.2s;
}

form input:focus,
form textarea:focus {
  outline: none;
  border-color: var(--matcha-mid);
  box-shadow: 0 0 0 3px rgba(124, 148, 115, 0.2);
}

button {
  background-color: var(--matcha-mid);
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 8px;
  font-size: 0.95rem;
  align-self: flex-start;
  transition: background-color 0.2s, transform 0.15s;
}

button:hover {
  background-color: var(--matcha-dark);
  cursor: pointer;
  transform: translateY(-1px);
}
```

- `display: flex; flex-direction: column;` pada `form` — menyusun label/input/textarea/tombol vertikal dengan jarak rapi (`gap`), bukan menempel bawaan browser.
- `:focus` — mirip `:hover`, tapi aktif selagi input sedang **diklik/diketik** (fokus), bukan cuma disorot kursor. Memberi garis biru-hijau lembut supaya pengguna tahu input mana yang sedang aktif.
- `align-self: flex-start` pada tombol — supaya tombol tidak ikut melebar penuh seperti input di atasnya, cukup selebar teksnya.

**Cek hasil:** form Kontak sekarang punya jarak rapi antar elemen, kotak input bergaris tipis dengan sudut membulat, dan menyala hijau lembut saat diklik. Tombol Kirim berwarna hijau matcha dan sedikit naik saat disorot kursor.

### Langkah 9 — Instal Git dan inisialisasi repo

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

### Langkah 10 — Commit pertama

```bash
git add .
git commit -m "Tampilan awal katalog UMKM dengan CSS"
```

**Cek hasil:** terminal menampilkan ringkasan file yang di-commit, tanpa pesan error.

**Kalau error:** kalau muncul pesan minta `user.name`/`user.email`, jalankan dulu perintah `git config` dari `panduan-setup.md`.

### Langkah 11 — Membuat repo di GitHub dan push

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

Halaman sudah responsif. Proyek sudah tersimpan di GitHub dengan minimal 2 commit.

## Bahan Visual Tambahan

`gambar-visual/html-dan-css.html` adalah halaman demo interaktif — bukan bagian dari proyek katalog UMKM, murni alat bantu mengajar. Buka langsung di browser (double-click filenya atau lewat Live Server), tidak butuh internet karena semua HTML+CSS+JS ada dalam satu file.

Isinya animasi/interaksi langsung untuk tiap konsep yang dipelajari hari ini:

- **Toggle "HTML Polos vs HTML + CSS"** — sakelar yang menyalakan/mematikan CSS pada satu kartu produk (HTML-nya sama persis), langsung kelihatan bedanya. Cocok jadi pembuka demo karena langsung jawab pertanyaan "CSS itu ngapain sih".
- **Struktur tag semantik** — kotak-kotak muncul bertahap sesuai urutan tag di HTML.
- **`<div>` vs `<span>`** — perbandingan visual block vs inline.
- **Box model** — klik tombol Margin/Border/Padding/Content untuk menyorot lapisan itu.
- **Display** — klik block/inline/inline-block secara manual, atau tekan **▶ Putar Otomatis** supaya semua kondisi berganti sendiri tiap 1,5 detik.
- **Position** — klik static/relative/absolute/fixed secara manual, atau tekan **▶ Putar Otomatis** untuk melihat semua siklusnya tanpa klik satu-satu.
- **Flexbox** — ganti `justify-content`, lihat kotak-kotak bergeser otomatis dengan animasi halus.
- **`:hover`** — kartu dan tombol yang bereaksi begitu kursor diarahkan ke atasnya, tanpa JavaScript.
- **Kesimpulan Visual** — kartu "Tanpa CSS" vs "Dengan CSS" berdampingan di akhir, rangkuman visual sebelum footer.

Tiap section demo juga muncul dengan animasi fade+slide begitu di-scroll ke posisinya (pakai `IntersectionObserver`), jadi halaman terasa hidup dari atas sampai bawah, bukan cuma interaktif kalau diklik. Cocok ditampilkan lewat proyektor saat menjelaskan konsep secara live, sebagai pelengkap slide PPT yang lebih statis.

## Catatan AI

Contoh prompt yang baik: "Jelaskan kapan sebaiknya pakai Flexbox `row` vs `column`, dengan contoh kartu produk. Jangan tuliskan CSS lengkap punyaku, cukup jelaskan konsepnya." Selalu cek hasil di browser — AI bisa saja memberi kode yang sebenarnya tidak sesuai kebutuhan tampilanmu.

## Latihan mandiri

Ubah salah satu warna di `:root` (misalnya `--gold`), lalu perhatikan semua elemen yang memakai `var(--gold)` ikut berubah otomatis. Tambahkan juga satu efek `:hover` baru pada elemen pilihanmu sendiri (misalnya logo di header). Commit perubahan ini dengan pesan commit yang jelas.

## Rangkuman

CSS menata tampilan lewat selector, box model, display, dan position; Flexbox dan Grid menata elemen berjajar maupun dalam baris-kolom; media query bikin tampilan menyesuaikan lebar layar; `:hover` bikin elemen bereaksi tanpa JavaScript. Git menyimpan riwayat perubahan kode, GitHub menyimpannya online. Minggu depan kita membuat halaman jadi hidup dengan JavaScript: klik tombol, filter data, dan validasi form.

## Istilah penting

| Istilah | Artinya |
|---|---|
| Selector | Penanda elemen HTML mana yang ingin distyle di CSS |
| Box model | Susunan content, padding, border, margin pada setiap elemen |
| Display | Properti CSS yang menentukan cara elemen mengambil ruang: block, inline, inline-block, none |
| Block | Elemen mengambil satu baris penuh |
| Inline | Elemen hanya mengambil selebar isinya, sejajar dengan teks |
| Inline-block | Gabungan block dan inline: sejajar tapi bisa diatur ukurannya |
| Position | Properti CSS untuk menempatkan elemen: static, relative, absolute, fixed |
| Relative | Elemen digeser dari posisi normalnya, tapi ruang aslinya tetap dijaga |
| Absolute | Elemen dilepas dari alur normal, ditempatkan relatif terhadap parent ber-`position` |
| Pseudo-class | Selector tambahan yang menandai kondisi tertentu pada elemen, misalnya `:hover` |
| `:hover` | Pseudo-class yang aktif selagi kursor berada di atas elemen |
| Flexbox | Metode CSS untuk menata elemen sejajar dalam 1 baris atau 1 kolom |
| CSS Grid | Metode CSS untuk menata elemen dalam baris DAN kolom sekaligus |
| `fr` | Unit CSS Grid, "fraction" — bagian relatif dari ruang yang tersedia |
| Media query | Aturan CSS yang berubah tergantung lebar layar |
| Repository | Folder proyek yang dilacak riwayat perubahannya oleh Git |
| Commit | Titik simpan berisi catatan perubahan kode |
| Push | Mengirim commit dari komputer ke GitHub |

## Isi folder

- `index.html` — versi jadi dari katalog UMKM, ditata ulang sebagai landing page.
- `style.css` — CSS versi jadi.
- `getout.mp3` — file audio untuk demo tag `<audio>`.
- `gambar-visual/html-dan-css.html` — halaman demo visual interaktif untuk bahan mengajar, lihat bagian tersendiri di bawah.

> **Catatan:** `index.html` dan `style.css` di folder ini sengaja digarap lebih jauh daripada Hands-on di atas — pakai Google Fonts, CSS Grid, `aspect-ratio`, peta Google Maps embed, dan sedikit JavaScript (tombol "kembali ke atas" + animasi muncul saat discroll pakai `IntersectionObserver`) yang belum dibahas hari ini. Kalau kamu ikuti Hands-on langkah demi langkah, hasilmu akan lebih sederhana (dan itu wajar/benar) — file ini contoh "kalau diteruskan sendiri di rumah, bisa jadi seperti apa". Setiap bagian di kedua file ini sudah dikasih komentar (`<!-- ... -->` di HTML, `/* ... */` di CSS) yang menjelaskan tag/properti apa yang dipakai dan kenapa — boleh dibaca dan dibongkar pelan-pelan setelah materi hari ini selesai.
>
> Mau coba ngetik dari nol, bertahap, sampai hasilnya persis sama seperti file ini? Ikuti **[`PANDUAN-LANDING-PAGE.md`](./PANDUAN-LANDING-PAGE.md)** — 24 langkah, tiap langkah ada kode lengkapnya sendiri, bisa langsung dicoba satu-satu di browser.
