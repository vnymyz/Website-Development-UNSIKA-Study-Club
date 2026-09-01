# Pertemuan 1 — Fondasi Web & HTML

**Durasi:** 19.30–21.00 WIB
**Tools:** VS Code, ekstensi Live Server, browser (Chrome/Edge)
**Output:** Peserta dapat menjalankan proyek web lokal dan membuat halaman HTML multi-section untuk katalog UMKM.

## Cara menjalankan kode di folder ini

`index.html` di folder ini adalah **hasil akhir** sesi ini. Buka lewat Live Server (klik kanan `index.html` di VS Code → **Open with Live Server**). Kalau ikut kelas dari awal, jangan buka file ini dulu — ikuti dulu bagian Hands-on di bawah dan bikin filenya sendiri; file ini jadi jaring pengaman kalau tertinggal.

## Tujuan belajar

- Memahami apa itu website dan bagaimana browser menampilkannya.
- Memahami peran HTML, CSS, dan JavaScript dalam sebuah halaman web.
- Menulis struktur HTML yang benar memakai tag semantik.
- Membuat form input sederhana.
- Menjalankan proyek secara lokal memakai VS Code dan Live Server.

## Rundown

| Waktu | Aktivitas |
|---|---|
| 19.30–19.40 | Pembukaan, ice breaking: "Website apa yang paling sering kalian buka hari ini?" |
| 19.40–19.55 | Teori: cara kerja website, client-server, peran HTML/CSS/JS |
| 19.55–20.10 | Setup VS Code + Live Server, membuat proyek pertama |
| 20.10–20.45 | Hands-on: menulis struktur HTML katalog UMKM section demi section |
| 20.45–20.55 | Latihan: menambahkan form kontak |
| 20.55–21.00 | Rangkuman dan pengantar kuis 1 |

## Teori

### Apa itu website?

Website adalah kumpulan halaman yang bisa dibuka lewat browser (Chrome, Edge, Firefox). Halaman itu berisi teks, gambar, tombol, dan bisa diklik-klik.

- Website berbeda dengan aplikasi desktop biasa: website hidup di internet, bukan di-install di komputer.
- Untuk membuat tampilannya, kita menulis kode yang dimengerti browser: **HTML, CSS, dan JavaScript**.
- Semua website besar (Tokopedia, Instagram, Gojek) pada dasarnya dibangun dari tiga bahan ini, hanya dengan skala dan alat bantu yang lebih rumit.

> Slide visual: tangkapan layar sebuah website sederhana dengan anotasi "ini HTML", "ini CSS", "ini JavaScript".

### Client dan server: analogi warung makan

Bayangkan kamu makan di warung:

- **Kamu (pembeli)** memesan makanan → ini seperti **client** (browser kamu) yang meminta halaman web.
- **Warung (penjual)** menyiapkan makanan lalu mengantar ke mejamu → ini seperti **server**, komputer yang menyimpan halaman web dan mengirimkannya balik.
- Prosesnya berulang: kamu pesan lagi, warung siapkan lagi.

Begitu juga saat kamu buka `www.contoh.com`:

```text
Browser (client)  --- "tolong kirim halaman ini" --->  Server
Browser (client)  <--- kirim balik HTML/CSS/JS  ------  Server
```

- **Client**: perangkat yang kamu pakai untuk membuka website (laptop, HP) lewat browser.
- **Server**: komputer lain (biasanya di data center) yang menyimpan file website dan mengirimkannya saat diminta.
- Proses "minta lalu dibalas" ini disebut **request** (permintaan) dan **response** (balasan). Bersama-sama disebut protokol **HTTP**.

> Slide visual: diagram panah bolak-balik Browser <-> Server dengan label "request" dan "response".

### Peran HTML, CSS, dan JavaScript

Analogi tubuh manusia sederhana:

| Bahasa | Analogi | Fungsi |
|---|---|---|
| HTML | Kerangka/tulang | Menentukan **struktur dan isi** halaman: judul, paragraf, tombol, gambar |
| CSS | Baju dan riasan | Menentukan **tampilan**: warna, ukuran, jarak, tata letak |
| JavaScript | Otot dan gerakan | Menentukan **interaksi**: tombol diklik, data berubah, muncul notifikasi |

- Tanpa CSS, halaman HTML tetap muncul tapi polos hitam-putih, tersusun dari atas ke bawah.
- Tanpa JavaScript, halaman tetap bisa dilihat tapi tidak bisa "bereaksi" terhadap klik atau input.
- Ketiganya dipelajari bertahap: HTML (pertemuan 1), CSS (pertemuan 2), JavaScript (pertemuan 3).

### Struktur dasar dokumen HTML

Setiap file HTML punya kerangka wajib:

```html
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>Judul Tab Browser</title>
</head>
<body>
  <h1>Konten halaman ditulis di sini</h1>
</body>
</html>
```

Penjelasan tiap baris:

- `<!DOCTYPE html>` — memberi tahu browser bahwa file ini HTML versi terbaru (HTML5).
- `<html lang="id">` — pembungkus seluruh halaman; `lang="id"` menandai bahasa Indonesia.
- `<head>` — bagian "belakang layar": judul tab, pengaturan karakter, tautan ke file CSS (nanti). Tidak tampil di halaman.
- `<meta charset="UTF-8">` — memastikan karakter seperti huruf é atau simbol Rp tampil benar.
- `<title>` — teks yang muncul di tab browser.
- `<body>` — semua yang **tampil** di halaman ditulis di sini.

### Tag semantik: memberi nama pada setiap bagian halaman

"Semantik" artinya nama tag menjelaskan **arti/fungsi** bagian itu, bukan cuma tampilannya. Ini memudahkan browser, mesin pencari, dan sesama developer memahami struktur halaman.

| Tag | Fungsi |
|---|---|
| `<header>` | Bagian atas halaman: logo, judul, menu navigasi |
| `<nav>` | Kumpulan link navigasi |
| `<main>` | Konten utama halaman |
| `<section>` | Satu kelompok konten dengan tema tertentu |
| `<footer>` | Bagian bawah halaman: hak cipta, kontak, sosial media |

```text
<header>  → Logo Katalog UMKM + menu
<main>
  <section> → Daftar UMKM
  <section> → Tentang
  <section> → Kontak
</main>
<footer>  → Hak cipta 2026
```

> Slide visual: kotak-kotak bertumpuk melambangkan header, main (berisi 3 section), footer.

### Tag umum untuk isi konten

- **Heading**: `<h1>` sampai `<h6>` — judul dan sub-judul, urut dari paling penting (`h1`) ke paling kecil.
- **Paragraf**: `<p>` — teks biasa.
- **List**: `<ul>` (list tanpa urutan) dan `<ol>` (list berurutan), isinya `<li>` per item.
- **Gambar**: `<img src="alamat-gambar.jpg" alt="deskripsi gambar">`.
- **Link**: `<a href="alamat-tujuan">teks link</a>`.

```html
<h1>Katalog UMKM Karawang</h1>
<p>Temukan usaha lokal terbaik di Karawang.</p>
<ul>
  <li>Kuliner</li>
  <li>Fashion</li>
  <li>Kerajinan</li>
</ul>
<img src="umkm1.jpg" alt="Warung Bu Sari">
<a href="#kontak">Hubungi Kami</a>
```

### Menampilkan Gambar, GIF, Video, dan Audio

HTML enggak cuma bisa nampilin teks — halaman web sekarang penuh gambar, video, dan suara. Untungnya, caranya enggak jauh beda dari yang sudah kita pelajari.

- **Gambar** — pakai `<img src="alamat-file" alt="deskripsi">`, sama seperti yang sudah dipelajari di atas. **GIF sebenarnya cuma gambar biasa** yang isinya banyak frame berurutan sehingga kelihatan bergerak — cara nampilinnya di HTML **sama persis** dengan gambar `.jpg`/`.png`, tinggal ganti nama filenya jadi `.gif`.
- **Video** — ada dua cara, tergantung sumber videonya:
  - **Video file sendiri** (`.mp4` dsb, disimpan di folder proyek) — pakai tag `<video>` dengan atribut `controls`.
  - **Video dari YouTube** — **bukan** pakai `<video>`, karena YouTube tidak memberikan link file video langsung (untuk alasan hak cipta dan bandwidth). Caranya pakai `<iframe>` yang menampilkan video itu seperti "jendela" ke halaman YouTube.
- **Audio** — pakai tag `<audio>`, juga butuh atribut `controls` supaya pengguna bisa play/pause.

```html
<img src="foto-umkm.jpg" alt="Suasana pasar UMKM Karawang">

<iframe
  width="400"
  height="225"
  src="https://www.youtube.com/embed/M7lc1UVf-VE"
  title="Video profil UMKM"
  allowfullscreen
></iframe>

<audio src="audio-testimoni-pelanggan.mp3" controls></audio>
```

- `<iframe>` — tag untuk menampilkan halaman/konten dari situs lain di dalam halaman kita, semacam "jendela" ke website lain.
- URL embed YouTube **bukan** URL biasa saat nonton (`youtube.com/watch?v=...`) — bagian `watch?v=` diganti jadi `embed/`. Cara paling gampang: buka video YouTube-nya, klik **Share > Embed**, lalu salin `src` dari kode `<iframe>` yang muncul di situ.
- `allowfullscreen` — atribut supaya tombol layar penuh di video YouTube berfungsi.
- `width` dan `height` — mengatur ukuran tampilan iframe dalam piksel.
- `controls` — atribut wajib di `<audio>` (dan `<video>` kalau pakai file sendiri) supaya pengguna punya tombol buat mengatur pemutarannya sendiri.
- Gambar (`src="alamat-file"`) juga bisa berupa **file lokal** atau **link ke internet** — keduanya valid.

> Slide visual: tiga ikon berdampingan — gambar, kamera video, dan speaker — masing-masing dengan potongan tag `<img>`, `<iframe>` (YouTube), `<audio>` di bawahnya.

### Form: mengumpulkan input dari pengguna

Form dipakai saat pengguna perlu **mengetik atau memilih sesuatu**, misalnya form kontak atau form login (dipakai lagi di pertemuan 5).

```html
<form>
  <label for="nama">Nama</label>
  <input type="text" id="nama" name="nama" placeholder="Nama kamu">

  <label for="pesan">Pesan</label>
  <textarea id="pesan" name="pesan" placeholder="Tulis pesan..."></textarea>

  <button type="submit">Kirim</button>
</form>
```

- `<label>` — teks penjelas untuk input, `for` harus sama dengan `id` input agar saling terhubung (klik label akan fokus ke input).
- `<input type="text">` — kotak isian satu baris.
- `<textarea>` — kotak isian banyak baris.
- `<button type="submit">` — tombol untuk mengirim form. Belum berfungsi mengirim data ke mana pun sampai kita pelajari JavaScript (pertemuan 3) dan database (pertemuan 4).

### Tools yang Dibutuhkan Hari Ini

Sebelum mulai ngoding, siapkan tiga hal ini dulu di laptop kamu.

- **VS Code** — unduh di [code.visualstudio.com/Download](https://code.visualstudio.com/Download) — editor tempat kita menulis semua kode HTML, gratis dan ringan, dipakai sepanjang kelas ini.
- **Ekstensi Live Server** — cari lewat [marketplace.visualstudio.com](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer) atau langsung dari tab Extensions di VS Code — biar halaman otomatis ter-refresh setiap file disimpan.
- **Browser modern** — Chrome ([google.com/chrome](https://www.google.com/chrome/)) atau Edge (sudah terpasang bawaan di Windows) — buat melihat hasil halaman dan memakai Inspect Element untuk debugging.

> Slide visual: screenshot VS Code dengan panel Extensions terbuka, ekstensi Live Server ter-highlight.

Belum perlu bikin akun GitHub, Supabase, atau Vercel hari ini — itu semua dipakai mulai pertemuan 2 dan seterusnya. Panduan instalasi lengkap dan langkah-langkahnya ada di `panduan-setup.md` di folder utama, dan juga di Hands-on bagian Langkah 1 di bawah ini.

## Hands-on: Langkah demi Langkah

### Langkah 1 — Instal VS Code dan ekstensi Live Server

1. Buka [code.visualstudio.com](https://code.visualstudio.com/), unduh, dan instal VS Code sesuai sistem operasi.
2. Buka VS Code, klik ikon **Extensions** di sidebar kiri (atau tekan `Ctrl + Shift + X`).
3. Ketik `Live Server` di kotak pencarian, pilih ekstensi buatan **Ritwick Dey**, klik **Install**.

**Cek hasil:** ekstensi muncul di daftar "Installed" pada tab Extensions.

**Kalau error:** kalau tombol Install tidak muncul, cek koneksi internet, atau restart VS Code.

### Langkah 2 — Membuat folder proyek

1. Buat folder baru di komputer, misalnya `website-umkm`.
2. Di VS Code, klik **File > Open Folder**, pilih folder `website-umkm` tadi.
3. Di sidebar kiri VS Code, klik ikon **New File**, buat file bernama `index.html`.

**Cek hasil:** file `index.html` muncul di sidebar dalam folder `website-umkm`.

### Langkah 3 — Menulis kerangka HTML dasar

1. Buka `index.html`, ketik `!` lalu tekan `Tab` (VS Code otomatis membuat boilerplate HTML5). Kalau tidak muncul, tulis manual:

```html
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Katalog UMKM Karawang</title>
</head>
<body>

</body>
</html>
```

2. Simpan file (`Ctrl + S`).
3. Klik kanan `index.html` di sidebar, pilih **Open with Live Server**.

**Cek hasil:** browser terbuka otomatis menampilkan halaman kosong dengan tab bertuliskan "Katalog UMKM Karawang".

**Kalau error:** kalau tidak ada opsi "Open with Live Server", pastikan ekstensi sudah ter-install dan VS Code sudah di-restart.

### Langkah 4 — Membuat section Header

Di dalam `<body>`, tambahkan:

```html
<header>
  <h1>Katalog UMKM Karawang</h1>
  <nav>
    <a href="#daftar-umkm">Daftar UMKM</a>
    <a href="#tentang">Tentang</a>
    <a href="#kontak">Kontak</a>
  </nav>
</header>
```

Simpan file. Karena Live Server aktif, browser akan otomatis ter-refresh.

**Cek hasil:** muncul judul "Katalog UMKM Karawang" dan tiga link navigasi di bagian atas halaman.

### Langkah 5 — Membuat section Daftar UMKM

Tambahkan setelah `</header>`, masih di dalam `<body>`:

```html
<main>
  <section id="daftar-umkm">
    <h2>Daftar UMKM</h2>
    <article>
      <h3>Warung Bu Sari</h3>
      <p>Kategori: Kuliner</p>
      <p>Alamat: Jl. Merdeka No. 10, Karawang</p>
    </article>
    <article>
      <h3>Batik Karawang Asli</h3>
      <p>Kategori: Fashion</p>
      <p>Alamat: Jl. Kertabumi No. 5, Karawang</p>
    </article>
    <article>
      <h3>Anyaman Bambu Pak Jaya</h3>
      <p>Kategori: Kerajinan</p>
      <p>Alamat: Jl. Tuparev No. 22, Karawang</p>
    </article>
  </section>
</main>
```

`<article>` dipakai untuk konten yang bisa "berdiri sendiri" — cocok untuk satu kartu UMKM.

**Cek hasil:** muncul judul "Daftar UMKM" dengan tiga blok informasi usaha.

### Langkah 6 — Membuat section Tentang dan Kontak, lalu Footer

Tambahkan sebelum `</main>`:

```html
  <section id="tentang">
    <h2>Tentang</h2>
    <p>Katalog ini dibuat untuk membantu warga menemukan UMKM lokal di Karawang.</p>
  </section>

  <section id="kontak">
    <h2>Kontak</h2>
    <form>
      <label for="nama">Nama</label>
      <input type="text" id="nama" name="nama" placeholder="Nama kamu">

      <label for="pesan">Pesan</label>
      <textarea id="pesan" name="pesan" placeholder="Tulis pesan..."></textarea>

      <button type="submit">Kirim</button>
    </form>
  </section>
```

Lalu tambahkan setelah `</main>`, sebelum `</body>`:

```html
<footer>
  <p>&copy; 2026 Katalog UMKM Karawang</p>
</footer>
```

**Cek hasil:** halaman lengkap punya empat bagian: Header (judul + menu), Daftar UMKM (3 kartu), Tentang, Kontak (form), dan Footer.

### Langkah 7 — Menambahkan Gambar, Video YouTube, dan Audio

Di dalam section `tentang`, tambahkan setelah paragraf yang sudah ada:

```html
<section id="tentang">
  <h2>Tentang</h2>
  <p>Katalog ini dibuat untuk membantu warga menemukan UMKM lokal di Karawang.</p>

  <img src="https://placehold.co/400x300" alt="Suasana pasar UMKM Karawang">

  <iframe
    width="400"
    height="225"
    src="https://www.youtube.com/embed/M7lc1UVf-VE"
    title="Video profil UMKM"
    allowfullscreen
  ></iframe>

  <audio src="audio-testimoni-pelanggan.mp3" controls></audio>
</section>
```

**Cek hasil:** muncul gambar placeholder abu-abu, lalu di bawahnya muncul video YouTube yang benar-benar bisa diputar (karena embed YouTube memang mengambil videonya langsung dari server YouTube), dan terakhir player audio dengan tombol play/pause — meski file audionya belum benar-benar ada di folder proyek.

**Kalau error:** kalau video YouTube tidak muncul, cek lagi URL-nya harus format `youtube.com/embed/ID-VIDEO`, bukan format biasa `youtube.com/watch?v=ID-VIDEO` — dua URL itu beda kegunaan. Kalau tombol play audio tidak jalan, itu wajar — `audio-testimoni-pelanggan.mp3` memang sengaja belum dibuat, fokus langkah ini adalah struktur tag yang benar. Nanti saat proyek beneran, ganti ID video YouTube di atas dengan video profil UMKM yang sesungguhnya, dan taruh file `.mp3` asli di folder proyek untuk audio.

### Langkah 8 — Mencoba klik menu navigasi

1. Klik link "Daftar UMKM" di menu atas.
2. Klik link "Kontak".

**Cek hasil:** halaman langsung meloncat (scroll) ke section yang sesuai, karena `href="#id-section"` menunjuk ke `id` yang sama pada tag `<section>`.

### Langkah 9 — Inspect Element

1. Klik kanan di halaman browser, pilih **Inspect** (atau tekan `F12`).
2. Coba klik salah satu elemen di tab **Elements**, perhatikan bagian HTML yang ikut ter-highlight di halaman.

**Cek hasil:** paham bahwa setiap elemen di halaman punya "alamat" di kode HTML, dan ini akan sering dipakai untuk debugging ke depannya.

### Hasil akhir sesi ini

Struktur folder:

```text
website-umkm/
└── index.html
```

`index.html` berisi halaman katalog UMKM dengan empat bagian: header + navigasi, daftar UMKM (3 kartu), tentang, dan form kontak. Halaman berjalan lokal lewat Live Server, tampilannya masih polos (belum ada CSS) — itu wajar, karena styling dipelajari pertemuan berikutnya.

## Catatan AI

Contoh prompt yang baik: "Jelaskan perbedaan tag `<section>` dan `<div>` dengan contoh sederhana. Jangan tuliskan kode lengkap punyaku." Verifikasi selalu jawaban AI dengan menjalankan kode lewat Live Server, jangan langsung percaya tanpa dicoba.

## Latihan mandiri

Tambahkan satu kartu UMKM baru pada section "Daftar UMKM" dengan kategori berbeda dari tiga contoh yang ada, lalu tambahkan satu `<img>` dengan `alt` yang menjelaskan gambarnya (gambar boleh belum ada/rusak, yang penting struktur tag benar).

## Rangkuman

Website terdiri dari HTML (struktur), CSS (tampilan), dan JavaScript (interaksi), dikirim dari server ke browser lewat mekanisme request-response. Hari ini kita fokus membangun struktur halaman dengan tag semantik. Minggu depan halaman ini akan dipercantik memakai CSS dan Tailwind, lalu disimpan versinya memakai Git dan GitHub.

## Istilah penting

| Istilah | Artinya |
|---|---|
| Client | Perangkat/browser yang meminta halaman web |
| Server | Komputer yang menyimpan dan mengirimkan halaman web |
| Request | Permintaan dari client ke server |
| Response | Balasan dari server ke client |
| HTTP | Aturan/protokol komunikasi antara client dan server |
| Tag semantik | Tag HTML yang namanya menjelaskan fungsi bagian tersebut |
| Live Server | Ekstensi VS Code untuk menjalankan halaman HTML secara lokal dengan auto-refresh |
| GIF | Gambar yang berisi banyak frame berurutan sehingga terlihat bergerak; ditampilkan di HTML sama seperti gambar biasa |
| `controls` | Atribut pada `<video>`/`<audio>` yang menampilkan tombol play/pause/volume untuk pengguna |
| `<iframe>` | Tag untuk menampilkan halaman/konten dari situs lain di dalam halaman kita, dipakai untuk embed video YouTube |

## Isi folder

- `index.html` — hasil akhir hands-on di atas.
