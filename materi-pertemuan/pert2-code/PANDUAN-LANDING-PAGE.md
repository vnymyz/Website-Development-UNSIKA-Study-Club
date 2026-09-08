# Panduan Step-by-Step: Bangun Landing Page Katalog UMKM dari Nol

Dokumen ini buat kamu yang mau paham **cara** `index.html` dan `style.css` di folder ini dibangun — bukan cuma buka file jadi terus bingung kok bisa serapi ini. Ikuti urutannya dari atas, satu langkah demi satu langkah, dan **ketik manual** (jangan copy-paste borongan). Tiap selesai satu langkah, buka file-nya di browser (disarankan pakai Live Server di VS Code) sebelum lanjut ke langkah berikutnya, biar kamu betul-betul lihat efek tiap baris kode yang baru ditambahkan.

> Materi konsepnya (apa itu `display`, `position`, Flexbox, dst) sudah dibahas lengkap di `README.md`. Dokumen ini fokus ke **proses membangun**, bukan pengulangan teori — tapi tetap disinggung sekilas tiap kali konsep baru muncul.

Tiap langkah nampilin **seluruh isi file sampai titik itu** (bukan cuma baris yang baru ditambahkan), jadi kamu bisa langsung timpa file kamu dengan isi kotak kode itu dan langsung lihat hasilnya — tidak perlu nebak taruh di mana.

## Persiapan

1. Buat folder kosong buat latihan, misal `latihan-landing-page/`.
2. Buat file kosong bernama `index.html` di dalamnya.
3. Buka folder itu di VS Code, aktifkan ekstensi **Live Server**.

## Daftar Isi

**Bagian HTML & CSS dasar**
- [Langkah 1 — Kerangka HTML paling dasar](#langkah-1--kerangka-html-paling-dasar)
- [Langkah 2 — Isi `<head>` lengkap](#langkah-2--isi-head-lengkap)
- [Langkah 3 — Menyambungkan ke CSS](#langkah-3--menyambungkan-ke-css)
- [Langkah 4 — Reset dasar dan CSS variable](#langkah-4--reset-dasar-dan-css-variable)

**Header**
- [Langkah 5 — HTML: Header dan navigasi](#langkah-5--html-header-dan-navigasi)
- [Langkah 6 — CSS: Styling header](#langkah-6--css-styling-header)

**Hero**
- [Langkah 7 — HTML: Section Hero](#langkah-7--html-section-hero)
- [Langkah 8 — CSS: Styling Hero (background gonta-ganti otomatis)](#langkah-8--css-styling-hero-background-gonta-ganti-otomatis)

**Direktori**
- [Langkah 9 — HTML: Section Direktori (kartu, cari, filter, paginasi)](#langkah-9--html-section-direktori-kartu-cari-filter-paginasi)
- [Langkah 10 — CSS: Styling Direktori](#langkah-10--css-styling-direktori)

**Tentang**
- [Langkah 11 — HTML: Section Tentang](#langkah-11--html-section-tentang)
- [Langkah 12 — CSS: Styling Tentang](#langkah-12--css-styling-tentang)

**Testimoni**
- [Langkah 13 — HTML: Section Testimoni](#langkah-13--html-section-testimoni)
- [Langkah 14 — CSS: Styling Testimoni](#langkah-14--css-styling-testimoni)

**Video**
- [Langkah 15 — HTML: Section Video](#langkah-15--html-section-video)
- [Langkah 16 — CSS: Styling Video](#langkah-16--css-styling-video)

**Lokasi**
- [Langkah 17 — HTML: Section Lokasi (peta)](#langkah-17--html-section-lokasi-peta)
- [Langkah 18 — CSS: Styling Lokasi](#langkah-18--css-styling-lokasi)

**Kontak**
- [Langkah 19 — HTML: Section Kontak (form)](#langkah-19--html-section-kontak-form)
- [Langkah 20 — CSS: Styling Kontak](#langkah-20--css-styling-kontak)

**Footer dan sentuhan akhir**
- [Langkah 21 — HTML: Footer dan tombol kembali ke atas](#langkah-21--html-footer-dan-tombol-kembali-ke-atas)
- [Langkah 22 — CSS: Styling Footer dan tombol kembali ke atas](#langkah-22--css-styling-footer-dan-tombol-kembali-ke-atas)
- [Langkah 23 — JavaScript: Navbar sembunyi, tombol ke atas, dan efek muncul saat discroll](#langkah-23--javascript-navbar-sembunyi-tombol-ke-atas-dan-efek-muncul-saat-discroll)
- [Langkah 24 — CSS: Bikin responsif dan hormati "reduce motion"](#langkah-24--css-bikin-responsif-dan-hormati-reduce-motion)

- [Penutup](#penutup)

---

## Langkah 1 — Kerangka HTML paling dasar

Sebelum nulis apa pun yang kelihatan, tiap halaman HTML butuh kerangka wajib ini. `<!doctype html>` bilang ke browser "ini dokumen HTML5". `<html lang="id">` bungkus semuanya, `lang="id"` kasih tahu browser (dan pembaca layar) kontennya berbahasa Indonesia. `<head>` isinya info buat browser (belum kelihatan di halaman), `<body>` isinya yang bakal tampil.

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
  </head>
  <body>

  </body>
</html>
```

Buka di browser: halaman putih kosong. Wajar — `<body>` memang belum diisi apa-apa.

## Langkah 2 — Isi `<head>` lengkap

Sekarang lengkapi `<head>`: `meta viewport` bikin halaman menyesuaikan lebar layar HP (tanpa ini, halaman HP bakal ke-zoom-out kayak lihat versi desktop), `<title>` jadi judul di tab browser, lalu dua link CDN — Google Fonts (font **Plus Jakarta Sans** yang dipakai di seluruh halaman) dan Font Awesome (kumpulan ikon, dipakai nanti buat ikon medsos dan telepon).

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Katalog UMKM Karawang</title>

    <!-- Google Fonts: Plus Jakarta Sans, satu family buat judul (weight tebal) dan teks biasa (weight normal) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <!-- Font Awesome lewat CDN, dipakai buat ikon medsos di footer dan ikon telepon di kartu UMKM -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />
  </head>
  <body>

  </body>
</html>
```

Belum ada bedanya secara visual (body masih kosong), tapi coba lihat tab browser — judulnya sekarang "Katalog UMKM Karawang".

## Langkah 3 — Menyambungkan ke CSS

HTML ngatur **struktur**, CSS ngatur **tampilan**. Bisa saja nulis CSS langsung di dalam `<style>` di `<head>`, tapi kita pisah ke file sendiri (`style.css`) supaya HTML tetap rapi dan CSS-nya bisa dipakai ulang. Buat file baru namanya **`style.css`** (kosongkan dulu, isinya nanti di Langkah 4), lalu sambungkan lewat `<link rel="stylesheet">`.

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Katalog UMKM Karawang</title>

    <!-- Google Fonts: Plus Jakarta Sans, satu family buat judul (weight tebal) dan teks biasa (weight normal) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <!-- Font Awesome lewat CDN, dipakai buat ikon medsos di footer dan ikon telepon di kartu UMKM -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>

  </body>
</html>
```

Penting: `style.css` harus ada di **folder yang sama** dengan `index.html`, kalau tidak link-nya gak nemu filenya (cek tab Network di DevTools kalau ragu, harusnya `style.css` muncul dengan status 200).

## Langkah 4 — Reset dasar dan CSS variable

Ini isi pertama `style.css`. Dua hal penting di sini:

- **Reset** (`* { margin: 0; padding: 0; box-sizing: border-box; }`) — tiap browser punya margin/padding bawaan yang beda-beda buat elemen seperti `<h1>` atau `<body>`. Reset ini nyamain semuanya jadi 0 dulu, baru kita atur ulang sesuai kebutuhan.
- **CSS variable** (`:root { --nama: nilai; }`) — tempat naruh nilai yang dipakai berkali-kali (di sini: warna). Dipanggil lewat `var(--nama)`. Enaknya, kalau nanti mau ganti skema warna, cukup ubah di satu tempat ini.

`html { scroll-behavior: smooth; }` bikin perpindahan ke `#id` (nanti dipakai link nav) meluncur halus, bukan langsung loncat.

```css
/*
  CSS variable (custom property). Ditulis sekali di :root, dipakai
  berkali-kali lewat var(--nama). Kalau mau ganti warna tema, cukup
  ubah di sini — tidak perlu cari-ganti di semua tempat.
*/
:root {
  --matcha-abyss: #1e2a18;
  --matcha-dark: #33422b;
  --matcha-mid: #7c9473;
  --sage-pale: #e9efe1;
  --cream: #f6f3e7;
  --gold: #c9a66b;
  --ink: #1f2937;
  --content-width: 1080px;
}

/* Reset dasar: hilangkan margin/padding bawaan browser yang beda-beda tiap browser */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box; /* border & padding dihitung masuk ke lebar elemen, bukan nambah lebar */
}

/*
  scroll-behavior: smooth membuat perpindahan ke #id (misalnya klik link
  nav ke "#tentang") meluncur halus, bukan langsung loncat.
  scroll-padding-top mengimbangi tinggi header yang sticky, supaya judul
  section tidak ketutupan header saat baru sampai.
*/
html {
  scroll-behavior: smooth;
  scroll-padding-top: 84px;
}

body {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  color: var(--ink);
  background-color: var(--cream);
  line-height: 1.6;
}

h1, h2, h3 {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  font-weight: 800;
}

a {
  color: inherit;
}
```

Buka lagi di browser: masih putih kosong (belum ada konten di `<body>`), tapi kalau kamu buka DevTools dan cek `<body>`, background-nya sudah krem (`--cream`) bukan putih polos bawaan browser lagi.

## Langkah 5 — HTML: Header dan navigasi

Mulai isi `<body>`. Bagian pertama: `<header>` berisi nama situs dan menu navigasi. Perhatikan ada `<span aria-hidden="true"></span>` kosong di akhir — itu sengaja, fungsinya jadi "penyeimbang" buat grid 3 kolom yang bakal kita buat di Langkah 6 (biar nav-nya beneran di tengah, bukan nempel kanan).

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Katalog UMKM Karawang</title>

    <!-- Google Fonts: Plus Jakarta Sans, satu family buat judul (weight tebal) dan teks biasa (weight normal) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <!-- Font Awesome lewat CDN, dipakai buat ikon medsos di footer dan ikon telepon di kartu UMKM -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <!--
      HEADER
      "sticky" di style.css bikin header ini tetap kelihatan walau halaman
      discroll ke bawah. Ini salah satu contoh nyata `position: sticky`
      yang disebutkan sekilas di materi Position.
    -->
    <header>
      <!--
        header-inner pakai 3 kolom grid (kiri-tengah-kanan) supaya nav
        benar-benar di tengah header, bukan ikut menempel ke kanan
        seperti pola flexbox space-between biasa.
      -->
      <div class="header-inner">
        <span class="wordmark">UMKM Karawang</span>
        <nav>
          <a href="#daftar-umkm">UMKM</a>
          <a href="#tentang">Tentang</a>
          <a href="#kontak">Daftar</a>
        </nav>
        <span aria-hidden="true"></span>
      </div>
    </header>
  </body>
</html>
```

Coba buka di browser: kelihatan teks "UMKM Karawang" lalu 3 link di bawahnya, berurutan ke bawah, polos tanpa warna — wajar, CSS-nya belum ditulis.

## Langkah 6 — CSS: Styling header

Sekarang header-nya dibikin jadi bar hijau tua yang nempel di atas. Bagian paling menarik: `grid-template-columns: 1fr auto 1fr`. Kolom kiri (wordmark) dan kolom kanan (`<span>` kosong tadi) sama-sama `1fr`, jadi lebarnya **selalu sama** apa pun isinya — efeknya kolom tengah (nav) selalu benar-benar di tengah header.

```css
/*
  CSS variable (custom property). Ditulis sekali di :root, dipakai
  berkali-kali lewat var(--nama). Kalau mau ganti warna tema, cukup
  ubah di sini — tidak perlu cari-ganti di semua tempat.
*/
:root {
  --matcha-abyss: #1e2a18;
  --matcha-dark: #33422b;
  --matcha-mid: #7c9473;
  --sage-pale: #e9efe1;
  --cream: #f6f3e7;
  --gold: #c9a66b;
  --ink: #1f2937;
  --content-width: 1080px;
}

/* Reset dasar: hilangkan margin/padding bawaan browser yang beda-beda tiap browser */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box; /* border & padding dihitung masuk ke lebar elemen, bukan nambah lebar */
}

/*
  scroll-behavior: smooth membuat perpindahan ke #id (misalnya klik link
  nav ke "#tentang") meluncur halus, bukan langsung loncat.
  scroll-padding-top mengimbangi tinggi header yang sticky, supaya judul
  section tidak ketutupan header saat baru sampai.
*/
html {
  scroll-behavior: smooth;
  scroll-padding-top: 84px;
}

body {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  color: var(--ink);
  background-color: var(--cream);
  line-height: 1.6;
}

h1, h2, h3 {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  font-weight: 800;
}

a {
  color: inherit;
}

/* ================= HEADER ================= */
/*
  position: sticky membuat header ini nempel di atas begitu halaman
  discroll sampai posisinya, lalu tetap di situ (beda dengan "fixed"
  yang nempel dari awal halaman dibuka).
*/
header {
  position: sticky;
  top: 0;
  z-index: 10;
  background-color: var(--matcha-abyss);
  color: white;
  transition: transform 0.3s ease;
}

/* Ditambahkan lewat JS saat pengguna scroll ke bawah — header digeser ke atas sampai hilang */
header.sembunyi {
  transform: translateY(-100%);
}

/*
  Grid 3 kolom "1fr auto 1fr": kolom kiri (wordmark) dan kolom kanan
  (spacer kosong) selalu diberi lebar yang SAMA karena sama-sama 1fr,
  apa pun isinya. Efeknya kolom tengah (nav) selalu benar-benar di
  tengah header — beda dengan flexbox space-between yang mendorong nav
  ke ujung kanan mengikuti lebar wordmark.
*/
.header-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 20px 24px;
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: center;
  gap: 12px;
}

.wordmark {
  font-family: "Plus Jakarta Sans", sans-serif;
  font-weight: 800;
  font-size: 1.2rem;
  letter-spacing: -0.01em;
}

header nav {
  display: flex;
  gap: 24px;
}

header nav a {
  color: var(--sage-pale);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  padding-bottom: 2px;
  border-bottom: 2px solid transparent;
  transition: border-color 0.2s, color 0.2s;
}

header nav a:hover,
header nav a:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}
```

Reload browser: header sekarang jadi bar hijau tua, nav-nya beneran di tengah. `header.sembunyi` belum kepakai — itu baru difungsikan lewat JavaScript di Langkah 23, sekarang cuma disiapkan CSS-nya duluan.

## Langkah 7 — HTML: Section Hero

Bagian paling atas setelah header: Hero, isinya judul besar + ajakan bertindak (CTA). Yang agak beda: ada 3 `<div class="hero-bg">` kosong (isinya cuma `style="background-image: ..."`) dan satu `<div class="hero-overlay">` — ini bakal jadi latar foto yang gonta-ganti otomatis, CSS-nya nyusul di Langkah 8. Section ini (dan semua section sesudahnya) dibungkus `<main>`.

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Katalog UMKM Karawang</title>

    <!-- Google Fonts: Plus Jakarta Sans, satu family buat judul (weight tebal) dan teks biasa (weight normal) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <!-- Font Awesome lewat CDN, dipakai buat ikon medsos di footer dan ikon telepon di kartu UMKM -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <!--
      HEADER
      "sticky" di style.css bikin header ini tetap kelihatan walau halaman
      discroll ke bawah. Ini salah satu contoh nyata `position: sticky`
      yang disebutkan sekilas di materi Position.
    -->
    <header>
      <!--
        header-inner pakai 3 kolom grid (kiri-tengah-kanan) supaya nav
        benar-benar di tengah header, bukan ikut menempel ke kanan
        seperti pola flexbox space-between biasa.
      -->
      <div class="header-inner">
        <span class="wordmark">UMKM Karawang</span>
        <nav>
          <a href="#daftar-umkm">UMKM</a>
          <a href="#tentang">Tentang</a>
          <a href="#kontak">Daftar</a>
        </nav>
        <span aria-hidden="true"></span>
      </div>
    </header>

    <main>
      <!--
        HERO
        Tiga foto ditumpuk sebagai latar (.hero-bg), masing-masing diberi
        animation-delay berbeda supaya bergantian muncul terus-menerus —
        murni CSS @keyframes, tidak ada JavaScript sama sekali. Di atasnya
        ada lapisan gelap transparan (.hero-overlay) supaya teks putih
        tetap kebaca di foto apa pun yang lagi tampil.
      -->
      <section class="hero">
        <div
          class="hero-bg"
          style="background-image: url('https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-2"
          style="background-image: url('https://images.unsplash.com/photo-1533900298318-6b8da08a523e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-3"
          style="background-image: url('https://images.unsplash.com/photo-1519996529931-28324d5a630e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div class="hero-overlay" aria-hidden="true"></div>

        <div class="hero-inner">
          <h1>Usaha warga yang layak kamu temukan.</h1>
          <p>
            Direktori usaha kecil di Karawang — warung, kerajinan, dan
            busana yang dijalankan tetangga sendiri, bukan waralaba.
          </p>
          <div class="hero-cta">
            <a href="#daftar-umkm" class="btn-primary">Lihat direktori</a>
            <a href="#kontak" class="btn-ghost">Daftarkan usahamu</a>
          </div>
        </div>
      </section>
    </main>
  </body>
</html>
```

Buka di browser: judul dan paragraf muncul, tapi foto latarnya belum kelihatan (masih `<div>` kosong tanpa ukuran) — itu wajar, ukurannya baru didefinisikan lewat CSS.

## Langkah 8 — CSS: Styling Hero (background gonta-ganti otomatis)

Bagian paling seru di halaman ini: **3 foto ditumpuk pas di posisi yang sama** (`position: absolute; inset: 0;`), lalu masing-masing dikasih `animation-delay` beda lewat `@keyframes heroBgCycle`. Hasilnya: foto bergantian muncul terus-menerus, **tanpa JavaScript sama sekali** — murni CSS.

```css
/*
  CSS variable (custom property). Ditulis sekali di :root, dipakai
  berkali-kali lewat var(--nama). Kalau mau ganti warna tema, cukup
  ubah di sini — tidak perlu cari-ganti di semua tempat.
*/
:root {
  --matcha-abyss: #1e2a18;
  --matcha-dark: #33422b;
  --matcha-mid: #7c9473;
  --sage-pale: #e9efe1;
  --cream: #f6f3e7;
  --gold: #c9a66b;
  --ink: #1f2937;
  --content-width: 1080px;
}

/* Reset dasar: hilangkan margin/padding bawaan browser yang beda-beda tiap browser */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box; /* border & padding dihitung masuk ke lebar elemen, bukan nambah lebar */
}

/*
  scroll-behavior: smooth membuat perpindahan ke #id (misalnya klik link
  nav ke "#tentang") meluncur halus, bukan langsung loncat.
  scroll-padding-top mengimbangi tinggi header yang sticky, supaya judul
  section tidak ketutupan header saat baru sampai.
*/
html {
  scroll-behavior: smooth;
  scroll-padding-top: 84px;
}

body {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  color: var(--ink);
  background-color: var(--cream);
  line-height: 1.6;
}

h1, h2, h3 {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  font-weight: 800;
}

a {
  color: inherit;
}

/* ================= HEADER ================= */
/*
  position: sticky membuat header ini nempel di atas begitu halaman
  discroll sampai posisinya, lalu tetap di situ (beda dengan "fixed"
  yang nempel dari awal halaman dibuka).
*/
header {
  position: sticky;
  top: 0;
  z-index: 10;
  background-color: var(--matcha-abyss);
  color: white;
  transition: transform 0.3s ease;
}

/* Ditambahkan lewat JS saat pengguna scroll ke bawah — header digeser ke atas sampai hilang */
header.sembunyi {
  transform: translateY(-100%);
}

/*
  Grid 3 kolom "1fr auto 1fr": kolom kiri (wordmark) dan kolom kanan
  (spacer kosong) selalu diberi lebar yang SAMA karena sama-sama 1fr,
  apa pun isinya. Efeknya kolom tengah (nav) selalu benar-benar di
  tengah header — beda dengan flexbox space-between yang mendorong nav
  ke ujung kanan mengikuti lebar wordmark.
*/
.header-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 20px 24px;
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: center;
  gap: 12px;
}

.wordmark {
  font-family: "Plus Jakarta Sans", sans-serif;
  font-weight: 800;
  font-size: 1.2rem;
  letter-spacing: -0.01em;
}

header nav {
  display: flex;
  gap: 24px;
}

header nav a {
  color: var(--sage-pale);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  padding-bottom: 2px;
  border-bottom: 2px solid transparent;
  transition: border-color 0.2s, color 0.2s;
}

header nav a:hover,
header nav a:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= HERO ================= */
/*
  position: relative di sini jadi acuan buat 3 lapisan .hero-bg dan
  .hero-overlay yang semuanya position: absolute — pola yang sama
  seperti badge kategori (relative parent + absolute child), cuma
  dipakai buat menumpuk latar belakang, bukan menumpuk elemen kecil.
*/
.hero {
  position: relative;
  overflow: hidden;
  color: white;
  text-align: center;
  padding: 120px 24px;
}

/*
  Tiga foto ditumpuk persis di posisi yang sama (inset: 0 memenuhi
  seluruh .hero), lalu masing-masing diberi animation-delay berbeda
  supaya bergantian terlihat. Ini murni CSS — tidak ada JavaScript
  yang mengganti gambar.
*/
.hero-bg {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  opacity: 0;
  animation: heroBgCycle 18s infinite;
}

.hero-bg-2 {
  animation-delay: 6s;
}

.hero-bg-3 {
  animation-delay: 12s;
}

/*
  18 detik dibagi 3 foto = 6 detik jatah tiap foto. Tiap foto: tersembunyi
  (0%) → memudar masuk (5%) → tampil penuh (28%) → memudar keluar (33%) →
  tersembunyi lagi sampai putaran berikutnya. animation-delay di atas
  menggeser kapan tiap foto memulai siklus ini, jadi hasilnya bergantian.
*/
@keyframes heroBgCycle {
  0%, 100% { opacity: 0; }
  5% { opacity: 1; }
  28% { opacity: 1; }
  33% { opacity: 0; }
}

/* Lapisan gelap transparan di atas foto, supaya teks putih tetap terbaca di foto apa pun */
.hero-overlay {
  position: absolute;
  inset: 0;
  background-color: rgba(20, 28, 16, 0.68);
}

.hero-inner {
  position: relative; /* supaya tampil di atas .hero-bg dan .hero-overlay */
  max-width: 640px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/*
  clamp(min, ideal, max) bikin ukuran font otomatis menyesuaikan lebar
  layar di antara batas minimum dan maksimum — tanpa perlu media query
  terpisah cuma buat ukuran teks.
*/
.hero-inner h1 {
  font-size: clamp(2.2rem, 5vw, 3.3rem);
  line-height: 1.05;
  letter-spacing: -0.02em;
  margin-bottom: 20px;
  opacity: 0;
  animation: heroRise 0.6s ease forwards;
}

.hero-inner p {
  max-width: 46ch;
  color: var(--sage-pale);
  font-size: 1.05rem;
  margin-bottom: 28px;
  opacity: 0;
  animation: heroRise 0.6s ease 0.15s forwards;
}

.hero-cta {
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
  justify-content: center;
  opacity: 0;
  animation: heroRise 0.6s ease 0.3s forwards;
}

/*
  Ini satu-satunya urutan animasi "otomatis saat halaman dibuka" di
  seluruh halaman (judul, lalu paragraf, lalu tombol —
  perhatikan animation-delay yang berbeda tiap elemen). Sengaja cuma
  di hero, supaya animasi tidak berserakan di semua bagian.
*/
@keyframes heroRise {
  from { opacity: 0; transform: translateY(16px); }
  to { opacity: 1; transform: translateY(0); }
}

.btn-primary, .btn-ghost {
  display: inline-block;
  padding: 12px 24px;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.95rem;
  text-decoration: none;
  transition: transform 0.15s, background-color 0.2s, color 0.2s;
}

.btn-primary {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

.btn-primary:hover, .btn-primary:focus-visible {
  transform: translateY(-2px);
}

.btn-ghost {
  border: 1px solid var(--matcha-mid);
  color: var(--sage-pale);
}

.btn-ghost:hover, .btn-ghost:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}
```

Reload dan **tunggu beberapa detik** — foto latar belakangnya bakal gonta-ganti sendiri secara halus. Judul, paragraf, dan tombol juga muncul berurutan (bukan langsung semua sekaligus) berkat `heroRise` dengan `animation-delay` beda-beda.

## Langkah 9 — HTML: Section Direktori (kartu, cari, filter, paginasi)

Bagian ini yang paling panjang: daftar 6 UMKM dalam bentuk kartu, plus kotak cari, dropdown kategori, dan paginasi di bawahnya. **Penting**: kotak cari, dropdown, dan paginasi di sini **baru tampilannya saja** — belum benar-benar menyaring apa pun, karena logikanya (JavaScript) sengaja belum kita bahas di sini. Anggap dulu sebagai "maket" tampilan.

Perhatikan tiap UMKM ditulis sebagai `<article>`, bukan `<div>` — karena isinya memang "satu unit konten yang berdiri sendiri", cocok sama makna semantik `<article>`. Ikon-ikon kecil (`<i class="fa-solid ...">`) datang dari Font Awesome yang sudah disambungkan di Langkah 2.

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Katalog UMKM Karawang</title>

    <!-- Google Fonts: Plus Jakarta Sans, satu family buat judul (weight tebal) dan teks biasa (weight normal) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <!-- Font Awesome lewat CDN, dipakai buat ikon medsos di footer dan ikon telepon di kartu UMKM -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <!--
      HEADER
      "sticky" di style.css bikin header ini tetap kelihatan walau halaman
      discroll ke bawah. Ini salah satu contoh nyata `position: sticky`
      yang disebutkan sekilas di materi Position.
    -->
    <header>
      <!--
        header-inner pakai 3 kolom grid (kiri-tengah-kanan) supaya nav
        benar-benar di tengah header, bukan ikut menempel ke kanan
        seperti pola flexbox space-between biasa.
      -->
      <div class="header-inner">
        <span class="wordmark">UMKM Karawang</span>
        <nav>
          <a href="#daftar-umkm">UMKM</a>
          <a href="#tentang">Tentang</a>
          <a href="#kontak">Daftar</a>
        </nav>
        <span aria-hidden="true"></span>
      </div>
    </header>

    <main>
      <!--
        HERO
        Tiga foto ditumpuk sebagai latar (.hero-bg), masing-masing diberi
        animation-delay berbeda supaya bergantian muncul terus-menerus —
        murni CSS @keyframes, tidak ada JavaScript sama sekali. Di atasnya
        ada lapisan gelap transparan (.hero-overlay) supaya teks putih
        tetap kebaca di foto apa pun yang lagi tampil.
      -->
      <section class="hero">
        <div
          class="hero-bg"
          style="background-image: url('https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-2"
          style="background-image: url('https://images.unsplash.com/photo-1533900298318-6b8da08a523e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-3"
          style="background-image: url('https://images.unsplash.com/photo-1519996529931-28324d5a630e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div class="hero-overlay" aria-hidden="true"></div>

        <div class="hero-inner">
          <h1>Usaha warga yang layak kamu temukan.</h1>
          <p>
            Direktori usaha kecil di Karawang — warung, kerajinan, dan
            busana yang dijalankan tetangga sendiri, bukan waralaba.
          </p>
          <div class="hero-cta">
            <a href="#daftar-umkm" class="btn-primary">Lihat direktori</a>
            <a href="#kontak" class="btn-ghost">Daftarkan usahamu</a>
          </div>
        </div>
      </section>

      <!--
        DIREKTORI
        Tiap UMKM ditulis sebagai <article> (bukan <div>) karena isinya
        memang "satu unit konten yang berdiri sendiri" — cocok dengan
        makna semantik <article>. class="reveal" dipakai script di bawah
        untuk animasi muncul saat discroll.

        Kotak pencarian, dropdown kategori, dan paginasi di bawah ini
        BARU TAMPILANNYA SAJA — belum benar-benar menyaring apa pun,
        karena logikanya (JavaScript) sengaja belum dibahas. Anggap ini
        "maket" tampilan dulu, fungsinya menyusul di materi selanjutnya.
      -->
      <section id="daftar-umkm" class="direktori reveal">
        <h2>Direktori</h2>

        <div class="direktori-toolbar">
          <input
            type="search"
            class="direktori-cari"
            placeholder="Cari nama UMKM..."
            aria-label="Cari UMKM"
          />
          <select class="direktori-kategori" aria-label="Filter kategori">
            <option>Semua kategori</option>
            <option>Kuliner</option>
            <option>Fashion</option>
            <option>Kerajinan</option>
          </select>
        </div>

        <div class="grid-umkm">
          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&q=60&auto=format&fit=crop"
                alt="Meja warung dengan aneka lauk siap saji"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Warung Bu Sari</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Merdeka No. 10, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 07.00 – 21.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0812-3456-7810</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1761515315375-1315503bb3ce?w=400&q=60&auto=format&fit=crop"
                alt="Kain batik bermotif tradisional"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Batik Karawang Asli</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Kertabumi No. 5, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 09.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0813-2345-6705</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1696574727184-a8cdb758d3bf?w=400&q=60&auto=format&fit=crop"
                alt="Keranjang anyaman bambu"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Anyaman Bambu Pak Jaya</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Tuparev No. 22, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0857-1234-9902</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&q=60&auto=format&fit=crop"
                alt="Secangkir kopi hitam di atas meja kayu"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Kopi Rawa Gede</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ahmad Yani No. 3, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 10.00 – 23.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0821-9988-2214</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1445205170230-053b83016050?w=400&q=60&auto=format&fit=crop"
                alt="Mesin jahit dan gulungan kain"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Konveksi Sinar Tani</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Pangkal Perjuangan No. 18, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0838-4567-3321</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=400&q=60&auto=format&fit=crop"
                alt="Kumpulan gerabah tanah liat"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Gerabah Cikampek</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ir. H. Juanda No. 45, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0896-7712-0043</p>
            </div>
          </article>
        </div>

        <!-- Paginasi: tampilan saja, angka "aktif" ditandai lewat class, belum benar-benar berpindah halaman -->
        <nav class="pagination" aria-label="Navigasi halaman direktori">
          <a href="#daftar-umkm" aria-label="Halaman sebelumnya">‹</a>
          <a href="#daftar-umkm" class="aktif" aria-current="page">1</a>
          <a href="#daftar-umkm">2</a>
          <a href="#daftar-umkm">3</a>
          <a href="#daftar-umkm" aria-label="Halaman berikutnya">›</a>
        </nav>
      </section>
    </main>
  </body>
</html>
```

Buka di browser: bakal kelihatan berantakan — kartu-kartu numpuk vertikal lebar penuh, gambar gede sendiri-sendiri. Wajar, belum ada CSS grid-nya.

## Langkah 10 — CSS: Styling Direktori

Sekarang kartu-kartunya dirapikan jadi grid yang responsif. Perhatikan `grid-template-columns: repeat(auto-fit, minmax(240px, 1fr))` — ini bikin jumlah kolom **otomatis menyesuaikan** lebar layar, tanpa perlu nulis media query manual buat tiap ukuran layar.

Dua trik lain yang penting: `.badge` pakai `position: absolute` di dalam `.kartu-foto` yang `position: relative` (pola relative-parent + absolute-child, sama kayak yang dipelajari di materi Position), dan `text-overflow: ellipsis` di nama/alamat supaya teks kepanjangan dipotong jadi `...` rapi, bukan bikin kartu jadi tinggi sebelah.

Satu lagi di `.direktori-kategori`: `appearance: none` menghilangkan panah dropdown bawaan browser (posisinya gak bisa diatur pakai padding di kebanyakan browser), lalu diganti panah custom lewat `background-image` SVG yang posisinya diatur manual pakai `background-position` — jadi bisa "dimasukin" sesuai jarak yang kita mau, ngikutin padding kanan.

```css
/*
  CSS variable (custom property). Ditulis sekali di :root, dipakai
  berkali-kali lewat var(--nama). Kalau mau ganti warna tema, cukup
  ubah di sini — tidak perlu cari-ganti di semua tempat.
*/
:root {
  --matcha-abyss: #1e2a18;
  --matcha-dark: #33422b;
  --matcha-mid: #7c9473;
  --sage-pale: #e9efe1;
  --cream: #f6f3e7;
  --gold: #c9a66b;
  --ink: #1f2937;
  --content-width: 1080px;
}

/* Reset dasar: hilangkan margin/padding bawaan browser yang beda-beda tiap browser */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box; /* border & padding dihitung masuk ke lebar elemen, bukan nambah lebar */
}

/*
  scroll-behavior: smooth membuat perpindahan ke #id (misalnya klik link
  nav ke "#tentang") meluncur halus, bukan langsung loncat.
  scroll-padding-top mengimbangi tinggi header yang sticky, supaya judul
  section tidak ketutupan header saat baru sampai.
*/
html {
  scroll-behavior: smooth;
  scroll-padding-top: 84px;
}

body {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  color: var(--ink);
  background-color: var(--cream);
  line-height: 1.6;
}

h1, h2, h3 {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  font-weight: 800;
}

a {
  color: inherit;
}

/* ================= HEADER ================= */
/*
  position: sticky membuat header ini nempel di atas begitu halaman
  discroll sampai posisinya, lalu tetap di situ (beda dengan "fixed"
  yang nempel dari awal halaman dibuka).
*/
header {
  position: sticky;
  top: 0;
  z-index: 10;
  background-color: var(--matcha-abyss);
  color: white;
  transition: transform 0.3s ease;
}

/* Ditambahkan lewat JS saat pengguna scroll ke bawah — header digeser ke atas sampai hilang */
header.sembunyi {
  transform: translateY(-100%);
}

/*
  Grid 3 kolom "1fr auto 1fr": kolom kiri (wordmark) dan kolom kanan
  (spacer kosong) selalu diberi lebar yang SAMA karena sama-sama 1fr,
  apa pun isinya. Efeknya kolom tengah (nav) selalu benar-benar di
  tengah header — beda dengan flexbox space-between yang mendorong nav
  ke ujung kanan mengikuti lebar wordmark.
*/
.header-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 20px 24px;
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: center;
  gap: 12px;
}

.wordmark {
  font-family: "Plus Jakarta Sans", sans-serif;
  font-weight: 800;
  font-size: 1.2rem;
  letter-spacing: -0.01em;
}

header nav {
  display: flex;
  gap: 24px;
}

header nav a {
  color: var(--sage-pale);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  padding-bottom: 2px;
  border-bottom: 2px solid transparent;
  transition: border-color 0.2s, color 0.2s;
}

header nav a:hover,
header nav a:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= HERO ================= */
/*
  position: relative di sini jadi acuan buat 3 lapisan .hero-bg dan
  .hero-overlay yang semuanya position: absolute — pola yang sama
  seperti badge kategori (relative parent + absolute child), cuma
  dipakai buat menumpuk latar belakang, bukan menumpuk elemen kecil.
*/
.hero {
  position: relative;
  overflow: hidden;
  color: white;
  text-align: center;
  padding: 120px 24px;
}

/*
  Tiga foto ditumpuk persis di posisi yang sama (inset: 0 memenuhi
  seluruh .hero), lalu masing-masing diberi animation-delay berbeda
  supaya bergantian terlihat. Ini murni CSS — tidak ada JavaScript
  yang mengganti gambar.
*/
.hero-bg {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  opacity: 0;
  animation: heroBgCycle 18s infinite;
}

.hero-bg-2 {
  animation-delay: 6s;
}

.hero-bg-3 {
  animation-delay: 12s;
}

/*
  18 detik dibagi 3 foto = 6 detik jatah tiap foto. Tiap foto: tersembunyi
  (0%) → memudar masuk (5%) → tampil penuh (28%) → memudar keluar (33%) →
  tersembunyi lagi sampai putaran berikutnya. animation-delay di atas
  menggeser kapan tiap foto memulai siklus ini, jadi hasilnya bergantian.
*/
@keyframes heroBgCycle {
  0%, 100% { opacity: 0; }
  5% { opacity: 1; }
  28% { opacity: 1; }
  33% { opacity: 0; }
}

/* Lapisan gelap transparan di atas foto, supaya teks putih tetap terbaca di foto apa pun */
.hero-overlay {
  position: absolute;
  inset: 0;
  background-color: rgba(20, 28, 16, 0.68);
}

.hero-inner {
  position: relative; /* supaya tampil di atas .hero-bg dan .hero-overlay */
  max-width: 640px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/*
  clamp(min, ideal, max) bikin ukuran font otomatis menyesuaikan lebar
  layar di antara batas minimum dan maksimum — tanpa perlu media query
  terpisah cuma buat ukuran teks.
*/
.hero-inner h1 {
  font-size: clamp(2.2rem, 5vw, 3.3rem);
  line-height: 1.05;
  letter-spacing: -0.02em;
  margin-bottom: 20px;
  opacity: 0;
  animation: heroRise 0.6s ease forwards;
}

.hero-inner p {
  max-width: 46ch;
  color: var(--sage-pale);
  font-size: 1.05rem;
  margin-bottom: 28px;
  opacity: 0;
  animation: heroRise 0.6s ease 0.15s forwards;
}

.hero-cta {
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
  justify-content: center;
  opacity: 0;
  animation: heroRise 0.6s ease 0.3s forwards;
}

/*
  Ini satu-satunya urutan animasi "otomatis saat halaman dibuka" di
  seluruh halaman (judul, lalu paragraf, lalu tombol —
  perhatikan animation-delay yang berbeda tiap elemen). Sengaja cuma
  di hero, supaya animasi tidak berserakan di semua bagian.
*/
@keyframes heroRise {
  from { opacity: 0; transform: translateY(16px); }
  to { opacity: 1; transform: translateY(0); }
}

.btn-primary, .btn-ghost {
  display: inline-block;
  padding: 12px 24px;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.95rem;
  text-decoration: none;
  transition: transform 0.15s, background-color 0.2s, color 0.2s;
}

.btn-primary {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

.btn-primary:hover, .btn-primary:focus-visible {
  transform: translateY(-2px);
}

.btn-ghost {
  border: 1px solid var(--matcha-mid);
  color: var(--sage-pale);
}

.btn-ghost:hover, .btn-ghost:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= Direktori ================= */
.direktori {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
}

.direktori h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 20px;
}

/*
  Toolbar pencarian + filter — TAMPILAN SAJA. Input dan select ini belum
  disambungkan ke logika apa pun (belum ada JavaScript), jadi mengetik
  atau ganti dropdown-nya belum benar-benar menyaring kartu di bawah.
*/
.direktori-toolbar {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
  margin-bottom: 28px;
}

.direktori-cari {
  flex: 1;
  min-width: 200px;
  padding: 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
}

/*
  appearance: none menghilangkan panah bawaan browser (posisinya gak bisa
  diatur pakai padding). Panah custom dipasang lewat SVG di background,
  posisinya diatur manual pakai background-position — jadi bisa "dimasukin"
  sesuai jarak yang kita mau, ngikutin padding kanan.
*/
.direktori-kategori {
  padding: 11px 36px 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
  color: var(--ink);
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6' viewBox='0 0 10 6' fill='none'%3E%3Cpath d='M1 1l4 4 4-4' stroke='%2333422b' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 16px center;
}

.direktori-cari:focus,
.direktori-kategori:focus {
  outline: none;
  border-color: var(--gold);
}

/* Grid kartu: auto-fit + minmax bikin jumlah kolom menyesuaikan sendiri lebar layar, tanpa media query manual */
.grid-umkm {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.kartu-umkm {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  overflow: hidden;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.kartu-umkm:hover,
.kartu-umkm:focus-within {
  transform: translateY(-4px);
  box-shadow: 0 14px 28px rgba(51, 66, 43, 0.14);
}

/* position: relative di sini jadi acuan buat .badge yang absolute di dalamnya */
.kartu-foto {
  position: relative;
  aspect-ratio: 4 / 3;
}

.kartu-foto img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.kartu-isi {
  padding: 16px 18px 20px;
}

.kartu-isi h3 {
  font-size: 1.1rem;
  color: var(--matcha-dark);
  margin-bottom: 4px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis; /* nama kepanjangan dipotong jadi "...", bukan bikin tinggi kartu beda-beda */
}

.kartu-isi .alamat {
  color: #6b6b5f;
  font-size: 0.88rem;
  display: flex;
  align-items: center;
  gap: 6px;
}

/*
  Alamat yang kepanjangan dipotong jadi satu baris + "..." di ujungnya
  (text-overflow: ellipsis), bukan bikin kartu jadi tinggi sebelah.
  min-width: 0 wajib di sini supaya flex item ini mau menyusut duluan
  sebelum ikon di sebelahnya ikut menyusut.
*/
.kartu-isi .alamat span {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  min-width: 0;
}

.kartu-isi .alamat i,
.kartu-isi .jam i {
  color: var(--matcha-mid);
  flex-shrink: 0;
}

.kartu-isi .jam {
  color: var(--matcha-mid);
  font-size: 0.8rem;
  margin-top: 2px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa {
  color: var(--matcha-dark);
  font-size: 0.85rem;
  font-weight: 600;
  margin-top: 8px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa i {
  color: var(--matcha-mid);
}

/*
  Badge kategori: position: absolute melepas elemen ini dari alur normal
  dan menempelkannya presisi ke pojok kanan-atas .kartu-foto (parent
  terdekat yang sudah diberi position: relative di atas).
*/
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

/*
  Paginasi — TAMPILAN SAJA juga. Angka "1" ditandai .aktif lewat HTML
  langsung (bukan JavaScript), sekadar contoh bagaimana halaman aktif
  biasanya dibedakan secara visual.
*/
.pagination {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-top: 36px;
}

.pagination a {
  width: 38px;
  height: 38px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid #ddd6c4;
  border-radius: 8px;
  color: var(--matcha-dark);
  text-decoration: none;
  font-size: 0.9rem;
  transition: border-color 0.2s, background-color 0.2s, color 0.2s;
}

.pagination a:hover,
.pagination a:focus-visible {
  border-color: var(--gold);
}

.pagination a.aktif {
  background-color: var(--matcha-dark);
  border-color: var(--matcha-dark);
  color: white;
}
```

Reload: kartu-kartu sekarang rapi dalam grid, badge kategori nempel di pojok foto, hover kartu bikin dia naik dikit dengan bayangan membesar. Coba kecilkan jendela browser pelan-pelan — perhatikan kolomnya otomatis berkurang tanpa kamu nulis media query apa pun.

## Langkah 11 — HTML: Section Tentang

Section ini sengaja simpel: judul + satu paragraf + satu foto, dibagi 2 kolom.

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Katalog UMKM Karawang</title>

    <!-- Google Fonts: Plus Jakarta Sans, satu family buat judul (weight tebal) dan teks biasa (weight normal) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <!-- Font Awesome lewat CDN, dipakai buat ikon medsos di footer dan ikon telepon di kartu UMKM -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <!--
      HEADER
      "sticky" di style.css bikin header ini tetap kelihatan walau halaman
      discroll ke bawah. Ini salah satu contoh nyata `position: sticky`
      yang disebutkan sekilas di materi Position.
    -->
    <header>
      <!--
        header-inner pakai 3 kolom grid (kiri-tengah-kanan) supaya nav
        benar-benar di tengah header, bukan ikut menempel ke kanan
        seperti pola flexbox space-between biasa.
      -->
      <div class="header-inner">
        <span class="wordmark">UMKM Karawang</span>
        <nav>
          <a href="#daftar-umkm">UMKM</a>
          <a href="#tentang">Tentang</a>
          <a href="#kontak">Daftar</a>
        </nav>
        <span aria-hidden="true"></span>
      </div>
    </header>

    <main>
      <!--
        HERO
        Tiga foto ditumpuk sebagai latar (.hero-bg), masing-masing diberi
        animation-delay berbeda supaya bergantian muncul terus-menerus —
        murni CSS @keyframes, tidak ada JavaScript sama sekali. Di atasnya
        ada lapisan gelap transparan (.hero-overlay) supaya teks putih
        tetap kebaca di foto apa pun yang lagi tampil.
      -->
      <section class="hero">
        <div
          class="hero-bg"
          style="background-image: url('https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-2"
          style="background-image: url('https://images.unsplash.com/photo-1533900298318-6b8da08a523e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-3"
          style="background-image: url('https://images.unsplash.com/photo-1519996529931-28324d5a630e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div class="hero-overlay" aria-hidden="true"></div>

        <div class="hero-inner">
          <h1>Usaha warga yang layak kamu temukan.</h1>
          <p>
            Direktori usaha kecil di Karawang — warung, kerajinan, dan
            busana yang dijalankan tetangga sendiri, bukan waralaba.
          </p>
          <div class="hero-cta">
            <a href="#daftar-umkm" class="btn-primary">Lihat direktori</a>
            <a href="#kontak" class="btn-ghost">Daftarkan usahamu</a>
          </div>
        </div>
      </section>

      <!--
        DIREKTORI
        Tiap UMKM ditulis sebagai <article> (bukan <div>) karena isinya
        memang "satu unit konten yang berdiri sendiri" — cocok dengan
        makna semantik <article>. class="reveal" dipakai script di bawah
        untuk animasi muncul saat discroll.

        Kotak pencarian, dropdown kategori, dan paginasi di bawah ini
        BARU TAMPILANNYA SAJA — belum benar-benar menyaring apa pun,
        karena logikanya (JavaScript) sengaja belum dibahas. Anggap ini
        "maket" tampilan dulu, fungsinya menyusul di materi selanjutnya.
      -->
      <section id="daftar-umkm" class="direktori reveal">
        <h2>Direktori</h2>

        <div class="direktori-toolbar">
          <input
            type="search"
            class="direktori-cari"
            placeholder="Cari nama UMKM..."
            aria-label="Cari UMKM"
          />
          <select class="direktori-kategori" aria-label="Filter kategori">
            <option>Semua kategori</option>
            <option>Kuliner</option>
            <option>Fashion</option>
            <option>Kerajinan</option>
          </select>
        </div>

        <div class="grid-umkm">
          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&q=60&auto=format&fit=crop"
                alt="Meja warung dengan aneka lauk siap saji"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Warung Bu Sari</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Merdeka No. 10, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 07.00 – 21.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0812-3456-7810</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1761515315375-1315503bb3ce?w=400&q=60&auto=format&fit=crop"
                alt="Kain batik bermotif tradisional"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Batik Karawang Asli</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Kertabumi No. 5, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 09.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0813-2345-6705</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1696574727184-a8cdb758d3bf?w=400&q=60&auto=format&fit=crop"
                alt="Keranjang anyaman bambu"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Anyaman Bambu Pak Jaya</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Tuparev No. 22, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0857-1234-9902</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&q=60&auto=format&fit=crop"
                alt="Secangkir kopi hitam di atas meja kayu"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Kopi Rawa Gede</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ahmad Yani No. 3, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 10.00 – 23.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0821-9988-2214</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1445205170230-053b83016050?w=400&q=60&auto=format&fit=crop"
                alt="Mesin jahit dan gulungan kain"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Konveksi Sinar Tani</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Pangkal Perjuangan No. 18, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0838-4567-3321</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=400&q=60&auto=format&fit=crop"
                alt="Kumpulan gerabah tanah liat"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Gerabah Cikampek</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ir. H. Juanda No. 45, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0896-7712-0043</p>
            </div>
          </article>
        </div>

        <!-- Paginasi: tampilan saja, angka "aktif" ditandai lewat class, belum benar-benar berpindah halaman -->
        <nav class="pagination" aria-label="Navigasi halaman direktori">
          <a href="#daftar-umkm" aria-label="Halaman sebelumnya">‹</a>
          <a href="#daftar-umkm" class="aktif" aria-current="page">1</a>
          <a href="#daftar-umkm">2</a>
          <a href="#daftar-umkm">3</a>
          <a href="#daftar-umkm" aria-label="Halaman berikutnya">›</a>
        </nav>
      </section>

      <!-- TENTANG: disederhanakan, cuma judul + satu paragraf singkat + foto -->
      <section id="tentang" class="tentang reveal">
        <div class="tentang-teks">
          <h2>Tentang katalog ini</h2>
          <p>
            Dibuat supaya warga lebih mudah menemukan UMKM di sekitar
            Karawang — dan supaya pemilik usaha kecil punya satu tempat untuk
            dicari, tanpa harus bayar iklan. Pilih kategori di direktori,
            lalu hubungi langsung lewat WA atau form Kontak di bawah.
          </p>
        </div>
        <div class="tentang-gambar">
          <img
            src="https://images.unsplash.com/photo-1642473194881-c7425b3789f1?fm=jpg&amp;q=60&amp;w=800&amp;auto=format&amp;fit=crop"
            alt="Suasana pasar UMKM Karawang"
            loading="lazy"
          />
        </div>
      </section>
    </main>
  </body>
</html>
```

Taruh setelah `</section>` Direktori. Di browser: teks dan foto ketumpuk berurutan ke bawah lebar penuh — CSS grid-nya belum ada.

## Langkah 12 — CSS: Styling Tentang

`display: grid; grid-template-columns: 7fr 5fr;` bikin 2 kolom dengan lebar **tidak sama rata** — kolom teks dapat porsi 7 bagian, kolom gambar 5 bagian. `overflow: hidden` + `border-radius: 16px` di `.tentang` bikin sudut foto ikut membulat mengikuti bentuk keseluruhan blok, bukan cuma sudut terluarnya.

```css
/*
  CSS variable (custom property). Ditulis sekali di :root, dipakai
  berkali-kali lewat var(--nama). Kalau mau ganti warna tema, cukup
  ubah di sini — tidak perlu cari-ganti di semua tempat.
*/
:root {
  --matcha-abyss: #1e2a18;
  --matcha-dark: #33422b;
  --matcha-mid: #7c9473;
  --sage-pale: #e9efe1;
  --cream: #f6f3e7;
  --gold: #c9a66b;
  --ink: #1f2937;
  --content-width: 1080px;
}

/* Reset dasar: hilangkan margin/padding bawaan browser yang beda-beda tiap browser */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box; /* border & padding dihitung masuk ke lebar elemen, bukan nambah lebar */
}

/*
  scroll-behavior: smooth membuat perpindahan ke #id (misalnya klik link
  nav ke "#tentang") meluncur halus, bukan langsung loncat.
  scroll-padding-top mengimbangi tinggi header yang sticky, supaya judul
  section tidak ketutupan header saat baru sampai.
*/
html {
  scroll-behavior: smooth;
  scroll-padding-top: 84px;
}

body {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  color: var(--ink);
  background-color: var(--cream);
  line-height: 1.6;
}

h1, h2, h3 {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  font-weight: 800;
}

a {
  color: inherit;
}

/* ================= HEADER ================= */
/*
  position: sticky membuat header ini nempel di atas begitu halaman
  discroll sampai posisinya, lalu tetap di situ (beda dengan "fixed"
  yang nempel dari awal halaman dibuka).
*/
header {
  position: sticky;
  top: 0;
  z-index: 10;
  background-color: var(--matcha-abyss);
  color: white;
  transition: transform 0.3s ease;
}

/* Ditambahkan lewat JS saat pengguna scroll ke bawah — header digeser ke atas sampai hilang */
header.sembunyi {
  transform: translateY(-100%);
}

/*
  Grid 3 kolom "1fr auto 1fr": kolom kiri (wordmark) dan kolom kanan
  (spacer kosong) selalu diberi lebar yang SAMA karena sama-sama 1fr,
  apa pun isinya. Efeknya kolom tengah (nav) selalu benar-benar di
  tengah header — beda dengan flexbox space-between yang mendorong nav
  ke ujung kanan mengikuti lebar wordmark.
*/
.header-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 20px 24px;
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: center;
  gap: 12px;
}

.wordmark {
  font-family: "Plus Jakarta Sans", sans-serif;
  font-weight: 800;
  font-size: 1.2rem;
  letter-spacing: -0.01em;
}

header nav {
  display: flex;
  gap: 24px;
}

header nav a {
  color: var(--sage-pale);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  padding-bottom: 2px;
  border-bottom: 2px solid transparent;
  transition: border-color 0.2s, color 0.2s;
}

header nav a:hover,
header nav a:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= HERO ================= */
/*
  position: relative di sini jadi acuan buat 3 lapisan .hero-bg dan
  .hero-overlay yang semuanya position: absolute — pola yang sama
  seperti badge kategori (relative parent + absolute child), cuma
  dipakai buat menumpuk latar belakang, bukan menumpuk elemen kecil.
*/
.hero {
  position: relative;
  overflow: hidden;
  color: white;
  text-align: center;
  padding: 120px 24px;
}

/*
  Tiga foto ditumpuk persis di posisi yang sama (inset: 0 memenuhi
  seluruh .hero), lalu masing-masing diberi animation-delay berbeda
  supaya bergantian terlihat. Ini murni CSS — tidak ada JavaScript
  yang mengganti gambar.
*/
.hero-bg {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  opacity: 0;
  animation: heroBgCycle 18s infinite;
}

.hero-bg-2 {
  animation-delay: 6s;
}

.hero-bg-3 {
  animation-delay: 12s;
}

/*
  18 detik dibagi 3 foto = 6 detik jatah tiap foto. Tiap foto: tersembunyi
  (0%) → memudar masuk (5%) → tampil penuh (28%) → memudar keluar (33%) →
  tersembunyi lagi sampai putaran berikutnya. animation-delay di atas
  menggeser kapan tiap foto memulai siklus ini, jadi hasilnya bergantian.
*/
@keyframes heroBgCycle {
  0%, 100% { opacity: 0; }
  5% { opacity: 1; }
  28% { opacity: 1; }
  33% { opacity: 0; }
}

/* Lapisan gelap transparan di atas foto, supaya teks putih tetap terbaca di foto apa pun */
.hero-overlay {
  position: absolute;
  inset: 0;
  background-color: rgba(20, 28, 16, 0.68);
}

.hero-inner {
  position: relative; /* supaya tampil di atas .hero-bg dan .hero-overlay */
  max-width: 640px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/*
  clamp(min, ideal, max) bikin ukuran font otomatis menyesuaikan lebar
  layar di antara batas minimum dan maksimum — tanpa perlu media query
  terpisah cuma buat ukuran teks.
*/
.hero-inner h1 {
  font-size: clamp(2.2rem, 5vw, 3.3rem);
  line-height: 1.05;
  letter-spacing: -0.02em;
  margin-bottom: 20px;
  opacity: 0;
  animation: heroRise 0.6s ease forwards;
}

.hero-inner p {
  max-width: 46ch;
  color: var(--sage-pale);
  font-size: 1.05rem;
  margin-bottom: 28px;
  opacity: 0;
  animation: heroRise 0.6s ease 0.15s forwards;
}

.hero-cta {
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
  justify-content: center;
  opacity: 0;
  animation: heroRise 0.6s ease 0.3s forwards;
}

/*
  Ini satu-satunya urutan animasi "otomatis saat halaman dibuka" di
  seluruh halaman (judul, lalu paragraf, lalu tombol —
  perhatikan animation-delay yang berbeda tiap elemen). Sengaja cuma
  di hero, supaya animasi tidak berserakan di semua bagian.
*/
@keyframes heroRise {
  from { opacity: 0; transform: translateY(16px); }
  to { opacity: 1; transform: translateY(0); }
}

.btn-primary, .btn-ghost {
  display: inline-block;
  padding: 12px 24px;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.95rem;
  text-decoration: none;
  transition: transform 0.15s, background-color 0.2s, color 0.2s;
}

.btn-primary {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

.btn-primary:hover, .btn-primary:focus-visible {
  transform: translateY(-2px);
}

.btn-ghost {
  border: 1px solid var(--matcha-mid);
  color: var(--sage-pale);
}

.btn-ghost:hover, .btn-ghost:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= Direktori ================= */
.direktori {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
}

.direktori h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 20px;
}

/*
  Toolbar pencarian + filter — TAMPILAN SAJA. Input dan select ini belum
  disambungkan ke logika apa pun (belum ada JavaScript), jadi mengetik
  atau ganti dropdown-nya belum benar-benar menyaring kartu di bawah.
*/
.direktori-toolbar {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
  margin-bottom: 28px;
}

.direktori-cari {
  flex: 1;
  min-width: 200px;
  padding: 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
}

/*
  appearance: none menghilangkan panah bawaan browser (posisinya gak bisa
  diatur pakai padding). Panah custom dipasang lewat SVG di background,
  posisinya diatur manual pakai background-position — jadi bisa "dimasukin"
  sesuai jarak yang kita mau, ngikutin padding kanan.
*/
.direktori-kategori {
  padding: 11px 36px 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
  color: var(--ink);
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6' viewBox='0 0 10 6' fill='none'%3E%3Cpath d='M1 1l4 4 4-4' stroke='%2333422b' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 16px center;
}

.direktori-cari:focus,
.direktori-kategori:focus {
  outline: none;
  border-color: var(--gold);
}

/* Grid kartu: auto-fit + minmax bikin jumlah kolom menyesuaikan sendiri lebar layar, tanpa media query manual */
.grid-umkm {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.kartu-umkm {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  overflow: hidden;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.kartu-umkm:hover,
.kartu-umkm:focus-within {
  transform: translateY(-4px);
  box-shadow: 0 14px 28px rgba(51, 66, 43, 0.14);
}

/* position: relative di sini jadi acuan buat .badge yang absolute di dalamnya */
.kartu-foto {
  position: relative;
  aspect-ratio: 4 / 3;
}

.kartu-foto img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.kartu-isi {
  padding: 16px 18px 20px;
}

.kartu-isi h3 {
  font-size: 1.1rem;
  color: var(--matcha-dark);
  margin-bottom: 4px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis; /* nama kepanjangan dipotong jadi "...", bukan bikin tinggi kartu beda-beda */
}

.kartu-isi .alamat {
  color: #6b6b5f;
  font-size: 0.88rem;
  display: flex;
  align-items: center;
  gap: 6px;
}

/*
  Alamat yang kepanjangan dipotong jadi satu baris + "..." di ujungnya
  (text-overflow: ellipsis), bukan bikin kartu jadi tinggi sebelah.
  min-width: 0 wajib di sini supaya flex item ini mau menyusut duluan
  sebelum ikon di sebelahnya ikut menyusut.
*/
.kartu-isi .alamat span {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  min-width: 0;
}

.kartu-isi .alamat i,
.kartu-isi .jam i {
  color: var(--matcha-mid);
  flex-shrink: 0;
}

.kartu-isi .jam {
  color: var(--matcha-mid);
  font-size: 0.8rem;
  margin-top: 2px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa {
  color: var(--matcha-dark);
  font-size: 0.85rem;
  font-weight: 600;
  margin-top: 8px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa i {
  color: var(--matcha-mid);
}

/*
  Badge kategori: position: absolute melepas elemen ini dari alur normal
  dan menempelkannya presisi ke pojok kanan-atas .kartu-foto (parent
  terdekat yang sudah diberi position: relative di atas).
*/
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

/*
  Paginasi — TAMPILAN SAJA juga. Angka "1" ditandai .aktif lewat HTML
  langsung (bukan JavaScript), sekadar contoh bagaimana halaman aktif
  biasanya dibedakan secara visual.
*/
.pagination {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-top: 36px;
}

.pagination a {
  width: 38px;
  height: 38px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid #ddd6c4;
  border-radius: 8px;
  color: var(--matcha-dark);
  text-decoration: none;
  font-size: 0.9rem;
  transition: border-color 0.2s, background-color 0.2s, color 0.2s;
}

.pagination a:hover,
.pagination a:focus-visible {
  border-color: var(--gold);
}

.pagination a.aktif {
  background-color: var(--matcha-dark);
  border-color: var(--matcha-dark);
  color: white;
}

/* ================= Tentang ================= */
/* CSS Grid 2 kolom asimetris: kolom teks lebih lebar (7 bagian) dari kolom gambar (5 bagian) */
.tentang {
  display: grid;
  grid-template-columns: 7fr 5fr;
  max-width: var(--content-width);
  margin: 56px auto;
  border-radius: 16px;
  overflow: hidden; /* biar sudut foto & panel ikut membulat mengikuti .tentang, bukan cuma sudut luarnya */
}

.tentang-teks {
  background-color: var(--sage-pale);
  padding: 48px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.tentang-teks h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 8px;
}

.tentang-teks > p {
  color: #444;
}

.tentang-gambar {
  overflow: hidden; /* biar foto yang dibesarkan lewat object-fit tidak keluar dari kotaknya */
}

.tentang-gambar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}
```

Reload: sekarang jadi 1 blok dengan sudut membulat, panel hijau pucat di kiri dan foto di kanan yang mengisi penuh tingginya.

## Langkah 13 — HTML: Section Testimoni

Tiga kutipan dari "warga" dengan avatar berupa lingkaran berisi inisial nama — **sengaja bukan foto orang beneran**, karena testimoni di sini contoh/dummy, jadi tidak pantas pakai foto wajah orang asli.

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Katalog UMKM Karawang</title>

    <!-- Google Fonts: Plus Jakarta Sans, satu family buat judul (weight tebal) dan teks biasa (weight normal) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <!-- Font Awesome lewat CDN, dipakai buat ikon medsos di footer dan ikon telepon di kartu UMKM -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <!--
      HEADER
      "sticky" di style.css bikin header ini tetap kelihatan walau halaman
      discroll ke bawah. Ini salah satu contoh nyata `position: sticky`
      yang disebutkan sekilas di materi Position.
    -->
    <header>
      <!--
        header-inner pakai 3 kolom grid (kiri-tengah-kanan) supaya nav
        benar-benar di tengah header, bukan ikut menempel ke kanan
        seperti pola flexbox space-between biasa.
      -->
      <div class="header-inner">
        <span class="wordmark">UMKM Karawang</span>
        <nav>
          <a href="#daftar-umkm">UMKM</a>
          <a href="#tentang">Tentang</a>
          <a href="#kontak">Daftar</a>
        </nav>
        <span aria-hidden="true"></span>
      </div>
    </header>

    <main>
      <!--
        HERO
        Tiga foto ditumpuk sebagai latar (.hero-bg), masing-masing diberi
        animation-delay berbeda supaya bergantian muncul terus-menerus —
        murni CSS @keyframes, tidak ada JavaScript sama sekali. Di atasnya
        ada lapisan gelap transparan (.hero-overlay) supaya teks putih
        tetap kebaca di foto apa pun yang lagi tampil.
      -->
      <section class="hero">
        <div
          class="hero-bg"
          style="background-image: url('https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-2"
          style="background-image: url('https://images.unsplash.com/photo-1533900298318-6b8da08a523e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-3"
          style="background-image: url('https://images.unsplash.com/photo-1519996529931-28324d5a630e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div class="hero-overlay" aria-hidden="true"></div>

        <div class="hero-inner">
          <h1>Usaha warga yang layak kamu temukan.</h1>
          <p>
            Direktori usaha kecil di Karawang — warung, kerajinan, dan
            busana yang dijalankan tetangga sendiri, bukan waralaba.
          </p>
          <div class="hero-cta">
            <a href="#daftar-umkm" class="btn-primary">Lihat direktori</a>
            <a href="#kontak" class="btn-ghost">Daftarkan usahamu</a>
          </div>
        </div>
      </section>

      <!--
        DIREKTORI
        Tiap UMKM ditulis sebagai <article> (bukan <div>) karena isinya
        memang "satu unit konten yang berdiri sendiri" — cocok dengan
        makna semantik <article>. class="reveal" dipakai script di bawah
        untuk animasi muncul saat discroll.

        Kotak pencarian, dropdown kategori, dan paginasi di bawah ini
        BARU TAMPILANNYA SAJA — belum benar-benar menyaring apa pun,
        karena logikanya (JavaScript) sengaja belum dibahas. Anggap ini
        "maket" tampilan dulu, fungsinya menyusul di materi selanjutnya.
      -->
      <section id="daftar-umkm" class="direktori reveal">
        <h2>Direktori</h2>

        <div class="direktori-toolbar">
          <input
            type="search"
            class="direktori-cari"
            placeholder="Cari nama UMKM..."
            aria-label="Cari UMKM"
          />
          <select class="direktori-kategori" aria-label="Filter kategori">
            <option>Semua kategori</option>
            <option>Kuliner</option>
            <option>Fashion</option>
            <option>Kerajinan</option>
          </select>
        </div>

        <div class="grid-umkm">
          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&q=60&auto=format&fit=crop"
                alt="Meja warung dengan aneka lauk siap saji"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Warung Bu Sari</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Merdeka No. 10, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 07.00 – 21.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0812-3456-7810</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1761515315375-1315503bb3ce?w=400&q=60&auto=format&fit=crop"
                alt="Kain batik bermotif tradisional"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Batik Karawang Asli</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Kertabumi No. 5, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 09.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0813-2345-6705</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1696574727184-a8cdb758d3bf?w=400&q=60&auto=format&fit=crop"
                alt="Keranjang anyaman bambu"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Anyaman Bambu Pak Jaya</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Tuparev No. 22, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0857-1234-9902</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&q=60&auto=format&fit=crop"
                alt="Secangkir kopi hitam di atas meja kayu"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Kopi Rawa Gede</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ahmad Yani No. 3, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 10.00 – 23.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0821-9988-2214</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1445205170230-053b83016050?w=400&q=60&auto=format&fit=crop"
                alt="Mesin jahit dan gulungan kain"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Konveksi Sinar Tani</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Pangkal Perjuangan No. 18, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0838-4567-3321</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=400&q=60&auto=format&fit=crop"
                alt="Kumpulan gerabah tanah liat"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Gerabah Cikampek</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ir. H. Juanda No. 45, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0896-7712-0043</p>
            </div>
          </article>
        </div>

        <!-- Paginasi: tampilan saja, angka "aktif" ditandai lewat class, belum benar-benar berpindah halaman -->
        <nav class="pagination" aria-label="Navigasi halaman direktori">
          <a href="#daftar-umkm" aria-label="Halaman sebelumnya">‹</a>
          <a href="#daftar-umkm" class="aktif" aria-current="page">1</a>
          <a href="#daftar-umkm">2</a>
          <a href="#daftar-umkm">3</a>
          <a href="#daftar-umkm" aria-label="Halaman berikutnya">›</a>
        </nav>
      </section>

      <!-- TENTANG: disederhanakan, cuma judul + satu paragraf singkat + foto -->
      <section id="tentang" class="tentang reveal">
        <div class="tentang-teks">
          <h2>Tentang katalog ini</h2>
          <p>
            Dibuat supaya warga lebih mudah menemukan UMKM di sekitar
            Karawang — dan supaya pemilik usaha kecil punya satu tempat untuk
            dicari, tanpa harus bayar iklan. Pilih kategori di direktori,
            lalu hubungi langsung lewat WA atau form Kontak di bawah.
          </p>
        </div>
        <div class="tentang-gambar">
          <img
            src="https://images.unsplash.com/photo-1642473194881-c7425b3789f1?fm=jpg&amp;q=60&amp;w=800&amp;auto=format&amp;fit=crop"
            alt="Suasana pasar UMKM Karawang"
            loading="lazy"
          />
        </div>
      </section>

      <!--
        TESTIMONI
        Avatar cuma lingkaran berisi inisial nama (bukan foto orang
        sungguhan) — supaya tidak terkesan memakai identitas/wajah orang
        asli untuk testimoni yang sebetulnya contoh/dummy.
      -->
      <section class="testimoni reveal">
        <h2>Kata Warga</h2>
        <div class="testimoni-grid">
          <article class="testimoni-kartu">
            <p class="testimoni-teks">Pesan lewat WA gampang, makanannya masih anget pas sampai. Sejak tahu Warung Bu Sari dari sini, jadi langganan.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">R</span>
              <div>
                <p class="testimoni-nama">Rina</p>
                <p class="testimoni-lokasi">Warga Karawang Barat</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">Batiknya asli buatan tangan, bukan cetak. Harganya juga jujur dibanding beli di pasar yang suka dikira turis.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">D</span>
              <div>
                <p class="testimoni-nama">Dedi</p>
                <p class="testimoni-lokasi">Pelanggan Batik Karawang Asli</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">Enak karena tinggal cari kategori Kerajinan, langsung ketemu kontaknya. Gak perlu tanya-tanya ke tetangga dulu.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">S</span>
              <div>
                <p class="testimoni-nama">Sri</p>
                <p class="testimoni-lokasi">Warga Karawang Timur</p>
              </div>
            </div>
          </article>
        </div>
      </section>
    </main>
  </body>
</html>
```

Taruh setelah `</section>` Tentang. Belum rapi di browser — masih numpuk ke bawah.

## Langkah 14 — CSS: Styling Testimoni

Pola grid-nya mirip Direktori (`auto-fit` + `minmax`), cuma isinya kartu kutipan. Avatar-nya lingkaran polos pakai `border-radius: 50%` + `display: flex` buat naruh inisialnya pas di tengah.

```css
/*
  CSS variable (custom property). Ditulis sekali di :root, dipakai
  berkali-kali lewat var(--nama). Kalau mau ganti warna tema, cukup
  ubah di sini — tidak perlu cari-ganti di semua tempat.
*/
:root {
  --matcha-abyss: #1e2a18;
  --matcha-dark: #33422b;
  --matcha-mid: #7c9473;
  --sage-pale: #e9efe1;
  --cream: #f6f3e7;
  --gold: #c9a66b;
  --ink: #1f2937;
  --content-width: 1080px;
}

/* Reset dasar: hilangkan margin/padding bawaan browser yang beda-beda tiap browser */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box; /* border & padding dihitung masuk ke lebar elemen, bukan nambah lebar */
}

/*
  scroll-behavior: smooth membuat perpindahan ke #id (misalnya klik link
  nav ke "#tentang") meluncur halus, bukan langsung loncat.
  scroll-padding-top mengimbangi tinggi header yang sticky, supaya judul
  section tidak ketutupan header saat baru sampai.
*/
html {
  scroll-behavior: smooth;
  scroll-padding-top: 84px;
}

body {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  color: var(--ink);
  background-color: var(--cream);
  line-height: 1.6;
}

h1, h2, h3 {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  font-weight: 800;
}

a {
  color: inherit;
}

/* ================= HEADER ================= */
/*
  position: sticky membuat header ini nempel di atas begitu halaman
  discroll sampai posisinya, lalu tetap di situ (beda dengan "fixed"
  yang nempel dari awal halaman dibuka).
*/
header {
  position: sticky;
  top: 0;
  z-index: 10;
  background-color: var(--matcha-abyss);
  color: white;
  transition: transform 0.3s ease;
}

/* Ditambahkan lewat JS saat pengguna scroll ke bawah — header digeser ke atas sampai hilang */
header.sembunyi {
  transform: translateY(-100%);
}

/*
  Grid 3 kolom "1fr auto 1fr": kolom kiri (wordmark) dan kolom kanan
  (spacer kosong) selalu diberi lebar yang SAMA karena sama-sama 1fr,
  apa pun isinya. Efeknya kolom tengah (nav) selalu benar-benar di
  tengah header — beda dengan flexbox space-between yang mendorong nav
  ke ujung kanan mengikuti lebar wordmark.
*/
.header-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 20px 24px;
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: center;
  gap: 12px;
}

.wordmark {
  font-family: "Plus Jakarta Sans", sans-serif;
  font-weight: 800;
  font-size: 1.2rem;
  letter-spacing: -0.01em;
}

header nav {
  display: flex;
  gap: 24px;
}

header nav a {
  color: var(--sage-pale);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  padding-bottom: 2px;
  border-bottom: 2px solid transparent;
  transition: border-color 0.2s, color 0.2s;
}

header nav a:hover,
header nav a:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= HERO ================= */
/*
  position: relative di sini jadi acuan buat 3 lapisan .hero-bg dan
  .hero-overlay yang semuanya position: absolute — pola yang sama
  seperti badge kategori (relative parent + absolute child), cuma
  dipakai buat menumpuk latar belakang, bukan menumpuk elemen kecil.
*/
.hero {
  position: relative;
  overflow: hidden;
  color: white;
  text-align: center;
  padding: 120px 24px;
}

/*
  Tiga foto ditumpuk persis di posisi yang sama (inset: 0 memenuhi
  seluruh .hero), lalu masing-masing diberi animation-delay berbeda
  supaya bergantian terlihat. Ini murni CSS — tidak ada JavaScript
  yang mengganti gambar.
*/
.hero-bg {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  opacity: 0;
  animation: heroBgCycle 18s infinite;
}

.hero-bg-2 {
  animation-delay: 6s;
}

.hero-bg-3 {
  animation-delay: 12s;
}

/*
  18 detik dibagi 3 foto = 6 detik jatah tiap foto. Tiap foto: tersembunyi
  (0%) → memudar masuk (5%) → tampil penuh (28%) → memudar keluar (33%) →
  tersembunyi lagi sampai putaran berikutnya. animation-delay di atas
  menggeser kapan tiap foto memulai siklus ini, jadi hasilnya bergantian.
*/
@keyframes heroBgCycle {
  0%, 100% { opacity: 0; }
  5% { opacity: 1; }
  28% { opacity: 1; }
  33% { opacity: 0; }
}

/* Lapisan gelap transparan di atas foto, supaya teks putih tetap terbaca di foto apa pun */
.hero-overlay {
  position: absolute;
  inset: 0;
  background-color: rgba(20, 28, 16, 0.68);
}

.hero-inner {
  position: relative; /* supaya tampil di atas .hero-bg dan .hero-overlay */
  max-width: 640px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/*
  clamp(min, ideal, max) bikin ukuran font otomatis menyesuaikan lebar
  layar di antara batas minimum dan maksimum — tanpa perlu media query
  terpisah cuma buat ukuran teks.
*/
.hero-inner h1 {
  font-size: clamp(2.2rem, 5vw, 3.3rem);
  line-height: 1.05;
  letter-spacing: -0.02em;
  margin-bottom: 20px;
  opacity: 0;
  animation: heroRise 0.6s ease forwards;
}

.hero-inner p {
  max-width: 46ch;
  color: var(--sage-pale);
  font-size: 1.05rem;
  margin-bottom: 28px;
  opacity: 0;
  animation: heroRise 0.6s ease 0.15s forwards;
}

.hero-cta {
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
  justify-content: center;
  opacity: 0;
  animation: heroRise 0.6s ease 0.3s forwards;
}

/*
  Ini satu-satunya urutan animasi "otomatis saat halaman dibuka" di
  seluruh halaman (judul, lalu paragraf, lalu tombol —
  perhatikan animation-delay yang berbeda tiap elemen). Sengaja cuma
  di hero, supaya animasi tidak berserakan di semua bagian.
*/
@keyframes heroRise {
  from { opacity: 0; transform: translateY(16px); }
  to { opacity: 1; transform: translateY(0); }
}

.btn-primary, .btn-ghost {
  display: inline-block;
  padding: 12px 24px;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.95rem;
  text-decoration: none;
  transition: transform 0.15s, background-color 0.2s, color 0.2s;
}

.btn-primary {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

.btn-primary:hover, .btn-primary:focus-visible {
  transform: translateY(-2px);
}

.btn-ghost {
  border: 1px solid var(--matcha-mid);
  color: var(--sage-pale);
}

.btn-ghost:hover, .btn-ghost:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= Direktori ================= */
.direktori {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
}

.direktori h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 20px;
}

/*
  Toolbar pencarian + filter — TAMPILAN SAJA. Input dan select ini belum
  disambungkan ke logika apa pun (belum ada JavaScript), jadi mengetik
  atau ganti dropdown-nya belum benar-benar menyaring kartu di bawah.
*/
.direktori-toolbar {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
  margin-bottom: 28px;
}

.direktori-cari {
  flex: 1;
  min-width: 200px;
  padding: 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
}

/*
  appearance: none menghilangkan panah bawaan browser (posisinya gak bisa
  diatur pakai padding). Panah custom dipasang lewat SVG di background,
  posisinya diatur manual pakai background-position — jadi bisa "dimasukin"
  sesuai jarak yang kita mau, ngikutin padding kanan.
*/
.direktori-kategori {
  padding: 11px 36px 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
  color: var(--ink);
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6' viewBox='0 0 10 6' fill='none'%3E%3Cpath d='M1 1l4 4 4-4' stroke='%2333422b' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 16px center;
}

.direktori-cari:focus,
.direktori-kategori:focus {
  outline: none;
  border-color: var(--gold);
}

/* Grid kartu: auto-fit + minmax bikin jumlah kolom menyesuaikan sendiri lebar layar, tanpa media query manual */
.grid-umkm {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.kartu-umkm {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  overflow: hidden;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.kartu-umkm:hover,
.kartu-umkm:focus-within {
  transform: translateY(-4px);
  box-shadow: 0 14px 28px rgba(51, 66, 43, 0.14);
}

/* position: relative di sini jadi acuan buat .badge yang absolute di dalamnya */
.kartu-foto {
  position: relative;
  aspect-ratio: 4 / 3;
}

.kartu-foto img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.kartu-isi {
  padding: 16px 18px 20px;
}

.kartu-isi h3 {
  font-size: 1.1rem;
  color: var(--matcha-dark);
  margin-bottom: 4px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis; /* nama kepanjangan dipotong jadi "...", bukan bikin tinggi kartu beda-beda */
}

.kartu-isi .alamat {
  color: #6b6b5f;
  font-size: 0.88rem;
  display: flex;
  align-items: center;
  gap: 6px;
}

/*
  Alamat yang kepanjangan dipotong jadi satu baris + "..." di ujungnya
  (text-overflow: ellipsis), bukan bikin kartu jadi tinggi sebelah.
  min-width: 0 wajib di sini supaya flex item ini mau menyusut duluan
  sebelum ikon di sebelahnya ikut menyusut.
*/
.kartu-isi .alamat span {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  min-width: 0;
}

.kartu-isi .alamat i,
.kartu-isi .jam i {
  color: var(--matcha-mid);
  flex-shrink: 0;
}

.kartu-isi .jam {
  color: var(--matcha-mid);
  font-size: 0.8rem;
  margin-top: 2px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa {
  color: var(--matcha-dark);
  font-size: 0.85rem;
  font-weight: 600;
  margin-top: 8px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa i {
  color: var(--matcha-mid);
}

/*
  Badge kategori: position: absolute melepas elemen ini dari alur normal
  dan menempelkannya presisi ke pojok kanan-atas .kartu-foto (parent
  terdekat yang sudah diberi position: relative di atas).
*/
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

/*
  Paginasi — TAMPILAN SAJA juga. Angka "1" ditandai .aktif lewat HTML
  langsung (bukan JavaScript), sekadar contoh bagaimana halaman aktif
  biasanya dibedakan secara visual.
*/
.pagination {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-top: 36px;
}

.pagination a {
  width: 38px;
  height: 38px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid #ddd6c4;
  border-radius: 8px;
  color: var(--matcha-dark);
  text-decoration: none;
  font-size: 0.9rem;
  transition: border-color 0.2s, background-color 0.2s, color 0.2s;
}

.pagination a:hover,
.pagination a:focus-visible {
  border-color: var(--gold);
}

.pagination a.aktif {
  background-color: var(--matcha-dark);
  border-color: var(--matcha-dark);
  color: white;
}

/* ================= Tentang ================= */
/* CSS Grid 2 kolom asimetris: kolom teks lebih lebar (7 bagian) dari kolom gambar (5 bagian) */
.tentang {
  display: grid;
  grid-template-columns: 7fr 5fr;
  max-width: var(--content-width);
  margin: 56px auto;
  border-radius: 16px;
  overflow: hidden; /* biar sudut foto & panel ikut membulat mengikuti .tentang, bukan cuma sudut luarnya */
}

.tentang-teks {
  background-color: var(--sage-pale);
  padding: 48px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.tentang-teks h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 8px;
}

.tentang-teks > p {
  color: #444;
}

.tentang-gambar {
  overflow: hidden; /* biar foto yang dibesarkan lewat object-fit tidak keluar dari kotaknya */
}

.tentang-gambar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

/* ================= Testimoni ================= */
.testimoni {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
}

.testimoni h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 24px;
}

.testimoni-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.testimoni-kartu {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  padding: 22px;
  display: flex;
  flex-direction: column;
  gap: 18px;
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.testimoni-teks {
  color: #444;
  font-size: 0.95rem;
  line-height: 1.6;
}

.testimoni-orang {
  display: flex;
  align-items: center;
  gap: 12px;
}

/* Avatar cuma inisial di lingkaran warna gold — bukan foto orang beneran */
.testimoni-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: var(--sage-pale);
  color: var(--matcha-dark);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  flex-shrink: 0;
}

.testimoni-nama {
  color: var(--matcha-dark);
  font-weight: 600;
  font-size: 0.9rem;
}

.testimoni-lokasi {
  color: var(--matcha-mid);
  font-size: 0.8rem;
}
```

Reload: 3 kartu testimoni rapi berjajar, dengan garis tipis (`border-top`) yang memisahkannya dari section Tentang di atasnya.

## Langkah 15 — HTML: Section Video

Cuma satu `<iframe>` buat nanam video YouTube, plus teks pengantar di sampingnya.

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Katalog UMKM Karawang</title>

    <!-- Google Fonts: Plus Jakarta Sans, satu family buat judul (weight tebal) dan teks biasa (weight normal) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <!-- Font Awesome lewat CDN, dipakai buat ikon medsos di footer dan ikon telepon di kartu UMKM -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <!--
      HEADER
      "sticky" di style.css bikin header ini tetap kelihatan walau halaman
      discroll ke bawah. Ini salah satu contoh nyata `position: sticky`
      yang disebutkan sekilas di materi Position.
    -->
    <header>
      <!--
        header-inner pakai 3 kolom grid (kiri-tengah-kanan) supaya nav
        benar-benar di tengah header, bukan ikut menempel ke kanan
        seperti pola flexbox space-between biasa.
      -->
      <div class="header-inner">
        <span class="wordmark">UMKM Karawang</span>
        <nav>
          <a href="#daftar-umkm">UMKM</a>
          <a href="#tentang">Tentang</a>
          <a href="#kontak">Daftar</a>
        </nav>
        <span aria-hidden="true"></span>
      </div>
    </header>

    <main>
      <!--
        HERO
        Tiga foto ditumpuk sebagai latar (.hero-bg), masing-masing diberi
        animation-delay berbeda supaya bergantian muncul terus-menerus —
        murni CSS @keyframes, tidak ada JavaScript sama sekali. Di atasnya
        ada lapisan gelap transparan (.hero-overlay) supaya teks putih
        tetap kebaca di foto apa pun yang lagi tampil.
      -->
      <section class="hero">
        <div
          class="hero-bg"
          style="background-image: url('https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-2"
          style="background-image: url('https://images.unsplash.com/photo-1533900298318-6b8da08a523e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-3"
          style="background-image: url('https://images.unsplash.com/photo-1519996529931-28324d5a630e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div class="hero-overlay" aria-hidden="true"></div>

        <div class="hero-inner">
          <h1>Usaha warga yang layak kamu temukan.</h1>
          <p>
            Direktori usaha kecil di Karawang — warung, kerajinan, dan
            busana yang dijalankan tetangga sendiri, bukan waralaba.
          </p>
          <div class="hero-cta">
            <a href="#daftar-umkm" class="btn-primary">Lihat direktori</a>
            <a href="#kontak" class="btn-ghost">Daftarkan usahamu</a>
          </div>
        </div>
      </section>

      <!--
        DIREKTORI
        Tiap UMKM ditulis sebagai <article> (bukan <div>) karena isinya
        memang "satu unit konten yang berdiri sendiri" — cocok dengan
        makna semantik <article>. class="reveal" dipakai script di bawah
        untuk animasi muncul saat discroll.

        Kotak pencarian, dropdown kategori, dan paginasi di bawah ini
        BARU TAMPILANNYA SAJA — belum benar-benar menyaring apa pun,
        karena logikanya (JavaScript) sengaja belum dibahas. Anggap ini
        "maket" tampilan dulu, fungsinya menyusul di materi selanjutnya.
      -->
      <section id="daftar-umkm" class="direktori reveal">
        <h2>Direktori</h2>

        <div class="direktori-toolbar">
          <input
            type="search"
            class="direktori-cari"
            placeholder="Cari nama UMKM..."
            aria-label="Cari UMKM"
          />
          <select class="direktori-kategori" aria-label="Filter kategori">
            <option>Semua kategori</option>
            <option>Kuliner</option>
            <option>Fashion</option>
            <option>Kerajinan</option>
          </select>
        </div>

        <div class="grid-umkm">
          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&q=60&auto=format&fit=crop"
                alt="Meja warung dengan aneka lauk siap saji"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Warung Bu Sari</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Merdeka No. 10, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 07.00 – 21.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0812-3456-7810</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1761515315375-1315503bb3ce?w=400&q=60&auto=format&fit=crop"
                alt="Kain batik bermotif tradisional"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Batik Karawang Asli</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Kertabumi No. 5, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 09.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0813-2345-6705</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1696574727184-a8cdb758d3bf?w=400&q=60&auto=format&fit=crop"
                alt="Keranjang anyaman bambu"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Anyaman Bambu Pak Jaya</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Tuparev No. 22, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0857-1234-9902</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&q=60&auto=format&fit=crop"
                alt="Secangkir kopi hitam di atas meja kayu"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Kopi Rawa Gede</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ahmad Yani No. 3, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 10.00 – 23.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0821-9988-2214</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1445205170230-053b83016050?w=400&q=60&auto=format&fit=crop"
                alt="Mesin jahit dan gulungan kain"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Konveksi Sinar Tani</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Pangkal Perjuangan No. 18, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0838-4567-3321</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=400&q=60&auto=format&fit=crop"
                alt="Kumpulan gerabah tanah liat"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Gerabah Cikampek</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ir. H. Juanda No. 45, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0896-7712-0043</p>
            </div>
          </article>
        </div>

        <!-- Paginasi: tampilan saja, angka "aktif" ditandai lewat class, belum benar-benar berpindah halaman -->
        <nav class="pagination" aria-label="Navigasi halaman direktori">
          <a href="#daftar-umkm" aria-label="Halaman sebelumnya">‹</a>
          <a href="#daftar-umkm" class="aktif" aria-current="page">1</a>
          <a href="#daftar-umkm">2</a>
          <a href="#daftar-umkm">3</a>
          <a href="#daftar-umkm" aria-label="Halaman berikutnya">›</a>
        </nav>
      </section>

      <!-- TENTANG: disederhanakan, cuma judul + satu paragraf singkat + foto -->
      <section id="tentang" class="tentang reveal">
        <div class="tentang-teks">
          <h2>Tentang katalog ini</h2>
          <p>
            Dibuat supaya warga lebih mudah menemukan UMKM di sekitar
            Karawang — dan supaya pemilik usaha kecil punya satu tempat untuk
            dicari, tanpa harus bayar iklan. Pilih kategori di direktori,
            lalu hubungi langsung lewat WA atau form Kontak di bawah.
          </p>
        </div>
        <div class="tentang-gambar">
          <img
            src="https://images.unsplash.com/photo-1642473194881-c7425b3789f1?fm=jpg&amp;q=60&amp;w=800&amp;auto=format&amp;fit=crop"
            alt="Suasana pasar UMKM Karawang"
            loading="lazy"
          />
        </div>
      </section>

      <!--
        TESTIMONI
        Avatar cuma lingkaran berisi inisial nama (bukan foto orang
        sungguhan) — supaya tidak terkesan memakai identitas/wajah orang
        asli untuk testimoni yang sebetulnya contoh/dummy.
      -->
      <section class="testimoni reveal">
        <h2>Kata Warga</h2>
        <div class="testimoni-grid">
          <article class="testimoni-kartu">
            <p class="testimoni-teks">Pesan lewat WA gampang, makanannya masih anget pas sampai. Sejak tahu Warung Bu Sari dari sini, jadi langganan.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">R</span>
              <div>
                <p class="testimoni-nama">Rina</p>
                <p class="testimoni-lokasi">Warga Karawang Barat</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">Batiknya asli buatan tangan, bukan cetak. Harganya juga jujur dibanding beli di pasar yang suka dikira turis.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">D</span>
              <div>
                <p class="testimoni-nama">Dedi</p>
                <p class="testimoni-lokasi">Pelanggan Batik Karawang Asli</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">Enak karena tinggal cari kategori Kerajinan, langsung ketemu kontaknya. Gak perlu tanya-tanya ke tetangga dulu.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">S</span>
              <div>
                <p class="testimoni-nama">Sri</p>
                <p class="testimoni-lokasi">Warga Karawang Timur</p>
              </div>
            </div>
          </article>
        </div>
      </section>

      <!-- VIDEO: contoh tag <iframe> buat nanam video YouTube -->
      <section class="video-section reveal">
        <div class="video-copy">
          <div class="sub-label">Profil singkat</div>
          <h2>Lihat langsung kesehariannya</h2>
          <p>
            Video pendek ini merekam bagaimana salah satu UMKM di katalog ini
            beroperasi tiap hari — dari buka lapak sampai melayani pembeli
            pertama.
          </p>
        </div>
        <!--
          .video-frame di style.css pakai aspect-ratio: 16/9 supaya video
          selalu proporsional di layar berapa pun lebarnya, tanpa perlu
          angka width/height tetap seperti iframe biasa.
        -->
        <div class="video-frame">
          <iframe
            src="https://www.youtube.com/embed/IxX_QHay02M"
            title="Video profil UMKM"
            loading="lazy"
            allowfullscreen
          ></iframe>
        </div>
      </section>
    </main>
  </body>
</html>
```

Taruh setelah `</section>` Testimoni. Videonya sudah bisa diputar walau belum di-CSS (`<iframe>` punya ukuran default dari browser), cuma tata letaknya masih berantakan.

## Langkah 16 — CSS: Styling Video

`aspect-ratio: 16 / 9` mengunci rasio lebar:tinggi video ini **apa pun lebar layarnya** — video tidak akan pernah gepeng atau kepotong. Ini menggantikan trik lama `padding-bottom: 56.25%` yang lebih ribet.

```css
/*
  CSS variable (custom property). Ditulis sekali di :root, dipakai
  berkali-kali lewat var(--nama). Kalau mau ganti warna tema, cukup
  ubah di sini — tidak perlu cari-ganti di semua tempat.
*/
:root {
  --matcha-abyss: #1e2a18;
  --matcha-dark: #33422b;
  --matcha-mid: #7c9473;
  --sage-pale: #e9efe1;
  --cream: #f6f3e7;
  --gold: #c9a66b;
  --ink: #1f2937;
  --content-width: 1080px;
}

/* Reset dasar: hilangkan margin/padding bawaan browser yang beda-beda tiap browser */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box; /* border & padding dihitung masuk ke lebar elemen, bukan nambah lebar */
}

/*
  scroll-behavior: smooth membuat perpindahan ke #id (misalnya klik link
  nav ke "#tentang") meluncur halus, bukan langsung loncat.
  scroll-padding-top mengimbangi tinggi header yang sticky, supaya judul
  section tidak ketutupan header saat baru sampai.
*/
html {
  scroll-behavior: smooth;
  scroll-padding-top: 84px;
}

body {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  color: var(--ink);
  background-color: var(--cream);
  line-height: 1.6;
}

h1, h2, h3 {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  font-weight: 800;
}

a {
  color: inherit;
}

/* ================= HEADER ================= */
/*
  position: sticky membuat header ini nempel di atas begitu halaman
  discroll sampai posisinya, lalu tetap di situ (beda dengan "fixed"
  yang nempel dari awal halaman dibuka).
*/
header {
  position: sticky;
  top: 0;
  z-index: 10;
  background-color: var(--matcha-abyss);
  color: white;
  transition: transform 0.3s ease;
}

/* Ditambahkan lewat JS saat pengguna scroll ke bawah — header digeser ke atas sampai hilang */
header.sembunyi {
  transform: translateY(-100%);
}

/*
  Grid 3 kolom "1fr auto 1fr": kolom kiri (wordmark) dan kolom kanan
  (spacer kosong) selalu diberi lebar yang SAMA karena sama-sama 1fr,
  apa pun isinya. Efeknya kolom tengah (nav) selalu benar-benar di
  tengah header — beda dengan flexbox space-between yang mendorong nav
  ke ujung kanan mengikuti lebar wordmark.
*/
.header-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 20px 24px;
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: center;
  gap: 12px;
}

.wordmark {
  font-family: "Plus Jakarta Sans", sans-serif;
  font-weight: 800;
  font-size: 1.2rem;
  letter-spacing: -0.01em;
}

header nav {
  display: flex;
  gap: 24px;
}

header nav a {
  color: var(--sage-pale);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  padding-bottom: 2px;
  border-bottom: 2px solid transparent;
  transition: border-color 0.2s, color 0.2s;
}

header nav a:hover,
header nav a:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= HERO ================= */
/*
  position: relative di sini jadi acuan buat 3 lapisan .hero-bg dan
  .hero-overlay yang semuanya position: absolute — pola yang sama
  seperti badge kategori (relative parent + absolute child), cuma
  dipakai buat menumpuk latar belakang, bukan menumpuk elemen kecil.
*/
.hero {
  position: relative;
  overflow: hidden;
  color: white;
  text-align: center;
  padding: 120px 24px;
}

/*
  Tiga foto ditumpuk persis di posisi yang sama (inset: 0 memenuhi
  seluruh .hero), lalu masing-masing diberi animation-delay berbeda
  supaya bergantian terlihat. Ini murni CSS — tidak ada JavaScript
  yang mengganti gambar.
*/
.hero-bg {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  opacity: 0;
  animation: heroBgCycle 18s infinite;
}

.hero-bg-2 {
  animation-delay: 6s;
}

.hero-bg-3 {
  animation-delay: 12s;
}

/*
  18 detik dibagi 3 foto = 6 detik jatah tiap foto. Tiap foto: tersembunyi
  (0%) → memudar masuk (5%) → tampil penuh (28%) → memudar keluar (33%) →
  tersembunyi lagi sampai putaran berikutnya. animation-delay di atas
  menggeser kapan tiap foto memulai siklus ini, jadi hasilnya bergantian.
*/
@keyframes heroBgCycle {
  0%, 100% { opacity: 0; }
  5% { opacity: 1; }
  28% { opacity: 1; }
  33% { opacity: 0; }
}

/* Lapisan gelap transparan di atas foto, supaya teks putih tetap terbaca di foto apa pun */
.hero-overlay {
  position: absolute;
  inset: 0;
  background-color: rgba(20, 28, 16, 0.68);
}

.hero-inner {
  position: relative; /* supaya tampil di atas .hero-bg dan .hero-overlay */
  max-width: 640px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/*
  clamp(min, ideal, max) bikin ukuran font otomatis menyesuaikan lebar
  layar di antara batas minimum dan maksimum — tanpa perlu media query
  terpisah cuma buat ukuran teks.
*/
.hero-inner h1 {
  font-size: clamp(2.2rem, 5vw, 3.3rem);
  line-height: 1.05;
  letter-spacing: -0.02em;
  margin-bottom: 20px;
  opacity: 0;
  animation: heroRise 0.6s ease forwards;
}

.hero-inner p {
  max-width: 46ch;
  color: var(--sage-pale);
  font-size: 1.05rem;
  margin-bottom: 28px;
  opacity: 0;
  animation: heroRise 0.6s ease 0.15s forwards;
}

.hero-cta {
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
  justify-content: center;
  opacity: 0;
  animation: heroRise 0.6s ease 0.3s forwards;
}

/*
  Ini satu-satunya urutan animasi "otomatis saat halaman dibuka" di
  seluruh halaman (judul, lalu paragraf, lalu tombol —
  perhatikan animation-delay yang berbeda tiap elemen). Sengaja cuma
  di hero, supaya animasi tidak berserakan di semua bagian.
*/
@keyframes heroRise {
  from { opacity: 0; transform: translateY(16px); }
  to { opacity: 1; transform: translateY(0); }
}

.btn-primary, .btn-ghost {
  display: inline-block;
  padding: 12px 24px;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.95rem;
  text-decoration: none;
  transition: transform 0.15s, background-color 0.2s, color 0.2s;
}

.btn-primary {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

.btn-primary:hover, .btn-primary:focus-visible {
  transform: translateY(-2px);
}

.btn-ghost {
  border: 1px solid var(--matcha-mid);
  color: var(--sage-pale);
}

.btn-ghost:hover, .btn-ghost:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= Direktori ================= */
.direktori {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
}

.direktori h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 20px;
}

/*
  Toolbar pencarian + filter — TAMPILAN SAJA. Input dan select ini belum
  disambungkan ke logika apa pun (belum ada JavaScript), jadi mengetik
  atau ganti dropdown-nya belum benar-benar menyaring kartu di bawah.
*/
.direktori-toolbar {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
  margin-bottom: 28px;
}

.direktori-cari {
  flex: 1;
  min-width: 200px;
  padding: 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
}

/*
  appearance: none menghilangkan panah bawaan browser (posisinya gak bisa
  diatur pakai padding). Panah custom dipasang lewat SVG di background,
  posisinya diatur manual pakai background-position — jadi bisa "dimasukin"
  sesuai jarak yang kita mau, ngikutin padding kanan.
*/
.direktori-kategori {
  padding: 11px 36px 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
  color: var(--ink);
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6' viewBox='0 0 10 6' fill='none'%3E%3Cpath d='M1 1l4 4 4-4' stroke='%2333422b' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 16px center;
}

.direktori-cari:focus,
.direktori-kategori:focus {
  outline: none;
  border-color: var(--gold);
}

/* Grid kartu: auto-fit + minmax bikin jumlah kolom menyesuaikan sendiri lebar layar, tanpa media query manual */
.grid-umkm {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.kartu-umkm {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  overflow: hidden;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.kartu-umkm:hover,
.kartu-umkm:focus-within {
  transform: translateY(-4px);
  box-shadow: 0 14px 28px rgba(51, 66, 43, 0.14);
}

/* position: relative di sini jadi acuan buat .badge yang absolute di dalamnya */
.kartu-foto {
  position: relative;
  aspect-ratio: 4 / 3;
}

.kartu-foto img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.kartu-isi {
  padding: 16px 18px 20px;
}

.kartu-isi h3 {
  font-size: 1.1rem;
  color: var(--matcha-dark);
  margin-bottom: 4px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis; /* nama kepanjangan dipotong jadi "...", bukan bikin tinggi kartu beda-beda */
}

.kartu-isi .alamat {
  color: #6b6b5f;
  font-size: 0.88rem;
  display: flex;
  align-items: center;
  gap: 6px;
}

/*
  Alamat yang kepanjangan dipotong jadi satu baris + "..." di ujungnya
  (text-overflow: ellipsis), bukan bikin kartu jadi tinggi sebelah.
  min-width: 0 wajib di sini supaya flex item ini mau menyusut duluan
  sebelum ikon di sebelahnya ikut menyusut.
*/
.kartu-isi .alamat span {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  min-width: 0;
}

.kartu-isi .alamat i,
.kartu-isi .jam i {
  color: var(--matcha-mid);
  flex-shrink: 0;
}

.kartu-isi .jam {
  color: var(--matcha-mid);
  font-size: 0.8rem;
  margin-top: 2px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa {
  color: var(--matcha-dark);
  font-size: 0.85rem;
  font-weight: 600;
  margin-top: 8px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa i {
  color: var(--matcha-mid);
}

/*
  Badge kategori: position: absolute melepas elemen ini dari alur normal
  dan menempelkannya presisi ke pojok kanan-atas .kartu-foto (parent
  terdekat yang sudah diberi position: relative di atas).
*/
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

/*
  Paginasi — TAMPILAN SAJA juga. Angka "1" ditandai .aktif lewat HTML
  langsung (bukan JavaScript), sekadar contoh bagaimana halaman aktif
  biasanya dibedakan secara visual.
*/
.pagination {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-top: 36px;
}

.pagination a {
  width: 38px;
  height: 38px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid #ddd6c4;
  border-radius: 8px;
  color: var(--matcha-dark);
  text-decoration: none;
  font-size: 0.9rem;
  transition: border-color 0.2s, background-color 0.2s, color 0.2s;
}

.pagination a:hover,
.pagination a:focus-visible {
  border-color: var(--gold);
}

.pagination a.aktif {
  background-color: var(--matcha-dark);
  border-color: var(--matcha-dark);
  color: white;
}

/* ================= Tentang ================= */
/* CSS Grid 2 kolom asimetris: kolom teks lebih lebar (7 bagian) dari kolom gambar (5 bagian) */
.tentang {
  display: grid;
  grid-template-columns: 7fr 5fr;
  max-width: var(--content-width);
  margin: 56px auto;
  border-radius: 16px;
  overflow: hidden; /* biar sudut foto & panel ikut membulat mengikuti .tentang, bukan cuma sudut luarnya */
}

.tentang-teks {
  background-color: var(--sage-pale);
  padding: 48px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.tentang-teks h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 8px;
}

.tentang-teks > p {
  color: #444;
}

.tentang-gambar {
  overflow: hidden; /* biar foto yang dibesarkan lewat object-fit tidak keluar dari kotaknya */
}

.tentang-gambar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

/* ================= Testimoni ================= */
.testimoni {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
}

.testimoni h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 24px;
}

.testimoni-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.testimoni-kartu {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  padding: 22px;
  display: flex;
  flex-direction: column;
  gap: 18px;
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.testimoni-teks {
  color: #444;
  font-size: 0.95rem;
  line-height: 1.6;
}

.testimoni-orang {
  display: flex;
  align-items: center;
  gap: 12px;
}

/* Avatar cuma inisial di lingkaran warna gold — bukan foto orang beneran */
.testimoni-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: var(--sage-pale);
  color: var(--matcha-dark);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  flex-shrink: 0;
}

.testimoni-nama {
  color: var(--matcha-dark);
  font-weight: 600;
  font-size: 0.9rem;
}

.testimoni-lokasi {
  color: var(--matcha-mid);
  font-size: 0.8rem;
}

/* ================= Video ================= */
.video-section {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
  display: grid;
  grid-template-columns: 1fr 1.4fr;
  gap: 40px;
  align-items: center;
}

.sub-label {
  color: var(--matcha-mid);
  font-weight: 600;
  font-size: 0.85rem;
  margin-bottom: 8px;
}

.video-copy h2 {
  color: var(--matcha-dark);
  font-size: 1.5rem;
  margin-bottom: 12px;
}

.video-copy p {
  color: #555;
  max-width: 42ch;
}

/*
  aspect-ratio: 16/9 mengunci rasio lebar:tinggi kotak ini apa pun lebar
  layarnya, jadi video tidak pernah gepeng atau terlalu tinggi. Ini
  menggantikan trik lama "padding-bottom: 56.25%" yang lebih ribet.
*/
.video-frame {
  position: relative;
  width: 100%;
  aspect-ratio: 16 / 9;
  border-radius: 12px;
  overflow: hidden;
  background-color: var(--matcha-abyss);
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.video-frame iframe {
  position: absolute;
  inset: 0; /* setara top:0; right:0; bottom:0; left:0; */
  width: 100%;
  height: 100%;
  border: 0;
}
```

Reload: video sekarang proporsional 16:9 di kanan, teks pengantar di kiri.

## Langkah 17 — HTML: Section Lokasi (peta)

Peta pakai URL embed publik Google Maps (`...&output=embed`) — **bukan** Maps JavaScript API, jadi **tidak butuh API key sama sekali**. Cocok buat latihan karena bisa langsung ditiru tanpa daftar akun developer.

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Katalog UMKM Karawang</title>

    <!-- Google Fonts: Plus Jakarta Sans, satu family buat judul (weight tebal) dan teks biasa (weight normal) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <!-- Font Awesome lewat CDN, dipakai buat ikon medsos di footer dan ikon telepon di kartu UMKM -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <!--
      HEADER
      "sticky" di style.css bikin header ini tetap kelihatan walau halaman
      discroll ke bawah. Ini salah satu contoh nyata `position: sticky`
      yang disebutkan sekilas di materi Position.
    -->
    <header>
      <!--
        header-inner pakai 3 kolom grid (kiri-tengah-kanan) supaya nav
        benar-benar di tengah header, bukan ikut menempel ke kanan
        seperti pola flexbox space-between biasa.
      -->
      <div class="header-inner">
        <span class="wordmark">UMKM Karawang</span>
        <nav>
          <a href="#daftar-umkm">UMKM</a>
          <a href="#tentang">Tentang</a>
          <a href="#kontak">Daftar</a>
        </nav>
        <span aria-hidden="true"></span>
      </div>
    </header>

    <main>
      <!--
        HERO
        Tiga foto ditumpuk sebagai latar (.hero-bg), masing-masing diberi
        animation-delay berbeda supaya bergantian muncul terus-menerus —
        murni CSS @keyframes, tidak ada JavaScript sama sekali. Di atasnya
        ada lapisan gelap transparan (.hero-overlay) supaya teks putih
        tetap kebaca di foto apa pun yang lagi tampil.
      -->
      <section class="hero">
        <div
          class="hero-bg"
          style="background-image: url('https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-2"
          style="background-image: url('https://images.unsplash.com/photo-1533900298318-6b8da08a523e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-3"
          style="background-image: url('https://images.unsplash.com/photo-1519996529931-28324d5a630e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div class="hero-overlay" aria-hidden="true"></div>

        <div class="hero-inner">
          <h1>Usaha warga yang layak kamu temukan.</h1>
          <p>
            Direktori usaha kecil di Karawang — warung, kerajinan, dan
            busana yang dijalankan tetangga sendiri, bukan waralaba.
          </p>
          <div class="hero-cta">
            <a href="#daftar-umkm" class="btn-primary">Lihat direktori</a>
            <a href="#kontak" class="btn-ghost">Daftarkan usahamu</a>
          </div>
        </div>
      </section>

      <!--
        DIREKTORI
        Tiap UMKM ditulis sebagai <article> (bukan <div>) karena isinya
        memang "satu unit konten yang berdiri sendiri" — cocok dengan
        makna semantik <article>. class="reveal" dipakai script di bawah
        untuk animasi muncul saat discroll.

        Kotak pencarian, dropdown kategori, dan paginasi di bawah ini
        BARU TAMPILANNYA SAJA — belum benar-benar menyaring apa pun,
        karena logikanya (JavaScript) sengaja belum dibahas. Anggap ini
        "maket" tampilan dulu, fungsinya menyusul di materi selanjutnya.
      -->
      <section id="daftar-umkm" class="direktori reveal">
        <h2>Direktori</h2>

        <div class="direktori-toolbar">
          <input
            type="search"
            class="direktori-cari"
            placeholder="Cari nama UMKM..."
            aria-label="Cari UMKM"
          />
          <select class="direktori-kategori" aria-label="Filter kategori">
            <option>Semua kategori</option>
            <option>Kuliner</option>
            <option>Fashion</option>
            <option>Kerajinan</option>
          </select>
        </div>

        <div class="grid-umkm">
          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&q=60&auto=format&fit=crop"
                alt="Meja warung dengan aneka lauk siap saji"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Warung Bu Sari</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Merdeka No. 10, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 07.00 – 21.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0812-3456-7810</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1761515315375-1315503bb3ce?w=400&q=60&auto=format&fit=crop"
                alt="Kain batik bermotif tradisional"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Batik Karawang Asli</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Kertabumi No. 5, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 09.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0813-2345-6705</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1696574727184-a8cdb758d3bf?w=400&q=60&auto=format&fit=crop"
                alt="Keranjang anyaman bambu"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Anyaman Bambu Pak Jaya</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Tuparev No. 22, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0857-1234-9902</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&q=60&auto=format&fit=crop"
                alt="Secangkir kopi hitam di atas meja kayu"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Kopi Rawa Gede</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ahmad Yani No. 3, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 10.00 – 23.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0821-9988-2214</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1445205170230-053b83016050?w=400&q=60&auto=format&fit=crop"
                alt="Mesin jahit dan gulungan kain"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Konveksi Sinar Tani</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Pangkal Perjuangan No. 18, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0838-4567-3321</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=400&q=60&auto=format&fit=crop"
                alt="Kumpulan gerabah tanah liat"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Gerabah Cikampek</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ir. H. Juanda No. 45, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0896-7712-0043</p>
            </div>
          </article>
        </div>

        <!-- Paginasi: tampilan saja, angka "aktif" ditandai lewat class, belum benar-benar berpindah halaman -->
        <nav class="pagination" aria-label="Navigasi halaman direktori">
          <a href="#daftar-umkm" aria-label="Halaman sebelumnya">‹</a>
          <a href="#daftar-umkm" class="aktif" aria-current="page">1</a>
          <a href="#daftar-umkm">2</a>
          <a href="#daftar-umkm">3</a>
          <a href="#daftar-umkm" aria-label="Halaman berikutnya">›</a>
        </nav>
      </section>

      <!-- TENTANG: disederhanakan, cuma judul + satu paragraf singkat + foto -->
      <section id="tentang" class="tentang reveal">
        <div class="tentang-teks">
          <h2>Tentang katalog ini</h2>
          <p>
            Dibuat supaya warga lebih mudah menemukan UMKM di sekitar
            Karawang — dan supaya pemilik usaha kecil punya satu tempat untuk
            dicari, tanpa harus bayar iklan. Pilih kategori di direktori,
            lalu hubungi langsung lewat WA atau form Kontak di bawah.
          </p>
        </div>
        <div class="tentang-gambar">
          <img
            src="https://images.unsplash.com/photo-1642473194881-c7425b3789f1?fm=jpg&amp;q=60&amp;w=800&amp;auto=format&amp;fit=crop"
            alt="Suasana pasar UMKM Karawang"
            loading="lazy"
          />
        </div>
      </section>

      <!--
        TESTIMONI
        Avatar cuma lingkaran berisi inisial nama (bukan foto orang
        sungguhan) — supaya tidak terkesan memakai identitas/wajah orang
        asli untuk testimoni yang sebetulnya contoh/dummy.
      -->
      <section class="testimoni reveal">
        <h2>Kata Warga</h2>
        <div class="testimoni-grid">
          <article class="testimoni-kartu">
            <p class="testimoni-teks">Pesan lewat WA gampang, makanannya masih anget pas sampai. Sejak tahu Warung Bu Sari dari sini, jadi langganan.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">R</span>
              <div>
                <p class="testimoni-nama">Rina</p>
                <p class="testimoni-lokasi">Warga Karawang Barat</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">Batiknya asli buatan tangan, bukan cetak. Harganya juga jujur dibanding beli di pasar yang suka dikira turis.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">D</span>
              <div>
                <p class="testimoni-nama">Dedi</p>
                <p class="testimoni-lokasi">Pelanggan Batik Karawang Asli</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">Enak karena tinggal cari kategori Kerajinan, langsung ketemu kontaknya. Gak perlu tanya-tanya ke tetangga dulu.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">S</span>
              <div>
                <p class="testimoni-nama">Sri</p>
                <p class="testimoni-lokasi">Warga Karawang Timur</p>
              </div>
            </div>
          </article>
        </div>
      </section>

      <!-- VIDEO: contoh tag <iframe> buat nanam video YouTube -->
      <section class="video-section reveal">
        <div class="video-copy">
          <div class="sub-label">Profil singkat</div>
          <h2>Lihat langsung kesehariannya</h2>
          <p>
            Video pendek ini merekam bagaimana salah satu UMKM di katalog ini
            beroperasi tiap hari — dari buka lapak sampai melayani pembeli
            pertama.
          </p>
        </div>
        <!--
          .video-frame di style.css pakai aspect-ratio: 16/9 supaya video
          selalu proporsional di layar berapa pun lebarnya, tanpa perlu
          angka width/height tetap seperti iframe biasa.
        -->
        <div class="video-frame">
          <iframe
            src="https://www.youtube.com/embed/IxX_QHay02M"
            title="Video profil UMKM"
            loading="lazy"
            allowfullscreen
          ></iframe>
        </div>
      </section>

      <!--
        LOKASI
        Peta Google Maps di sini pakai URL embed publik (bukan Maps
        JavaScript API), jadi tidak butuh API key sama sekali — cocok
        buat latihan karena bisa langsung ditiru tanpa daftar akun.
      -->
      <section id="lokasi" class="lokasi reveal">
        <div class="lokasi-peta">
          <iframe
            src="https://maps.google.com/maps?q=Karawang&t=&z=13&ie=UTF8&iwloc=&output=embed"
            title="Peta area Karawang"
            loading="lazy"
          ></iframe>
        </div>
        <div class="lokasi-daftar">
          <h2>Mau kerja sama atau daftarin UMKM-mu?</h2>
          <ul>
            <li><i class="fa-solid fa-envelope" aria-hidden="true"></i> halo@umkmkarawang.id</li>
            <li><i class="fa-regular fa-clock" aria-hidden="true"></i> Senin–Sabtu, jam 09.00–17.00</li>
          </ul>
          <div class="lokasi-sosial">
            <a href="https://wa.me/6281200001234" target="_blank" rel="noopener" aria-label="Chat WhatsApp UMKM Karawang"><i class="fa-brands fa-whatsapp" aria-hidden="true"></i></a>
            <a href="https://instagram.com/umkmkarawang" target="_blank" rel="noopener" aria-label="Instagram UMKM Karawang"><i class="fa-brands fa-instagram" aria-hidden="true"></i></a>
          </div>
        </div>
      </section>
    </main>
  </body>
</html>
```

Taruh setelah `</section>` Video. Peta sudah bisa digeser/zoom walau tata letaknya masih berantakan.

## Langkah 18 — CSS: Styling Lokasi

Pola sama seperti Video: `aspect-ratio: 16 / 9` juga dipakai di sini biar peta proporsional. Daftar kontak di sampingnya pakai `list-style: none` supaya bulatan bawaan `<ul>` hilang, diganti garis tipis antar baris.

```css
/*
  CSS variable (custom property). Ditulis sekali di :root, dipakai
  berkali-kali lewat var(--nama). Kalau mau ganti warna tema, cukup
  ubah di sini — tidak perlu cari-ganti di semua tempat.
*/
:root {
  --matcha-abyss: #1e2a18;
  --matcha-dark: #33422b;
  --matcha-mid: #7c9473;
  --sage-pale: #e9efe1;
  --cream: #f6f3e7;
  --gold: #c9a66b;
  --ink: #1f2937;
  --content-width: 1080px;
}

/* Reset dasar: hilangkan margin/padding bawaan browser yang beda-beda tiap browser */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box; /* border & padding dihitung masuk ke lebar elemen, bukan nambah lebar */
}

/*
  scroll-behavior: smooth membuat perpindahan ke #id (misalnya klik link
  nav ke "#tentang") meluncur halus, bukan langsung loncat.
  scroll-padding-top mengimbangi tinggi header yang sticky, supaya judul
  section tidak ketutupan header saat baru sampai.
*/
html {
  scroll-behavior: smooth;
  scroll-padding-top: 84px;
}

body {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  color: var(--ink);
  background-color: var(--cream);
  line-height: 1.6;
}

h1, h2, h3 {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  font-weight: 800;
}

a {
  color: inherit;
}

/* ================= HEADER ================= */
/*
  position: sticky membuat header ini nempel di atas begitu halaman
  discroll sampai posisinya, lalu tetap di situ (beda dengan "fixed"
  yang nempel dari awal halaman dibuka).
*/
header {
  position: sticky;
  top: 0;
  z-index: 10;
  background-color: var(--matcha-abyss);
  color: white;
  transition: transform 0.3s ease;
}

/* Ditambahkan lewat JS saat pengguna scroll ke bawah — header digeser ke atas sampai hilang */
header.sembunyi {
  transform: translateY(-100%);
}

/*
  Grid 3 kolom "1fr auto 1fr": kolom kiri (wordmark) dan kolom kanan
  (spacer kosong) selalu diberi lebar yang SAMA karena sama-sama 1fr,
  apa pun isinya. Efeknya kolom tengah (nav) selalu benar-benar di
  tengah header — beda dengan flexbox space-between yang mendorong nav
  ke ujung kanan mengikuti lebar wordmark.
*/
.header-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 20px 24px;
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: center;
  gap: 12px;
}

.wordmark {
  font-family: "Plus Jakarta Sans", sans-serif;
  font-weight: 800;
  font-size: 1.2rem;
  letter-spacing: -0.01em;
}

header nav {
  display: flex;
  gap: 24px;
}

header nav a {
  color: var(--sage-pale);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  padding-bottom: 2px;
  border-bottom: 2px solid transparent;
  transition: border-color 0.2s, color 0.2s;
}

header nav a:hover,
header nav a:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= HERO ================= */
/*
  position: relative di sini jadi acuan buat 3 lapisan .hero-bg dan
  .hero-overlay yang semuanya position: absolute — pola yang sama
  seperti badge kategori (relative parent + absolute child), cuma
  dipakai buat menumpuk latar belakang, bukan menumpuk elemen kecil.
*/
.hero {
  position: relative;
  overflow: hidden;
  color: white;
  text-align: center;
  padding: 120px 24px;
}

/*
  Tiga foto ditumpuk persis di posisi yang sama (inset: 0 memenuhi
  seluruh .hero), lalu masing-masing diberi animation-delay berbeda
  supaya bergantian terlihat. Ini murni CSS — tidak ada JavaScript
  yang mengganti gambar.
*/
.hero-bg {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  opacity: 0;
  animation: heroBgCycle 18s infinite;
}

.hero-bg-2 {
  animation-delay: 6s;
}

.hero-bg-3 {
  animation-delay: 12s;
}

/*
  18 detik dibagi 3 foto = 6 detik jatah tiap foto. Tiap foto: tersembunyi
  (0%) → memudar masuk (5%) → tampil penuh (28%) → memudar keluar (33%) →
  tersembunyi lagi sampai putaran berikutnya. animation-delay di atas
  menggeser kapan tiap foto memulai siklus ini, jadi hasilnya bergantian.
*/
@keyframes heroBgCycle {
  0%, 100% { opacity: 0; }
  5% { opacity: 1; }
  28% { opacity: 1; }
  33% { opacity: 0; }
}

/* Lapisan gelap transparan di atas foto, supaya teks putih tetap terbaca di foto apa pun */
.hero-overlay {
  position: absolute;
  inset: 0;
  background-color: rgba(20, 28, 16, 0.68);
}

.hero-inner {
  position: relative; /* supaya tampil di atas .hero-bg dan .hero-overlay */
  max-width: 640px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/*
  clamp(min, ideal, max) bikin ukuran font otomatis menyesuaikan lebar
  layar di antara batas minimum dan maksimum — tanpa perlu media query
  terpisah cuma buat ukuran teks.
*/
.hero-inner h1 {
  font-size: clamp(2.2rem, 5vw, 3.3rem);
  line-height: 1.05;
  letter-spacing: -0.02em;
  margin-bottom: 20px;
  opacity: 0;
  animation: heroRise 0.6s ease forwards;
}

.hero-inner p {
  max-width: 46ch;
  color: var(--sage-pale);
  font-size: 1.05rem;
  margin-bottom: 28px;
  opacity: 0;
  animation: heroRise 0.6s ease 0.15s forwards;
}

.hero-cta {
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
  justify-content: center;
  opacity: 0;
  animation: heroRise 0.6s ease 0.3s forwards;
}

/*
  Ini satu-satunya urutan animasi "otomatis saat halaman dibuka" di
  seluruh halaman (judul, lalu paragraf, lalu tombol —
  perhatikan animation-delay yang berbeda tiap elemen). Sengaja cuma
  di hero, supaya animasi tidak berserakan di semua bagian.
*/
@keyframes heroRise {
  from { opacity: 0; transform: translateY(16px); }
  to { opacity: 1; transform: translateY(0); }
}

.btn-primary, .btn-ghost {
  display: inline-block;
  padding: 12px 24px;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.95rem;
  text-decoration: none;
  transition: transform 0.15s, background-color 0.2s, color 0.2s;
}

.btn-primary {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

.btn-primary:hover, .btn-primary:focus-visible {
  transform: translateY(-2px);
}

.btn-ghost {
  border: 1px solid var(--matcha-mid);
  color: var(--sage-pale);
}

.btn-ghost:hover, .btn-ghost:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= Direktori ================= */
.direktori {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
}

.direktori h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 20px;
}

/*
  Toolbar pencarian + filter — TAMPILAN SAJA. Input dan select ini belum
  disambungkan ke logika apa pun (belum ada JavaScript), jadi mengetik
  atau ganti dropdown-nya belum benar-benar menyaring kartu di bawah.
*/
.direktori-toolbar {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
  margin-bottom: 28px;
}

.direktori-cari {
  flex: 1;
  min-width: 200px;
  padding: 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
}

/*
  appearance: none menghilangkan panah bawaan browser (posisinya gak bisa
  diatur pakai padding). Panah custom dipasang lewat SVG di background,
  posisinya diatur manual pakai background-position — jadi bisa "dimasukin"
  sesuai jarak yang kita mau, ngikutin padding kanan.
*/
.direktori-kategori {
  padding: 11px 36px 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
  color: var(--ink);
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6' viewBox='0 0 10 6' fill='none'%3E%3Cpath d='M1 1l4 4 4-4' stroke='%2333422b' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 16px center;
}

.direktori-cari:focus,
.direktori-kategori:focus {
  outline: none;
  border-color: var(--gold);
}

/* Grid kartu: auto-fit + minmax bikin jumlah kolom menyesuaikan sendiri lebar layar, tanpa media query manual */
.grid-umkm {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.kartu-umkm {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  overflow: hidden;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.kartu-umkm:hover,
.kartu-umkm:focus-within {
  transform: translateY(-4px);
  box-shadow: 0 14px 28px rgba(51, 66, 43, 0.14);
}

/* position: relative di sini jadi acuan buat .badge yang absolute di dalamnya */
.kartu-foto {
  position: relative;
  aspect-ratio: 4 / 3;
}

.kartu-foto img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.kartu-isi {
  padding: 16px 18px 20px;
}

.kartu-isi h3 {
  font-size: 1.1rem;
  color: var(--matcha-dark);
  margin-bottom: 4px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis; /* nama kepanjangan dipotong jadi "...", bukan bikin tinggi kartu beda-beda */
}

.kartu-isi .alamat {
  color: #6b6b5f;
  font-size: 0.88rem;
  display: flex;
  align-items: center;
  gap: 6px;
}

/*
  Alamat yang kepanjangan dipotong jadi satu baris + "..." di ujungnya
  (text-overflow: ellipsis), bukan bikin kartu jadi tinggi sebelah.
  min-width: 0 wajib di sini supaya flex item ini mau menyusut duluan
  sebelum ikon di sebelahnya ikut menyusut.
*/
.kartu-isi .alamat span {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  min-width: 0;
}

.kartu-isi .alamat i,
.kartu-isi .jam i {
  color: var(--matcha-mid);
  flex-shrink: 0;
}

.kartu-isi .jam {
  color: var(--matcha-mid);
  font-size: 0.8rem;
  margin-top: 2px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa {
  color: var(--matcha-dark);
  font-size: 0.85rem;
  font-weight: 600;
  margin-top: 8px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa i {
  color: var(--matcha-mid);
}

/*
  Badge kategori: position: absolute melepas elemen ini dari alur normal
  dan menempelkannya presisi ke pojok kanan-atas .kartu-foto (parent
  terdekat yang sudah diberi position: relative di atas).
*/
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

/*
  Paginasi — TAMPILAN SAJA juga. Angka "1" ditandai .aktif lewat HTML
  langsung (bukan JavaScript), sekadar contoh bagaimana halaman aktif
  biasanya dibedakan secara visual.
*/
.pagination {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-top: 36px;
}

.pagination a {
  width: 38px;
  height: 38px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid #ddd6c4;
  border-radius: 8px;
  color: var(--matcha-dark);
  text-decoration: none;
  font-size: 0.9rem;
  transition: border-color 0.2s, background-color 0.2s, color 0.2s;
}

.pagination a:hover,
.pagination a:focus-visible {
  border-color: var(--gold);
}

.pagination a.aktif {
  background-color: var(--matcha-dark);
  border-color: var(--matcha-dark);
  color: white;
}

/* ================= Tentang ================= */
/* CSS Grid 2 kolom asimetris: kolom teks lebih lebar (7 bagian) dari kolom gambar (5 bagian) */
.tentang {
  display: grid;
  grid-template-columns: 7fr 5fr;
  max-width: var(--content-width);
  margin: 56px auto;
  border-radius: 16px;
  overflow: hidden; /* biar sudut foto & panel ikut membulat mengikuti .tentang, bukan cuma sudut luarnya */
}

.tentang-teks {
  background-color: var(--sage-pale);
  padding: 48px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.tentang-teks h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 8px;
}

.tentang-teks > p {
  color: #444;
}

.tentang-gambar {
  overflow: hidden; /* biar foto yang dibesarkan lewat object-fit tidak keluar dari kotaknya */
}

.tentang-gambar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

/* ================= Testimoni ================= */
.testimoni {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
}

.testimoni h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 24px;
}

.testimoni-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.testimoni-kartu {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  padding: 22px;
  display: flex;
  flex-direction: column;
  gap: 18px;
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.testimoni-teks {
  color: #444;
  font-size: 0.95rem;
  line-height: 1.6;
}

.testimoni-orang {
  display: flex;
  align-items: center;
  gap: 12px;
}

/* Avatar cuma inisial di lingkaran warna gold — bukan foto orang beneran */
.testimoni-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: var(--sage-pale);
  color: var(--matcha-dark);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  flex-shrink: 0;
}

.testimoni-nama {
  color: var(--matcha-dark);
  font-weight: 600;
  font-size: 0.9rem;
}

.testimoni-lokasi {
  color: var(--matcha-mid);
  font-size: 0.8rem;
}

/* ================= Video ================= */
.video-section {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
  display: grid;
  grid-template-columns: 1fr 1.4fr;
  gap: 40px;
  align-items: center;
}

.sub-label {
  color: var(--matcha-mid);
  font-weight: 600;
  font-size: 0.85rem;
  margin-bottom: 8px;
}

.video-copy h2 {
  color: var(--matcha-dark);
  font-size: 1.5rem;
  margin-bottom: 12px;
}

.video-copy p {
  color: #555;
  max-width: 42ch;
}

/*
  aspect-ratio: 16/9 mengunci rasio lebar:tinggi kotak ini apa pun lebar
  layarnya, jadi video tidak pernah gepeng atau terlalu tinggi. Ini
  menggantikan trik lama "padding-bottom: 56.25%" yang lebih ribet.
*/
.video-frame {
  position: relative;
  width: 100%;
  aspect-ratio: 16 / 9;
  border-radius: 12px;
  overflow: hidden;
  background-color: var(--matcha-abyss);
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.video-frame iframe {
  position: absolute;
  inset: 0; /* setara top:0; right:0; bottom:0; left:0; */
  width: 100%;
  height: 100%;
  border: 0;
}

/* ================= Lokasi ================= */
.lokasi {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
  display: grid;
  grid-template-columns: 1.3fr 1fr;
  gap: 40px;
  align-items: start;
}

/* Peta juga pakai aspect-ratio, sama seperti video di atas */
.lokasi-peta {
  aspect-ratio: 16 / 9;
  border-radius: 12px;
  overflow: hidden;
  border: 1px solid #ddd6c4;
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.lokasi-peta iframe {
  width: 100%;
  height: 100%;
  border: 0;
}

.lokasi-daftar h2 {
  color: var(--matcha-dark);
  font-size: 1.5rem;
  margin-bottom: 16px;
}

.lokasi-daftar ul {
  list-style: none;
}

/* WhatsApp & Instagram jadi tombol bulat yang bisa diklik, bukan cuma teks */
.lokasi-sosial {
  display: flex;
  gap: 12px;
  margin-top: 28px;
}

.lokasi-sosial a {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background-color: var(--sage-pale);
  color: var(--matcha-dark);
  font-size: 1.05rem;
  text-decoration: none;
  transition: background-color 0.2s, color 0.2s;
}

.lokasi-sosial a:hover,
.lokasi-sosial a:focus-visible {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

.lokasi-daftar li {
  padding: 6px 0;
  font-size: 0.92rem;
  color: #555;
}

.lokasi-daftar li i {
  color: var(--matcha-mid);
  width: 16px;
  margin-right: 8px;
  text-align: center;
}
```

Reload: peta dan daftar kontak sekarang berdampingan rapi, tiap barisnya punya garis pemisah tipis.

## Langkah 19 — HTML: Section Kontak (form)

Form sederhana: nama, pesan, tombol kirim. Perhatikan `<label for="nama">` terhubung ke `<input id="nama">` lewat atribut `for`/`id` yang sama — ini bikin klik label ikut fokus ke input-nya, bagus buat aksesibilitas.

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Katalog UMKM Karawang</title>

    <!-- Google Fonts: Plus Jakarta Sans, satu family buat judul (weight tebal) dan teks biasa (weight normal) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <!-- Font Awesome lewat CDN, dipakai buat ikon medsos di footer dan ikon telepon di kartu UMKM -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <!--
      HEADER
      "sticky" di style.css bikin header ini tetap kelihatan walau halaman
      discroll ke bawah. Ini salah satu contoh nyata `position: sticky`
      yang disebutkan sekilas di materi Position.
    -->
    <header>
      <!--
        header-inner pakai 3 kolom grid (kiri-tengah-kanan) supaya nav
        benar-benar di tengah header, bukan ikut menempel ke kanan
        seperti pola flexbox space-between biasa.
      -->
      <div class="header-inner">
        <span class="wordmark">UMKM Karawang</span>
        <nav>
          <a href="#daftar-umkm">UMKM</a>
          <a href="#tentang">Tentang</a>
          <a href="#kontak">Daftar</a>
        </nav>
        <span aria-hidden="true"></span>
      </div>
    </header>

    <main>
      <!--
        HERO
        Tiga foto ditumpuk sebagai latar (.hero-bg), masing-masing diberi
        animation-delay berbeda supaya bergantian muncul terus-menerus —
        murni CSS @keyframes, tidak ada JavaScript sama sekali. Di atasnya
        ada lapisan gelap transparan (.hero-overlay) supaya teks putih
        tetap kebaca di foto apa pun yang lagi tampil.
      -->
      <section class="hero">
        <div
          class="hero-bg"
          style="background-image: url('https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-2"
          style="background-image: url('https://images.unsplash.com/photo-1533900298318-6b8da08a523e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-3"
          style="background-image: url('https://images.unsplash.com/photo-1519996529931-28324d5a630e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div class="hero-overlay" aria-hidden="true"></div>

        <div class="hero-inner">
          <h1>Usaha warga yang layak kamu temukan.</h1>
          <p>
            Direktori usaha kecil di Karawang — warung, kerajinan, dan
            busana yang dijalankan tetangga sendiri, bukan waralaba.
          </p>
          <div class="hero-cta">
            <a href="#daftar-umkm" class="btn-primary">Lihat direktori</a>
            <a href="#kontak" class="btn-ghost">Daftarkan usahamu</a>
          </div>
        </div>
      </section>

      <!--
        DIREKTORI
        Tiap UMKM ditulis sebagai <article> (bukan <div>) karena isinya
        memang "satu unit konten yang berdiri sendiri" — cocok dengan
        makna semantik <article>. class="reveal" dipakai script di bawah
        untuk animasi muncul saat discroll.

        Kotak pencarian, dropdown kategori, dan paginasi di bawah ini
        BARU TAMPILANNYA SAJA — belum benar-benar menyaring apa pun,
        karena logikanya (JavaScript) sengaja belum dibahas. Anggap ini
        "maket" tampilan dulu, fungsinya menyusul di materi selanjutnya.
      -->
      <section id="daftar-umkm" class="direktori reveal">
        <h2>Direktori</h2>

        <div class="direktori-toolbar">
          <input
            type="search"
            class="direktori-cari"
            placeholder="Cari nama UMKM..."
            aria-label="Cari UMKM"
          />
          <select class="direktori-kategori" aria-label="Filter kategori">
            <option>Semua kategori</option>
            <option>Kuliner</option>
            <option>Fashion</option>
            <option>Kerajinan</option>
          </select>
        </div>

        <div class="grid-umkm">
          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&q=60&auto=format&fit=crop"
                alt="Meja warung dengan aneka lauk siap saji"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Warung Bu Sari</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Merdeka No. 10, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 07.00 – 21.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0812-3456-7810</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1761515315375-1315503bb3ce?w=400&q=60&auto=format&fit=crop"
                alt="Kain batik bermotif tradisional"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Batik Karawang Asli</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Kertabumi No. 5, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 09.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0813-2345-6705</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1696574727184-a8cdb758d3bf?w=400&q=60&auto=format&fit=crop"
                alt="Keranjang anyaman bambu"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Anyaman Bambu Pak Jaya</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Tuparev No. 22, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0857-1234-9902</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&q=60&auto=format&fit=crop"
                alt="Secangkir kopi hitam di atas meja kayu"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Kopi Rawa Gede</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ahmad Yani No. 3, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 10.00 – 23.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0821-9988-2214</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1445205170230-053b83016050?w=400&q=60&auto=format&fit=crop"
                alt="Mesin jahit dan gulungan kain"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Konveksi Sinar Tani</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Pangkal Perjuangan No. 18, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0838-4567-3321</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=400&q=60&auto=format&fit=crop"
                alt="Kumpulan gerabah tanah liat"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Gerabah Cikampek</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ir. H. Juanda No. 45, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0896-7712-0043</p>
            </div>
          </article>
        </div>

        <!-- Paginasi: tampilan saja, angka "aktif" ditandai lewat class, belum benar-benar berpindah halaman -->
        <nav class="pagination" aria-label="Navigasi halaman direktori">
          <a href="#daftar-umkm" aria-label="Halaman sebelumnya">‹</a>
          <a href="#daftar-umkm" class="aktif" aria-current="page">1</a>
          <a href="#daftar-umkm">2</a>
          <a href="#daftar-umkm">3</a>
          <a href="#daftar-umkm" aria-label="Halaman berikutnya">›</a>
        </nav>
      </section>

      <!-- TENTANG: disederhanakan, cuma judul + satu paragraf singkat + foto -->
      <section id="tentang" class="tentang reveal">
        <div class="tentang-teks">
          <h2>Tentang katalog ini</h2>
          <p>
            Dibuat supaya warga lebih mudah menemukan UMKM di sekitar
            Karawang — dan supaya pemilik usaha kecil punya satu tempat untuk
            dicari, tanpa harus bayar iklan. Pilih kategori di direktori,
            lalu hubungi langsung lewat WA atau form Kontak di bawah.
          </p>
        </div>
        <div class="tentang-gambar">
          <img
            src="https://images.unsplash.com/photo-1642473194881-c7425b3789f1?fm=jpg&amp;q=60&amp;w=800&amp;auto=format&amp;fit=crop"
            alt="Suasana pasar UMKM Karawang"
            loading="lazy"
          />
        </div>
      </section>

      <!--
        TESTIMONI
        Avatar cuma lingkaran berisi inisial nama (bukan foto orang
        sungguhan) — supaya tidak terkesan memakai identitas/wajah orang
        asli untuk testimoni yang sebetulnya contoh/dummy.
      -->
      <section class="testimoni reveal">
        <h2>Kata Warga</h2>
        <div class="testimoni-grid">
          <article class="testimoni-kartu">
            <p class="testimoni-teks">Pesan lewat WA gampang, makanannya masih anget pas sampai. Sejak tahu Warung Bu Sari dari sini, jadi langganan.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">R</span>
              <div>
                <p class="testimoni-nama">Rina</p>
                <p class="testimoni-lokasi">Warga Karawang Barat</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">Batiknya asli buatan tangan, bukan cetak. Harganya juga jujur dibanding beli di pasar yang suka dikira turis.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">D</span>
              <div>
                <p class="testimoni-nama">Dedi</p>
                <p class="testimoni-lokasi">Pelanggan Batik Karawang Asli</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">Enak karena tinggal cari kategori Kerajinan, langsung ketemu kontaknya. Gak perlu tanya-tanya ke tetangga dulu.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">S</span>
              <div>
                <p class="testimoni-nama">Sri</p>
                <p class="testimoni-lokasi">Warga Karawang Timur</p>
              </div>
            </div>
          </article>
        </div>
      </section>

      <!-- VIDEO: contoh tag <iframe> buat nanam video YouTube -->
      <section class="video-section reveal">
        <div class="video-copy">
          <div class="sub-label">Profil singkat</div>
          <h2>Lihat langsung kesehariannya</h2>
          <p>
            Video pendek ini merekam bagaimana salah satu UMKM di katalog ini
            beroperasi tiap hari — dari buka lapak sampai melayani pembeli
            pertama.
          </p>
        </div>
        <!--
          .video-frame di style.css pakai aspect-ratio: 16/9 supaya video
          selalu proporsional di layar berapa pun lebarnya, tanpa perlu
          angka width/height tetap seperti iframe biasa.
        -->
        <div class="video-frame">
          <iframe
            src="https://www.youtube.com/embed/IxX_QHay02M"
            title="Video profil UMKM"
            loading="lazy"
            allowfullscreen
          ></iframe>
        </div>
      </section>

      <!--
        LOKASI
        Peta Google Maps di sini pakai URL embed publik (bukan Maps
        JavaScript API), jadi tidak butuh API key sama sekali — cocok
        buat latihan karena bisa langsung ditiru tanpa daftar akun.
      -->
      <section id="lokasi" class="lokasi reveal">
        <div class="lokasi-peta">
          <iframe
            src="https://maps.google.com/maps?q=Karawang&t=&z=13&ie=UTF8&iwloc=&output=embed"
            title="Peta area Karawang"
            loading="lazy"
          ></iframe>
        </div>
        <div class="lokasi-daftar">
          <h2>Mau kerja sama atau daftarin UMKM-mu?</h2>
          <ul>
            <li><i class="fa-solid fa-envelope" aria-hidden="true"></i> halo@umkmkarawang.id</li>
            <li><i class="fa-regular fa-clock" aria-hidden="true"></i> Senin–Sabtu, jam 09.00–17.00</li>
          </ul>
          <div class="lokasi-sosial">
            <a href="https://wa.me/6281200001234" target="_blank" rel="noopener" aria-label="Chat WhatsApp UMKM Karawang"><i class="fa-brands fa-whatsapp" aria-hidden="true"></i></a>
            <a href="https://instagram.com/umkmkarawang" target="_blank" rel="noopener" aria-label="Instagram UMKM Karawang"><i class="fa-brands fa-instagram" aria-hidden="true"></i></a>
          </div>
        </div>
      </section>

      <!-- KONTAK: form pendaftaran UMKM baru -->
      <section id="kontak" class="kontak reveal">
        <div class="kontak-inner">
          <div class="kontak-copy">
            <h2>Punya usaha yang belum terdaftar?</h2>
            <p>
              Kirim nama dan pesan singkat, kami hubungi balik untuk proses
              pendaftarannya.
            </p>
          </div>
          <form>
            <label for="nama">Nama</label>
            <input type="text" id="nama" name="nama" placeholder="Nama kamu" />

            <label for="pesan">Pesan</label>
            <textarea
              id="pesan"
              name="pesan"
              placeholder="Ceritakan usahamu secara singkat..."
            ></textarea>

            <button type="submit">Kirim pesan</button>
          </form>
        </div>
      </section>
    </main>
  </body>
</html>
```

Taruh setelah `</section>` Lokasi. **Perhatikan** kali ini kita juga menutup `</main>` — karena Kontak adalah section terakhir di dalam `<main>`. Di browser: form-nya sudah bisa diketik/diklik walau tampilannya masih tampilan bawaan browser (kotak putih polos).

## Langkah 20 — CSS: Styling Kontak

Form di sini sengaja **tidak** pakai kotak input bergaya biasa — inputnya cuma bergaris bawah (`border-bottom`), lebih ringan dilihat di atas panel gelap. Di akhir ada satu aturan penting yang berlaku ke **semua** elemen interaktif di halaman (link, tombol, input, textarea): `:focus-visible` kasih garis outline jelas ke elemen yang lagi difokus lewat keyboard (Tab), bukan cuma mouse.

```css
/*
  CSS variable (custom property). Ditulis sekali di :root, dipakai
  berkali-kali lewat var(--nama). Kalau mau ganti warna tema, cukup
  ubah di sini — tidak perlu cari-ganti di semua tempat.
*/
:root {
  --matcha-abyss: #1e2a18;
  --matcha-dark: #33422b;
  --matcha-mid: #7c9473;
  --sage-pale: #e9efe1;
  --cream: #f6f3e7;
  --gold: #c9a66b;
  --ink: #1f2937;
  --content-width: 1080px;
}

/* Reset dasar: hilangkan margin/padding bawaan browser yang beda-beda tiap browser */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box; /* border & padding dihitung masuk ke lebar elemen, bukan nambah lebar */
}

/*
  scroll-behavior: smooth membuat perpindahan ke #id (misalnya klik link
  nav ke "#tentang") meluncur halus, bukan langsung loncat.
  scroll-padding-top mengimbangi tinggi header yang sticky, supaya judul
  section tidak ketutupan header saat baru sampai.
*/
html {
  scroll-behavior: smooth;
  scroll-padding-top: 84px;
}

body {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  color: var(--ink);
  background-color: var(--cream);
  line-height: 1.6;
}

h1, h2, h3 {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  font-weight: 800;
}

a {
  color: inherit;
}

/* ================= HEADER ================= */
/*
  position: sticky membuat header ini nempel di atas begitu halaman
  discroll sampai posisinya, lalu tetap di situ (beda dengan "fixed"
  yang nempel dari awal halaman dibuka).
*/
header {
  position: sticky;
  top: 0;
  z-index: 10;
  background-color: var(--matcha-abyss);
  color: white;
  transition: transform 0.3s ease;
}

/* Ditambahkan lewat JS saat pengguna scroll ke bawah — header digeser ke atas sampai hilang */
header.sembunyi {
  transform: translateY(-100%);
}

/*
  Grid 3 kolom "1fr auto 1fr": kolom kiri (wordmark) dan kolom kanan
  (spacer kosong) selalu diberi lebar yang SAMA karena sama-sama 1fr,
  apa pun isinya. Efeknya kolom tengah (nav) selalu benar-benar di
  tengah header — beda dengan flexbox space-between yang mendorong nav
  ke ujung kanan mengikuti lebar wordmark.
*/
.header-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 20px 24px;
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: center;
  gap: 12px;
}

.wordmark {
  font-family: "Plus Jakarta Sans", sans-serif;
  font-weight: 800;
  font-size: 1.2rem;
  letter-spacing: -0.01em;
}

header nav {
  display: flex;
  gap: 24px;
}

header nav a {
  color: var(--sage-pale);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  padding-bottom: 2px;
  border-bottom: 2px solid transparent;
  transition: border-color 0.2s, color 0.2s;
}

header nav a:hover,
header nav a:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= HERO ================= */
/*
  position: relative di sini jadi acuan buat 3 lapisan .hero-bg dan
  .hero-overlay yang semuanya position: absolute — pola yang sama
  seperti badge kategori (relative parent + absolute child), cuma
  dipakai buat menumpuk latar belakang, bukan menumpuk elemen kecil.
*/
.hero {
  position: relative;
  overflow: hidden;
  color: white;
  text-align: center;
  padding: 120px 24px;
}

/*
  Tiga foto ditumpuk persis di posisi yang sama (inset: 0 memenuhi
  seluruh .hero), lalu masing-masing diberi animation-delay berbeda
  supaya bergantian terlihat. Ini murni CSS — tidak ada JavaScript
  yang mengganti gambar.
*/
.hero-bg {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  opacity: 0;
  animation: heroBgCycle 18s infinite;
}

.hero-bg-2 {
  animation-delay: 6s;
}

.hero-bg-3 {
  animation-delay: 12s;
}

/*
  18 detik dibagi 3 foto = 6 detik jatah tiap foto. Tiap foto: tersembunyi
  (0%) → memudar masuk (5%) → tampil penuh (28%) → memudar keluar (33%) →
  tersembunyi lagi sampai putaran berikutnya. animation-delay di atas
  menggeser kapan tiap foto memulai siklus ini, jadi hasilnya bergantian.
*/
@keyframes heroBgCycle {
  0%, 100% { opacity: 0; }
  5% { opacity: 1; }
  28% { opacity: 1; }
  33% { opacity: 0; }
}

/* Lapisan gelap transparan di atas foto, supaya teks putih tetap terbaca di foto apa pun */
.hero-overlay {
  position: absolute;
  inset: 0;
  background-color: rgba(20, 28, 16, 0.68);
}

.hero-inner {
  position: relative; /* supaya tampil di atas .hero-bg dan .hero-overlay */
  max-width: 640px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/*
  clamp(min, ideal, max) bikin ukuran font otomatis menyesuaikan lebar
  layar di antara batas minimum dan maksimum — tanpa perlu media query
  terpisah cuma buat ukuran teks.
*/
.hero-inner h1 {
  font-size: clamp(2.2rem, 5vw, 3.3rem);
  line-height: 1.05;
  letter-spacing: -0.02em;
  margin-bottom: 20px;
  opacity: 0;
  animation: heroRise 0.6s ease forwards;
}

.hero-inner p {
  max-width: 46ch;
  color: var(--sage-pale);
  font-size: 1.05rem;
  margin-bottom: 28px;
  opacity: 0;
  animation: heroRise 0.6s ease 0.15s forwards;
}

.hero-cta {
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
  justify-content: center;
  opacity: 0;
  animation: heroRise 0.6s ease 0.3s forwards;
}

/*
  Ini satu-satunya urutan animasi "otomatis saat halaman dibuka" di
  seluruh halaman (judul, lalu paragraf, lalu tombol —
  perhatikan animation-delay yang berbeda tiap elemen). Sengaja cuma
  di hero, supaya animasi tidak berserakan di semua bagian.
*/
@keyframes heroRise {
  from { opacity: 0; transform: translateY(16px); }
  to { opacity: 1; transform: translateY(0); }
}

.btn-primary, .btn-ghost {
  display: inline-block;
  padding: 12px 24px;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.95rem;
  text-decoration: none;
  transition: transform 0.15s, background-color 0.2s, color 0.2s;
}

.btn-primary {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

.btn-primary:hover, .btn-primary:focus-visible {
  transform: translateY(-2px);
}

.btn-ghost {
  border: 1px solid var(--matcha-mid);
  color: var(--sage-pale);
}

.btn-ghost:hover, .btn-ghost:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= Direktori ================= */
.direktori {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
}

.direktori h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 20px;
}

/*
  Toolbar pencarian + filter — TAMPILAN SAJA. Input dan select ini belum
  disambungkan ke logika apa pun (belum ada JavaScript), jadi mengetik
  atau ganti dropdown-nya belum benar-benar menyaring kartu di bawah.
*/
.direktori-toolbar {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
  margin-bottom: 28px;
}

.direktori-cari {
  flex: 1;
  min-width: 200px;
  padding: 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
}

/*
  appearance: none menghilangkan panah bawaan browser (posisinya gak bisa
  diatur pakai padding). Panah custom dipasang lewat SVG di background,
  posisinya diatur manual pakai background-position — jadi bisa "dimasukin"
  sesuai jarak yang kita mau, ngikutin padding kanan.
*/
.direktori-kategori {
  padding: 11px 36px 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
  color: var(--ink);
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6' viewBox='0 0 10 6' fill='none'%3E%3Cpath d='M1 1l4 4 4-4' stroke='%2333422b' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 16px center;
}

.direktori-cari:focus,
.direktori-kategori:focus {
  outline: none;
  border-color: var(--gold);
}

/* Grid kartu: auto-fit + minmax bikin jumlah kolom menyesuaikan sendiri lebar layar, tanpa media query manual */
.grid-umkm {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.kartu-umkm {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  overflow: hidden;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.kartu-umkm:hover,
.kartu-umkm:focus-within {
  transform: translateY(-4px);
  box-shadow: 0 14px 28px rgba(51, 66, 43, 0.14);
}

/* position: relative di sini jadi acuan buat .badge yang absolute di dalamnya */
.kartu-foto {
  position: relative;
  aspect-ratio: 4 / 3;
}

.kartu-foto img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.kartu-isi {
  padding: 16px 18px 20px;
}

.kartu-isi h3 {
  font-size: 1.1rem;
  color: var(--matcha-dark);
  margin-bottom: 4px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis; /* nama kepanjangan dipotong jadi "...", bukan bikin tinggi kartu beda-beda */
}

.kartu-isi .alamat {
  color: #6b6b5f;
  font-size: 0.88rem;
  display: flex;
  align-items: center;
  gap: 6px;
}

/*
  Alamat yang kepanjangan dipotong jadi satu baris + "..." di ujungnya
  (text-overflow: ellipsis), bukan bikin kartu jadi tinggi sebelah.
  min-width: 0 wajib di sini supaya flex item ini mau menyusut duluan
  sebelum ikon di sebelahnya ikut menyusut.
*/
.kartu-isi .alamat span {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  min-width: 0;
}

.kartu-isi .alamat i,
.kartu-isi .jam i {
  color: var(--matcha-mid);
  flex-shrink: 0;
}

.kartu-isi .jam {
  color: var(--matcha-mid);
  font-size: 0.8rem;
  margin-top: 2px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa {
  color: var(--matcha-dark);
  font-size: 0.85rem;
  font-weight: 600;
  margin-top: 8px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa i {
  color: var(--matcha-mid);
}

/*
  Badge kategori: position: absolute melepas elemen ini dari alur normal
  dan menempelkannya presisi ke pojok kanan-atas .kartu-foto (parent
  terdekat yang sudah diberi position: relative di atas).
*/
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

/*
  Paginasi — TAMPILAN SAJA juga. Angka "1" ditandai .aktif lewat HTML
  langsung (bukan JavaScript), sekadar contoh bagaimana halaman aktif
  biasanya dibedakan secara visual.
*/
.pagination {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-top: 36px;
}

.pagination a {
  width: 38px;
  height: 38px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid #ddd6c4;
  border-radius: 8px;
  color: var(--matcha-dark);
  text-decoration: none;
  font-size: 0.9rem;
  transition: border-color 0.2s, background-color 0.2s, color 0.2s;
}

.pagination a:hover,
.pagination a:focus-visible {
  border-color: var(--gold);
}

.pagination a.aktif {
  background-color: var(--matcha-dark);
  border-color: var(--matcha-dark);
  color: white;
}

/* ================= Tentang ================= */
/* CSS Grid 2 kolom asimetris: kolom teks lebih lebar (7 bagian) dari kolom gambar (5 bagian) */
.tentang {
  display: grid;
  grid-template-columns: 7fr 5fr;
  max-width: var(--content-width);
  margin: 56px auto;
  border-radius: 16px;
  overflow: hidden; /* biar sudut foto & panel ikut membulat mengikuti .tentang, bukan cuma sudut luarnya */
}

.tentang-teks {
  background-color: var(--sage-pale);
  padding: 48px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.tentang-teks h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 8px;
}

.tentang-teks > p {
  color: #444;
}

.tentang-gambar {
  overflow: hidden; /* biar foto yang dibesarkan lewat object-fit tidak keluar dari kotaknya */
}

.tentang-gambar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

/* ================= Testimoni ================= */
.testimoni {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
}

.testimoni h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 24px;
}

.testimoni-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.testimoni-kartu {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  padding: 22px;
  display: flex;
  flex-direction: column;
  gap: 18px;
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.testimoni-teks {
  color: #444;
  font-size: 0.95rem;
  line-height: 1.6;
}

.testimoni-orang {
  display: flex;
  align-items: center;
  gap: 12px;
}

/* Avatar cuma inisial di lingkaran warna gold — bukan foto orang beneran */
.testimoni-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: var(--sage-pale);
  color: var(--matcha-dark);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  flex-shrink: 0;
}

.testimoni-nama {
  color: var(--matcha-dark);
  font-weight: 600;
  font-size: 0.9rem;
}

.testimoni-lokasi {
  color: var(--matcha-mid);
  font-size: 0.8rem;
}

/* ================= Video ================= */
.video-section {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
  display: grid;
  grid-template-columns: 1fr 1.4fr;
  gap: 40px;
  align-items: center;
}

.sub-label {
  color: var(--matcha-mid);
  font-weight: 600;
  font-size: 0.85rem;
  margin-bottom: 8px;
}

.video-copy h2 {
  color: var(--matcha-dark);
  font-size: 1.5rem;
  margin-bottom: 12px;
}

.video-copy p {
  color: #555;
  max-width: 42ch;
}

/*
  aspect-ratio: 16/9 mengunci rasio lebar:tinggi kotak ini apa pun lebar
  layarnya, jadi video tidak pernah gepeng atau terlalu tinggi. Ini
  menggantikan trik lama "padding-bottom: 56.25%" yang lebih ribet.
*/
.video-frame {
  position: relative;
  width: 100%;
  aspect-ratio: 16 / 9;
  border-radius: 12px;
  overflow: hidden;
  background-color: var(--matcha-abyss);
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.video-frame iframe {
  position: absolute;
  inset: 0; /* setara top:0; right:0; bottom:0; left:0; */
  width: 100%;
  height: 100%;
  border: 0;
}

/* ================= Lokasi ================= */
.lokasi {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
  display: grid;
  grid-template-columns: 1.3fr 1fr;
  gap: 40px;
  align-items: start;
}

/* Peta juga pakai aspect-ratio, sama seperti video di atas */
.lokasi-peta {
  aspect-ratio: 16 / 9;
  border-radius: 12px;
  overflow: hidden;
  border: 1px solid #ddd6c4;
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.lokasi-peta iframe {
  width: 100%;
  height: 100%;
  border: 0;
}

.lokasi-daftar h2 {
  color: var(--matcha-dark);
  font-size: 1.5rem;
  margin-bottom: 16px;
}

.lokasi-daftar ul {
  list-style: none;
}

/* WhatsApp & Instagram jadi tombol bulat yang bisa diklik, bukan cuma teks */
.lokasi-sosial {
  display: flex;
  gap: 12px;
  margin-top: 28px;
}

.lokasi-sosial a {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background-color: var(--sage-pale);
  color: var(--matcha-dark);
  font-size: 1.05rem;
  text-decoration: none;
  transition: background-color 0.2s, color 0.2s;
}

.lokasi-sosial a:hover,
.lokasi-sosial a:focus-visible {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

.lokasi-daftar li {
  padding: 6px 0;
  font-size: 0.92rem;
  color: #555;
}

.lokasi-daftar li i {
  color: var(--matcha-mid);
  width: 16px;
  margin-right: 8px;
  text-align: center;
}

/* ================= Kontak ================= */
.kontak {
  background-color: var(--matcha-abyss);
  color: white;
  padding: 64px 24px;
}

.kontak-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  display: grid;
  grid-template-columns: 1fr 1.2fr;
  gap: 48px;
}

.kontak-copy h2 {
  font-size: 1.8rem;
  margin-bottom: 12px;
}

.kontak-copy p {
  color: var(--sage-pale);
  max-width: 36ch;
}

form {
  display: flex;
  flex-direction: column;
  gap: 22px;
}

form label {
  font-weight: 600;
  font-size: 0.85rem;
  color: var(--sage-pale);
  text-transform: uppercase;
  letter-spacing: 0.04em;
}

/* Form bergaris bawah, bukan kotak — lebih ringan di atas panel gelap */
form input,
form textarea {
  background: transparent;
  border: none;
  border-bottom: 1px solid var(--matcha-mid);
  color: white;
  padding: 8px 2px;
  font-family: inherit;
  font-size: 1rem;
  transition: border-color 0.2s;
}

form input::placeholder,
form textarea::placeholder {
  color: #8ba088;
}

form input:focus,
form textarea:focus {
  outline: none;
  border-color: var(--gold);
}

form textarea {
  resize: vertical;
  min-height: 70px;
}

button {
  align-self: flex-start;
  background-color: var(--gold);
  color: var(--matcha-abyss);
  border: none;
  padding: 12px 24px;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.95rem;
  cursor: pointer;
  transition: transform 0.15s;
}

button:hover,
button:focus-visible {
  transform: translateY(-2px);
}

/* Garis fokus jelas untuk pengguna keyboard, di semua elemen interaktif */
a:focus-visible,
button:focus-visible,
input:focus-visible,
textarea:focus-visible {
  outline: 2px solid var(--gold);
  outline-offset: 2px;
}
```

Reload: panel Kontak jadi hijau gelap dengan form bergaris bawah dan tombol gold pill. Coba tekan Tab berkali-kali dari address bar — perhatikan tiap elemen yang kena fokus dapat outline gold jelas.

## Langkah 21 — HTML: Footer dan tombol kembali ke atas

Terakhir untuk HTML: footer (copyright + ikon medsos + pemutar audio kecil "iseng") dan tombol bulat "kembali ke atas" dengan ikon panah SVG. **Tombol ini belum berfungsi** — dia baru benar-benar hidup setelah kita tambahkan JavaScript-nya di Langkah 23.

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Katalog UMKM Karawang</title>

    <!-- Google Fonts: Plus Jakarta Sans, satu family buat judul (weight tebal) dan teks biasa (weight normal) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <!-- Font Awesome lewat CDN, dipakai buat ikon medsos di footer dan ikon telepon di kartu UMKM -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <!--
      HEADER
      "sticky" di style.css bikin header ini tetap kelihatan walau halaman
      discroll ke bawah. Ini salah satu contoh nyata `position: sticky`
      yang disebutkan sekilas di materi Position.
    -->
    <header>
      <!--
        header-inner pakai 3 kolom grid (kiri-tengah-kanan) supaya nav
        benar-benar di tengah header, bukan ikut menempel ke kanan
        seperti pola flexbox space-between biasa.
      -->
      <div class="header-inner">
        <span class="wordmark">UMKM Karawang</span>
        <nav>
          <a href="#daftar-umkm">UMKM</a>
          <a href="#tentang">Tentang</a>
          <a href="#kontak">Daftar</a>
        </nav>
        <span aria-hidden="true"></span>
      </div>
    </header>

    <main>
      <!--
        HERO
        Tiga foto ditumpuk sebagai latar (.hero-bg), masing-masing diberi
        animation-delay berbeda supaya bergantian muncul terus-menerus —
        murni CSS @keyframes, tidak ada JavaScript sama sekali. Di atasnya
        ada lapisan gelap transparan (.hero-overlay) supaya teks putih
        tetap kebaca di foto apa pun yang lagi tampil.
      -->
      <section class="hero">
        <div
          class="hero-bg"
          style="background-image: url('https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-2"
          style="background-image: url('https://images.unsplash.com/photo-1533900298318-6b8da08a523e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-3"
          style="background-image: url('https://images.unsplash.com/photo-1519996529931-28324d5a630e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div class="hero-overlay" aria-hidden="true"></div>

        <div class="hero-inner">
          <h1>Usaha warga yang layak kamu temukan.</h1>
          <p>
            Direktori usaha kecil di Karawang — warung, kerajinan, dan
            busana yang dijalankan tetangga sendiri, bukan waralaba.
          </p>
          <div class="hero-cta">
            <a href="#daftar-umkm" class="btn-primary">Lihat direktori</a>
            <a href="#kontak" class="btn-ghost">Daftarkan usahamu</a>
          </div>
        </div>
      </section>

      <!--
        DIREKTORI
        Tiap UMKM ditulis sebagai <article> (bukan <div>) karena isinya
        memang "satu unit konten yang berdiri sendiri" — cocok dengan
        makna semantik <article>. class="reveal" dipakai script di bawah
        untuk animasi muncul saat discroll.

        Kotak pencarian, dropdown kategori, dan paginasi di bawah ini
        BARU TAMPILANNYA SAJA — belum benar-benar menyaring apa pun,
        karena logikanya (JavaScript) sengaja belum dibahas. Anggap ini
        "maket" tampilan dulu, fungsinya menyusul di materi selanjutnya.
      -->
      <section id="daftar-umkm" class="direktori reveal">
        <h2>Direktori</h2>

        <div class="direktori-toolbar">
          <input
            type="search"
            class="direktori-cari"
            placeholder="Cari nama UMKM..."
            aria-label="Cari UMKM"
          />
          <select class="direktori-kategori" aria-label="Filter kategori">
            <option>Semua kategori</option>
            <option>Kuliner</option>
            <option>Fashion</option>
            <option>Kerajinan</option>
          </select>
        </div>

        <div class="grid-umkm">
          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&q=60&auto=format&fit=crop"
                alt="Meja warung dengan aneka lauk siap saji"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Warung Bu Sari</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Merdeka No. 10, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 07.00 – 21.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0812-3456-7810</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1761515315375-1315503bb3ce?w=400&q=60&auto=format&fit=crop"
                alt="Kain batik bermotif tradisional"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Batik Karawang Asli</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Kertabumi No. 5, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 09.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0813-2345-6705</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1696574727184-a8cdb758d3bf?w=400&q=60&auto=format&fit=crop"
                alt="Keranjang anyaman bambu"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Anyaman Bambu Pak Jaya</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Tuparev No. 22, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0857-1234-9902</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&q=60&auto=format&fit=crop"
                alt="Secangkir kopi hitam di atas meja kayu"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Kopi Rawa Gede</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ahmad Yani No. 3, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 10.00 – 23.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0821-9988-2214</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1445205170230-053b83016050?w=400&q=60&auto=format&fit=crop"
                alt="Mesin jahit dan gulungan kain"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Konveksi Sinar Tani</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Pangkal Perjuangan No. 18, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0838-4567-3321</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=400&q=60&auto=format&fit=crop"
                alt="Kumpulan gerabah tanah liat"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Gerabah Cikampek</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ir. H. Juanda No. 45, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0896-7712-0043</p>
            </div>
          </article>
        </div>

        <!-- Paginasi: tampilan saja, angka "aktif" ditandai lewat class, belum benar-benar berpindah halaman -->
        <nav class="pagination" aria-label="Navigasi halaman direktori">
          <a href="#daftar-umkm" aria-label="Halaman sebelumnya">‹</a>
          <a href="#daftar-umkm" class="aktif" aria-current="page">1</a>
          <a href="#daftar-umkm">2</a>
          <a href="#daftar-umkm">3</a>
          <a href="#daftar-umkm" aria-label="Halaman berikutnya">›</a>
        </nav>
      </section>

      <!-- TENTANG: disederhanakan, cuma judul + satu paragraf singkat + foto -->
      <section id="tentang" class="tentang reveal">
        <div class="tentang-teks">
          <h2>Tentang katalog ini</h2>
          <p>
            Dibuat supaya warga lebih mudah menemukan UMKM di sekitar
            Karawang — dan supaya pemilik usaha kecil punya satu tempat untuk
            dicari, tanpa harus bayar iklan. Pilih kategori di direktori,
            lalu hubungi langsung lewat WA atau form Kontak di bawah.
          </p>
        </div>
        <div class="tentang-gambar">
          <img
            src="https://images.unsplash.com/photo-1642473194881-c7425b3789f1?fm=jpg&amp;q=60&amp;w=800&amp;auto=format&amp;fit=crop"
            alt="Suasana pasar UMKM Karawang"
            loading="lazy"
          />
        </div>
      </section>

      <!--
        TESTIMONI
        Avatar cuma lingkaran berisi inisial nama (bukan foto orang
        sungguhan) — supaya tidak terkesan memakai identitas/wajah orang
        asli untuk testimoni yang sebetulnya contoh/dummy.
      -->
      <section class="testimoni reveal">
        <h2>Kata Warga</h2>
        <div class="testimoni-grid">
          <article class="testimoni-kartu">
            <p class="testimoni-teks">Pesan lewat WA gampang, makanannya masih anget pas sampai. Sejak tahu Warung Bu Sari dari sini, jadi langganan.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">R</span>
              <div>
                <p class="testimoni-nama">Rina</p>
                <p class="testimoni-lokasi">Warga Karawang Barat</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">Batiknya asli buatan tangan, bukan cetak. Harganya juga jujur dibanding beli di pasar yang suka dikira turis.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">D</span>
              <div>
                <p class="testimoni-nama">Dedi</p>
                <p class="testimoni-lokasi">Pelanggan Batik Karawang Asli</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">Enak karena tinggal cari kategori Kerajinan, langsung ketemu kontaknya. Gak perlu tanya-tanya ke tetangga dulu.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">S</span>
              <div>
                <p class="testimoni-nama">Sri</p>
                <p class="testimoni-lokasi">Warga Karawang Timur</p>
              </div>
            </div>
          </article>
        </div>
      </section>

      <!-- VIDEO: contoh tag <iframe> buat nanam video YouTube -->
      <section class="video-section reveal">
        <div class="video-copy">
          <div class="sub-label">Profil singkat</div>
          <h2>Lihat langsung kesehariannya</h2>
          <p>
            Video pendek ini merekam bagaimana salah satu UMKM di katalog ini
            beroperasi tiap hari — dari buka lapak sampai melayani pembeli
            pertama.
          </p>
        </div>
        <!--
          .video-frame di style.css pakai aspect-ratio: 16/9 supaya video
          selalu proporsional di layar berapa pun lebarnya, tanpa perlu
          angka width/height tetap seperti iframe biasa.
        -->
        <div class="video-frame">
          <iframe
            src="https://www.youtube.com/embed/IxX_QHay02M"
            title="Video profil UMKM"
            loading="lazy"
            allowfullscreen
          ></iframe>
        </div>
      </section>

      <!--
        LOKASI
        Peta Google Maps di sini pakai URL embed publik (bukan Maps
        JavaScript API), jadi tidak butuh API key sama sekali — cocok
        buat latihan karena bisa langsung ditiru tanpa daftar akun.
      -->
      <section id="lokasi" class="lokasi reveal">
        <div class="lokasi-peta">
          <iframe
            src="https://maps.google.com/maps?q=Karawang&t=&z=13&ie=UTF8&iwloc=&output=embed"
            title="Peta area Karawang"
            loading="lazy"
          ></iframe>
        </div>
        <div class="lokasi-daftar">
          <h2>Mau kerja sama atau daftarin UMKM-mu?</h2>
          <ul>
            <li><i class="fa-solid fa-envelope" aria-hidden="true"></i> halo@umkmkarawang.id</li>
            <li><i class="fa-regular fa-clock" aria-hidden="true"></i> Senin–Sabtu, jam 09.00–17.00</li>
          </ul>
          <div class="lokasi-sosial">
            <a href="https://wa.me/6281200001234" target="_blank" rel="noopener" aria-label="Chat WhatsApp UMKM Karawang"><i class="fa-brands fa-whatsapp" aria-hidden="true"></i></a>
            <a href="https://instagram.com/umkmkarawang" target="_blank" rel="noopener" aria-label="Instagram UMKM Karawang"><i class="fa-brands fa-instagram" aria-hidden="true"></i></a>
          </div>
        </div>
      </section>

      <!-- KONTAK: form pendaftaran UMKM baru -->
      <section id="kontak" class="kontak reveal">
        <div class="kontak-inner">
          <div class="kontak-copy">
            <h2>Punya usaha yang belum terdaftar?</h2>
            <p>
              Kirim nama dan pesan singkat, kami hubungi balik untuk proses
              pendaftarannya.
            </p>
          </div>
          <form>
            <label for="nama">Nama</label>
            <input type="text" id="nama" name="nama" placeholder="Nama kamu" />

            <label for="pesan">Pesan</label>
            <textarea
              id="pesan"
              name="pesan"
              placeholder="Ceritakan usahamu secara singkat..."
            ></textarea>

            <button type="submit">Kirim pesan</button>
          </form>
        </div>
      </section>
    </main>

    <footer>
      <div class="footer-inner">
        <p>&copy; 2026 Katalog UMKM Karawang</p>
        <div class="footer-sosial">
          <a href="#" aria-label="Instagram Katalog UMKM Karawang"><i class="fa-brands fa-instagram" aria-hidden="true"></i></a>
          <a href="#" aria-label="Facebook Katalog UMKM Karawang"><i class="fa-brands fa-facebook" aria-hidden="true"></i></a>
          <a href="#" aria-label="WhatsApp Katalog UMKM Karawang"><i class="fa-brands fa-whatsapp" aria-hidden="true"></i></a>
          <!-- Contoh tag <audio> — sengaja ditaruh kecil dan santai di sini, bukan di tengah konten -->
          <audio class="footer-audio" src="getout.mp3" controls></audio>
        </div>
      </div>
    </footer>

    <!-- Tombol "kembali ke atas": disembunyikan lewat CSS, dimunculkan lewat JS saat halaman sudah discroll cukup jauh -->
    <button id="ke-atas" class="ke-atas" aria-label="Kembali ke atas">
      <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
        <path d="M12 19V5"></path>
        <path d="M6 11l6-6 6 6"></path>
      </svg>
    </button>
  </body>
</html>
```

File `getout.mp3` harus ada satu folder dengan `index.html` — kalau kamu belum punya, pakai file mp3 apa saja dulu buat coba.

## Langkah 22 — CSS: Styling Footer dan tombol kembali ke atas

Satu hal krusial di sini: **ikon SVG panah di tombol dikasih `width`/`height` eksplisit dan `flex-shrink: 0`**. Tanpa itu, ada bug klasik di Chromium: SVG di dalam container `display: flex` bersama reset `box-sizing: border-box` global bisa **terhitung lebar 0** dan jadi tidak kelihatan sama sekali, padahal HTML-nya benar. Kalau nanti ikon SVG kamu di proyek lain "hilang" padahal sudah ditulis, ingat trik ini.

```css
/*
  CSS variable (custom property). Ditulis sekali di :root, dipakai
  berkali-kali lewat var(--nama). Kalau mau ganti warna tema, cukup
  ubah di sini — tidak perlu cari-ganti di semua tempat.
*/
:root {
  --matcha-abyss: #1e2a18;
  --matcha-dark: #33422b;
  --matcha-mid: #7c9473;
  --sage-pale: #e9efe1;
  --cream: #f6f3e7;
  --gold: #c9a66b;
  --ink: #1f2937;
  --content-width: 1080px;
}

/* Reset dasar: hilangkan margin/padding bawaan browser yang beda-beda tiap browser */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box; /* border & padding dihitung masuk ke lebar elemen, bukan nambah lebar */
}

/*
  scroll-behavior: smooth membuat perpindahan ke #id (misalnya klik link
  nav ke "#tentang") meluncur halus, bukan langsung loncat.
  scroll-padding-top mengimbangi tinggi header yang sticky, supaya judul
  section tidak ketutupan header saat baru sampai.
*/
html {
  scroll-behavior: smooth;
  scroll-padding-top: 84px;
}

body {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  color: var(--ink);
  background-color: var(--cream);
  line-height: 1.6;
}

h1, h2, h3 {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  font-weight: 800;
}

a {
  color: inherit;
}

/* ================= HEADER ================= */
/*
  position: sticky membuat header ini nempel di atas begitu halaman
  discroll sampai posisinya, lalu tetap di situ (beda dengan "fixed"
  yang nempel dari awal halaman dibuka).
*/
header {
  position: sticky;
  top: 0;
  z-index: 10;
  background-color: var(--matcha-abyss);
  color: white;
  transition: transform 0.3s ease;
}

/* Ditambahkan lewat JS saat pengguna scroll ke bawah — header digeser ke atas sampai hilang */
header.sembunyi {
  transform: translateY(-100%);
}

/*
  Grid 3 kolom "1fr auto 1fr": kolom kiri (wordmark) dan kolom kanan
  (spacer kosong) selalu diberi lebar yang SAMA karena sama-sama 1fr,
  apa pun isinya. Efeknya kolom tengah (nav) selalu benar-benar di
  tengah header — beda dengan flexbox space-between yang mendorong nav
  ke ujung kanan mengikuti lebar wordmark.
*/
.header-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 20px 24px;
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: center;
  gap: 12px;
}

.wordmark {
  font-family: "Plus Jakarta Sans", sans-serif;
  font-weight: 800;
  font-size: 1.2rem;
  letter-spacing: -0.01em;
}

header nav {
  display: flex;
  gap: 24px;
}

header nav a {
  color: var(--sage-pale);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  padding-bottom: 2px;
  border-bottom: 2px solid transparent;
  transition: border-color 0.2s, color 0.2s;
}

header nav a:hover,
header nav a:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= HERO ================= */
/*
  position: relative di sini jadi acuan buat 3 lapisan .hero-bg dan
  .hero-overlay yang semuanya position: absolute — pola yang sama
  seperti badge kategori (relative parent + absolute child), cuma
  dipakai buat menumpuk latar belakang, bukan menumpuk elemen kecil.
*/
.hero {
  position: relative;
  overflow: hidden;
  color: white;
  text-align: center;
  padding: 120px 24px;
}

/*
  Tiga foto ditumpuk persis di posisi yang sama (inset: 0 memenuhi
  seluruh .hero), lalu masing-masing diberi animation-delay berbeda
  supaya bergantian terlihat. Ini murni CSS — tidak ada JavaScript
  yang mengganti gambar.
*/
.hero-bg {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  opacity: 0;
  animation: heroBgCycle 18s infinite;
}

.hero-bg-2 {
  animation-delay: 6s;
}

.hero-bg-3 {
  animation-delay: 12s;
}

/*
  18 detik dibagi 3 foto = 6 detik jatah tiap foto. Tiap foto: tersembunyi
  (0%) → memudar masuk (5%) → tampil penuh (28%) → memudar keluar (33%) →
  tersembunyi lagi sampai putaran berikutnya. animation-delay di atas
  menggeser kapan tiap foto memulai siklus ini, jadi hasilnya bergantian.
*/
@keyframes heroBgCycle {
  0%, 100% { opacity: 0; }
  5% { opacity: 1; }
  28% { opacity: 1; }
  33% { opacity: 0; }
}

/* Lapisan gelap transparan di atas foto, supaya teks putih tetap terbaca di foto apa pun */
.hero-overlay {
  position: absolute;
  inset: 0;
  background-color: rgba(20, 28, 16, 0.68);
}

.hero-inner {
  position: relative; /* supaya tampil di atas .hero-bg dan .hero-overlay */
  max-width: 640px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/*
  clamp(min, ideal, max) bikin ukuran font otomatis menyesuaikan lebar
  layar di antara batas minimum dan maksimum — tanpa perlu media query
  terpisah cuma buat ukuran teks.
*/
.hero-inner h1 {
  font-size: clamp(2.2rem, 5vw, 3.3rem);
  line-height: 1.05;
  letter-spacing: -0.02em;
  margin-bottom: 20px;
  opacity: 0;
  animation: heroRise 0.6s ease forwards;
}

.hero-inner p {
  max-width: 46ch;
  color: var(--sage-pale);
  font-size: 1.05rem;
  margin-bottom: 28px;
  opacity: 0;
  animation: heroRise 0.6s ease 0.15s forwards;
}

.hero-cta {
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
  justify-content: center;
  opacity: 0;
  animation: heroRise 0.6s ease 0.3s forwards;
}

/*
  Ini satu-satunya urutan animasi "otomatis saat halaman dibuka" di
  seluruh halaman (judul, lalu paragraf, lalu tombol —
  perhatikan animation-delay yang berbeda tiap elemen). Sengaja cuma
  di hero, supaya animasi tidak berserakan di semua bagian.
*/
@keyframes heroRise {
  from { opacity: 0; transform: translateY(16px); }
  to { opacity: 1; transform: translateY(0); }
}

.btn-primary, .btn-ghost {
  display: inline-block;
  padding: 12px 24px;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.95rem;
  text-decoration: none;
  transition: transform 0.15s, background-color 0.2s, color 0.2s;
}

.btn-primary {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

.btn-primary:hover, .btn-primary:focus-visible {
  transform: translateY(-2px);
}

.btn-ghost {
  border: 1px solid var(--matcha-mid);
  color: var(--sage-pale);
}

.btn-ghost:hover, .btn-ghost:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= Direktori ================= */
.direktori {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
}

.direktori h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 20px;
}

/*
  Toolbar pencarian + filter — TAMPILAN SAJA. Input dan select ini belum
  disambungkan ke logika apa pun (belum ada JavaScript), jadi mengetik
  atau ganti dropdown-nya belum benar-benar menyaring kartu di bawah.
*/
.direktori-toolbar {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
  margin-bottom: 28px;
}

.direktori-cari {
  flex: 1;
  min-width: 200px;
  padding: 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
}

/*
  appearance: none menghilangkan panah bawaan browser (posisinya gak bisa
  diatur pakai padding). Panah custom dipasang lewat SVG di background,
  posisinya diatur manual pakai background-position — jadi bisa "dimasukin"
  sesuai jarak yang kita mau, ngikutin padding kanan.
*/
.direktori-kategori {
  padding: 11px 36px 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
  color: var(--ink);
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6' viewBox='0 0 10 6' fill='none'%3E%3Cpath d='M1 1l4 4 4-4' stroke='%2333422b' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 16px center;
}

.direktori-cari:focus,
.direktori-kategori:focus {
  outline: none;
  border-color: var(--gold);
}

/* Grid kartu: auto-fit + minmax bikin jumlah kolom menyesuaikan sendiri lebar layar, tanpa media query manual */
.grid-umkm {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.kartu-umkm {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  overflow: hidden;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.kartu-umkm:hover,
.kartu-umkm:focus-within {
  transform: translateY(-4px);
  box-shadow: 0 14px 28px rgba(51, 66, 43, 0.14);
}

/* position: relative di sini jadi acuan buat .badge yang absolute di dalamnya */
.kartu-foto {
  position: relative;
  aspect-ratio: 4 / 3;
}

.kartu-foto img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.kartu-isi {
  padding: 16px 18px 20px;
}

.kartu-isi h3 {
  font-size: 1.1rem;
  color: var(--matcha-dark);
  margin-bottom: 4px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis; /* nama kepanjangan dipotong jadi "...", bukan bikin tinggi kartu beda-beda */
}

.kartu-isi .alamat {
  color: #6b6b5f;
  font-size: 0.88rem;
  display: flex;
  align-items: center;
  gap: 6px;
}

/*
  Alamat yang kepanjangan dipotong jadi satu baris + "..." di ujungnya
  (text-overflow: ellipsis), bukan bikin kartu jadi tinggi sebelah.
  min-width: 0 wajib di sini supaya flex item ini mau menyusut duluan
  sebelum ikon di sebelahnya ikut menyusut.
*/
.kartu-isi .alamat span {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  min-width: 0;
}

.kartu-isi .alamat i,
.kartu-isi .jam i {
  color: var(--matcha-mid);
  flex-shrink: 0;
}

.kartu-isi .jam {
  color: var(--matcha-mid);
  font-size: 0.8rem;
  margin-top: 2px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa {
  color: var(--matcha-dark);
  font-size: 0.85rem;
  font-weight: 600;
  margin-top: 8px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa i {
  color: var(--matcha-mid);
}

/*
  Badge kategori: position: absolute melepas elemen ini dari alur normal
  dan menempelkannya presisi ke pojok kanan-atas .kartu-foto (parent
  terdekat yang sudah diberi position: relative di atas).
*/
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

/*
  Paginasi — TAMPILAN SAJA juga. Angka "1" ditandai .aktif lewat HTML
  langsung (bukan JavaScript), sekadar contoh bagaimana halaman aktif
  biasanya dibedakan secara visual.
*/
.pagination {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-top: 36px;
}

.pagination a {
  width: 38px;
  height: 38px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid #ddd6c4;
  border-radius: 8px;
  color: var(--matcha-dark);
  text-decoration: none;
  font-size: 0.9rem;
  transition: border-color 0.2s, background-color 0.2s, color 0.2s;
}

.pagination a:hover,
.pagination a:focus-visible {
  border-color: var(--gold);
}

.pagination a.aktif {
  background-color: var(--matcha-dark);
  border-color: var(--matcha-dark);
  color: white;
}

/* ================= Tentang ================= */
/* CSS Grid 2 kolom asimetris: kolom teks lebih lebar (7 bagian) dari kolom gambar (5 bagian) */
.tentang {
  display: grid;
  grid-template-columns: 7fr 5fr;
  max-width: var(--content-width);
  margin: 56px auto;
  border-radius: 16px;
  overflow: hidden; /* biar sudut foto & panel ikut membulat mengikuti .tentang, bukan cuma sudut luarnya */
}

.tentang-teks {
  background-color: var(--sage-pale);
  padding: 48px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.tentang-teks h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 8px;
}

.tentang-teks > p {
  color: #444;
}

.tentang-gambar {
  overflow: hidden; /* biar foto yang dibesarkan lewat object-fit tidak keluar dari kotaknya */
}

.tentang-gambar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

/* ================= Testimoni ================= */
.testimoni {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
}

.testimoni h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 24px;
}

.testimoni-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.testimoni-kartu {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  padding: 22px;
  display: flex;
  flex-direction: column;
  gap: 18px;
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.testimoni-teks {
  color: #444;
  font-size: 0.95rem;
  line-height: 1.6;
}

.testimoni-orang {
  display: flex;
  align-items: center;
  gap: 12px;
}

/* Avatar cuma inisial di lingkaran warna gold — bukan foto orang beneran */
.testimoni-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: var(--sage-pale);
  color: var(--matcha-dark);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  flex-shrink: 0;
}

.testimoni-nama {
  color: var(--matcha-dark);
  font-weight: 600;
  font-size: 0.9rem;
}

.testimoni-lokasi {
  color: var(--matcha-mid);
  font-size: 0.8rem;
}

/* ================= Video ================= */
.video-section {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
  display: grid;
  grid-template-columns: 1fr 1.4fr;
  gap: 40px;
  align-items: center;
}

.sub-label {
  color: var(--matcha-mid);
  font-weight: 600;
  font-size: 0.85rem;
  margin-bottom: 8px;
}

.video-copy h2 {
  color: var(--matcha-dark);
  font-size: 1.5rem;
  margin-bottom: 12px;
}

.video-copy p {
  color: #555;
  max-width: 42ch;
}

/*
  aspect-ratio: 16/9 mengunci rasio lebar:tinggi kotak ini apa pun lebar
  layarnya, jadi video tidak pernah gepeng atau terlalu tinggi. Ini
  menggantikan trik lama "padding-bottom: 56.25%" yang lebih ribet.
*/
.video-frame {
  position: relative;
  width: 100%;
  aspect-ratio: 16 / 9;
  border-radius: 12px;
  overflow: hidden;
  background-color: var(--matcha-abyss);
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.video-frame iframe {
  position: absolute;
  inset: 0; /* setara top:0; right:0; bottom:0; left:0; */
  width: 100%;
  height: 100%;
  border: 0;
}

/* ================= Lokasi ================= */
.lokasi {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
  display: grid;
  grid-template-columns: 1.3fr 1fr;
  gap: 40px;
  align-items: start;
}

/* Peta juga pakai aspect-ratio, sama seperti video di atas */
.lokasi-peta {
  aspect-ratio: 16 / 9;
  border-radius: 12px;
  overflow: hidden;
  border: 1px solid #ddd6c4;
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.lokasi-peta iframe {
  width: 100%;
  height: 100%;
  border: 0;
}

.lokasi-daftar h2 {
  color: var(--matcha-dark);
  font-size: 1.5rem;
  margin-bottom: 16px;
}

.lokasi-daftar ul {
  list-style: none;
}

/* WhatsApp & Instagram jadi tombol bulat yang bisa diklik, bukan cuma teks */
.lokasi-sosial {
  display: flex;
  gap: 12px;
  margin-top: 28px;
}

.lokasi-sosial a {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background-color: var(--sage-pale);
  color: var(--matcha-dark);
  font-size: 1.05rem;
  text-decoration: none;
  transition: background-color 0.2s, color 0.2s;
}

.lokasi-sosial a:hover,
.lokasi-sosial a:focus-visible {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

.lokasi-daftar li {
  padding: 6px 0;
  font-size: 0.92rem;
  color: #555;
}

.lokasi-daftar li i {
  color: var(--matcha-mid);
  width: 16px;
  margin-right: 8px;
  text-align: center;
}

/* ================= Kontak ================= */
.kontak {
  background-color: var(--matcha-abyss);
  color: white;
  padding: 64px 24px;
}

.kontak-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  display: grid;
  grid-template-columns: 1fr 1.2fr;
  gap: 48px;
}

.kontak-copy h2 {
  font-size: 1.8rem;
  margin-bottom: 12px;
}

.kontak-copy p {
  color: var(--sage-pale);
  max-width: 36ch;
}

form {
  display: flex;
  flex-direction: column;
  gap: 22px;
}

form label {
  font-weight: 600;
  font-size: 0.85rem;
  color: var(--sage-pale);
  text-transform: uppercase;
  letter-spacing: 0.04em;
}

/* Form bergaris bawah, bukan kotak — lebih ringan di atas panel gelap */
form input,
form textarea {
  background: transparent;
  border: none;
  border-bottom: 1px solid var(--matcha-mid);
  color: white;
  padding: 8px 2px;
  font-family: inherit;
  font-size: 1rem;
  transition: border-color 0.2s;
}

form input::placeholder,
form textarea::placeholder {
  color: #8ba088;
}

form input:focus,
form textarea:focus {
  outline: none;
  border-color: var(--gold);
}

form textarea {
  resize: vertical;
  min-height: 70px;
}

button {
  align-self: flex-start;
  background-color: var(--gold);
  color: var(--matcha-abyss);
  border: none;
  padding: 12px 24px;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.95rem;
  cursor: pointer;
  transition: transform 0.15s;
}

button:hover,
button:focus-visible {
  transform: translateY(-2px);
}

/* Garis fokus jelas untuk pengguna keyboard, di semua elemen interaktif */
a:focus-visible,
button:focus-visible,
input:focus-visible,
textarea:focus-visible {
  outline: 2px solid var(--gold);
  outline-offset: 2px;
}

/* ================= Footer ================= */
footer {
  background-color: var(--matcha-abyss);
  color: var(--matcha-mid);
  padding: 20px 24px;
  font-size: 0.85rem;
  border-top: 1px solid #34432c;
}

.footer-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 12px;
}

.footer-sosial {
  display: flex;
  align-items: center;
  gap: 14px;
}

.footer-sosial a {
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background-color: rgba(246, 243, 231, 0.08);
  color: var(--sage-pale);
  font-size: 0.95rem;
  text-decoration: none;
  transition: color 0.2s, background-color 0.2s;
}

.footer-sosial a:hover,
.footer-sosial a:focus-visible {
  color: var(--gold);
  background-color: rgba(201, 166, 107, 0.15);
}

/* Player audio dibikin kecil dan rendah — cuma "iseng" nemplok di footer, bukan elemen utama */
.footer-audio {
  height: 28px;
  max-width: 180px;
}

/* ================= Tombol kembali ke atas ================= */
/*
  position: fixed menempel ke jendela browser (bukan ke halaman), jadi
  tombol ini selalu ada di pojok kanan-bawah layar walau halaman
  discroll ke mana pun. Bedanya dengan .badge yang "absolute": absolute
  nempel ke parent, fixed nempel ke jendela.
*/
/*
  Ikon panah di dalam tombol ini di-set width/height eksplisit + flex-shrink:0
  di bawah — tanpa itu, ikon SVG bisa kehitung lebar 0 oleh browser saat
  beradadi dalam container flex bersama reset box-sizing: border-box global.
*/
.ke-atas {
  position: fixed;
  right: 24px;
  bottom: 24px;
  width: 46px;
  height: 46px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: var(--gold);
  color: var(--matcha-abyss);
  border: none;
  box-shadow: 0 6px 16px rgba(30, 42, 24, 0.25);
  cursor: pointer;
  opacity: 0;
  pointer-events: none; /* saat tersembunyi, tombol tidak bisa diklik walau posisinya masih ada */
  transform: translateY(8px) scale(0.9);
  transition: opacity 0.25s, transform 0.2s ease, box-shadow 0.2s ease, background-color 0.2s ease;
}

.ke-atas svg {
  width: 20px;
  height: 20px;
  flex-shrink: 0;
}

.ke-atas.tampil {
  opacity: 1;
  pointer-events: auto;
  transform: translateY(0) scale(1);
}

.ke-atas:hover,
.ke-atas:focus-visible {
  background-color: var(--matcha-dark);
  color: var(--sage-pale);
  box-shadow: 0 10px 22px rgba(30, 42, 24, 0.32);
  transform: translateY(-3px) scale(1);
}
```

Reload dan scroll ke bawah — kamu bakal sadar tombol kembali ke atas **tidak kelihatan**. Itu **disengaja**: `opacity: 0; pointer-events: none;` bikin dia tersembunyi sampai class `.tampil` ditambahkan. Class itu baru muncul lewat JavaScript di langkah berikutnya. Footer-nya sendiri sudah jadi, dengan ikon medsos bulat dan pemutar audio kecil di sebelahnya.

## Langkah 23 — JavaScript: Navbar sembunyi, tombol ke atas, dan efek muncul saat discroll

Sampai sini semua yang kita buat murni HTML+CSS. Sekarang kita intip sedikit **JavaScript** — bahasa yang bikin halaman bisa "bereaksi" terhadap kejadian (di sini: scroll dan klik), bukan cuma tampil statis. Ini baru pengenalan; dibahas tuntas di materi JavaScript.

Ada 3 potongan logika sekaligus:

1. **Navbar sembunyi saat scroll ke bawah** — bandingkan posisi scroll sekarang dengan posisi sebelumnya; kalau turun, tambahkan class `sembunyi` ke `<header>` (CSS-nya sudah kita siapkan dari Langkah 6).
2. **Tombol kembali ke atas** — tambahkan class `tampil` (CSS dari Langkah 22) begitu halaman discroll lebih dari 400px, dan `window.scrollTo({ top: 0, behavior: 'smooth' })` waktu diklik.
3. **Efek muncul saat discroll** — `IntersectionObserver` adalah fitur browser buat mendeteksi kapan sebuah elemen masuk ke area layar, tanpa kita harus menghitung posisi scroll manual. Begitu terdeteksi, class `tampil` ditambahkan.

Sisipkan `<script>` ini tepat sebelum `</body>` (isi FULL `index.html` sampai titik ini):

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Katalog UMKM Karawang</title>

    <!-- Google Fonts: Plus Jakarta Sans, satu family buat judul (weight tebal) dan teks biasa (weight normal) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <!-- Font Awesome lewat CDN, dipakai buat ikon medsos di footer dan ikon telepon di kartu UMKM -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <!--
      HEADER
      "sticky" di style.css bikin header ini tetap kelihatan walau halaman
      discroll ke bawah. Ini salah satu contoh nyata `position: sticky`
      yang disebutkan sekilas di materi Position.
    -->
    <header>
      <!--
        header-inner pakai 3 kolom grid (kiri-tengah-kanan) supaya nav
        benar-benar di tengah header, bukan ikut menempel ke kanan
        seperti pola flexbox space-between biasa.
      -->
      <div class="header-inner">
        <span class="wordmark">UMKM Karawang</span>
        <nav>
          <a href="#daftar-umkm">UMKM</a>
          <a href="#tentang">Tentang</a>
          <a href="#kontak">Daftar</a>
        </nav>
        <span aria-hidden="true"></span>
      </div>
    </header>

    <main>
      <!--
        HERO
        Tiga foto ditumpuk sebagai latar (.hero-bg), masing-masing diberi
        animation-delay berbeda supaya bergantian muncul terus-menerus —
        murni CSS @keyframes, tidak ada JavaScript sama sekali. Di atasnya
        ada lapisan gelap transparan (.hero-overlay) supaya teks putih
        tetap kebaca di foto apa pun yang lagi tampil.
      -->
      <section class="hero">
        <div
          class="hero-bg"
          style="background-image: url('https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-2"
          style="background-image: url('https://images.unsplash.com/photo-1533900298318-6b8da08a523e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div
          class="hero-bg hero-bg-3"
          style="background-image: url('https://images.unsplash.com/photo-1519996529931-28324d5a630e?w=1600&q=65&auto=format&fit=crop');"
        ></div>
        <div class="hero-overlay" aria-hidden="true"></div>

        <div class="hero-inner">
          <h1>Usaha warga yang layak kamu temukan.</h1>
          <p>
            Direktori usaha kecil di Karawang — warung, kerajinan, dan
            busana yang dijalankan tetangga sendiri, bukan waralaba.
          </p>
          <div class="hero-cta">
            <a href="#daftar-umkm" class="btn-primary">Lihat direktori</a>
            <a href="#kontak" class="btn-ghost">Daftarkan usahamu</a>
          </div>
        </div>
      </section>

      <!--
        DIREKTORI
        Tiap UMKM ditulis sebagai <article> (bukan <div>) karena isinya
        memang "satu unit konten yang berdiri sendiri" — cocok dengan
        makna semantik <article>. class="reveal" dipakai script di bawah
        untuk animasi muncul saat discroll.

        Kotak pencarian, dropdown kategori, dan paginasi di bawah ini
        BARU TAMPILANNYA SAJA — belum benar-benar menyaring apa pun,
        karena logikanya (JavaScript) sengaja belum dibahas. Anggap ini
        "maket" tampilan dulu, fungsinya menyusul di materi selanjutnya.
      -->
      <section id="daftar-umkm" class="direktori reveal">
        <h2>Direktori</h2>

        <div class="direktori-toolbar">
          <input
            type="search"
            class="direktori-cari"
            placeholder="Cari nama UMKM..."
            aria-label="Cari UMKM"
          />
          <select class="direktori-kategori" aria-label="Filter kategori">
            <option>Semua kategori</option>
            <option>Kuliner</option>
            <option>Fashion</option>
            <option>Kerajinan</option>
          </select>
        </div>

        <div class="grid-umkm">
          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&q=60&auto=format&fit=crop"
                alt="Meja warung dengan aneka lauk siap saji"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Warung Bu Sari</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Merdeka No. 10, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 07.00 – 21.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0812-3456-7810</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1761515315375-1315503bb3ce?w=400&q=60&auto=format&fit=crop"
                alt="Kain batik bermotif tradisional"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Batik Karawang Asli</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Kertabumi No. 5, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 09.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0813-2345-6705</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1696574727184-a8cdb758d3bf?w=400&q=60&auto=format&fit=crop"
                alt="Keranjang anyaman bambu"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Anyaman Bambu Pak Jaya</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Tuparev No. 22, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0857-1234-9902</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&q=60&auto=format&fit=crop"
                alt="Secangkir kopi hitam di atas meja kayu"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Kopi Rawa Gede</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ahmad Yani No. 3, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 10.00 – 23.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0821-9988-2214</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1445205170230-053b83016050?w=400&q=60&auto=format&fit=crop"
                alt="Mesin jahit dan gulungan kain"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Konveksi Sinar Tani</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Pangkal Perjuangan No. 18, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0838-4567-3321</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=400&q=60&auto=format&fit=crop"
                alt="Kumpulan gerabah tanah liat"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Gerabah Cikampek</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ir. H. Juanda No. 45, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0896-7712-0043</p>
            </div>
          </article>
        </div>

        <!-- Paginasi: tampilan saja, angka "aktif" ditandai lewat class, belum benar-benar berpindah halaman -->
        <nav class="pagination" aria-label="Navigasi halaman direktori">
          <a href="#daftar-umkm" aria-label="Halaman sebelumnya">‹</a>
          <a href="#daftar-umkm" class="aktif" aria-current="page">1</a>
          <a href="#daftar-umkm">2</a>
          <a href="#daftar-umkm">3</a>
          <a href="#daftar-umkm" aria-label="Halaman berikutnya">›</a>
        </nav>
      </section>

      <!-- TENTANG: disederhanakan, cuma judul + satu paragraf singkat + foto -->
      <section id="tentang" class="tentang reveal">
        <div class="tentang-teks">
          <h2>Tentang katalog ini</h2>
          <p>
            Dibuat supaya warga lebih mudah menemukan UMKM di sekitar
            Karawang — dan supaya pemilik usaha kecil punya satu tempat untuk
            dicari, tanpa harus bayar iklan. Pilih kategori di direktori,
            lalu hubungi langsung lewat WA atau form Kontak di bawah.
          </p>
        </div>
        <div class="tentang-gambar">
          <img
            src="https://images.unsplash.com/photo-1642473194881-c7425b3789f1?fm=jpg&amp;q=60&amp;w=800&amp;auto=format&amp;fit=crop"
            alt="Suasana pasar UMKM Karawang"
            loading="lazy"
          />
        </div>
      </section>

      <!--
        TESTIMONI
        Avatar cuma lingkaran berisi inisial nama (bukan foto orang
        sungguhan) — supaya tidak terkesan memakai identitas/wajah orang
        asli untuk testimoni yang sebetulnya contoh/dummy.
      -->
      <section class="testimoni reveal">
        <h2>Kata Warga</h2>
        <div class="testimoni-grid">
          <article class="testimoni-kartu">
            <p class="testimoni-teks">Pesan lewat WA gampang, makanannya masih anget pas sampai. Sejak tahu Warung Bu Sari dari sini, jadi langganan.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">R</span>
              <div>
                <p class="testimoni-nama">Rina</p>
                <p class="testimoni-lokasi">Warga Karawang Barat</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">Batiknya asli buatan tangan, bukan cetak. Harganya juga jujur dibanding beli di pasar yang suka dikira turis.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">D</span>
              <div>
                <p class="testimoni-nama">Dedi</p>
                <p class="testimoni-lokasi">Pelanggan Batik Karawang Asli</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">Enak karena tinggal cari kategori Kerajinan, langsung ketemu kontaknya. Gak perlu tanya-tanya ke tetangga dulu.</p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">S</span>
              <div>
                <p class="testimoni-nama">Sri</p>
                <p class="testimoni-lokasi">Warga Karawang Timur</p>
              </div>
            </div>
          </article>
        </div>
      </section>

      <!-- VIDEO: contoh tag <iframe> buat nanam video YouTube -->
      <section class="video-section reveal">
        <div class="video-copy">
          <div class="sub-label">Profil singkat</div>
          <h2>Lihat langsung kesehariannya</h2>
          <p>
            Video pendek ini merekam bagaimana salah satu UMKM di katalog ini
            beroperasi tiap hari — dari buka lapak sampai melayani pembeli
            pertama.
          </p>
        </div>
        <!--
          .video-frame di style.css pakai aspect-ratio: 16/9 supaya video
          selalu proporsional di layar berapa pun lebarnya, tanpa perlu
          angka width/height tetap seperti iframe biasa.
        -->
        <div class="video-frame">
          <iframe
            src="https://www.youtube.com/embed/IxX_QHay02M"
            title="Video profil UMKM"
            loading="lazy"
            allowfullscreen
          ></iframe>
        </div>
      </section>

      <!--
        LOKASI
        Peta Google Maps di sini pakai URL embed publik (bukan Maps
        JavaScript API), jadi tidak butuh API key sama sekali — cocok
        buat latihan karena bisa langsung ditiru tanpa daftar akun.
      -->
      <section id="lokasi" class="lokasi reveal">
        <div class="lokasi-peta">
          <iframe
            src="https://maps.google.com/maps?q=Karawang&t=&z=13&ie=UTF8&iwloc=&output=embed"
            title="Peta area Karawang"
            loading="lazy"
          ></iframe>
        </div>
        <div class="lokasi-daftar">
          <h2>Mau kerja sama atau daftarin UMKM-mu?</h2>
          <ul>
            <li><i class="fa-solid fa-envelope" aria-hidden="true"></i> halo@umkmkarawang.id</li>
            <li><i class="fa-regular fa-clock" aria-hidden="true"></i> Senin–Sabtu, jam 09.00–17.00</li>
          </ul>
          <div class="lokasi-sosial">
            <a href="https://wa.me/6281200001234" target="_blank" rel="noopener" aria-label="Chat WhatsApp UMKM Karawang"><i class="fa-brands fa-whatsapp" aria-hidden="true"></i></a>
            <a href="https://instagram.com/umkmkarawang" target="_blank" rel="noopener" aria-label="Instagram UMKM Karawang"><i class="fa-brands fa-instagram" aria-hidden="true"></i></a>
          </div>
        </div>
      </section>

      <!-- KONTAK: form pendaftaran UMKM baru -->
      <section id="kontak" class="kontak reveal">
        <div class="kontak-inner">
          <div class="kontak-copy">
            <h2>Punya usaha yang belum terdaftar?</h2>
            <p>
              Kirim nama dan pesan singkat, kami hubungi balik untuk proses
              pendaftarannya.
            </p>
          </div>
          <form>
            <label for="nama">Nama</label>
            <input type="text" id="nama" name="nama" placeholder="Nama kamu" />

            <label for="pesan">Pesan</label>
            <textarea
              id="pesan"
              name="pesan"
              placeholder="Ceritakan usahamu secara singkat..."
            ></textarea>

            <button type="submit">Kirim pesan</button>
          </form>
        </div>
      </section>
    </main>

    <footer>
      <div class="footer-inner">
        <p>&copy; 2026 Katalog UMKM Karawang</p>
        <div class="footer-sosial">
          <a href="#" aria-label="Instagram Katalog UMKM Karawang"><i class="fa-brands fa-instagram" aria-hidden="true"></i></a>
          <a href="#" aria-label="Facebook Katalog UMKM Karawang"><i class="fa-brands fa-facebook" aria-hidden="true"></i></a>
          <a href="#" aria-label="WhatsApp Katalog UMKM Karawang"><i class="fa-brands fa-whatsapp" aria-hidden="true"></i></a>
          <!-- Contoh tag <audio> — sengaja ditaruh kecil dan santai di sini, bukan di tengah konten -->
          <audio class="footer-audio" src="getout.mp3" controls></audio>
        </div>
      </div>
    </footer>

    <!-- Tombol "kembali ke atas": disembunyikan lewat CSS, dimunculkan lewat JS saat halaman sudah discroll cukup jauh -->
    <button id="ke-atas" class="ke-atas" aria-label="Kembali ke atas">
      <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
        <path d="M12 19V5"></path>
        <path d="M6 11l6-6 6 6"></path>
      </svg>
    </button>

    <script>
      // ---------- Navbar sembunyi saat scroll ke bawah ----------
      // Bandingkan posisi scroll sekarang dengan posisi sebelumnya:
      // kalau turun (scroll ke bawah) navbar disembunyikan, kalau naik
      // (scroll ke atas) navbar dimunculkan lagi.
      const headerEl = document.querySelector('header');
      let posisiScrollTerakhir = 0;
      window.addEventListener('scroll', () => {
        const posisiSekarang = window.scrollY;
        const scrollTurun = posisiSekarang > posisiScrollTerakhir;
        // Cuma disembunyikan kalau sudah scroll cukup jauh (80px), supaya
        // navbar tidak kedap-kedip saat baru sedikit digeser di paling atas.
        headerEl.classList.toggle('sembunyi', scrollTurun && posisiSekarang > 80);
        posisiScrollTerakhir = posisiSekarang;
      });

      // ---------- Tombol kembali ke atas ----------
      // Tombolnya cuma tampil kalau memang berguna: setelah discroll > 400px.
      const tombolKeAtas = document.getElementById('ke-atas');
      window.addEventListener('scroll', () => {
        tombolKeAtas.classList.toggle('tampil', window.scrollY > 400);
      });
      tombolKeAtas.addEventListener('click', () => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
      });

      // ---------- Reveal saat discroll ----------
      // IntersectionObserver mendeteksi kapan sebuah elemen masuk ke layar,
      // tanpa perlu menghitung posisi scroll secara manual.
      const revealObserver = new IntersectionObserver(
        (entries) => {
          entries.forEach((entry) => {
            if (entry.isIntersecting) {
              entry.target.classList.add('tampil');
              revealObserver.unobserve(entry.target); // cukup sekali, tidak diulang
            }
          });
        },
        { threshold: 0.12 }
      );
      document.querySelectorAll('.reveal').forEach((el) => revealObserver.observe(el));
    </script>
  </body>
</html>
```

Dan tambahkan CSS `.reveal` yang baru ke `style.css` (potongan ini yang bikin tiap section muncul dengan efek "kabut memudar" saat discroll ke posisinya — cek `class="reveal"` yang sudah kita tulis di tiap section sejak Langkah 9). Isi FULL `style.css` sampai titik ini:

```css
/*
  CSS variable (custom property). Ditulis sekali di :root, dipakai
  berkali-kali lewat var(--nama). Kalau mau ganti warna tema, cukup
  ubah di sini — tidak perlu cari-ganti di semua tempat.
*/
:root {
  --matcha-abyss: #1e2a18;
  --matcha-dark: #33422b;
  --matcha-mid: #7c9473;
  --sage-pale: #e9efe1;
  --cream: #f6f3e7;
  --gold: #c9a66b;
  --ink: #1f2937;
  --content-width: 1080px;
}

/* Reset dasar: hilangkan margin/padding bawaan browser yang beda-beda tiap browser */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box; /* border & padding dihitung masuk ke lebar elemen, bukan nambah lebar */
}

/*
  scroll-behavior: smooth membuat perpindahan ke #id (misalnya klik link
  nav ke "#tentang") meluncur halus, bukan langsung loncat.
  scroll-padding-top mengimbangi tinggi header yang sticky, supaya judul
  section tidak ketutupan header saat baru sampai.
*/
html {
  scroll-behavior: smooth;
  scroll-padding-top: 84px;
}

body {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  color: var(--ink);
  background-color: var(--cream);
  line-height: 1.6;
}

h1, h2, h3 {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  font-weight: 800;
}

a {
  color: inherit;
}

/* ================= HEADER ================= */
/*
  position: sticky membuat header ini nempel di atas begitu halaman
  discroll sampai posisinya, lalu tetap di situ (beda dengan "fixed"
  yang nempel dari awal halaman dibuka).
*/
header {
  position: sticky;
  top: 0;
  z-index: 10;
  background-color: var(--matcha-abyss);
  color: white;
  transition: transform 0.3s ease;
}

/* Ditambahkan lewat JS saat pengguna scroll ke bawah — header digeser ke atas sampai hilang */
header.sembunyi {
  transform: translateY(-100%);
}

/*
  Grid 3 kolom "1fr auto 1fr": kolom kiri (wordmark) dan kolom kanan
  (spacer kosong) selalu diberi lebar yang SAMA karena sama-sama 1fr,
  apa pun isinya. Efeknya kolom tengah (nav) selalu benar-benar di
  tengah header — beda dengan flexbox space-between yang mendorong nav
  ke ujung kanan mengikuti lebar wordmark.
*/
.header-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 20px 24px;
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: center;
  gap: 12px;
}

.wordmark {
  font-family: "Plus Jakarta Sans", sans-serif;
  font-weight: 800;
  font-size: 1.2rem;
  letter-spacing: -0.01em;
}

header nav {
  display: flex;
  gap: 24px;
}

header nav a {
  color: var(--sage-pale);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  padding-bottom: 2px;
  border-bottom: 2px solid transparent;
  transition: border-color 0.2s, color 0.2s;
}

header nav a:hover,
header nav a:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= HERO ================= */
/*
  position: relative di sini jadi acuan buat 3 lapisan .hero-bg dan
  .hero-overlay yang semuanya position: absolute — pola yang sama
  seperti badge kategori (relative parent + absolute child), cuma
  dipakai buat menumpuk latar belakang, bukan menumpuk elemen kecil.
*/
.hero {
  position: relative;
  overflow: hidden;
  color: white;
  text-align: center;
  padding: 120px 24px;
}

/*
  Tiga foto ditumpuk persis di posisi yang sama (inset: 0 memenuhi
  seluruh .hero), lalu masing-masing diberi animation-delay berbeda
  supaya bergantian terlihat. Ini murni CSS — tidak ada JavaScript
  yang mengganti gambar.
*/
.hero-bg {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  opacity: 0;
  animation: heroBgCycle 18s infinite;
}

.hero-bg-2 {
  animation-delay: 6s;
}

.hero-bg-3 {
  animation-delay: 12s;
}

/*
  18 detik dibagi 3 foto = 6 detik jatah tiap foto. Tiap foto: tersembunyi
  (0%) → memudar masuk (5%) → tampil penuh (28%) → memudar keluar (33%) →
  tersembunyi lagi sampai putaran berikutnya. animation-delay di atas
  menggeser kapan tiap foto memulai siklus ini, jadi hasilnya bergantian.
*/
@keyframes heroBgCycle {
  0%, 100% { opacity: 0; }
  5% { opacity: 1; }
  28% { opacity: 1; }
  33% { opacity: 0; }
}

/* Lapisan gelap transparan di atas foto, supaya teks putih tetap terbaca di foto apa pun */
.hero-overlay {
  position: absolute;
  inset: 0;
  background-color: rgba(20, 28, 16, 0.68);
}

.hero-inner {
  position: relative; /* supaya tampil di atas .hero-bg dan .hero-overlay */
  max-width: 640px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/*
  clamp(min, ideal, max) bikin ukuran font otomatis menyesuaikan lebar
  layar di antara batas minimum dan maksimum — tanpa perlu media query
  terpisah cuma buat ukuran teks.
*/
.hero-inner h1 {
  font-size: clamp(2.2rem, 5vw, 3.3rem);
  line-height: 1.05;
  letter-spacing: -0.02em;
  margin-bottom: 20px;
  opacity: 0;
  animation: heroRise 0.6s ease forwards;
}

.hero-inner p {
  max-width: 46ch;
  color: var(--sage-pale);
  font-size: 1.05rem;
  margin-bottom: 28px;
  opacity: 0;
  animation: heroRise 0.6s ease 0.15s forwards;
}

.hero-cta {
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
  justify-content: center;
  opacity: 0;
  animation: heroRise 0.6s ease 0.3s forwards;
}

/*
  Ini satu-satunya urutan animasi "otomatis saat halaman dibuka" di
  seluruh halaman (judul, lalu paragraf, lalu tombol —
  perhatikan animation-delay yang berbeda tiap elemen). Sengaja cuma
  di hero, supaya animasi tidak berserakan di semua bagian.
*/
@keyframes heroRise {
  from { opacity: 0; transform: translateY(16px); }
  to { opacity: 1; transform: translateY(0); }
}

.btn-primary, .btn-ghost {
  display: inline-block;
  padding: 12px 24px;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.95rem;
  text-decoration: none;
  transition: transform 0.15s, background-color 0.2s, color 0.2s;
}

.btn-primary {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

.btn-primary:hover, .btn-primary:focus-visible {
  transform: translateY(-2px);
}

.btn-ghost {
  border: 1px solid var(--matcha-mid);
  color: var(--sage-pale);
}

.btn-ghost:hover, .btn-ghost:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= Direktori ================= */
.direktori {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
}

.direktori h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 20px;
}

/*
  Toolbar pencarian + filter — TAMPILAN SAJA. Input dan select ini belum
  disambungkan ke logika apa pun (belum ada JavaScript), jadi mengetik
  atau ganti dropdown-nya belum benar-benar menyaring kartu di bawah.
*/
.direktori-toolbar {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
  margin-bottom: 28px;
}

.direktori-cari {
  flex: 1;
  min-width: 200px;
  padding: 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
}

/*
  appearance: none menghilangkan panah bawaan browser (posisinya gak bisa
  diatur pakai padding). Panah custom dipasang lewat SVG di background,
  posisinya diatur manual pakai background-position — jadi bisa "dimasukin"
  sesuai jarak yang kita mau, ngikutin padding kanan.
*/
.direktori-kategori {
  padding: 11px 36px 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
  color: var(--ink);
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6' viewBox='0 0 10 6' fill='none'%3E%3Cpath d='M1 1l4 4 4-4' stroke='%2333422b' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 16px center;
}

.direktori-cari:focus,
.direktori-kategori:focus {
  outline: none;
  border-color: var(--gold);
}

/* Grid kartu: auto-fit + minmax bikin jumlah kolom menyesuaikan sendiri lebar layar, tanpa media query manual */
.grid-umkm {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.kartu-umkm {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  overflow: hidden;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.kartu-umkm:hover,
.kartu-umkm:focus-within {
  transform: translateY(-4px);
  box-shadow: 0 14px 28px rgba(51, 66, 43, 0.14);
}

/* position: relative di sini jadi acuan buat .badge yang absolute di dalamnya */
.kartu-foto {
  position: relative;
  aspect-ratio: 4 / 3;
}

.kartu-foto img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.kartu-isi {
  padding: 16px 18px 20px;
}

.kartu-isi h3 {
  font-size: 1.1rem;
  color: var(--matcha-dark);
  margin-bottom: 4px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis; /* nama kepanjangan dipotong jadi "...", bukan bikin tinggi kartu beda-beda */
}

.kartu-isi .alamat {
  color: #6b6b5f;
  font-size: 0.88rem;
  display: flex;
  align-items: center;
  gap: 6px;
}

/*
  Alamat yang kepanjangan dipotong jadi satu baris + "..." di ujungnya
  (text-overflow: ellipsis), bukan bikin kartu jadi tinggi sebelah.
  min-width: 0 wajib di sini supaya flex item ini mau menyusut duluan
  sebelum ikon di sebelahnya ikut menyusut.
*/
.kartu-isi .alamat span {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  min-width: 0;
}

.kartu-isi .alamat i,
.kartu-isi .jam i {
  color: var(--matcha-mid);
  flex-shrink: 0;
}

.kartu-isi .jam {
  color: var(--matcha-mid);
  font-size: 0.8rem;
  margin-top: 2px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa {
  color: var(--matcha-dark);
  font-size: 0.85rem;
  font-weight: 600;
  margin-top: 8px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa i {
  color: var(--matcha-mid);
}

/*
  Badge kategori: position: absolute melepas elemen ini dari alur normal
  dan menempelkannya presisi ke pojok kanan-atas .kartu-foto (parent
  terdekat yang sudah diberi position: relative di atas).
*/
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

/*
  Paginasi — TAMPILAN SAJA juga. Angka "1" ditandai .aktif lewat HTML
  langsung (bukan JavaScript), sekadar contoh bagaimana halaman aktif
  biasanya dibedakan secara visual.
*/
.pagination {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-top: 36px;
}

.pagination a {
  width: 38px;
  height: 38px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid #ddd6c4;
  border-radius: 8px;
  color: var(--matcha-dark);
  text-decoration: none;
  font-size: 0.9rem;
  transition: border-color 0.2s, background-color 0.2s, color 0.2s;
}

.pagination a:hover,
.pagination a:focus-visible {
  border-color: var(--gold);
}

.pagination a.aktif {
  background-color: var(--matcha-dark);
  border-color: var(--matcha-dark);
  color: white;
}

/* ================= Tentang ================= */
/* CSS Grid 2 kolom asimetris: kolom teks lebih lebar (7 bagian) dari kolom gambar (5 bagian) */
.tentang {
  display: grid;
  grid-template-columns: 7fr 5fr;
  max-width: var(--content-width);
  margin: 56px auto;
  border-radius: 16px;
  overflow: hidden; /* biar sudut foto & panel ikut membulat mengikuti .tentang, bukan cuma sudut luarnya */
}

.tentang-teks {
  background-color: var(--sage-pale);
  padding: 48px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.tentang-teks h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 8px;
}

.tentang-teks > p {
  color: #444;
}

.tentang-gambar {
  overflow: hidden; /* biar foto yang dibesarkan lewat object-fit tidak keluar dari kotaknya */
}

.tentang-gambar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

/* ================= Testimoni ================= */
.testimoni {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
}

.testimoni h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 24px;
}

.testimoni-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.testimoni-kartu {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  padding: 22px;
  display: flex;
  flex-direction: column;
  gap: 18px;
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.testimoni-teks {
  color: #444;
  font-size: 0.95rem;
  line-height: 1.6;
}

.testimoni-orang {
  display: flex;
  align-items: center;
  gap: 12px;
}

/* Avatar cuma inisial di lingkaran warna gold — bukan foto orang beneran */
.testimoni-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: var(--sage-pale);
  color: var(--matcha-dark);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  flex-shrink: 0;
}

.testimoni-nama {
  color: var(--matcha-dark);
  font-weight: 600;
  font-size: 0.9rem;
}

.testimoni-lokasi {
  color: var(--matcha-mid);
  font-size: 0.8rem;
}

/* ================= Video ================= */
.video-section {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
  display: grid;
  grid-template-columns: 1fr 1.4fr;
  gap: 40px;
  align-items: center;
}

.sub-label {
  color: var(--matcha-mid);
  font-weight: 600;
  font-size: 0.85rem;
  margin-bottom: 8px;
}

.video-copy h2 {
  color: var(--matcha-dark);
  font-size: 1.5rem;
  margin-bottom: 12px;
}

.video-copy p {
  color: #555;
  max-width: 42ch;
}

/*
  aspect-ratio: 16/9 mengunci rasio lebar:tinggi kotak ini apa pun lebar
  layarnya, jadi video tidak pernah gepeng atau terlalu tinggi. Ini
  menggantikan trik lama "padding-bottom: 56.25%" yang lebih ribet.
*/
.video-frame {
  position: relative;
  width: 100%;
  aspect-ratio: 16 / 9;
  border-radius: 12px;
  overflow: hidden;
  background-color: var(--matcha-abyss);
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.video-frame iframe {
  position: absolute;
  inset: 0; /* setara top:0; right:0; bottom:0; left:0; */
  width: 100%;
  height: 100%;
  border: 0;
}

/* ================= Lokasi ================= */
.lokasi {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
  display: grid;
  grid-template-columns: 1.3fr 1fr;
  gap: 40px;
  align-items: start;
}

/* Peta juga pakai aspect-ratio, sama seperti video di atas */
.lokasi-peta {
  aspect-ratio: 16 / 9;
  border-radius: 12px;
  overflow: hidden;
  border: 1px solid #ddd6c4;
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.lokasi-peta iframe {
  width: 100%;
  height: 100%;
  border: 0;
}

.lokasi-daftar h2 {
  color: var(--matcha-dark);
  font-size: 1.5rem;
  margin-bottom: 16px;
}

.lokasi-daftar ul {
  list-style: none;
}

/* WhatsApp & Instagram jadi tombol bulat yang bisa diklik, bukan cuma teks */
.lokasi-sosial {
  display: flex;
  gap: 12px;
  margin-top: 28px;
}

.lokasi-sosial a {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background-color: var(--sage-pale);
  color: var(--matcha-dark);
  font-size: 1.05rem;
  text-decoration: none;
  transition: background-color 0.2s, color 0.2s;
}

.lokasi-sosial a:hover,
.lokasi-sosial a:focus-visible {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

.lokasi-daftar li {
  padding: 6px 0;
  font-size: 0.92rem;
  color: #555;
}

.lokasi-daftar li i {
  color: var(--matcha-mid);
  width: 16px;
  margin-right: 8px;
  text-align: center;
}

/* ================= Kontak ================= */
.kontak {
  background-color: var(--matcha-abyss);
  color: white;
  padding: 64px 24px;
}

.kontak-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  display: grid;
  grid-template-columns: 1fr 1.2fr;
  gap: 48px;
}

.kontak-copy h2 {
  font-size: 1.8rem;
  margin-bottom: 12px;
}

.kontak-copy p {
  color: var(--sage-pale);
  max-width: 36ch;
}

form {
  display: flex;
  flex-direction: column;
  gap: 22px;
}

form label {
  font-weight: 600;
  font-size: 0.85rem;
  color: var(--sage-pale);
  text-transform: uppercase;
  letter-spacing: 0.04em;
}

/* Form bergaris bawah, bukan kotak — lebih ringan di atas panel gelap */
form input,
form textarea {
  background: transparent;
  border: none;
  border-bottom: 1px solid var(--matcha-mid);
  color: white;
  padding: 8px 2px;
  font-family: inherit;
  font-size: 1rem;
  transition: border-color 0.2s;
}

form input::placeholder,
form textarea::placeholder {
  color: #8ba088;
}

form input:focus,
form textarea:focus {
  outline: none;
  border-color: var(--gold);
}

form textarea {
  resize: vertical;
  min-height: 70px;
}

button {
  align-self: flex-start;
  background-color: var(--gold);
  color: var(--matcha-abyss);
  border: none;
  padding: 12px 24px;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.95rem;
  cursor: pointer;
  transition: transform 0.15s;
}

button:hover,
button:focus-visible {
  transform: translateY(-2px);
}

/* Garis fokus jelas untuk pengguna keyboard, di semua elemen interaktif */
a:focus-visible,
button:focus-visible,
input:focus-visible,
textarea:focus-visible {
  outline: 2px solid var(--gold);
  outline-offset: 2px;
}

/* ================= Footer ================= */
footer {
  background-color: var(--matcha-abyss);
  color: var(--matcha-mid);
  padding: 20px 24px;
  font-size: 0.85rem;
  border-top: 1px solid #34432c;
}

.footer-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 12px;
}

.footer-sosial {
  display: flex;
  align-items: center;
  gap: 14px;
}

.footer-sosial a {
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background-color: rgba(246, 243, 231, 0.08);
  color: var(--sage-pale);
  font-size: 0.95rem;
  text-decoration: none;
  transition: color 0.2s, background-color 0.2s;
}

.footer-sosial a:hover,
.footer-sosial a:focus-visible {
  color: var(--gold);
  background-color: rgba(201, 166, 107, 0.15);
}

/* Player audio dibikin kecil dan rendah — cuma "iseng" nemplok di footer, bukan elemen utama */
.footer-audio {
  height: 28px;
  max-width: 180px;
}

/* ================= Tombol kembali ke atas ================= */
/*
  position: fixed menempel ke jendela browser (bukan ke halaman), jadi
  tombol ini selalu ada di pojok kanan-bawah layar walau halaman
  discroll ke mana pun. Bedanya dengan .badge yang "absolute": absolute
  nempel ke parent, fixed nempel ke jendela.
*/
/*
  Ikon panah di dalam tombol ini di-set width/height eksplisit + flex-shrink:0
  di bawah — tanpa itu, ikon SVG bisa kehitung lebar 0 oleh browser saat
  beradadi dalam container flex bersama reset box-sizing: border-box global.
*/
.ke-atas {
  position: fixed;
  right: 24px;
  bottom: 24px;
  width: 46px;
  height: 46px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: var(--gold);
  color: var(--matcha-abyss);
  border: none;
  box-shadow: 0 6px 16px rgba(30, 42, 24, 0.25);
  cursor: pointer;
  opacity: 0;
  pointer-events: none; /* saat tersembunyi, tombol tidak bisa diklik walau posisinya masih ada */
  transform: translateY(8px) scale(0.9);
  transition: opacity 0.25s, transform 0.2s ease, box-shadow 0.2s ease, background-color 0.2s ease;
}

.ke-atas svg {
  width: 20px;
  height: 20px;
  flex-shrink: 0;
}

.ke-atas.tampil {
  opacity: 1;
  pointer-events: auto;
  transform: translateY(0) scale(1);
}

.ke-atas:hover,
.ke-atas:focus-visible {
  background-color: var(--matcha-dark);
  color: var(--sage-pale);
  box-shadow: 0 10px 22px rgba(30, 42, 24, 0.32);
  transform: translateY(-3px) scale(1);
}

/* ================= Reveal saat discroll ================= */
/*
  Section dimulai transparan + sedikit turun. Begitu IntersectionObserver
  (lihat script di index.html) mendeteksi section masuk layar, class
  "tampil" ditambahkan dan transition di bawah ini yang menganimasikannya.
  Jaraknya sengaja kecil (12px) dan cepat (0.5s) supaya terasa halus,
  bukan pertunjukan animasi yang berlebihan.
*/
.reveal {
  opacity: 0;
  transform: translateY(12px);
  filter: blur(6px); /* mulai buram, jadi terlihat "muncul dari kabut" saat opacity naik */
  transition: opacity 0.6s ease, transform 0.6s ease, filter 0.6s ease;
}

.reveal.tampil {
  opacity: 1;
  transform: translateY(0);
  filter: blur(0);
}
```

Reload dan coba semuanya: scroll ke bawah pelan-pelan (navbar hilang, tiap section muncul dari buram), klik tombol bulat gold di pojok kanan-bawah (halaman meluncur balik ke atas), scroll ke atas lagi (navbar muncul lagi). Tiga fitur ini masing-masing cuma butuh beberapa baris JavaScript — sengaja disimpan sesederhana mungkin.

## Langkah 24 — CSS: Bikin responsif dan hormati "reduce motion"

Langkah terakhir: menyesuaikan apa yang sudah dibuat, bukan menambah elemen baru. Dua hal:

- **Media query** (`@media (max-width: ...)`) mengubah beberapa aturan CSS kalau lebar layar di bawah angka tertentu — di sini breakpoint 860px (tablet) dan 640px (HP), bikin kolom-kolom yang tadinya berdampingan jadi ditumpuk vertikal.
- **`prefers-reduced-motion`** — sebagian orang mengaktifkan pengaturan "reduce motion" di sistem operasinya (biasanya karena animasi bikin pusing/mabuk gerak). Aturan ini mendeteksi preferensi itu dan memaksa semua durasi animasi jadi nyaris 0 detik, tanpa kita perlu menulis ulang tiap animasi satu-satu.

> Catatan: di `style.css` yang asli, blok `prefers-reduced-motion` sebenarnya ditaruh dekat bagian atas (setelah reset dasar) — kita taruh di akhir dokumen ini karena baru masuk akal dibahas setelah semua animasi di halaman ini sudah ada. Taruh sesuai selera kamu di file aslimu, urutannya tidak memengaruhi hasil tampilan.

Ini isi FULL `style.css` — versi akhir, persis sama dengan `style.css` yang ada di folder ini:

```css
/*
  CSS variable (custom property). Ditulis sekali di :root, dipakai
  berkali-kali lewat var(--nama). Kalau mau ganti warna tema, cukup
  ubah di sini — tidak perlu cari-ganti di semua tempat.
*/
:root {
  --matcha-abyss: #1e2a18;
  --matcha-dark: #33422b;
  --matcha-mid: #7c9473;
  --sage-pale: #e9efe1;
  --cream: #f6f3e7;
  --gold: #c9a66b;
  --ink: #1f2937;
  --content-width: 1080px;
}

/* Reset dasar: hilangkan margin/padding bawaan browser yang beda-beda tiap browser */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box; /* border & padding dihitung masuk ke lebar elemen, bukan nambah lebar */
}

/*
  scroll-behavior: smooth membuat perpindahan ke #id (misalnya klik link
  nav ke "#tentang") meluncur halus, bukan langsung loncat.
  scroll-padding-top mengimbangi tinggi header yang sticky, supaya judul
  section tidak ketutupan header saat baru sampai.
*/
html {
  scroll-behavior: smooth;
  scroll-padding-top: 84px;
}

body {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  color: var(--ink);
  background-color: var(--cream);
  line-height: 1.6;
}

h1, h2, h3 {
  font-family: "Plus Jakarta Sans", "Segoe UI", system-ui, sans-serif;
  font-weight: 800;
}

a {
  color: inherit;
}

/* ================= HEADER ================= */
/*
  position: sticky membuat header ini nempel di atas begitu halaman
  discroll sampai posisinya, lalu tetap di situ (beda dengan "fixed"
  yang nempel dari awal halaman dibuka).
*/
header {
  position: sticky;
  top: 0;
  z-index: 10;
  background-color: var(--matcha-abyss);
  color: white;
  transition: transform 0.3s ease;
}

/* Ditambahkan lewat JS saat pengguna scroll ke bawah — header digeser ke atas sampai hilang */
header.sembunyi {
  transform: translateY(-100%);
}

/*
  Grid 3 kolom "1fr auto 1fr": kolom kiri (wordmark) dan kolom kanan
  (spacer kosong) selalu diberi lebar yang SAMA karena sama-sama 1fr,
  apa pun isinya. Efeknya kolom tengah (nav) selalu benar-benar di
  tengah header — beda dengan flexbox space-between yang mendorong nav
  ke ujung kanan mengikuti lebar wordmark.
*/
.header-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 20px 24px;
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: center;
  gap: 12px;
}

.wordmark {
  font-family: "Plus Jakarta Sans", sans-serif;
  font-weight: 800;
  font-size: 1.2rem;
  letter-spacing: -0.01em;
}

header nav {
  display: flex;
  gap: 24px;
}

header nav a {
  color: var(--sage-pale);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  padding-bottom: 2px;
  border-bottom: 2px solid transparent;
  transition: border-color 0.2s, color 0.2s;
}

header nav a:hover,
header nav a:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= HERO ================= */
/*
  position: relative di sini jadi acuan buat 3 lapisan .hero-bg dan
  .hero-overlay yang semuanya position: absolute — pola yang sama
  seperti badge kategori (relative parent + absolute child), cuma
  dipakai buat menumpuk latar belakang, bukan menumpuk elemen kecil.
*/
.hero {
  position: relative;
  overflow: hidden;
  color: white;
  text-align: center;
  padding: 120px 24px;
}

/*
  Tiga foto ditumpuk persis di posisi yang sama (inset: 0 memenuhi
  seluruh .hero), lalu masing-masing diberi animation-delay berbeda
  supaya bergantian terlihat. Ini murni CSS — tidak ada JavaScript
  yang mengganti gambar.
*/
.hero-bg {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  opacity: 0;
  animation: heroBgCycle 18s infinite;
}

.hero-bg-2 {
  animation-delay: 6s;
}

.hero-bg-3 {
  animation-delay: 12s;
}

/*
  18 detik dibagi 3 foto = 6 detik jatah tiap foto. Tiap foto: tersembunyi
  (0%) → memudar masuk (5%) → tampil penuh (28%) → memudar keluar (33%) →
  tersembunyi lagi sampai putaran berikutnya. animation-delay di atas
  menggeser kapan tiap foto memulai siklus ini, jadi hasilnya bergantian.
*/
@keyframes heroBgCycle {
  0%, 100% { opacity: 0; }
  5% { opacity: 1; }
  28% { opacity: 1; }
  33% { opacity: 0; }
}

/* Lapisan gelap transparan di atas foto, supaya teks putih tetap terbaca di foto apa pun */
.hero-overlay {
  position: absolute;
  inset: 0;
  background-color: rgba(20, 28, 16, 0.68);
}

.hero-inner {
  position: relative; /* supaya tampil di atas .hero-bg dan .hero-overlay */
  max-width: 640px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/*
  clamp(min, ideal, max) bikin ukuran font otomatis menyesuaikan lebar
  layar di antara batas minimum dan maksimum — tanpa perlu media query
  terpisah cuma buat ukuran teks.
*/
.hero-inner h1 {
  font-size: clamp(2.2rem, 5vw, 3.3rem);
  line-height: 1.05;
  letter-spacing: -0.02em;
  margin-bottom: 20px;
  opacity: 0;
  animation: heroRise 0.6s ease forwards;
}

.hero-inner p {
  max-width: 46ch;
  color: var(--sage-pale);
  font-size: 1.05rem;
  margin-bottom: 28px;
  opacity: 0;
  animation: heroRise 0.6s ease 0.15s forwards;
}

.hero-cta {
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
  justify-content: center;
  opacity: 0;
  animation: heroRise 0.6s ease 0.3s forwards;
}

/*
  Ini satu-satunya urutan animasi "otomatis saat halaman dibuka" di
  seluruh halaman (judul, lalu paragraf, lalu tombol —
  perhatikan animation-delay yang berbeda tiap elemen). Sengaja cuma
  di hero, supaya animasi tidak berserakan di semua bagian.
*/
@keyframes heroRise {
  from { opacity: 0; transform: translateY(16px); }
  to { opacity: 1; transform: translateY(0); }
}

.btn-primary, .btn-ghost {
  display: inline-block;
  padding: 12px 24px;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.95rem;
  text-decoration: none;
  transition: transform 0.15s, background-color 0.2s, color 0.2s;
}

.btn-primary {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

.btn-primary:hover, .btn-primary:focus-visible {
  transform: translateY(-2px);
}

.btn-ghost {
  border: 1px solid var(--matcha-mid);
  color: var(--sage-pale);
}

.btn-ghost:hover, .btn-ghost:focus-visible {
  border-color: var(--gold);
  color: var(--gold);
}

/* ================= Direktori ================= */
.direktori {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
}

.direktori h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 20px;
}

/*
  Toolbar pencarian + filter — TAMPILAN SAJA. Input dan select ini belum
  disambungkan ke logika apa pun (belum ada JavaScript), jadi mengetik
  atau ganti dropdown-nya belum benar-benar menyaring kartu di bawah.
*/
.direktori-toolbar {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
  margin-bottom: 28px;
}

.direktori-cari {
  flex: 1;
  min-width: 200px;
  padding: 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
}

/*
  appearance: none menghilangkan panah bawaan browser (posisinya gak bisa
  diatur pakai padding). Panah custom dipasang lewat SVG di background,
  posisinya diatur manual pakai background-position — jadi bisa "dimasukin"
  sesuai jarak yang kita mau, ngikutin padding kanan.
*/
.direktori-kategori {
  padding: 11px 36px 11px 18px;
  border: 1px solid #ddd6c4;
  border-radius: 999px;
  font-family: inherit;
  font-size: 0.95rem;
  background-color: white;
  color: var(--ink);
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6' viewBox='0 0 10 6' fill='none'%3E%3Cpath d='M1 1l4 4 4-4' stroke='%2333422b' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 16px center;
}

.direktori-cari:focus,
.direktori-kategori:focus {
  outline: none;
  border-color: var(--gold);
}

/* Grid kartu: auto-fit + minmax bikin jumlah kolom menyesuaikan sendiri lebar layar, tanpa media query manual */
.grid-umkm {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.kartu-umkm {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  overflow: hidden;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.kartu-umkm:hover,
.kartu-umkm:focus-within {
  transform: translateY(-4px);
  box-shadow: 0 14px 28px rgba(51, 66, 43, 0.14);
}

/* position: relative di sini jadi acuan buat .badge yang absolute di dalamnya */
.kartu-foto {
  position: relative;
  aspect-ratio: 4 / 3;
}

.kartu-foto img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.kartu-isi {
  padding: 16px 18px 20px;
}

.kartu-isi h3 {
  font-size: 1.1rem;
  color: var(--matcha-dark);
  margin-bottom: 4px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis; /* nama kepanjangan dipotong jadi "...", bukan bikin tinggi kartu beda-beda */
}

.kartu-isi .alamat {
  color: #6b6b5f;
  font-size: 0.88rem;
  display: flex;
  align-items: center;
  gap: 6px;
}

/*
  Alamat yang kepanjangan dipotong jadi satu baris + "..." di ujungnya
  (text-overflow: ellipsis), bukan bikin kartu jadi tinggi sebelah.
  min-width: 0 wajib di sini supaya flex item ini mau menyusut duluan
  sebelum ikon di sebelahnya ikut menyusut.
*/
.kartu-isi .alamat span {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  min-width: 0;
}

.kartu-isi .alamat i,
.kartu-isi .jam i {
  color: var(--matcha-mid);
  flex-shrink: 0;
}

.kartu-isi .jam {
  color: var(--matcha-mid);
  font-size: 0.8rem;
  margin-top: 2px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa {
  color: var(--matcha-dark);
  font-size: 0.85rem;
  font-weight: 600;
  margin-top: 8px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.kartu-isi .wa i {
  color: var(--matcha-mid);
}

/*
  Badge kategori: position: absolute melepas elemen ini dari alur normal
  dan menempelkannya presisi ke pojok kanan-atas .kartu-foto (parent
  terdekat yang sudah diberi position: relative di atas).
*/
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

/*
  Paginasi — TAMPILAN SAJA juga. Angka "1" ditandai .aktif lewat HTML
  langsung (bukan JavaScript), sekadar contoh bagaimana halaman aktif
  biasanya dibedakan secara visual.
*/
.pagination {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-top: 36px;
}

.pagination a {
  width: 38px;
  height: 38px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid #ddd6c4;
  border-radius: 8px;
  color: var(--matcha-dark);
  text-decoration: none;
  font-size: 0.9rem;
  transition: border-color 0.2s, background-color 0.2s, color 0.2s;
}

.pagination a:hover,
.pagination a:focus-visible {
  border-color: var(--gold);
}

.pagination a.aktif {
  background-color: var(--matcha-dark);
  border-color: var(--matcha-dark);
  color: white;
}

/* ================= Tentang ================= */
/* CSS Grid 2 kolom asimetris: kolom teks lebih lebar (7 bagian) dari kolom gambar (5 bagian) */
.tentang {
  display: grid;
  grid-template-columns: 7fr 5fr;
  max-width: var(--content-width);
  margin: 56px auto;
  border-radius: 16px;
  overflow: hidden; /* biar sudut foto & panel ikut membulat mengikuti .tentang, bukan cuma sudut luarnya */
}

.tentang-teks {
  background-color: var(--sage-pale);
  padding: 48px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.tentang-teks h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 8px;
}

.tentang-teks > p {
  color: #444;
}

.tentang-gambar {
  overflow: hidden; /* biar foto yang dibesarkan lewat object-fit tidak keluar dari kotaknya */
}

.tentang-gambar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

/* ================= Testimoni ================= */
.testimoni {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
}

.testimoni h2 {
  font-size: 1.6rem;
  color: var(--matcha-dark);
  margin-bottom: 24px;
}

.testimoni-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 22px;
}

.testimoni-kartu {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
  padding: 22px;
  display: flex;
  flex-direction: column;
  gap: 18px;
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.testimoni-teks {
  color: #444;
  font-size: 0.95rem;
  line-height: 1.6;
}

.testimoni-orang {
  display: flex;
  align-items: center;
  gap: 12px;
}

/* Avatar cuma inisial di lingkaran warna gold — bukan foto orang beneran */
.testimoni-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: var(--sage-pale);
  color: var(--matcha-dark);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  flex-shrink: 0;
}

.testimoni-nama {
  color: var(--matcha-dark);
  font-weight: 600;
  font-size: 0.9rem;
}

.testimoni-lokasi {
  color: var(--matcha-mid);
  font-size: 0.8rem;
}

/* ================= Video ================= */
.video-section {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
  display: grid;
  grid-template-columns: 1fr 1.4fr;
  gap: 40px;
  align-items: center;
}

.sub-label {
  color: var(--matcha-mid);
  font-weight: 600;
  font-size: 0.85rem;
  margin-bottom: 8px;
}

.video-copy h2 {
  color: var(--matcha-dark);
  font-size: 1.5rem;
  margin-bottom: 12px;
}

.video-copy p {
  color: #555;
  max-width: 42ch;
}

/*
  aspect-ratio: 16/9 mengunci rasio lebar:tinggi kotak ini apa pun lebar
  layarnya, jadi video tidak pernah gepeng atau terlalu tinggi. Ini
  menggantikan trik lama "padding-bottom: 56.25%" yang lebih ribet.
*/
.video-frame {
  position: relative;
  width: 100%;
  aspect-ratio: 16 / 9;
  border-radius: 12px;
  overflow: hidden;
  background-color: var(--matcha-abyss);
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.video-frame iframe {
  position: absolute;
  inset: 0; /* setara top:0; right:0; bottom:0; left:0; */
  width: 100%;
  height: 100%;
  border: 0;
}

/* ================= Lokasi ================= */
.lokasi {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 56px 24px;
  border-top: 1px solid #ddd6c4;
  display: grid;
  grid-template-columns: 1.3fr 1fr;
  gap: 40px;
  align-items: start;
}

/* Peta juga pakai aspect-ratio, sama seperti video di atas */
.lokasi-peta {
  aspect-ratio: 16 / 9;
  border-radius: 12px;
  overflow: hidden;
  border: 1px solid #ddd6c4;
  box-shadow: 0 8px 24px rgba(51, 66, 43, 0.12);
}

.lokasi-peta iframe {
  width: 100%;
  height: 100%;
  border: 0;
}

.lokasi-daftar h2 {
  color: var(--matcha-dark);
  font-size: 1.5rem;
  margin-bottom: 16px;
}

.lokasi-daftar ul {
  list-style: none;
}

/* WhatsApp & Instagram jadi tombol bulat yang bisa diklik, bukan cuma teks */
.lokasi-sosial {
  display: flex;
  gap: 12px;
  margin-top: 28px;
}

.lokasi-sosial a {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background-color: var(--sage-pale);
  color: var(--matcha-dark);
  font-size: 1.05rem;
  text-decoration: none;
  transition: background-color 0.2s, color 0.2s;
}

.lokasi-sosial a:hover,
.lokasi-sosial a:focus-visible {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

.lokasi-daftar li {
  padding: 6px 0;
  font-size: 0.92rem;
  color: #555;
}

.lokasi-daftar li i {
  color: var(--matcha-mid);
  width: 16px;
  margin-right: 8px;
  text-align: center;
}

/* ================= Kontak ================= */
.kontak {
  background-color: var(--matcha-abyss);
  color: white;
  padding: 64px 24px;
}

.kontak-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  display: grid;
  grid-template-columns: 1fr 1.2fr;
  gap: 48px;
}

.kontak-copy h2 {
  font-size: 1.8rem;
  margin-bottom: 12px;
}

.kontak-copy p {
  color: var(--sage-pale);
  max-width: 36ch;
}

form {
  display: flex;
  flex-direction: column;
  gap: 22px;
}

form label {
  font-weight: 600;
  font-size: 0.85rem;
  color: var(--sage-pale);
  text-transform: uppercase;
  letter-spacing: 0.04em;
}

/* Form bergaris bawah, bukan kotak — lebih ringan di atas panel gelap */
form input,
form textarea {
  background: transparent;
  border: none;
  border-bottom: 1px solid var(--matcha-mid);
  color: white;
  padding: 8px 2px;
  font-family: inherit;
  font-size: 1rem;
  transition: border-color 0.2s;
}

form input::placeholder,
form textarea::placeholder {
  color: #8ba088;
}

form input:focus,
form textarea:focus {
  outline: none;
  border-color: var(--gold);
}

form textarea {
  resize: vertical;
  min-height: 70px;
}

button {
  align-self: flex-start;
  background-color: var(--gold);
  color: var(--matcha-abyss);
  border: none;
  padding: 12px 24px;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.95rem;
  cursor: pointer;
  transition: transform 0.15s;
}

button:hover,
button:focus-visible {
  transform: translateY(-2px);
}

/* Garis fokus jelas untuk pengguna keyboard, di semua elemen interaktif */
a:focus-visible,
button:focus-visible,
input:focus-visible,
textarea:focus-visible {
  outline: 2px solid var(--gold);
  outline-offset: 2px;
}

/* ================= Footer ================= */
footer {
  background-color: var(--matcha-abyss);
  color: var(--matcha-mid);
  padding: 20px 24px;
  font-size: 0.85rem;
  border-top: 1px solid #34432c;
}

.footer-inner {
  max-width: var(--content-width);
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 12px;
}

.footer-sosial {
  display: flex;
  align-items: center;
  gap: 14px;
}

.footer-sosial a {
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background-color: rgba(246, 243, 231, 0.08);
  color: var(--sage-pale);
  font-size: 0.95rem;
  text-decoration: none;
  transition: color 0.2s, background-color 0.2s;
}

.footer-sosial a:hover,
.footer-sosial a:focus-visible {
  color: var(--gold);
  background-color: rgba(201, 166, 107, 0.15);
}

/* Player audio dibikin kecil dan rendah — cuma "iseng" nemplok di footer, bukan elemen utama */
.footer-audio {
  height: 28px;
  max-width: 180px;
}

/* ================= Tombol kembali ke atas ================= */
/*
  position: fixed menempel ke jendela browser (bukan ke halaman), jadi
  tombol ini selalu ada di pojok kanan-bawah layar walau halaman
  discroll ke mana pun. Bedanya dengan .badge yang "absolute": absolute
  nempel ke parent, fixed nempel ke jendela.
*/
/*
  Ikon panah di dalam tombol ini di-set width/height eksplisit + flex-shrink:0
  di bawah — tanpa itu, ikon SVG bisa kehitung lebar 0 oleh browser saat
  beradadi dalam container flex bersama reset box-sizing: border-box global.
*/
.ke-atas {
  position: fixed;
  right: 24px;
  bottom: 24px;
  width: 46px;
  height: 46px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: var(--gold);
  color: var(--matcha-abyss);
  border: none;
  box-shadow: 0 6px 16px rgba(30, 42, 24, 0.25);
  cursor: pointer;
  opacity: 0;
  pointer-events: none; /* saat tersembunyi, tombol tidak bisa diklik walau posisinya masih ada */
  transform: translateY(8px) scale(0.9);
  transition: opacity 0.25s, transform 0.2s ease, box-shadow 0.2s ease, background-color 0.2s ease;
}

.ke-atas svg {
  width: 20px;
  height: 20px;
  flex-shrink: 0;
}

.ke-atas.tampil {
  opacity: 1;
  pointer-events: auto;
  transform: translateY(0) scale(1);
}

.ke-atas:hover,
.ke-atas:focus-visible {
  background-color: var(--matcha-dark);
  color: var(--sage-pale);
  box-shadow: 0 10px 22px rgba(30, 42, 24, 0.32);
  transform: translateY(-3px) scale(1);
}

/* ================= Reveal saat discroll ================= */
/*
  Section dimulai transparan + sedikit turun. Begitu IntersectionObserver
  (lihat script di index.html) mendeteksi section masuk layar, class
  "tampil" ditambahkan dan transition di bawah ini yang menganimasikannya.
  Jaraknya sengaja kecil (12px) dan cepat (0.5s) supaya terasa halus,
  bukan pertunjukan animasi yang berlebihan.
*/
.reveal {
  opacity: 0;
  transform: translateY(12px);
  filter: blur(6px); /* mulai buram, jadi terlihat "muncul dari kabut" saat opacity naik */
  transition: opacity 0.6s ease, transform 0.6s ease, filter 0.6s ease;
}

.reveal.tampil {
  opacity: 1;
  transform: translateY(0);
  filter: blur(0);
}

/*
  Peserta yang mengaktifkan "reduce motion" di sistem operasinya (biasanya
  karena mabuk gerak/motion sickness) akan melihat halaman ini nyaris tanpa
  animasi. Trik: paksa semua durasi animasi/transisi jadi nyaris 0 detik.
*/
@media (prefers-reduced-motion: reduce) {
  html {
    scroll-behavior: auto;
  }
  * {
    animation-duration: 0.001ms !important;
    transition-duration: 0.001ms !important;
  }
}

/* ================= Responsif ================= */
@media (max-width: 860px) {
  .tentang {
    grid-template-columns: 1fr;
  }

  .tentang-gambar {
    min-height: 240px;
  }

  .video-section {
    grid-template-columns: 1fr;
  }

  .lokasi {
    grid-template-columns: 1fr;
  }

  .kontak-inner {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 640px) {
  /* Header jadi 1 kolom: wordmark dan nav ditumpuk, tetap sama-sama di tengah */
  .header-inner {
    grid-template-columns: 1fr;
    justify-items: center;
    text-align: center;
  }

  header nav {
    flex-wrap: wrap;
    justify-content: center;
    gap: 4px 16px;
  }

  .hero {
    padding: 88px 20px;
  }

  .footer-inner {
    flex-direction: column;
    gap: 10px;
  }

  .ke-atas {
    right: 16px;
    bottom: 16px;
  }
}
```

Selesai! Kecilkan jendela browser kamu pelan-pelan dari lebar penuh sampai selebar HP — perhatikan tiap bagian menyesuaikan diri tanpa ada yang kepotong atau bikin scroll horizontal.

---

## Penutup

Kalau kamu ikuti sampai sini, `index.html` dan `style.css` kamu sekarang **persis sama** dengan yang ada di folder ini. Tapi bedanya: kamu tahu **kenapa** tiap baris ada di situ, bukan cuma tahu hasilnya jadi.

Beberapa hal yang bisa dicoba sendiri sebagai latihan lanjutan:

- Ganti nilai warna di `:root` (Langkah 4) — lihat seluruh halaman ikut berubah temanya.
- Ganti foto Unsplash di Hero atau Direktori dengan foto lain (cari di [unsplash.com](https://unsplash.com), ambil link gambarnya).
- Tambah satu UMKM baru di Direktori — copy salah satu `<article class="kartu-umkm">`, ganti isinya.
- Ganti angka `18s` di `heroBgCycle` (Langkah 8) jadi lebih cepat/lambat, lihat bedanya.

Materi konsep yang lebih detail (apa itu `display`, `position`, Flexbox, dan dasar-dasar lain) ada di `README.md` — dokumen ini sengaja fokus ke proses membangun, bukan pengulangan teori.
