# Panduan Pertemuan 4: Website UMKM + Supabase

Di pertemuan 3, data UMKM masih ditulis manual di `app.js`. Hari ini datanya dipindah ke **database Supabase**, dan kita tambah login sederhana supaya bisa menambah data lewat dashboard.

Yang dikerjakan hari ini:

- **Setup Supabase** — bikin database dan tabel UMKM.

- **Read** — Direktori UMKM mengambil data dari Supabase. Filter kategori dan pencarian tetap jalan.

- **Login** — pakai username saja, tanpa password.

- **Dashboard + Create** — halaman khusus untuk menambah UMKM baru.

Yang **belum** ada: Edit dan Hapus. Itu dikerjakan di pertemuan 5. Section **Kontak** juga tidak diubah sama sekali.

## Struktur Folder

Ada dua folder di `pert4-code/`:

- `implementasi-supabase/` = hasil jadi, buat contoh atau dicocokkan kalau kodemu error.

- `mulai-dari-kosong/` = folder kosong, **di sini kamu mengerjakan** panduan ini dari awal.

```text
pert4-code/
├── README.md                      <- teori pertemuan 4
├── implementasi-supabase/         <- HASIL JADI (kode lengkap, key dummy)
│   ├── README.md                  <- panduan ini
│   ├── supabase-setup.sql         <- script buat tabel + data awal (dipaste di Supabase)
│   ├── index.html                 <- halaman utama (Direktori dari Supabase)
│   ├── login.html                 <- halaman login username (layar penuh, 2 kolom)
│   ├── dashboard.html             <- dashboard dengan sidebar (daftar + tambah UMKM)
│   ├── css/
│   │   ├── style.css              <- gaya halaman utama (+ sedikit tambahan navbar login)
│   │   └── dashboard.css          <- gaya login + dashboard (sidebar, kartu, tabel, form)
│   └── js/
│       ├── common.js              <- URL/key Supabase, login username, navbar
│       ├── app.js                 <- logika halaman utama (ambil data + filter)
│       ├── login.js               <- logika halaman login
│       └── dashboard.js           <- penjaga login + tambah data
└── mulai-dari-kosong/             <- FOLDER KOSONG, tempat kamu mengerjakan
    └── .gitkeep                   <- file penanda saja (boleh dihapus), supaya folder kosong ikut tersimpan di git
```

## Arti Komentar di Kode

Semua kode di panduan ini punya komentar singkat penanda perubahan dari pertemuan 3:

| Penanda | Artinya |
|---|---|
| `[BARU P4]` | Ditambahkan di pertemuan 4 |
| `[UBAH P4]` | Kode pertemuan 3 yang diubah |
| `[SAMA P3]` | Sama persis dengan pertemuan 3, tidak berubah |
| `[DIBUANG P4]` | Sengaja dihapus (audio footer) |

## Penting: Login Ini Bukan Keamanan

Login hari ini cuma menyimpan username di browser (`localStorage`). Siapa saja bisa ketik username apa saja, dan tidak ada password.

Karena belum ada login asli, aturan di Supabase kita buka supaya pengunjung boleh membaca dan menambah data. Artinya orang yang tahu URL + key project kamu sebenarnya bisa menambah data tanpa lewat dashboard.

Untuk belajar ini tidak apa-apa. Login yang aman (Supabase Auth) dikerjakan di pertemuan berikutnya. Kalau data di tabel jadi berantakan, jalankan ulang script SQL di Langkah 3 untuk mereset.

## Daftar Isi

**Bagian A — Setup Supabase (di browser)**

1. [Buat akun Supabase](#langkah-1--buat-akun-supabase)
2. [Buat project](#langkah-2--buat-project)
3. [Buat tabel dengan SQL Editor](#langkah-3--buat-tabel-dengan-sql-editor)
4. [Cek tabel di Table Editor](#langkah-4--cek-tabel-di-table-editor)
5. [Ambil Project URL dan Publishable key](#langkah-5--ambil-project-url-dan-publishable-key)

**Bagian B — Kode (di VS Code, folder `mulai-dari-kosong/`)**

6. [Siapkan folder dan salin file dari pertemuan 3](#langkah-6--siapkan-folder-dan-salin-file-dari-pertemuan-3)
7. [common.js](#langkah-7--buat-jscommonjs)
8. [Ubah index.html](#langkah-8--ubah-indexhtml)
9. [Tambah CSS navbar di style.css](#langkah-9--tambah-css-navbar-di-stylecss)
10. [app.js](#langkah-10--buat-jsappjs)
11. [Isi URL dan key, lalu tes Read](#langkah-11--isi-url-dan-key-lalu-tes-read) — **titik berhenti 1**
12. [dashboard.css](#langkah-12--buat-cssdashboardcss)
13. [Halaman login](#langkah-13--buat-halaman-login)
14. [Halaman dashboard](#langkah-14--buat-halaman-dashboard) — **titik berhenti 2**
15. [Tes alur lengkap](#langkah-15--tes-alur-lengkap)
16. [Commit](#langkah-16--commit)

Lalu: [Hasil akhir](#hasil-akhir), [Ringkasan perubahan dari pertemuan 3](#ringkasan-perubahan-dari-pertemuan-3), [Kalau error](#kalau-error), [Latihan mandiri](#latihan-mandiri).

> Tampilan website Supabase kadang berubah (letak menu, nama tombol). Kalau ada yang beda dari panduan, cari kata kuncinya (misalnya "SQL Editor", "API Keys") — fungsinya tetap sama.

---

# Bagian A — Setup Supabase

## Langkah 1 — Buat akun Supabase

1. Buka [supabase.com](https://supabase.com/).

2. Klik **Start your project** (atau **Sign in** kalau sudah punya akun).

3. Paling gampang: pilih **Continue with GitHub**, lalu izinkan.

**Cek hasil:** kamu masuk ke dashboard Supabase (halaman daftar project).

## Langkah 2 — Buat project

Project = satu "gedung" database milikmu.

1. Di dashboard, klik **New project**. Kalau diminta memilih organization, pakai yang sudah ada (biasanya berisi namamu).

2. Isi formulirnya:

   - **Name:** `website-umkm`

   - **Database Password:** klik **Generate a password** atau bikin sendiri, lalu **simpan** di tempat aman. Untuk latihan ini kita tidak memakainya di kode, tapi jangan sampai hilang.

   - **Region:** pilih yang paling dekat, misalnya **Southeast Asia (Singapore)**.

3. Klik **Create new project**.

4. Tunggu 1–2 menit. Halaman akan menampilkan proses setup, sampai project siap.

**Cek hasil:** dashboard project terbuka. Di menu kiri ada **Table Editor**, **SQL Editor**, dan **Authentication**.

## Langkah 3 — Buat tabel dengan SQL Editor

Tabel itu seperti Excel: kolom di atas, tiap baris satu data. Supaya tidak perlu klik-klik bikin kolom satu per satu, kita pakai satu script SQL. Cukup copy, paste, klik Run.

1. Di menu kiri, klik **SQL Editor**.

2. Klik **New query** (atau tombol **+**) untuk membuka kotak kosong.

3. Copy **seluruh** script di bawah (isinya sama dengan file `supabase-setup.sql` di folder `implementasi-supabase/`), lalu paste ke kotak itu.

```sql
-- ======================================================
-- supabase-setup.sql — jalankan SEKALI di Supabase > SQL Editor
-- Membuat tabel "umkm" dan mengisi 6 data awal.
-- ======================================================

-- 1. Hapus tabel lama kalau ada (supaya script ini bisa dijalankan ulang).
--    PERHATIAN: semua data di tabel umkm ikut terhapus.
drop table if exists public.umkm;

-- 2. Buat tabel. Satu baris = satu UMKM.
create table public.umkm (
  id          bigint generated always as identity primary key, -- nomor otomatis 1, 2, 3, ...
  created_at  timestamptz not null default now(),              -- waktu dibuat, diisi otomatis
  nama        text not null,
  kategori    text not null,
  alamat      text not null,
  jam         text not null,
  wa          text not null,
  foto        text not null,
  dibuat_oleh text not null default 'sistem'                   -- username yang menambahkan
);

-- 3. Aktifkan Row Level Security (RLS).
--    Setelah ini tabel DITUTUP untuk semua orang, kecuali ada policy yang mengizinkan.
alter table public.umkm enable row level security;

-- 4. Policy: boleh membaca (select) dan menambah (insert) untuk pengunjung (role "anon").
--    Sengaja terbuka karena belum ada login asli. Diperketat di pertemuan berikutnya.
create policy "umkm boleh dibaca"
  on public.umkm for select to anon
  using (true);

create policy "umkm boleh ditambah"
  on public.umkm for insert to anon
  with check (true);

-- 5. Isi data awal: 6 UMKM yang sama seperti di pertemuan 3.
insert into public.umkm (nama, kategori, alamat, jam, wa, foto) values
  ('Warung Bu Sari', 'Kuliner', 'Jl. Merdeka No. 10, Karawang', 'Buka 07.00 – 21.00', '0812-3456-7810',
   'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&q=60&auto=format&fit=crop'),
  ('Batik Karawang Asli', 'Fashion', 'Jl. Kertabumi No. 5, Karawang', 'Buka 09.00 – 17.00', '0813-2345-6705',
   'https://images.unsplash.com/photo-1761515315375-1315503bb3ce?w=400&q=60&auto=format&fit=crop'),
  ('Anyaman Bambu Pak Jaya', 'Kerajinan', 'Jl. Tuparev No. 22, Karawang', 'Buka 08.00 – 16.00', '0857-1234-9902',
   'https://images.unsplash.com/photo-1696574727184-a8cdb758d3bf?w=400&q=60&auto=format&fit=crop'),
  ('Kopi Rawa Gede', 'Kuliner', 'Jl. Ahmad Yani No. 3, Karawang', 'Buka 10.00 – 23.00', '0821-9988-2214',
   'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&q=60&auto=format&fit=crop'),
  ('Konveksi Sinar Tani', 'Fashion', 'Jl. Pangkal Perjuangan No. 18, Karawang', 'Buka 08.00 – 17.00', '0838-4567-3321',
   'https://images.unsplash.com/photo-1445205170230-053b83016050?w=400&q=60&auto=format&fit=crop'),
  ('Gerabah Cikampek', 'Kerajinan', 'Jl. Ir. H. Juanda No. 45, Karawang', 'Buka 08.00 – 16.00', '0896-7712-0043',
   'https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=400&q=60&auto=format&fit=crop');
```

4. Klik tombol **Run** (atau tekan `Ctrl + Enter`).

5. Kalau muncul peringatan soal "destructive operation" karena ada `drop table`, klik **Run this query**. Ini aman, karena tabelnya memang belum ada.

**Cek hasil:** di bagian bawah muncul tulisan **Success. No rows returned**.

Penjelasan singkat script-nya:

- `drop table if exists` — menghapus tabel `umkm` kalau sudah ada, supaya script bisa dijalankan ulang untuk reset.

- `create table` — membuat tabel. Tiap baris di dalam kurung = satu kolom (nama kolom + tipe datanya). `text` artinya teks. `id` diisi otomatis (1, 2, 3, ...) dan jadi **primary key** (pembeda unik tiap baris).

- `enable row level security` — "mengunci" tabel. Setelah dikunci, tidak ada yang boleh akses kecuali ada aturan (policy) yang mengizinkan.

- `create policy ... for select` — aturan: pengunjung (`anon`) **boleh membaca** data.

- `create policy ... for insert` — aturan: pengunjung **boleh menambah** data. Tidak ada aturan edit/hapus, jadi itu otomatis ditolak (sampai pertemuan 5).

- `insert into ... values` — mengisi 6 data awal, yaitu 6 UMKM dari pertemuan 3.

## Langkah 4 — Cek tabel di Table Editor

1. Di menu kiri, klik **Table Editor**.

2. Klik tabel **umkm**.

**Cek hasil:** ada 6 baris (Warung Bu Sari, Batik Karawang Asli, dan seterusnya) dengan kolom `id`, `created_at`, `nama`, `kategori`, `alamat`, `jam`, `wa`, `foto`, `dibuat_oleh`.

**Kalau error:** kalau tabel `umkm` tidak muncul, ulangi Langkah 3 dan pastikan seluruh script ter-copy sampai baris terakhir (`;` di ujung).

## Langkah 5 — Ambil Project URL dan Publishable key

Dua nilai ini adalah "alamat" dan "kunci" supaya website kita bisa bicara ke database.

1. Di halaman project, cari tombol **Connect** di bagian atas, lalu klik. Di situ tampil **Project URL** (bentuknya `https://abcdefgh.supabase.co`) dan **Publishable key** (diawali `sb_publishable_`).

2. Kalau tidak ketemu, buka **Project Settings** (ikon gerigi, kiri bawah). Key ada di menu **API Keys**, URL ada di menu **Data API** (atau **API**).

3. Salin keduanya ke Notepad dulu, nanti dipaste di Langkah 11.

Catatan penting:

- Di tutorial lama, **Publishable key** disebut **anon key**. Fungsinya sama. Kalau kamu hanya melihat `anon` di tab **Legacy API keys**, itu juga boleh dipakai.

- Publishable key aman dipakai di kode website, karena memang dibuat untuk publik.

- Ada juga **Secret key** (dulu `service_role`). **Jangan pernah** dipakai di kode website atau di-commit ke GitHub, karena bisa membaca dan menghapus semua data.

**Cek hasil:** kamu punya 2 teks: Project URL dan Publishable key.

---

# Bagian B — Kode

Semua file di bagian ini dibuat di dalam folder **`mulai-dari-kosong/`** (buka foldernya di VS Code).

## Langkah 6 — Siapkan folder dan salin file dari pertemuan 3

1. Di dalam `mulai-dari-kosong/`, buat 2 folder baru: **`css`** dan **`js`**.

2. Dari `pert3-code/implementasi-umkm/`, salin file berikut:

   - `index.html` -> taruh di **`mulai-dari-kosong/`** (langsung di dalam folder, sejajar dengan folder `css` dan `js`)

   - `style.css` -> taruh di **`mulai-dari-kosong/css/`**

3. File `app.js` dan `getout.mp3` dari pertemuan 3 **tidak disalin**: `app.js` ditulis ulang di Langkah 10, dan audio tidak dipakai lagi.

**Cek hasil:** struktur foldermu sekarang:

```text
mulai-dari-kosong/
├── index.html
├── css/
│   └── style.css
└── js/
```

## Langkah 7 — Buat `js/common.js`

File baru ini dipakai semua halaman. Isinya koneksi Supabase, penyimpan username login, dan pengisi navbar.

Buat file **`mulai-dari-kosong/js/common.js`**, isi dengan:

```javascript
// ======================================================
// common.js — dipakai semua halaman (file BARU di pertemuan 4)
// Isinya: koneksi Supabase, login username, dan navbar.
// ======================================================

// ---------- [BARU P4] 1. Koneksi Supabase ----------
// GANTI dua nilai ini dengan milik project Supabase kamu sendiri.
const SUPABASE_URL = "https://xxxxxxxxxxxx.supabase.co";
const SUPABASE_KEY = "sb_publishable_ISI_KEY_KAMU_DI_SINI";

// Library Supabase (dari CDN di HTML) menyediakan window.supabase
const { createClient } = window.supabase;
const supabaseClient = createClient(SUPABASE_URL, SUPABASE_KEY);

// [BARU P4] true kalau URL dan key sudah diganti (bukan nilai contoh di atas)
function konfigurasiSiap() {
  return (
    !SUPABASE_URL.includes("xxxxxxxxxxxx") && !SUPABASE_KEY.includes("ISI_KEY")
  );
}

// ---------- [BARU P4] 2. Pengaman teks ----------
// Mengubah karakter berbahaya (< > " ') jadi teks biasa, supaya data dari
// form tidak bisa menyisipkan kode HTML/JavaScript ke halaman.
function escapeHtml(teks) {
  return String(teks ?? "")
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#39;");
}

// Foto bawaan kalau pengguna tidak mengisi kolom foto
const FOTO_DEFAULT =
  "https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=400&q=60&auto=format&fit=crop";

// ---------- [BARU P4] 3. Login username ----------
// Username disimpan di localStorage (memori browser, tetap ada setelah refresh).
// Ini BUKAN keamanan sungguhan — cuma penanda "sudah login" untuk belajar.
const KUNCI_USERNAME = "usernameUmkm";

function ambilUsername() {
  return localStorage.getItem(KUNCI_USERNAME);
}

function simpanUsername(nama) {
  localStorage.setItem(KUNCI_USERNAME, nama);
}

function hapusUsername() {
  localStorage.removeItem(KUNCI_USERNAME);
}

// ---------- [BARU P4] 4. Navbar ----------
// Belum login: tampil link "Login". Sudah login: tampil "Halo, username".
function renderNavbarAuth() {
  const tempat = document.querySelector("#auth-navbar");
  if (!tempat) return;

  const username = ambilUsername();
  tempat.innerHTML = username
    ? `<a href="dashboard.html">Halo, ${escapeHtml(username)}</a>`
    : `<a href="login.html">Login</a>`;
}

renderNavbarAuth();
```

Penjelasan singkat:

- `createClient(URL, KEY)` — membuat "telepon" ke Supabase. Hasilnya disimpan di `supabaseClient`, nanti dipakai di file lain.

- `escapeHtml()` — mengubah karakter berbahaya jadi teks biasa. Penting karena data dari form nanti ditampilkan ke halaman. Tanpa ini, orang bisa menyelipkan kode jahat lewat form.

- `localStorage` — memori kecil di browser. Datanya tetap ada walau halaman di-refresh atau ditutup.

- `renderNavbarAuth()` — kalau sudah login, navbar menampilkan "Halo, username". Kalau belum, menampilkan tombol "Login".

**Cek hasil:** belum ada perubahan di halaman. Lanjut.

## Langkah 8 — Ubah `index.html`

Buka **`mulai-dari-kosong/index.html`** (hasil salinan pertemuan 3). Ada 5 perubahan kecil. Kalau mau gampang, **ganti seluruh isi file** dengan versi lengkap di bawah.

Yang berubah:

1. `<link>` CSS diganti ke `css/style.css`. (`[UBAH P4]`)

2. Span kosong di kanan header diberi id `auth-navbar`. (`[UBAH P4]`)

3. Komentar di bagian Direktori diperbarui. (`[UBAH P4]`)

4. Tag `<audio>` di footer dihapus. (`[DIBUANG P4]`)

5. Di paling bawah sebelum `</body>`: tambah library Supabase dan `js/common.js`, lalu `app.js` pindah ke `js/app.js`. Urutannya **tidak boleh ditukar**. (`[BARU P4]` dan `[UBAH P4]`)

Versi lengkap `index.html`:

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
    <!-- [UBAH P4] CSS dipindah ke folder css/ (dulu: href="style.css") -->
    <link rel="stylesheet" href="css/style.css" />
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
        <!-- [UBAH P4] dulu span kosong. Sekarang diisi js/common.js: link Login, atau nama user kalau sudah login -->
        <span id="auth-navbar"></span>
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
          style="
            background-image: url(&quot;https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=1600&q=65&auto=format&fit=crop&quot;);
          "
        ></div>
        <div
          class="hero-bg hero-bg-2"
          style="
            background-image: url(&quot;https://images.unsplash.com/photo-1533900298318-6b8da08a523e?w=1600&q=65&auto=format&fit=crop&quot;);
          "
        ></div>
        <div
          class="hero-bg hero-bg-3"
          style="
            background-image: url(&quot;https://images.unsplash.com/photo-1519996529931-28324d5a630e?w=1600&q=65&auto=format&fit=crop&quot;);
          "
        ></div>
        <div class="hero-overlay" aria-hidden="true"></div>

        <div class="hero-inner">
          <h1>Usaha warga yang layak kamu temukan.</h1>
          <p>
            Direktori usaha kecil di Karawang — warung, kerajinan, dan busana
            yang dijalankan tetangga sendiri, bukan waralaba.
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

        [UBAH P4] Kartu di .grid-umkm sekarang diambil dari Supabase
        (bukan array manual lagi) lewat js/app.js. Filter dan pencarian
        tetap jalan seperti pertemuan 3.
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

        <div class="grid-umkm"></div>

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
            <p class="testimoni-teks">
              Pesan lewat WA gampang, makanannya masih anget pas sampai. Sejak
              tahu Warung Bu Sari dari sini, jadi langganan.
            </p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">R</span>
              <div>
                <p class="testimoni-nama">Rina</p>
                <p class="testimoni-lokasi">Warga Karawang Barat</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">
              Batiknya asli buatan tangan, bukan cetak. Harganya juga jujur
              dibanding beli di pasar yang suka dikira turis.
            </p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">D</span>
              <div>
                <p class="testimoni-nama">Dedi</p>
                <p class="testimoni-lokasi">Pelanggan Batik Karawang Asli</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">
              Enak karena tinggal cari kategori Kerajinan, langsung ketemu
              kontaknya. Gak perlu tanya-tanya ke tetangga dulu.
            </p>
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
            <a
              href="https://wa.me/6281200001234"
              target="_blank"
              rel="noopener"
              aria-label="Chat WhatsApp UMKM Karawang"
              ><i class="fa-brands fa-whatsapp" aria-hidden="true"></i
            ></a>
            <a
              href="https://instagram.com/umkmkarawang"
              target="_blank"
              rel="noopener"
              aria-label="Instagram UMKM Karawang"
              ><i class="fa-brands fa-instagram" aria-hidden="true"></i
            ></a>
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
          <a href="#" aria-label="Instagram Katalog UMKM Karawang"
            ><i class="fa-brands fa-instagram" aria-hidden="true"></i
          ></a>
          <a href="#" aria-label="Facebook Katalog UMKM Karawang"
            ><i class="fa-brands fa-facebook" aria-hidden="true"></i
          ></a>
          <a href="#" aria-label="WhatsApp Katalog UMKM Karawang"
            ><i class="fa-brands fa-whatsapp" aria-hidden="true"></i
          ></a>
          <!-- [DIBUANG P4] <audio> footer (getout.mp3) tidak dipakai lagi -->
        </div>
      </div>
    </footer>

    <!-- Tombol "kembali ke atas": disembunyikan lewat CSS, dimunculkan lewat JS saat halaman sudah discroll cukup jauh -->
    <button id="ke-atas" class="ke-atas" aria-label="Kembali ke atas">
      <svg
        viewBox="0 0 24 24"
        width="20"
        height="20"
        fill="none"
        stroke="currentColor"
        stroke-width="2.5"
        stroke-linecap="round"
        stroke-linejoin="round"
      >
        <path d="M12 19V5"></path>
        <path d="M6 11l6-6 6 6"></path>
      </svg>
    </button>

    <script>
      // ---------- Navbar sembunyi saat scroll ke bawah ----------
      // Bandingkan posisi scroll sekarang dengan posisi sebelumnya:
      // kalau turun (scroll ke bawah) navbar disembunyikan, kalau naik
      // (scroll ke atas) navbar dimunculkan lagi.
      const headerEl = document.querySelector("header");
      let posisiScrollTerakhir = 0;
      window.addEventListener("scroll", () => {
        const posisiSekarang = window.scrollY;
        const scrollTurun = posisiSekarang > posisiScrollTerakhir;
        // Cuma disembunyikan kalau sudah scroll cukup jauh (80px), supaya
        // navbar tidak kedap-kedip saat baru sedikit digeser di paling atas.
        headerEl.classList.toggle(
          "sembunyi",
          scrollTurun && posisiSekarang > 80,
        );
        posisiScrollTerakhir = posisiSekarang;
      });

      // ---------- Tombol kembali ke atas ----------
      // Tombolnya cuma tampil kalau memang berguna: setelah discroll > 400px.
      const tombolKeAtas = document.getElementById("ke-atas");
      window.addEventListener("scroll", () => {
        tombolKeAtas.classList.toggle("tampil", window.scrollY > 400);
      });
      tombolKeAtas.addEventListener("click", () => {
        window.scrollTo({ top: 0, behavior: "smooth" });
      });

      // ---------- Reveal saat discroll ----------
      // IntersectionObserver mendeteksi kapan sebuah elemen masuk ke layar,
      // tanpa perlu menghitung posisi scroll secara manual.
      const revealObserver = new IntersectionObserver(
        (entries) => {
          entries.forEach((entry) => {
            if (entry.isIntersecting) {
              entry.target.classList.add("tampil");
              revealObserver.unobserve(entry.target); // cukup sekali, tidak diulang
            }
          });
        },
        { threshold: 0.12 },
      );
      document
        .querySelectorAll(".reveal")
        .forEach((el) => revealObserver.observe(el));
    </script>

    <!-- [BARU P4] Library Supabase. Harus paling dulu, sebelum common.js -->
    <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
    <!-- [BARU P4] Koneksi Supabase + login + navbar. Harus sebelum app.js -->
    <script src="js/common.js"></script>
    <!-- [UBAH P4] app.js pindah ke folder js/ (dulu: src="app.js") -->
    <script src="js/app.js"></script>
  </body>
</html>
```

**Cek hasil:** belum bisa dites penuh karena `js/app.js` belum ada. Lanjut.

## Langkah 9 — Tambah CSS navbar di `style.css`

Buka **`mulai-dari-kosong/css/style.css`**. **Jangan hapus apa pun.** Scroll ke baris paling bawah, lalu tambahkan blok ini di bawah semua kode yang sudah ada:

```css
/* ================= [BARU P4] Navbar login ================= */
/* Diisi js/common.js: link "Login", atau "Halo, username" kalau sudah login */
#auth-navbar {
  justify-self: end;
}

#auth-navbar a {
  color: var(--gold);
  text-decoration: none;
  font-weight: 600;
  font-size: 0.9rem;
  border: 1px solid var(--gold);
  padding: 6px 16px;
  border-radius: 999px;
  transition: background-color 0.2s, color 0.2s;
}

#auth-navbar a:hover,
#auth-navbar a:focus-visible {
  background-color: var(--gold);
  color: var(--matcha-abyss);
}

/* [BARU P4] Pesan error di grid UMKM (teks "Memuat..." memakai .kosong yang sudah ada) */
.grid-umkm .galat {
  color: #b3412e;
}
```

Penjelasan singkat:

- Bagian atas = gaya tombol "Login" / "Halo, username" di navbar.

- Bagian bawah = warna merah untuk pesan error di grid UMKM.

**Cek hasil:** belum ada perubahan terlihat. Lanjut.

## Langkah 10 — Buat `js/app.js`

Buat file **`mulai-dari-kosong/js/app.js`**, isi dengan:

```javascript
// ======================================================
// app.js — halaman utama (Direktori UMKM)
// Penanda: [BARU P4] ditambah, [UBAH P4] diubah, [SAMA P3] tidak berubah.
// Butuh common.js (dimuat lebih dulu di index.html).
// ======================================================

// ---------- 1. Data UMKM ----------
// [UBAH P4] Dulu: array berisi 6 UMKM ditulis manual. Sekarang kosong,
// diisi dari Supabase oleh ambilUmkm() di bawah.
let daftarUmkm = [];

// ---------- 2. Render kartu UMKM ke HTML ----------
const gridUmkm = document.querySelector(".grid-umkm");

function renderUmkm(data) {
  gridUmkm.innerHTML = "";
  if (data.length === 0) {
    gridUmkm.innerHTML = `<p class="kosong">Tidak ada UMKM yang cocok.</p>`;
    return;
  }
  data.forEach((umkm) => {
    // [UBAH P4] Semua data lewat escapeHtml() supaya aman. Teks alt dibuat dari nama.
    gridUmkm.innerHTML += `
      <article class="kartu-umkm">
        <div class="kartu-foto">
          <img src="${escapeHtml(umkm.foto)}" alt="Foto ${escapeHtml(umkm.nama)}" loading="lazy" />
          <span class="badge">${escapeHtml(umkm.kategori)}</span>
        </div>
        <div class="kartu-isi">
          <h3>${escapeHtml(umkm.nama)}</h3>
          <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>${escapeHtml(umkm.alamat)}</span></p>
          <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> ${escapeHtml(umkm.jam)}</p>
          <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> ${escapeHtml(umkm.wa)}</p>
        </div>
      </article>
    `;
  });
}

// ---------- 3. Filter kategori + pencarian nama ----------
// [SAMA P3] Tidak berubah.
const inputCari = document.querySelector(".direktori-cari");
const selectKategori = document.querySelector(".direktori-kategori");

function terapkanFilter() {
  const kataKunci = inputCari.value.toLowerCase().trim();
  const kategoriDipilih = selectKategori.value;
  const hasil = daftarUmkm.filter((umkm) => {
    const namaCocok = umkm.nama.toLowerCase().includes(kataKunci);
    const kategoriCocok = kategoriDipilih === "Semua kategori" || umkm.kategori === kategoriDipilih;
    return namaCocok && kategoriCocok;
  });
  renderUmkm(hasil);
}

inputCari.addEventListener("input", terapkanFilter);
selectKategori.addEventListener("change", terapkanFilter);

// ---------- 4. Ambil data dari Supabase ----------
// [BARU P4] Menggantikan renderUmkm(daftarUmkm) langsung dari pertemuan 3.
async function ambilUmkm() {
  // Belum isi URL/key di common.js? Beri pesan jelas, jangan lanjut.
  if (!konfigurasiSiap()) {
    gridUmkm.innerHTML = `<p class="kosong galat">Isi SUPABASE_URL dan SUPABASE_KEY dulu di js/common.js.</p>`;
    return;
  }

  gridUmkm.innerHTML = `<p class="kosong">Memuat data...</p>`;

  // Supabase selalu membalas { data, error }: salah satunya terisi, satunya null
  const { data, error } = await supabaseClient
    .from("umkm")
    .select("*")
    .order("id", { ascending: true });

  if (error) {
    console.error("Gagal mengambil data:", error);
    gridUmkm.innerHTML = `<p class="kosong galat">Gagal mengambil data. Buka Console (F12) untuk detailnya.</p>`;
    return;
  }

  daftarUmkm = data;
  terapkanFilter(); // tampilkan, sekalian ikut aturan filter yang sedang aktif
}

ambilUmkm();

// ---------- 5. Validasi form kontak ----------
// [SAMA P3] Tidak berubah. Form kontak sengaja belum dihubungkan ke Supabase.
const formKontak = document.querySelector("#kontak form");

formKontak.addEventListener("submit", (event) => {
  event.preventDefault();
  const nama = document.querySelector("#nama").value;
  const pesan = document.querySelector("#pesan").value;
  if (nama.trim() === "" || pesan.trim() === "") {
    alert("Nama dan pesan tidak boleh kosong!");
    return;
  }
  console.log("Pesan terkirim:", { nama, pesan });
  alert("Terima kasih, " + nama + "! Pesanmu sudah tercatat di console.");
  formKontak.reset();
});
```

Penjelasan singkat:

- `let daftarUmkm = []` — dulu berisi 6 UMKM yang ditulis manual. Sekarang kosong dulu, diisi dari Supabase. Pakai `let` (bukan `const`) karena isinya akan diganti.

- `async` / `await` — tanda bahwa mengambil data lewat internet butuh waktu. `await` artinya "tunggu sampai selesai dulu, baru lanjut ke baris berikutnya".

- `{ data, error }` — Supabase selalu membalas dua kemungkinan: `data` kalau berhasil, `error` kalau gagal. Selalu cek `error` dulu.

- `.from("umkm").select("*")` — "ambil semua kolom dari tabel umkm". `.order("id")` — urutkan dari id kecil ke besar.

- Setelah data masuk ke `daftarUmkm`, fungsi `terapkanFilter()` dari pertemuan 3 dipanggil. Jadi filter dan pencarian tetap jalan seperti biasa.

## Langkah 11 — Isi URL dan key, lalu tes Read

1. Buka **`js/common.js`**. Ganti dua baris ini dengan milikmu dari Langkah 5:

```javascript
const SUPABASE_URL = "https://xxxxxxxxxxxx.supabase.co";
const SUPABASE_KEY = "sb_publishable_ISI_KEY_KAMU_DI_SINI";
```

   Hasilnya kira-kira begini (ini hanya contoh, pakai punyamu sendiri):

```javascript
const SUPABASE_URL = "https://abcdefghijkl.supabase.co";
const SUPABASE_KEY = "sb_publishable_AbCdEf123456...";
```

2. Buka `index.html` dengan **Live Server** (klik kanan file -> **Open with Live Server**).

3. Buka Console: tekan `F12`, pilih tab **Console**.

**Cek hasil:**

- Di bagian Direktori muncul 6 kartu UMKM, sama seperti pertemuan 3. Bedanya, sekarang datanya dari Supabase.

- Coba filter kategori dan pencarian — masih jalan.

- Tidak ada tulisan merah di Console.

- Tombol **Login** di navbar muncul. Kalau diklik masih error 404, itu wajar karena halaman login belum dibuat.

Buktikan data benar-benar dari database: di Supabase **Table Editor**, ubah nama salah satu UMKM, lalu refresh websitemu. Nama di kartu ikut berubah.

**Kalau error:** lihat bagian [Kalau error](#kalau-error) di bawah.

> **Titik berhenti 1.** Sampai sini kamu sudah punya website yang membaca data dari database (Read). Kalau waktu kelas habis, boleh berhenti di sini.

## Langkah 12 — Buat `css/dashboard.css`

File CSS terpisah khusus halaman login dan dashboard, supaya `style.css` halaman utama tidak ikut membengkak. Buat file **`mulai-dari-kosong/css/dashboard.css`**, isi dengan:

```css
/* ======================================================
   dashboard.css — gaya halaman login dan dashboard
   (file BARU di pertemuan 4). Dimuat SETELAH style.css.
   Warna dan font mengikuti tema website (variabel di style.css).
   ====================================================== */

/* Dashboard disembunyikan sampai dashboard.js selesai cek login */
body.belum-dicek {
  display: none;
}

/* ---------- Pesan status ---------- */
.status {
  min-height: 1.4em;
  font-size: 0.9rem;
}

.status.status-galat {
  color: #b3412e;
}

.status.status-ok {
  color: #3f6b34;
}

/* ---------- Form bergaya terang (dipakai login dan form tambah UMKM) ----------
   "form.form-terang ..." sengaja ditulis spesifik supaya menang dari gaya form
   gelap bawaan di style.css (yang dibuat untuk section Kontak). */
form.form-terang label {
  color: var(--matcha-dark);
  text-transform: none;
  letter-spacing: 0;
  font-size: 0.88rem;
  font-weight: 700;
}

form.form-terang input,
form.form-terang select {
  background: white;
  border: 1px solid #ddd6c4;
  border-radius: 12px;
  color: var(--ink);
  padding: 12px 14px;
  font-family: inherit;
  font-size: 0.95rem;
  transition: border-color 0.2s, box-shadow 0.2s;
}

form.form-terang input::placeholder {
  color: #9aa595;
}

form.form-terang input:focus,
form.form-terang select:focus {
  outline: none;
  border-color: var(--gold);
  box-shadow: 0 0 0 3px rgba(201, 166, 107, 0.25);
}

/* Tombol sekunder (Batal): garis tepi, bukan emas penuh */
.tombol-sekunder,
button.tombol-sekunder {
  background: transparent;
  color: var(--matcha-dark);
  border: 1px solid #cfc8b3;
}

/* ======================================================
   HALAMAN LOGIN
   ====================================================== */
.login-split {
  min-height: 100vh;
  display: grid;
  grid-template-columns: minmax(0, 1.05fr) minmax(0, 1fr);
}

/* ----- Kiri: visual ----- */
.login-visual {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  gap: 32px;
  padding: 48px;
  color: white;
  background:
    linear-gradient(160deg, rgba(30, 42, 24, 0.86), rgba(30, 42, 24, 0.95)),
    url("https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=1400&q=65&auto=format&fit=crop")
      center / cover;
}

.login-merek {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  align-self: flex-start;
  font-weight: 800;
  font-size: 1.2rem;
  color: white;
  text-decoration: none;
}

.login-merek i {
  color: var(--gold);
}

.login-visual h2 {
  font-size: clamp(1.8rem, 3vw, 2.6rem);
  line-height: 1.15;
  max-width: 16ch;
  margin-bottom: 14px;
}

.login-visual p {
  color: var(--sage-pale);
  max-width: 38ch;
}

.login-poin {
  list-style: none;
  display: grid;
  gap: 12px;
  margin-top: 28px;
  color: var(--sage-pale);
  font-size: 0.95rem;
}

.login-poin i {
  color: var(--gold);
  margin-right: 8px;
}

.login-visual .login-hak {
  font-size: 0.82rem;
  color: var(--matcha-mid);
}

/* ----- Kanan: form ----- */
.login-panel {
  display: flex;
  flex-direction: column;
  padding: 28px 48px;
  background-color: var(--cream);
}

.login-kembali {
  align-self: flex-start;
  color: var(--matcha-dark);
  font-weight: 600;
  font-size: 0.9rem;
  text-decoration: none;
}

.login-kembali i {
  margin-right: 6px;
}

.login-kembali:hover,
.login-kembali:focus-visible {
  color: var(--gold);
}

.login-isi {
  flex: 1;
  display: grid;
  place-items: center;
  padding: 24px 0;
}

.login-kartu {
  width: min(400px, 100%);
}

.login-logo {
  width: 52px;
  height: 52px;
  border-radius: 14px;
  background-color: var(--matcha-abyss);
  color: var(--gold);
  display: grid;
  place-items: center;
  font-size: 1.3rem;
  margin-bottom: 20px;
}

.login-kartu h1 {
  font-size: 1.9rem;
  color: var(--matcha-dark);
  margin-bottom: 8px;
}

.login-sub {
  color: #5b6b52;
  margin-bottom: 26px;
}

.login-kartu form {
  gap: 10px;
}

.login-kartu .status {
  margin-top: 14px;
}

/* Tombol selebar form */
.tombol-penuh {
  align-self: stretch;
  width: 100%;
  margin-top: 8px;
  padding: 14px 24px;
}

.tombol-penuh i {
  margin-left: 6px;
}

/* ======================================================
   DASHBOARD: layout sidebar + konten
   ====================================================== */
.layout {
  display: grid;
  grid-template-columns: 260px minmax(0, 1fr);
  min-height: 100vh;
}

/* ----- Sidebar ----- */
.sidebar {
  position: sticky;
  top: 0;
  height: 100vh;
  display: flex;
  flex-direction: column;
  padding: 24px 16px;
  background-color: var(--matcha-abyss);
  color: var(--sage-pale);
}

.sidebar-merek {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 4px 10px 24px;
  font-weight: 800;
  font-size: 1.15rem;
  color: white;
  text-decoration: none;
}

.sidebar-merek i {
  color: var(--gold);
}

.sidebar-menu {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

/* ".menu-item" dipakai untuk <button> maupun <a>, jadi gaya tombol bawaan perlu ditimpa */
.menu-item {
  display: flex;
  align-items: center;
  gap: 12px;
  width: 100%;
  padding: 12px 14px;
  background: transparent;
  color: var(--sage-pale);
  border: none;
  border-radius: 10px;
  font-family: inherit;
  font-size: 0.95rem;
  font-weight: 600;
  text-align: left;
  text-decoration: none;
  cursor: pointer;
  transition: background-color 0.2s, color 0.2s;
}

.menu-item i {
  width: 18px;
  text-align: center;
  color: var(--matcha-mid);
  transition: color 0.2s;
}

.menu-item:hover,
.menu-item:focus-visible {
  background-color: rgba(255, 255, 255, 0.07);
  transform: none;
}

.menu-item.aktif {
  background-color: var(--matcha-dark);
  color: white;
}

.menu-item.aktif i {
  color: var(--gold);
}

/* ----- Info user + logout (nempel di bawah sidebar) ----- */
.sidebar-user {
  margin-top: auto;
  padding-top: 18px;
  border-top: 1px solid #34432c;
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.sidebar-profil {
  display: flex;
  align-items: center;
  gap: 12px;
  min-width: 0;
}

.sidebar-profil > div {
  display: flex;
  flex-direction: column;
  min-width: 0;
}

.sidebar-profil small {
  color: var(--matcha-mid);
  font-size: 0.75rem;
}

.sidebar-profil strong {
  color: white;
  font-size: 0.95rem;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.avatar {
  flex-shrink: 0;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: var(--gold);
  color: var(--matcha-abyss);
  display: grid;
  place-items: center;
  font-weight: 800;
}

.tombol-logout {
  align-self: stretch;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 11px 16px;
  background: transparent;
  color: var(--sage-pale);
  border: 1px solid var(--matcha-mid);
  font-size: 0.9rem;
}

.tombol-logout:hover,
.tombol-logout:focus-visible {
  background-color: rgba(255, 255, 255, 0.07);
}

/* ----- Konten ----- */
.konten {
  min-width: 0;
}

.topbar {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 22px 36px;
  background-color: var(--cream);
  border-bottom: 1px solid #e8e3d2;
}

.topbar h1 {
  font-size: 1.5rem;
  color: var(--matcha-dark);
}

/* Tombol hamburger: hanya muncul di layar HP */
.tombol-menu {
  display: none;
  place-items: center;
  width: 42px;
  height: 42px;
  padding: 0;
  background-color: var(--matcha-abyss);
  color: var(--gold);
  border-radius: 12px;
  font-size: 1.05rem;
}

.dashboard {
  max-width: 1100px;
  padding: 28px 36px 56px;
}

/* ----- Kartu statistik ----- */
.statistik {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
  gap: 16px;
  margin-bottom: 24px;
}

.stat {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 18px;
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 14px;
}

.stat-ikon {
  flex-shrink: 0;
  width: 46px;
  height: 46px;
  border-radius: 12px;
  background-color: var(--sage-pale);
  color: var(--matcha-dark);
  display: grid;
  place-items: center;
  font-size: 1.1rem;
}

.stat strong {
  display: block;
  font-size: 1.7rem;
  line-height: 1.1;
  color: var(--matcha-dark);
}

.stat div span {
  font-size: 0.85rem;
  color: var(--matcha-mid);
}

/* ----- Kartu umum + tabel ----- */
.kartu {
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 16px;
  padding: 24px;
}

.kartu-kepala {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  margin-bottom: 16px;
}

.kartu h2 {
  font-size: 1.15rem;
  color: var(--matcha-dark);
}

.kartu-sub {
  color: #5b6b52;
  margin: 6px 0 22px;
}

/* Label kecil berbentuk pil (jumlah, kategori) */
.pil {
  display: inline-block;
  padding: 3px 12px;
  border-radius: 999px;
  background-color: var(--sage-pale);
  color: var(--matcha-dark);
  font-size: 0.8rem;
  font-weight: 700;
}

/* overflow-x: auto -> tabel bisa digeser ke samping di layar sempit */
.tabel-bungkus {
  overflow-x: auto;
}

table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.9rem;
}

th {
  text-align: left;
  font-size: 0.75rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: var(--matcha-mid);
  padding: 10px 12px;
  border-bottom: 1px solid #e5e7eb;
  white-space: nowrap;
}

td {
  padding: 12px;
  border-bottom: 1px solid #f0efe6;
  vertical-align: middle;
}

tr:last-child td {
  border-bottom: none;
}

td.galat {
  color: #b3412e;
}

td strong {
  display: block;
  color: var(--ink);
}

td small {
  display: block;
  color: var(--matcha-mid);
  font-size: 0.8rem;
}

.foto-kecil {
  display: block;
  width: 46px;
  height: 46px;
  border-radius: 10px;
  object-fit: cover;
  background-color: var(--sage-pale);
}

/* ----- Form tambah UMKM ----- */
.kartu-form {
  max-width: 760px;
}

.form-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 18px 20px;
}

.kolom {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.kolom-lebar {
  grid-column: 1 / -1;
}

.form-aksi {
  display: flex;
  gap: 12px;
  margin-top: 4px;
}

.kartu-form .status {
  margin-top: 16px;
}

/* ----- Toast: pesan singkat di pojok kanan bawah ----- */
.toast {
  position: fixed;
  right: 24px;
  bottom: 24px;
  max-width: calc(100vw - 48px);
  padding: 14px 20px;
  background-color: var(--matcha-abyss);
  color: white;
  border-left: 4px solid var(--gold);
  border-radius: 12px;
  font-size: 0.92rem;
  box-shadow: 0 12px 28px rgba(30, 42, 24, 0.25);
  opacity: 0;
  transform: translateY(12px);
  pointer-events: none;
  transition: opacity 0.25s, transform 0.25s;
  z-index: 50;
}

.toast.tampil {
  opacity: 1;
  transform: none;
}

/* Lapisan gelap di belakang sidebar (dipakai di layar HP) */
.sidebar-lapisan {
  display: none;
}

/* ======================================================
   LAYAR SEMPIT (tablet ke bawah)
   ====================================================== */
@media (max-width: 860px) {
  /* Login: satu kolom, sisi visual jadi banner pendek di atas */
  .login-split {
    grid-template-columns: minmax(0, 1fr);
    grid-template-rows: auto 1fr;
  }

  .login-visual {
    padding: 24px;
    gap: 16px;
  }

  .login-visual h2 {
    font-size: 1.5rem;
    max-width: none;
  }

  .login-poin,
  .login-visual .login-hak {
    display: none;
  }

  .login-panel {
    padding: 20px 24px 28px;
  }

  /* Dashboard: sidebar jadi menu geser dari kiri */
  .layout {
    grid-template-columns: minmax(0, 1fr);
  }

  .sidebar {
    position: fixed;
    top: 0;
    left: 0;
    bottom: 0;
    width: 270px;
    z-index: 40;
    transform: translateX(-100%);
    transition: transform 0.25s ease;
  }

  .sidebar.terbuka {
    transform: none;
  }

  .sidebar-lapisan.tampil {
    display: block;
    position: fixed;
    inset: 0;
    background-color: rgba(0, 0, 0, 0.45);
    z-index: 30;
  }

  .tombol-menu {
    display: grid;
  }

  .topbar {
    padding: 16px 20px;
  }

  .dashboard {
    padding: 20px 20px 48px;
  }

  .form-grid {
    grid-template-columns: minmax(0, 1fr);
  }

  .kartu {
    padding: 18px;
  }

  /* Kartu statistik jadi 2 kolom supaya tidak memanjang ke bawah */
  .statistik {
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 12px;
  }

  .stat {
    padding: 14px;
    gap: 10px;
  }

  .stat-ikon {
    width: 40px;
    height: 40px;
  }

  .stat strong {
    font-size: 1.4rem;
  }
}
```

Penjelasan singkat:

- Warna dan font memakai variabel dari `style.css` (`--matcha-abyss`, `--gold`, dst), jadi tampilannya otomatis sama dengan tema website.

- `.layout` memakai **CSS Grid** dua kolom: sidebar 260px di kiri, sisanya untuk konten.

- `position: sticky` pada `.sidebar` membuatnya tetap menempel di kiri walau konten di-scroll.

- Di layar kecil (`@media (max-width: 860px)`), sidebar disembunyikan ke kiri layar (`transform: translateX(-100%)`) dan muncul lagi saat tombol menu ditekan.

- `form.form-terang ...` sengaja ditulis spesifik supaya mengalahkan gaya form gelap bawaan section Kontak di `style.css`.

**Cek hasil:** belum ada perubahan terlihat. Lanjut.

## Langkah 13 — Buat halaman login

Dua file baru.

**1. `mulai-dari-kosong/login.html`** (sejajar dengan `index.html`):

```html
<!doctype html>
<!-- [BARU P4] Halaman baru: login pakai username saja -->
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login — Katalog UMKM Karawang</title>

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />
    <!-- Font Awesome: ikon di halaman login -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />

    <!-- style.css dulu (gaya dasar), baru dashboard.css (gaya khusus halaman ini) -->
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/dashboard.css" />
  </head>
  <body>
    <main class="login-split">
      <!-- Kiri: sisi visual (disembunyikan sebagian di layar HP) -->
      <section class="login-visual">
        <a class="login-merek" href="index.html">
          <i class="fa-solid fa-store" aria-hidden="true"></i> UMKM Karawang
        </a>

        <div>
          <h2>Kelola usaha warga Karawang di satu tempat.</h2>
          <p>Masuk untuk menambah UMKM baru ke direktori.</p>
          <ul class="login-poin">
            <li><i class="fa-solid fa-check" aria-hidden="true"></i> Data tersimpan di database Supabase</li>
            <li><i class="fa-solid fa-check" aria-hidden="true"></i> Langsung tampil di halaman Direktori</li>
            <li><i class="fa-solid fa-check" aria-hidden="true"></i> Login cukup pakai username</li>
          </ul>
        </div>

        <p class="login-hak">&copy; 2026 Katalog UMKM Karawang</p>
      </section>

      <!-- Kanan: form login -->
      <section class="login-panel">
        <a class="login-kembali" href="index.html">
          <i class="fa-solid fa-arrow-left" aria-hidden="true"></i> Kembali ke Home
        </a>

        <div class="login-isi">
          <div class="login-kartu">
            <span class="login-logo"><i class="fa-solid fa-store" aria-hidden="true"></i></span>
            <h1>Selamat datang</h1>
            <p class="login-sub">Isi username bebas, tidak perlu password.</p>

            <form id="form-login" class="form-terang">
              <label for="username">Username</label>
              <input
                type="text"
                id="username"
                name="username"
                maxlength="20"
                autocomplete="off"
                placeholder="contoh: budi"
              />
              <button type="submit" class="tombol-penuh">
                Masuk <i class="fa-solid fa-arrow-right" aria-hidden="true"></i>
              </button>
            </form>

            <p id="pesan-login" class="status status-galat" role="alert"></p>
          </div>
        </div>
      </section>
    </main>

    <!-- Urutan wajib: library Supabase -> common.js -> login.js -->
    <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
    <script src="js/common.js"></script>
    <script src="js/login.js"></script>
  </body>
</html>
```

**2. `mulai-dari-kosong/js/login.js`:**

```javascript
// ======================================================
// login.js — halaman login (file BARU di pertemuan 4)
// Login cuma pakai username, tanpa password. Butuh common.js.
// ======================================================

// Sudah login? Langsung ke dashboard, tidak perlu isi lagi.
if (ambilUsername()) {
  location.replace("dashboard.html");
}

const formLogin = document.querySelector("#form-login");
const pesanLogin = document.querySelector("#pesan-login");

formLogin.addEventListener("submit", (event) => {
  event.preventDefault();

  const username = document.querySelector("#username").value.trim();

  if (username === "") {
    pesanLogin.textContent = "Username tidak boleh kosong.";
    return;
  }

  simpanUsername(username);
  location.href = "dashboard.html";
});
```

Penjelasan singkat:

- Halaman login memenuhi satu layar penuh dan dibagi dua kolom: kiri visual bertema hijau, kanan form. Di layar HP, kolom kiri berubah jadi banner pendek di atas.

- Ikon (toko, panah, centang) memakai **Font Awesome** dari CDN, sama seperti di halaman utama. Kalau ikon tidak muncul, cek koneksi internetmu.

- Form login punya satu kolom saja: username.

- Kalau username kosong, muncul pesan error. Kalau terisi, username disimpan lewat `simpanUsername()` (dari `common.js`), lalu pindah ke dashboard.

- `location.replace(...)` dipakai kalau sudah login, supaya tombol Back tidak membawa balik ke halaman login.

**Cek hasil:** di `index.html` klik **Login** di navbar. Halaman login tampil. Klik **Masuk** tanpa isi apa-apa -> muncul "Username tidak boleh kosong." (Kalau kamu isi username, akan menuju dashboard yang belum dibuat. Itu normal.)

## Langkah 14 — Buat halaman dashboard

Dua file baru lagi.

**1. `mulai-dari-kosong/dashboard.html`** (sejajar dengan `index.html`):

```html
<!doctype html>
<!-- [BARU P4] Halaman baru: dashboard dengan sidebar (daftar UMKM + tambah UMKM) -->
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard — Katalog UMKM Karawang</title>

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />

    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/dashboard.css" />
  </head>

  <!-- class "belum-dicek" menyembunyikan halaman. dashboard.js menghapusnya setelah cek login lolos -->
  <body class="belum-dicek">
    <div class="layout">
      <!-- ========== SIDEBAR ========== -->
      <aside class="sidebar" id="sidebar">
        <a class="sidebar-merek" href="index.html">
          <i class="fa-solid fa-store" aria-hidden="true"></i> UMKM Karawang
        </a>

        <nav class="sidebar-menu" aria-label="Menu dashboard">
          <!-- Dua tombol ini mengganti tampilan di sebelah kanan (lihat dashboard.js) -->
          <button type="button" class="menu-item aktif" data-view="daftar">
            <i class="fa-solid fa-table-list" aria-hidden="true"></i> Daftar UMKM
          </button>
          <button type="button" class="menu-item" data-view="tambah">
            <i class="fa-solid fa-plus" aria-hidden="true"></i> Tambah UMKM
          </button>
          <a class="menu-item" href="index.html">
            <i class="fa-solid fa-house" aria-hidden="true"></i> Home
          </a>
        </nav>

        <!-- Info user + Logout di bagian bawah sidebar -->
        <div class="sidebar-user">
          <div class="sidebar-profil">
            <span class="avatar" id="avatar-user"></span>
            <div>
              <small>Masuk sebagai</small>
              <strong id="nama-user"></strong>
            </div>
          </div>
          <button type="button" id="tombol-logout" class="tombol-logout">
            <i class="fa-solid fa-right-from-bracket" aria-hidden="true"></i> Logout
          </button>
        </div>
      </aside>

      <!-- Lapisan gelap di belakang sidebar (hanya muncul di layar HP) -->
      <div class="sidebar-lapisan" id="lapisan-sidebar"></div>

      <!-- ========== KONTEN ========== -->
      <div class="konten">
        <div class="topbar">
          <button type="button" id="tombol-menu" class="tombol-menu" aria-label="Buka menu">
            <i class="fa-solid fa-bars" aria-hidden="true"></i>
          </button>
          <h1 id="judul-halaman">Daftar UMKM</h1>
        </div>

        <main class="dashboard">
          <!-- Tampilan 1: ringkasan + tabel daftar UMKM (Read) -->
          <section class="view" id="view-daftar">
            <div class="statistik" id="statistik"></div>

            <div class="kartu">
              <div class="kartu-kepala">
                <h2>Semua UMKM</h2>
                <span class="pil" id="jumlah-umkm"></span>
              </div>
              <div class="tabel-bungkus">
                <table>
                  <thead>
                    <tr>
                      <th>Foto</th>
                      <th>Usaha</th>
                      <th>Kategori</th>
                      <th>Jam buka</th>
                      <th>WA</th>
                      <th>Ditambah oleh</th>
                    </tr>
                  </thead>
                  <tbody id="tubuh-tabel"></tbody>
                </table>
              </div>
            </div>
          </section>

          <!-- Tampilan 2: form tambah UMKM (Create) -->
          <section class="view" id="view-tambah" hidden>
            <div class="kartu kartu-form">
              <h2>Tambah UMKM baru</h2>
              <p class="kartu-sub">Data langsung tersimpan di Supabase dan tampil di halaman Direktori.</p>

              <form id="form-umkm" class="form-terang form-grid">
                <div class="kolom">
                  <label for="nama">Nama usaha</label>
                  <input type="text" id="nama" placeholder="Warung Bu Sari" />
                </div>

                <div class="kolom">
                  <label for="kategori">Kategori</label>
                  <select id="kategori">
                    <option>Kuliner</option>
                    <option>Fashion</option>
                    <option>Kerajinan</option>
                  </select>
                </div>

                <div class="kolom kolom-lebar">
                  <label for="alamat">Alamat</label>
                  <input type="text" id="alamat" placeholder="Jl. Merdeka No. 10, Karawang" />
                </div>

                <div class="kolom">
                  <label for="jam">Jam buka</label>
                  <input type="text" id="jam" placeholder="Buka 07.00 – 21.00" />
                </div>

                <div class="kolom">
                  <label for="wa">Nomor WA</label>
                  <input type="text" id="wa" placeholder="0812-3456-7890" />
                </div>

                <div class="kolom kolom-lebar">
                  <label for="foto">Link foto (boleh dikosongkan)</label>
                  <input type="text" id="foto" placeholder="https://..." />
                </div>

                <div class="form-aksi kolom-lebar">
                  <button type="submit">Simpan</button>
                  <button type="button" id="tombol-batal" class="tombol-sekunder">Batal</button>
                </div>
              </form>

              <p id="status-form" class="status" role="status"></p>
            </div>
          </section>
        </main>
      </div>
    </div>

    <!-- Pesan singkat di pojok kanan bawah (muncul sebentar setelah berhasil menyimpan) -->
    <div id="toast" class="toast" role="status"></div>

    <!-- Urutan wajib: library Supabase -> common.js -> dashboard.js -->
    <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
    <script src="js/common.js"></script>
    <script src="js/dashboard.js"></script>
  </body>
</html>
```

**2. `mulai-dari-kosong/js/dashboard.js`:**

```javascript
// ======================================================
// dashboard.js — halaman dashboard (file BARU di pertemuan 4)
// Fitur: sidebar, ringkasan + daftar UMKM (Read), tambah UMKM (Create).
// Butuh common.js.
// ======================================================

// [BARU P4] Penjaga login: belum login langsung ditendang ke halaman login.
if (!ambilUsername()) {
  location.replace("login.html");
} else {
  mulaiDashboard();
}

function mulaiDashboard() {
  // Lolos cek login, baru tampilkan halaman (sebelumnya disembunyikan CSS)
  document.body.classList.remove("belum-dicek");

  const username = ambilUsername();
  document.querySelector("#nama-user").textContent = username;
  document.querySelector("#avatar-user").textContent = username.charAt(0).toUpperCase();

  const formUmkm = document.querySelector("#form-umkm");
  const statusForm = document.querySelector("#status-form");
  const tubuhTabel = document.querySelector("#tubuh-tabel");
  const statistik = document.querySelector("#statistik");
  const jumlahUmkm = document.querySelector("#jumlah-umkm");
  const judulHalaman = document.querySelector("#judul-halaman");
  const sidebar = document.querySelector("#sidebar");
  const lapisanSidebar = document.querySelector("#lapisan-sidebar");
  const toast = document.querySelector("#toast");

  // ---------- Sidebar: ganti tampilan (Daftar / Tambah) ----------
  function bukaTampilan(nama) {
    document.querySelectorAll(".view").forEach((view) => {
      view.hidden = view.id !== "view-" + nama;
    });
    document.querySelectorAll(".menu-item[data-view]").forEach((tombol) => {
      tombol.classList.toggle("aktif", tombol.dataset.view === nama);
    });
    judulHalaman.textContent = nama === "daftar" ? "Daftar UMKM" : "Tambah UMKM";
    tutupSidebar();
  }

  document.querySelectorAll(".menu-item[data-view]").forEach((tombol) => {
    tombol.addEventListener("click", () => bukaTampilan(tombol.dataset.view));
  });

  // ---------- Sidebar di layar HP: buka / tutup ----------
  function tutupSidebar() {
    sidebar.classList.remove("terbuka");
    lapisanSidebar.classList.remove("tampil");
  }

  document.querySelector("#tombol-menu").addEventListener("click", () => {
    sidebar.classList.add("terbuka");
    lapisanSidebar.classList.add("tampil");
  });
  lapisanSidebar.addEventListener("click", tutupSidebar);
  document.addEventListener("keydown", (event) => {
    if (event.key === "Escape") tutupSidebar();
  });

  // ---------- Logout ----------
  document.querySelector("#tombol-logout").addEventListener("click", () => {
    hapusUsername();
    location.replace("login.html");
  });

  // ---------- Toast: pesan singkat yang hilang sendiri ----------
  let waktuToast;
  function tampilToast(pesan) {
    toast.textContent = pesan;
    toast.classList.add("tampil");
    clearTimeout(waktuToast);
    waktuToast = setTimeout(() => toast.classList.remove("tampil"), 3500);
  }

  // ---------- Read: ringkasan + tabel daftar UMKM ----------
  function renderStatistik(data) {
    const hitung = (kategori) => data.filter((umkm) => umkm.kategori === kategori).length;
    const kartu = [
      ["fa-store", "Total UMKM", data.length],
      ["fa-utensils", "Kuliner", hitung("Kuliner")],
      ["fa-shirt", "Fashion", hitung("Fashion")],
      ["fa-hands", "Kerajinan", hitung("Kerajinan")],
    ];
    statistik.innerHTML = kartu
      .map(
        ([ikon, label, jumlah]) => `
        <div class="stat">
          <span class="stat-ikon"><i class="fa-solid ${ikon}" aria-hidden="true"></i></span>
          <div><strong>${jumlah}</strong><span>${label}</span></div>
        </div>`,
      )
      .join("");
  }

  async function muatTabel() {
    if (!konfigurasiSiap()) {
      tubuhTabel.innerHTML = `<tr><td colspan="6" class="galat">Isi SUPABASE_URL dan SUPABASE_KEY dulu di js/common.js.</td></tr>`;
      return;
    }

    tubuhTabel.innerHTML = `<tr><td colspan="6">Memuat data...</td></tr>`;

    const { data, error } = await supabaseClient
      .from("umkm")
      .select("*")
      .order("id", { ascending: true });

    if (error) {
      console.error("Gagal mengambil data:", error);
      tubuhTabel.innerHTML = `<tr><td colspan="6" class="galat">Gagal mengambil data. Buka Console (F12).</td></tr>`;
      return;
    }

    renderStatistik(data);
    jumlahUmkm.textContent = data.length + " usaha";
    tubuhTabel.innerHTML = data
      .map(
        (umkm) => `
        <tr>
          <td><img class="foto-kecil" src="${escapeHtml(umkm.foto)}" alt="" loading="lazy" /></td>
          <td><strong>${escapeHtml(umkm.nama)}</strong><small>${escapeHtml(umkm.alamat)}</small></td>
          <td><span class="pil">${escapeHtml(umkm.kategori)}</span></td>
          <td>${escapeHtml(umkm.jam)}</td>
          <td>${escapeHtml(umkm.wa)}</td>
          <td>${escapeHtml(umkm.dibuat_oleh)}</td>
        </tr>`,
      )
      .join("");
  }

  // ---------- Create: simpan UMKM baru ----------
  function tampilStatus(pesan, jenis) {
    statusForm.textContent = pesan;
    statusForm.className = "status status-" + jenis; // "ok" atau "galat"
  }

  function kosongkanForm() {
    formUmkm.reset();
    statusForm.textContent = "";
    statusForm.className = "status";
  }

  document.querySelector("#tombol-batal").addEventListener("click", () => {
    kosongkanForm();
    bukaTampilan("daftar");
  });

  formUmkm.addEventListener("submit", async (event) => {
    event.preventDefault();

    // Cek login lagi, jaga-jaga sesi sudah hilang (mis. logout di tab lain)
    if (!ambilUsername()) {
      location.replace("login.html");
      return;
    }

    if (!konfigurasiSiap()) {
      tampilStatus("Isi SUPABASE_URL dan SUPABASE_KEY dulu di js/common.js.", "galat");
      return;
    }

    const nama = document.querySelector("#nama").value.trim();
    const kategori = document.querySelector("#kategori").value;
    const alamat = document.querySelector("#alamat").value.trim();
    const jam = document.querySelector("#jam").value.trim();
    const wa = document.querySelector("#wa").value.trim();
    const foto = document.querySelector("#foto").value.trim();

    if (nama === "" || alamat === "" || jam === "" || wa === "") {
      tampilStatus("Nama, alamat, jam, dan WA wajib diisi.", "galat");
      return;
    }

    // insert() menerima array of object, walau cuma satu baris
    const { error } = await supabaseClient.from("umkm").insert([
      {
        nama: nama,
        kategori: kategori,
        alamat: alamat,
        jam: jam,
        wa: wa,
        foto: foto || FOTO_DEFAULT, // kosong -> pakai foto bawaan
        dibuat_oleh: ambilUsername(),
      },
    ]);

    if (error) {
      console.error("Gagal menyimpan data:", error);
      tampilStatus("Gagal menyimpan. Buka Console (F12) untuk detailnya.", "galat");
      return;
    }

    kosongkanForm();
    bukaTampilan("daftar"); // kembali ke daftar supaya data baru langsung kelihatan
    await muatTabel(); // muat ulang tabel + ringkasan
    tampilToast("UMKM berhasil ditambahkan!");
  });

  muatTabel();
}
```

Penjelasan singkat:

- **Sidebar** di kiri berisi menu **Daftar UMKM**, **Tambah UMKM**, **Home**, dan di bagian bawah nama user + tombol **Logout**. Dua menu pertama tidak pindah halaman: `dashboard.js` cuma menyembunyikan satu tampilan dan menampilkan yang lain.

- Di layar HP, sidebar bersembunyi. Tombol menu (tiga garis) di pojok kiri atas membukanya, dan ia menutup lagi saat kamu memilih menu atau menekan area gelap.

- Kartu ringkasan di atas tabel (Total, Kuliner, Fashion, Kerajinan) dihitung dari data yang diambil, jadi angkanya ikut berubah saat ada UMKM baru.

- Setelah berhasil menyimpan, kamu dikembalikan ke daftar dan muncul pesan singkat ("toast") di pojok kanan bawah.

- **Penjaga login** ada di bagian paling atas `dashboard.js`: kalau belum ada username, langsung `location.replace("login.html")`. Halaman dashboard juga disembunyikan lewat CSS (`belum-dicek`) sampai pengecekan lolos, jadi isinya tidak sempat kelihatan.

- Sebelum menyimpan data, login dicek lagi. Jadi kalau username terhapus di tengah jalan, kamu tetap ditendang ke halaman login.

- `.insert([{ ... }])` — menambah baris baru ke tabel. Isinya harus **array** (tanda `[ ]`), walau cuma satu baris.

- Kolom `dibuat_oleh` diisi otomatis dengan username yang sedang login.

- Setelah berhasil menyimpan, `muatTabel()` dipanggil lagi supaya data baru langsung muncul di tabel.

**Cek hasil:** lihat Langkah 15.

> **Titik berhenti 2.** Sampai sini: login, Read, dan Create semuanya jalan. Ini target pertemuan 4.

## Langkah 15 — Tes alur lengkap

Coba satu per satu:

1. Buka `dashboard.html` langsung (ketik di address bar) **tanpa login** -> kamu langsung dipindah ke halaman login.

2. Di halaman login, isi username bebas, misalnya `budi`, klik **Masuk** -> masuk dashboard. Terlihat sidebar di kiri (menu, nama **budi**, tombol **Logout**), 4 kartu ringkasan (Total 6, Kuliner 2, Fashion 2, Kerajinan 2), dan tabel berisi 6 UMKM.

3. Klik menu **Tambah UMKM** di sidebar -> tampil form. Kosongkan form lalu klik **Simpan** -> muncul pesan "wajib diisi".

4. Isi form dengan data UMKM baru (kolom link foto boleh kosong), klik **Simpan** -> kamu kembali ke daftar, muncul pesan "UMKM berhasil ditambahkan!" di pojok kanan bawah, tabel jadi 7 baris, dan kartu ringkasan ikut naik. Kolom "Ditambah oleh" berisi `budi`.

5. Klik **Home** di sidebar -> kartu UMKM baru ikut muncul di Direktori. Navbar kanan atas menampilkan **Halo, budi** (klik untuk kembali ke dashboard).

6. Refresh halaman (`F5`) -> data tetap ada, dan kamu tetap login.

7. Cek di Supabase **Table Editor** -> baris baru ada di tabel `umkm`.

8. Kembali ke dashboard, klik **Logout** di bawah sidebar -> pindah ke halaman login. Buka `index.html`, navbar kembali menampilkan **Login**.

9. Perkecil lebar jendela browser (atau buka di HP) -> sidebar bersembunyi, muncul tombol menu di pojok kiri atas untuk membukanya.

Kalau semua langkah di atas berhasil, pertemuan 4 selesai.

## Langkah 16 — Commit

```bash
git add .
git commit -m "Hubungkan website UMKM ke Supabase: login, read, create"
git push
```

Catatan soal key:

- **Publishable key** boleh ikut ter-commit.

- **Secret key** tidak boleh ter-commit, dan memang tidak kita pakai.

---

## Hasil Akhir

Isi `mulai-dari-kosong/` setelah semua langkah selesai (sama dengan `implementasi-supabase/` tanpa `README.md` dan `supabase-setup.sql`):

```text
mulai-dari-kosong/
├── index.html
├── login.html
├── dashboard.html
├── css/
│   ├── style.css
│   └── dashboard.css
└── js/
    ├── common.js
    ├── app.js
    ├── login.js
    └── dashboard.js
```

Alur yang sekarang jalan:

```text
Pengunjung -> index.html (Direktori dari Supabase, filter + cari)
                  |
                  +-- klik Login --> login.html (isi username)
                                          |
                                          v
                                    dashboard.html (daftar + tambah UMKM)
                                      |            |
                                    Home         Logout
```

## Ringkasan Perubahan dari Pertemuan 3

| File | Status | Perubahan |
|---|---|---|
| `index.html` | Diubah | Path CSS/JS ke folder, `#auth-navbar`, library Supabase + `common.js`, audio dibuang |
| `css/style.css` | Diubah sedikit | Tambah blok navbar login di paling bawah |
| `js/app.js` | Diubah | Data dari Supabase, `escapeHtml`, filter dan Kontak tetap sama |
| `js/common.js` | Baru | Koneksi Supabase, login username, navbar |
| `login.html`, `js/login.js` | Baru | Halaman login |
| `dashboard.html`, `js/dashboard.js` | Baru | Penjaga login, daftar, tambah data |
| `css/dashboard.css` | Baru | Gaya login + dashboard |
| section Kontak | Tidak diubah | Tetap seperti pertemuan 3 |

## Kalau Error

Buka Console dulu (`F12` -> tab **Console**), pesan merahnya biasanya sudah memberi petunjuk.

| Gejala | Kemungkinan penyebab | Solusi |
|---|---|---|
| Console: `Cannot destructure property 'createClient' of 'window.supabase'` | Library Supabase belum termuat | Cek tag `<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2">` ada dan **di atas** `common.js`. Cek juga internetmu |
| Kartu menampilkan "Isi SUPABASE_URL dan SUPABASE_KEY dulu..." | `common.js` belum diisi | Lakukan Langkah 11 |
| "Gagal mengambil data" + Console `relation "public.umkm" does not exist` | Tabel belum dibuat | Jalankan script SQL di Langkah 3 |
| Kartu kosong, **tanpa** error | Policy baca belum ada, jadi tabel mengembalikan data kosong | Jalankan ulang script SQL di Langkah 3 sampai habis |
| Console `Invalid API key` | Key salah salin / kelebihan spasi / yang dipakai Secret key | Salin ulang **Publishable key** (`sb_publishable_...`) |
| Console `new row violates row-level security policy` saat Simpan | Policy tambah data belum ada | Jalankan ulang script SQL di Langkah 3 |
| Gambar kartu tidak muncul | Link foto salah | Cek link di kolom `foto` (Table Editor) |
| Console `404` untuk `css/style.css` atau `js/...` | File ada di folder yang salah | Cocokkan dengan struktur folder di [Hasil Akhir](#hasil-akhir) |
| Klik Login -> halaman tidak ditemukan | `login.html` belum dibuat | Kerjakan Langkah 13 |
| Dashboard langsung kembali ke login | Belum login (atau username terhapus) | Login dulu lewat `login.html` |
| Dashboard kosong putih | Ada error JavaScript sebelum halaman ditampilkan | Lihat pesan merah di Console |
| Ikon (toko, plus, rumah) tidak muncul, tinggal kotak kosong | Font Awesome belum termuat | Cek tag `<link ... font-awesome ...>` di `login.html` / `dashboard.html` dan koneksi internetmu |
| Klik "Tambah UMKM" di sidebar tidak berpindah | `js/dashboard.js` error, atau id elemen salah ketik | Cek Console, dan cocokkan `data-view` di HTML dengan `id="view-..."` |

## Latihan Mandiri

Tambahkan kategori baru **Jasa**:

1. Di `dashboard.html`, tambah `<option>Jasa</option>` di dropdown kategori form.

2. Di `index.html`, tambah `<option>Jasa</option>` di dropdown filter Direktori.

3. Tambah satu UMKM kategori Jasa lewat dashboard, lalu coba filter "Jasa" di halaman utama.

Kalau berhasil, kamu sudah paham alur: **form -> Supabase -> tampil lagi di halaman**.
