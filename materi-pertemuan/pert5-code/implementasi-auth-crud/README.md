# Panduan Pertemuan 5: Edit, Hapus, Login Asli, dan Hak Akses

Di pertemuan 4, website UMKM kita sudah bisa membaca dan menambah data dari Supabase, dan punya login username. Hari ini kita lengkapi dan kita amankan.

Yang dikerjakan hari ini:

- **Update dan Delete** — tombol Edit dan Hapus di dashboard.

- **Login asli** — daftar dan login pakai email + password lewat Supabase Auth, menggantikan login username.

- **Hak akses** — aturan di database supaya hanya pemilik data yang boleh mengubah atau menghapus datanya.

- **Bonus** — memisahkan kategori jadi tabel sendiri (foreign key). Boleh dilewati.

Yang **tidak berubah**: halaman utama (`index.html`, `css/style.css`, `js/app.js`) dan section Kontak. Halaman publik tetap hanya membaca data.

## Mulai dari Mana

Panduan ini melanjutkan hasil pertemuan 4. Ada dua cara memulai:

- **Lanjut dari folder pertemuan 4 milikmu** (disarankan). Kamu cukup mengubah beberapa file di dalamnya.

- **Mulai dari `mulai-dari-pertemuan-4/`** kalau kemarin tertinggal. Folder itu berisi hasil jadi pertemuan 4 beserta `supabase-setup.sql`. Jalankan dulu `supabase-setup.sql` di SQL Editor Supabase (seperti Langkah 3 panduan pertemuan 4), lalu isi URL dan key di `js/common.js`.

## Struktur Folder

```text
pert5-code/
├── README.md                          <- teori pertemuan 5
├── implementasi-auth-crud/            <- HASIL JADI (key dummy)
│   ├── README.md                      <- panduan ini
│   ├── supabase-migrasi-p5.sql        <- tambah kolom user_id + ganti policy (dipaste di Supabase)
│   ├── index.html                     <- halaman utama (TIDAK berubah)
│   ├── login.html                     <- DIUBAH: email + password, tombol Masuk dan Daftar
│   ├── dashboard.html                 <- DIUBAH: kolom Aksi, judul form Tambah/Edit
│   ├── css/
│   │   ├── style.css                  <- TIDAK berubah
│   │   └── dashboard.css              <- DITAMBAH: gaya tombol Edit dan Hapus
│   ├── js/
│   │   ├── common.js                  <- DIUBAH: sesi memakai Supabase Auth
│   │   ├── app.js                     <- TIDAK berubah
│   │   ├── login.js                   <- DIUBAH: signInWithPassword dan signUp
│   │   └── dashboard.js               <- DIUBAH: Edit, Hapus, penjaga login Supabase Auth
│   └── bonus-relasi-kategori/         <- BONUS: tabel kategori + foreign key
│       ├── supabase-bonus-kategori.sql
│       └── js/  app.js  dashboard.js
└── mulai-dari-pertemuan-4/            <- titik awal: hasil pertemuan 4
```

## Arti Komentar di Kode

| Penanda | Artinya |
|---|---|
| `[BARU P5]` | Ditambahkan di pertemuan 5 |
| `[UBAH P5]` | Kode pertemuan 4 yang diubah |
| `[SAMA P4]` | Sama persis dengan pertemuan 4, tidak berubah |
| `[DIBUANG P5]` | Sengaja dihapus (fungsi login username) |

## Hal yang Perlu Dipahami Dulu

- Setelah migrasi SQL di Langkah 2, aturan database berubah: **pengunjung yang belum login tidak bisa lagi menambah data**, dan **hanya pemilik data yang bisa mengubah atau menghapusnya**.

- **Data bawaan** dari pertemuan 4 (6 UMKM awal) tidak punya pemilik (`user_id` kosong), jadi tidak bisa diedit atau dihapus lewat aplikasi. Ini disengaja. Untuk mencoba Edit dan Hapus, tambahkan dulu data milikmu sendiri.

- Menyembunyikan tombol bukan keamanan. Yang benar-benar menolak aksi yang tidak berhak adalah **aturan di database (RLS)**.

## Daftar Isi

**Bagian A — Supabase (di browser)**

1. [Matikan Confirm email](#langkah-1--matikan-confirm-email)
2. [Jalankan script migrasi SQL](#langkah-2--jalankan-script-migrasi-sql)

**Bagian B — Kode (di VS Code)**

3. [Siapkan folder kerja](#langkah-3--siapkan-folder-kerja)
4. [js/common.js](#langkah-4--ubah-jscommonjs)
5. [login.html](#langkah-5--ubah-loginhtml)
6. [js/login.js](#langkah-6--ubah-jsloginjs) — **titik berhenti 1**
7. [dashboard.html](#langkah-7--ubah-dashboardhtml)
8. [css/dashboard.css](#langkah-8--tambah-gaya-tombol-di-cssdashboardcss)
9. [js/dashboard.js](#langkah-9--ubah-jsdashboardjs) — **titik berhenti 2**
10. [Tes alur lengkap](#langkah-10--tes-alur-lengkap)
11. [Commit](#langkah-11--commit)

Lalu: [Bonus: relasi kategori](#bonus--relasi-tabel-kategori), [Ringkasan perubahan](#ringkasan-perubahan-dari-pertemuan-4), [Kalau error](#kalau-error), [Latihan mandiri](#latihan-mandiri).

> Tampilan website Supabase kadang berubah (letak menu, nama tombol). Kalau ada yang beda, cari kata kuncinya. Fungsinya tetap sama.

---

# Bagian A — Supabase

## Langkah 1 — Matikan Confirm email

Secara bawaan, Supabase meminta pengguna mengklik link di email sebelum akunnya aktif. Di kelas, ini bikin macet: kita harus membuka inbox, dan kalau banyak murid mendaftar sekaligus, pengiriman email bisa kena batas. Jadi untuk latihan, fitur ini kita matikan.

1. Buka project Supabase-mu.

2. Di menu kiri, klik **Authentication**.

3. Buka bagian **Sign In / Providers** (di tampilan lama bernama **Providers**), lalu klik **Email**.

4. Matikan pilihan **Confirm email**.

5. Klik **Save**.

**Cek hasil:** pilihan **Confirm email** dalam keadaan mati dan tersimpan.

Catatan: untuk aplikasi sungguhan, **Confirm email sebaiknya diaktifkan**, supaya orang tidak bisa mendaftar memakai email milik orang lain.

## Langkah 2 — Jalankan script migrasi SQL

Script ini mengubah tabel `umkm` yang sudah ada. Datanya tidak dihapus.

1. Di menu kiri Supabase, klik **SQL Editor**, lalu **New query**.

2. Copy **seluruh** script di bawah (isinya sama dengan file `supabase-migrasi-p5.sql`), lalu paste.

```sql
-- ======================================================
-- supabase-migrasi-p5.sql — jalankan SEKALI di Supabase > SQL Editor
-- Dijalankan SESUDAH script pertemuan 4 (supabase-setup.sql).
-- Isinya: menambah kolom pemilik data dan mengganti aturan (policy)
-- supaya hanya user yang login yang boleh menambah, mengubah, dan menghapus.
-- ======================================================

-- 1. Kolom pemilik data: menyimpan id user (dari Supabase Auth) yang menambahkan baris.
--    Data bawaan dari pertemuan 4 isinya kosong (null), artinya "milik sistem".
alter table public.umkm
  add column if not exists user_id uuid references auth.users (id) on delete set null;

-- 2. Hapus aturan lama dari pertemuan 4.
--    Aturan baca lama hanya untuk "anon" (pengunjung belum login), sehingga user yang
--    sudah login tidak bisa membaca data. Aturan tambah lama terlalu longgar.
drop policy if exists "umkm boleh dibaca" on public.umkm;
drop policy if exists "umkm boleh ditambah" on public.umkm;

-- 3. Baca: boleh untuk SEMUA orang, baik belum login (anon) maupun sudah login (authenticated).
create policy "umkm boleh dibaca"
  on public.umkm for select to anon, authenticated
  using (true);

-- 4. Tambah: hanya user yang login, dan baris yang ditambah harus atas namanya sendiri.
--    auth.uid() = id user yang sedang login.
create policy "umkm login boleh menambah"
  on public.umkm for insert to authenticated
  with check (user_id = (select auth.uid()));

-- 5. Ubah: hanya pemilik baris.
--    "using" memeriksa baris yang mau diubah, "with check" memeriksa hasil perubahannya.
create policy "umkm pemilik boleh mengubah"
  on public.umkm for update to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

-- 6. Hapus: hanya pemilik baris.
create policy "umkm pemilik boleh menghapus"
  on public.umkm for delete to authenticated
  using (user_id = (select auth.uid()));
```

3. Klik **Run**.

**Cek hasil:**

- Muncul **Success. No rows returned**.

- Di **Table Editor**, tabel `umkm` punya kolom baru **`user_id`** (isinya masih kosong).

Penjelasan singkat:

- `add column user_id` — kolom yang menyimpan **siapa pemilik baris**. Isinya id user dari Supabase Auth.

- `drop policy` — menghapus aturan lama pertemuan 4. Aturan baca lama hanya untuk `anon`, jadi user yang sudah login tidak bisa membaca data. Aturan tambah lama terlalu longgar.

- `for select to anon, authenticated using (true)` — **semua orang** boleh membaca.

- `for insert ... with check (user_id = auth.uid())` — hanya user yang login, dan baris yang ditambah harus atas namanya sendiri.

- `for update ... using ... with check` dan `for delete ... using` — hanya pemilik baris yang boleh mengubah atau menghapus.

---

# Bagian B — Kode

## Langkah 3 — Siapkan folder kerja

- Kalau **lanjut dari folder pertemuan 4** milikmu: pakai folder itu. Tidak ada yang perlu disalin.

- Kalau **mulai dari `mulai-dari-pertemuan-4/`**: salin isi folder itu ke tempat kerjamu, buka `js/common.js`, lalu isi dua baris ini dengan URL dan key milikmu:

```javascript
const SUPABASE_URL = "https://xxxxxxxxxxxx.supabase.co";
const SUPABASE_KEY = "sb_publishable_ISI_KEY_KAMU_DI_SINI";
```

Dua baris ini dipakai lagi di langkah berikutnya.

## Langkah 4 — Ubah `js/common.js`

Buka **`js/common.js`**. Fungsi login username dibuang, diganti sesi dari Supabase Auth.

> **Penting:** kalau kamu mengganti seluruh isi file, isi **lagi** dua baris `SUPABASE_URL` dan `SUPABASE_KEY` di bagian atas dengan milikmu.

```javascript
// ======================================================
// common.js — dipakai semua halaman
// Isinya: koneksi Supabase, sesi login (Supabase Auth), dan navbar.
// Penanda: [BARU P5] ditambah, [UBAH P5] diubah, [SAMA P4] tidak berubah,
// [DIBUANG P5] dihapus.
// ======================================================

// ---------- [SAMA P4] 1. Koneksi Supabase ----------
// GANTI dua nilai ini dengan milik project Supabase kamu sendiri.
const SUPABASE_URL = "https://xxxxxxxxxxxx.supabase.co";
const SUPABASE_KEY = "sb_publishable_ISI_KEY_KAMU_DI_SINI";

// Library Supabase (dari CDN di HTML) menyediakan window.supabase
const { createClient } = window.supabase;
const supabaseClient = createClient(SUPABASE_URL, SUPABASE_KEY);

// true kalau URL dan key sudah diganti (bukan nilai contoh di atas)
function konfigurasiSiap() {
  return (
    !SUPABASE_URL.includes("xxxxxxxxxxxx") && !SUPABASE_KEY.includes("ISI_KEY")
  );
}

// ---------- [SAMA P4] 2. Pengaman teks ----------
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

// ---------- [DIBUANG P5] 3. Login username ----------
// Fungsi ambilUsername(), simpanUsername(), dan hapusUsername() dihapus.
// Login sekarang diurus Supabase Auth (email + password), jadi tidak perlu
// menyimpan username sendiri di localStorage.

// ---------- [BARU P5] 3. Sesi login (Supabase Auth) ----------
// Mengembalikan sesi kalau sudah login, atau null kalau belum.
// Sesi disimpan Supabase di browser dan diperbarui otomatis.
async function ambilSesi() {
  const { data } = await supabaseClient.auth.getSession();
  return data.session;
}

// Nama yang ditampilkan: bagian email sebelum tanda @
function namaTampil(user) {
  return (user.email || "").split("@")[0];
}

// ---------- [UBAH P5] 4. Navbar ----------
// Dulu membaca username dari localStorage. Sekarang membaca sesi Supabase.
async function renderNavbarAuth() {
  const tempat = document.querySelector("#auth-navbar");
  if (!tempat) return;

  const sesi = await ambilSesi();
  tempat.innerHTML = sesi
    ? `<a href="dashboard.html">Halo, ${escapeHtml(namaTampil(sesi.user))}</a>`
    : `<a href="login.html">Login</a>`;
}

renderNavbarAuth();
```

Penjelasan singkat:

- `ambilSesi()` — bertanya ke Supabase: "ada yang sedang login di browser ini?". Hasilnya sesi (kalau login) atau `null` (kalau belum).

- Sesi disimpan Supabase di browser dan diperbarui otomatis, jadi tetap login walau halaman di-refresh. Kita tidak perlu menyimpannya sendiri di `localStorage`.

- `namaTampil(user)` — mengambil bagian email sebelum tanda `@` sebagai nama yang ditampilkan.

- `renderNavbarAuth()` sekarang `async`, karena `ambilSesi()` butuh waktu.

**Cek hasil:** belum ada perubahan terlihat. Lanjut.

## Langkah 5 — Ubah `login.html`

Form login username diganti form email + password. Ada dua tombol: **Masuk** dan **Daftar akun baru**. Ganti seluruh isi **`login.html`** dengan:

```html
<!doctype html>
<!-- [UBAH P5] Halaman login: sekarang email + password lewat Supabase Auth (dulu username saja) -->
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
            <!-- [UBAH P5] Dulu: "Login cukup pakai username" -->
            <li><i class="fa-solid fa-check" aria-hidden="true"></i> Login aman pakai email dan password</li>
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
            <!-- [UBAH P5] Dulu cuma satu kolom username. Sekarang email + password -->
            <p class="login-sub">Masuk dengan email dan password. Belum punya akun? Isi lalu klik Daftar.</p>

            <form id="form-login" class="form-terang">
              <label for="email">Email</label>
              <input
                type="email"
                id="email"
                name="email"
                autocomplete="email"
                placeholder="contoh: budi@email.com"
              />

              <label for="password">Password</label>
              <input
                type="password"
                id="password"
                name="password"
                autocomplete="current-password"
                placeholder="minimal 6 karakter"
              />

              <button type="submit" class="tombol-penuh">
                Masuk <i class="fa-solid fa-arrow-right" aria-hidden="true"></i>
              </button>
              <!-- [BARU P5] Tombol daftar akun baru (type="button" supaya tidak ikut submit) -->
              <button type="button" id="tombol-daftar" class="tombol-penuh tombol-sekunder">
                Daftar akun baru
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

**Cek hasil:** buka `login.html` di Live Server. Form punya kolom Email dan Password, tombol Masuk, dan tombol Daftar akun baru.

## Langkah 6 — Ubah `js/login.js`

Ganti seluruh isi **`js/login.js`**:

```javascript
// ======================================================
// login.js — halaman login dan daftar
// [UBAH P5] Dulu cuma username di localStorage. Sekarang pakai Supabase Auth
// (email + password). Butuh common.js.
// ======================================================

const formLogin = document.querySelector("#form-login");
const inputEmail = document.querySelector("#email");
const inputPassword = document.querySelector("#password");
const tombolDaftar = document.querySelector("#tombol-daftar");
const pesanLogin = document.querySelector("#pesan-login");

// Sudah login? Langsung ke dashboard, tidak perlu isi lagi.
ambilSesi().then((sesi) => {
  if (sesi) location.replace("dashboard.html");
});

function tampilPesan(teks, jenis) {
  pesanLogin.textContent = teks;
  pesanLogin.className = "status status-" + jenis; // "ok" atau "galat"
}

// Pesan dari Supabase berbahasa Inggris, yang umum kita terjemahkan.
function pesanRamah(error) {
  const teks = error.message || "";
  if (teks.includes("Invalid login credentials")) return "Email atau password salah.";
  if (teks.includes("Email not confirmed")) return "Email belum dikonfirmasi. Cek inbox emailmu.";
  if (teks.includes("already registered")) return "Email ini sudah terdaftar. Klik Masuk.";
  if (teks.includes("Password should be")) return "Password terlalu pendek (minimal 6 karakter).";
  return "Gagal: " + teks;
}

// Mengambil isian form. Mengembalikan null kalau belum lengkap.
function ambilIsian() {
  const email = inputEmail.value.trim();
  const password = inputPassword.value;

  if (email === "" || password === "") {
    tampilPesan("Email dan password wajib diisi.", "galat");
    return null;
  }
  if (!konfigurasiSiap()) {
    tampilPesan("Isi SUPABASE_URL dan SUPABASE_KEY dulu di js/common.js.", "galat");
    return null;
  }
  return { email, password };
}

// ---------- Masuk ----------
formLogin.addEventListener("submit", async (event) => {
  event.preventDefault();

  const isian = ambilIsian();
  if (!isian) return;

  tampilPesan("Memproses...", "ok");
  const { error } = await supabaseClient.auth.signInWithPassword(isian);

  if (error) {
    tampilPesan(pesanRamah(error), "galat");
    return;
  }
  location.href = "dashboard.html";
});

// ---------- Daftar ----------
tombolDaftar.addEventListener("click", async () => {
  const isian = ambilIsian();
  if (!isian) return;

  tampilPesan("Memproses...", "ok");
  const { data, error } = await supabaseClient.auth.signUp(isian);

  if (error) {
    tampilPesan(pesanRamah(error), "galat");
    return;
  }

  // Kalau "Confirm email" dimatikan di Supabase, sesi langsung ada.
  // Kalau masih aktif, user harus mengklik link di emailnya dulu.
  if (data.session) {
    location.href = "dashboard.html";
  } else {
    tampilPesan("Pendaftaran berhasil. Cek emailmu untuk konfirmasi, lalu klik Masuk.", "ok");
  }
});
```

Penjelasan singkat:

- `signUp({ email, password })` — membuat akun baru di Supabase Auth.

- `signInWithPassword({ email, password })` — masuk dengan akun yang sudah ada.

- Seperti `select()` dan `insert()` di pertemuan 4, hasilnya `{ data, error }`. Cek `error` dulu.

- Setelah **daftar**, kalau Confirm email sudah dimatikan, sesi langsung ada dan kamu langsung masuk dashboard. Kalau masih aktif, tampil pesan "Cek emailmu".

- `pesanRamah()` menerjemahkan pesan error bahasa Inggris dari Supabase yang paling sering muncul.

**Cek hasil (titik berhenti 1):**

1. Buka `login.html`, isi email (contoh `budi@email.com`) dan password minimal 6 karakter, klik **Daftar akun baru** -> masuk ke dashboard.

2. Di dashboard, bagian bawah sidebar menampilkan nama dari emailmu (bagian sebelum tanda `@`).

3. Klik **Logout** -> kembali ke halaman utama. Navbar menampilkan **Login**.

4. Login lagi lewat tombol **Masuk** -> berhasil.

5. Di Supabase, buka **Authentication > Users**: akunmu muncul di daftar.

> **Titik berhenti 1.** Daftar dan login sudah memakai Supabase Auth. Kalau waktu kelas habis, boleh berhenti di sini.

## Langkah 7 — Ubah `dashboard.html`

Ditambah kolom **Aksi** di tabel, dan judul serta tombol form diberi `id` supaya bisa berganti antara "Tambah" dan "Edit". Ganti seluruh isi **`dashboard.html`**:

```html
<!doctype html>
<!-- [UBAH P5] Dashboard: ditambah Edit dan Hapus. Dulu hanya daftar dan tambah UMKM (pertemuan 4) -->
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
                      <th class="nomor">No</th>
                      <th>Foto</th>
                      <th>Usaha</th>
                      <th>Kategori</th>
                      <th>Jam buka</th>
                      <th>WA</th>
                      <th>Ditambah oleh</th>
                      <!-- [BARU P5] Kolom tombol Edit dan Hapus -->
                      <th>Aksi</th>
                    </tr>
                  </thead>
                  <tbody id="tubuh-tabel"></tbody>
                </table>
              </div>
            </div>
          </section>

          <!-- Tampilan 2: form tambah UMKM (Create) dan edit UMKM (Update) -->
          <section class="view" id="view-tambah" hidden>
            <div class="kartu kartu-form">
              <!-- [UBAH P5] Judul diberi id supaya bisa berganti "Tambah" / "Edit" lewat JavaScript -->
              <h2 id="judul-form">Tambah UMKM baru</h2>
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
                  <!-- [UBAH P5] Diberi id, teksnya berubah jadi "Simpan perubahan" saat mengedit -->
                  <button type="submit" id="tombol-simpan">Simpan</button>
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

**Cek hasil:** belum bisa dites penuh karena `dashboard.js` belum diubah. Lanjut.

## Langkah 8 — Tambah gaya tombol di `css/dashboard.css`

Buka **`css/dashboard.css`**. **Jangan hapus apa pun.** Scroll ke baris paling bawah, lalu tambahkan blok ini di bawah semua kode yang sudah ada:

```css
/* ======================================================
   [BARU P5] Tombol Edit dan Hapus di kolom Aksi
   ====================================================== */
td.aksi {
  white-space: nowrap;
}

/* Tombol kecil: menimpa tombol emas bawaan di style.css */
.tombol-kecil {
  padding: 6px 14px;
  background-color: var(--sage-pale);
  color: var(--matcha-dark);
  border-radius: 8px;
  font-size: 0.8rem;
  line-height: 1.2;
}

.tombol-kecil:hover,
.tombol-kecil:focus-visible {
  background-color: #dbe5cf;
}

/* Tombol Hapus: merah supaya terasa berbahaya */
.tombol-kecil.tombol-bahaya {
  background-color: #f8e3de;
  color: #b3412e;
}

.tombol-kecil.tombol-bahaya:hover,
.tombol-kecil.tombol-bahaya:focus-visible {
  background-color: #f1cdc5;
}

/* Baris yang bukan milik user diberi strip, tanpa tombol */
.aksi-kosong {
  color: var(--matcha-mid);
}
```

**Cek hasil:** belum ada perubahan terlihat. Lanjut.

## Langkah 9 — Ubah `js/dashboard.js`

Ini file dengan perubahan terbanyak. Ganti seluruh isi **`js/dashboard.js`**:

```javascript
// ======================================================
// dashboard.js — halaman dashboard
// Fitur: sidebar, daftar UMKM (Read), tambah (Create), edit (Update),
// hapus (Delete). Login memakai Supabase Auth. Butuh common.js.
// Penanda: [BARU P5] ditambah, [UBAH P5] diubah, [SAMA P4] tidak berubah.
// ======================================================

// [UBAH P5] Penjaga login. Dulu cek username di localStorage, sekarang cek
// sesi Supabase Auth. Belum login langsung ditendang ke halaman login.
async function mulai() {
  const sesi = await ambilSesi();
  if (!sesi) {
    location.replace("login.html");
    return;
  }
  mulaiDashboard(sesi.user);
}
mulai();

function mulaiDashboard(user) {
  // Lolos cek login, baru tampilkan halaman (sebelumnya disembunyikan CSS)
  document.body.classList.remove("belum-dicek");

  const nama = namaTampil(user);
  document.querySelector("#nama-user").textContent = nama;
  document.querySelector("#avatar-user").textContent = nama.charAt(0).toUpperCase();

  const formUmkm = document.querySelector("#form-umkm");
  const statusForm = document.querySelector("#status-form");
  const tubuhTabel = document.querySelector("#tubuh-tabel");
  const statistik = document.querySelector("#statistik");
  const jumlahUmkm = document.querySelector("#jumlah-umkm");
  const judulHalaman = document.querySelector("#judul-halaman");
  const judulForm = document.querySelector("#judul-form");
  const tombolSimpan = document.querySelector("#tombol-simpan");
  const sidebar = document.querySelector("#sidebar");
  const lapisanSidebar = document.querySelector("#lapisan-sidebar");
  const toast = document.querySelector("#toast");

  // [BARU P5] idDiedit = null artinya form sedang mode "Tambah".
  // Kalau berisi angka id, form sedang mode "Edit" untuk baris itu.
  let idDiedit = null;
  // [BARU P5] Salinan data terakhir dari Supabase, dipakai saat tombol Edit diklik
  let dataTerakhir = [];

  // ---------- [SAMA P4] Sidebar: ganti tampilan (Daftar / Tambah) ----------
  function bukaTampilan(tampilan) {
    document.querySelectorAll(".view").forEach((view) => {
      view.hidden = view.id !== "view-" + tampilan;
    });
    document.querySelectorAll(".menu-item[data-view]").forEach((tombol) => {
      tombol.classList.toggle("aktif", tombol.dataset.view === tampilan);
    });
    if (tampilan === "daftar") {
      judulHalaman.textContent = "Daftar UMKM";
    } else {
      judulHalaman.textContent = idDiedit ? "Edit UMKM" : "Tambah UMKM";
    }
    tutupSidebar();
  }

  // Klik menu "Tambah UMKM" selalu membuka form kosong (mode Tambah)
  document.querySelectorAll(".menu-item[data-view]").forEach((tombol) => {
    tombol.addEventListener("click", () => {
      if (tombol.dataset.view === "tambah") selesaiEdit();
      bukaTampilan(tombol.dataset.view);
    });
  });

  // ---------- [SAMA P4] Sidebar di layar HP: buka / tutup ----------
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

  // ---------- [UBAH P5] Logout ----------
  // Dulu menghapus username. Sekarang signOut() menghapus sesi di Supabase.
  document.querySelector("#tombol-logout").addEventListener("click", async () => {
    await supabaseClient.auth.signOut();
    location.replace("index.html");
  });

  // ---------- [SAMA P4] Toast: pesan singkat yang hilang sendiri ----------
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

  // [BARU P5] Tombol Edit/Hapus hanya untuk baris milik user yang login.
  // Baris lain (termasuk data bawaan sistem) diberi tanda strip.
  function htmlAksi(umkm) {
    if (umkm.user_id !== user.id) {
      return `<span class="aksi-kosong" title="Bukan datamu">—</span>`;
    }
    const id = escapeHtml(umkm.id);
    return `
      <button type="button" class="tombol-kecil" data-aksi="edit" data-id="${id}">Edit</button>
      <button type="button" class="tombol-kecil tombol-bahaya" data-aksi="hapus" data-id="${id}">Hapus</button>`;
  }

  async function muatTabel() {
    if (!konfigurasiSiap()) {
      tubuhTabel.innerHTML = `<tr><td colspan="8" class="galat">Isi SUPABASE_URL dan SUPABASE_KEY dulu di js/common.js.</td></tr>`;
      return;
    }

    tubuhTabel.innerHTML = `<tr><td colspan="8">Memuat data...</td></tr>`;

    const { data, error } = await supabaseClient
      .from("umkm")
      .select("*")
      .order("id", { ascending: true });

    if (error) {
      console.error("Gagal mengambil data:", error);
      tubuhTabel.innerHTML = `<tr><td colspan="8" class="galat">Gagal mengambil data. Buka Console (F12).</td></tr>`;
      return;
    }

    dataTerakhir = data;
    renderStatistik(data);
    jumlahUmkm.textContent = data.length + " usaha";
    tubuhTabel.innerHTML = data
      .map(
        (umkm, urutan) => `
        <tr>
          <td class="nomor">${urutan + 1}</td>
          <td><img class="foto-kecil" src="${escapeHtml(umkm.foto)}" alt="" loading="lazy" /></td>
          <td><strong>${escapeHtml(umkm.nama)}</strong><small>${escapeHtml(umkm.alamat)}</small></td>
          <td><span class="pil">${escapeHtml(umkm.kategori)}</span></td>
          <td>${escapeHtml(umkm.jam)}</td>
          <td>${escapeHtml(umkm.wa)}</td>
          <td>${escapeHtml(umkm.dibuat_oleh)}</td>
          <td class="aksi">${htmlAksi(umkm)}</td>
        </tr>`,
      )
      .join("");
  }

  // ---------- Form: pesan status + mode Tambah / Edit ----------
  function tampilStatus(pesan, jenis) {
    statusForm.textContent = pesan;
    statusForm.className = "status status-" + jenis; // "ok" atau "galat"
  }

  // [UBAH P5] Mengembalikan form ke mode Tambah (kosong)
  function selesaiEdit() {
    idDiedit = null;
    formUmkm.reset();
    statusForm.textContent = "";
    statusForm.className = "status";
    judulForm.textContent = "Tambah UMKM baru";
    tombolSimpan.textContent = "Simpan";
  }

  // [BARU P5] Mengisi form dengan data baris yang mau diedit
  function mulaiEdit(id) {
    const umkm = dataTerakhir.find((item) => String(item.id) === String(id));
    if (!umkm) return;

    idDiedit = umkm.id;
    document.querySelector("#nama").value = umkm.nama;
    document.querySelector("#kategori").value = umkm.kategori;
    document.querySelector("#alamat").value = umkm.alamat;
    document.querySelector("#jam").value = umkm.jam;
    document.querySelector("#wa").value = umkm.wa;
    document.querySelector("#foto").value = umkm.foto === FOTO_DEFAULT ? "" : umkm.foto;

    judulForm.textContent = "Edit UMKM";
    tombolSimpan.textContent = "Simpan perubahan";
    statusForm.textContent = "";
    statusForm.className = "status";
    bukaTampilan("tambah");
  }

  // [BARU P5] Delete: konfirmasi dulu, baru hapus HANYA baris dengan id itu
  async function hapusUmkm(id) {
    const umkm = dataTerakhir.find((item) => String(item.id) === String(id));
    if (!umkm) return;
    if (!confirm(`Hapus "${umkm.nama}"? Data yang dihapus tidak bisa dikembalikan.`)) return;

    // .eq("id", id) WAJIB. Tanpa filter ini, yang terhapus bisa seluruh tabel.
    // .select() di belakang membuat Supabase mengembalikan baris yang benar-benar terhapus.
    const { data, error } = await supabaseClient
      .from("umkm")
      .delete()
      .eq("id", id)
      .select();

    if (error) {
      console.error("Gagal menghapus:", error);
      tampilToast("Gagal menghapus. Buka Console (F12).");
      return;
    }

    // RLS yang menolak TIDAK menghasilkan error, cuma 0 baris yang terhapus.
    if (data.length === 0) {
      tampilToast("Tidak ada data yang terhapus. Kamu bukan pemilik data ini.");
      return;
    }

    tampilToast("UMKM berhasil dihapus.");
    await muatTabel();
  }

  // [BARU P5] Satu pendengar untuk semua tombol Edit/Hapus di tabel.
  // Tabel digambar ulang tiap data dimuat, jadi pendengar dipasang di <tbody>
  // (induknya), bukan di tiap tombol. Cara ini disebut event delegation.
  tubuhTabel.addEventListener("click", (event) => {
    const tombol = event.target.closest("button[data-aksi]");
    if (!tombol) return;

    if (tombol.dataset.aksi === "edit") mulaiEdit(tombol.dataset.id);
    if (tombol.dataset.aksi === "hapus") hapusUmkm(tombol.dataset.id);
  });

  document.querySelector("#tombol-batal").addEventListener("click", () => {
    selesaiEdit();
    bukaTampilan("daftar");
  });

  // ---------- Create (tambah) dan Update (edit) ----------
  formUmkm.addEventListener("submit", async (event) => {
    event.preventDefault();

    // [UBAH P5] Cek sesi lagi sebelum menulis data, jaga-jaga sesi sudah habis
    const sesi = await ambilSesi();
    if (!sesi) {
      location.replace("login.html");
      return;
    }

    if (!konfigurasiSiap()) {
      tampilStatus("Isi SUPABASE_URL dan SUPABASE_KEY dulu di js/common.js.", "galat");
      return;
    }

    const isian = {
      nama: document.querySelector("#nama").value.trim(),
      kategori: document.querySelector("#kategori").value,
      alamat: document.querySelector("#alamat").value.trim(),
      jam: document.querySelector("#jam").value.trim(),
      wa: document.querySelector("#wa").value.trim(),
      foto: document.querySelector("#foto").value.trim() || FOTO_DEFAULT,
    };

    if (isian.nama === "" || isian.alamat === "" || isian.jam === "" || isian.wa === "") {
      tampilStatus("Nama, alamat, jam, dan WA wajib diisi.", "galat");
      return;
    }

    if (idDiedit === null) {
      // ----- Create: insert() menerima array of object -----
      // [UBAH P5] user_id diisi id user yang login (dicek RLS), dibuat_oleh diisi nama
      const { error } = await supabaseClient.from("umkm").insert([
        { ...isian, user_id: user.id, dibuat_oleh: namaTampil(user) },
      ]);

      if (error) {
        console.error("Gagal menyimpan data:", error);
        tampilStatus("Gagal menyimpan. Buka Console (F12) untuk detailnya.", "galat");
        return;
      }
      tampilToast("UMKM berhasil ditambahkan!");
    } else {
      // ----- [BARU P5] Update: ubah HANYA baris dengan id yang sedang diedit -----
      const { data, error } = await supabaseClient
        .from("umkm")
        .update(isian)
        .eq("id", idDiedit)
        .select();

      if (error) {
        console.error("Gagal mengubah data:", error);
        tampilStatus("Gagal mengubah. Buka Console (F12) untuk detailnya.", "galat");
        return;
      }

      // RLS yang menolak tidak menghasilkan error, cuma 0 baris yang berubah.
      if (data.length === 0) {
        tampilStatus("Tidak ada data yang berubah. Kamu bukan pemilik data ini.", "galat");
        return;
      }
      tampilToast("Perubahan berhasil disimpan.");
    }

    selesaiEdit();
    bukaTampilan("daftar"); // kembali ke daftar supaya hasilnya langsung kelihatan
    await muatTabel(); // muat ulang tabel + ringkasan
  });

  muatTabel();
}
```

Penjelasan singkat:

- **Penjaga login** sekarang memakai `ambilSesi()`: belum ada sesi, langsung `location.replace("login.html")`.

- **Kolom Aksi:** tombol Edit dan Hapus hanya tampil di baris yang `user_id`-nya sama dengan id user yang login. Baris lain diberi tanda strip.

- **Edit:** klik Edit mengisi form dengan data baris itu dan mengubah tombolnya jadi "Simpan perubahan". Variabel `idDiedit` menandai baris mana yang sedang diedit. Kalau `null`, form dalam mode Tambah.

- **Update:** `.update(isian).eq("id", idDiedit).select()`. `.eq()` memastikan hanya baris itu yang berubah. `.select()` meminta baris yang benar-benar berubah dikembalikan.

- **Delete:** `confirm()` dulu, lalu `.delete().eq("id", id).select()`.

- **Memeriksa `data.length === 0`:** kalau RLS menolak, Supabase tidak mengembalikan error, cuma nol baris yang berubah. Tanpa pemeriksaan ini, aplikasi akan terlihat berhasil padahal tidak ada yang berubah.

- **Event delegation:** satu pendengar klik di `<tbody>` melayani semua tombol Edit dan Hapus (lihat `tubuhTabel.addEventListener`).

- **Insert** sekarang mengirim `user_id` (id user yang login) dan `dibuat_oleh`. `user_id` inilah yang dicek policy RLS.

**Cek hasil (titik berhenti 2):**

1. Login, lalu buka menu **Tambah UMKM** dan tambah satu data.

2. Di tabel, baris barumu punya tombol **Edit** dan **Hapus**. Enam baris bawaan hanya bertanda strip (—).

3. Klik **Edit**, ubah namanya, klik **Simpan perubahan** -> nama di tabel berubah, baris lain tidak.

4. Klik **Hapus**, setujui konfirmasi -> baris itu hilang.

> **Titik berhenti 2.** CRUD sudah lengkap, dengan login asli dan hak akses. Ini target pertemuan 5.

## Langkah 10 — Tes alur lengkap

Coba satu per satu:

1. **Belum login:** buka `dashboard.html` langsung -> dipindah ke `login.html`.

2. **Hak akses akun pertama:** login sebagai akun A, tambah satu data, lalu Edit dan Hapus data itu -> berhasil.

3. **Akun kedua:** buka **jendela incognito** (sesi login tersimpan per browser, jadi akun kedua perlu browser/jendela lain). Daftar akun B, lalu lihat tabel -> data milik A **tidak punya tombol Edit/Hapus**.

4. **Aturan di database:** di jendela akun B, buka Console (`F12`) dan hapus data milik A langsung lewat kode, tanpa lewat tombol. Ganti `ID_DATA_A` dengan id baris milik A (lihat kolom `id` di Table Editor Supabase):

   ```javascript
   await supabaseClient.from("umkm").delete().eq("id", ID_DATA_A).select()
   ```

   Hasilnya `data: []` (kosong) dan tidak ada error. Itulah RLS menolak diam-diam, dan data A aman. Cek di tabel: barisnya masih ada.

5. **Pengunjung biasa:** buka `index.html` tanpa login -> daftar UMKM tetap tampil (baca tetap terbuka untuk semua).

6. **Data bawaan:** coba hapus salah satu dari 6 UMKM awal lewat Console, misalnya `await supabaseClient.from("umkm").delete().eq("id", 1).select()` -> hasilnya `data: []`, barisnya tetap ada.

7. **Refresh:** muat ulang dashboard -> tetap login.

8. **Logout** -> kembali ke `index.html`, lalu coba buka `dashboard.html` -> dipindah ke login.

## Langkah 11 — Commit

```bash
git add .
git commit -m "Tambah edit, hapus, Supabase Auth, dan RLS pemilik data"
git push
```

Catatan soal key: **Publishable key** boleh ikut ter-commit karena memang untuk publik. **Secret key** tidak boleh, dan memang tidak kita pakai.

---

# Bonus — Relasi Tabel Kategori

Bonus ini boleh dilewati. Ide dasarnya ada di bagian teori: kategori jadi tabel sendiri, dihubungkan dengan foreign key (`kategori_id`).

Isi folder `bonus-relasi-kategori/`:

- `supabase-bonus-kategori.sql` — script SQL.

- `js/app.js` dan `js/dashboard.js` — versi yang sudah memakai relasi. Kamu bisa menggantinya langsung, atau mengikuti langkah di bawah.

## Bonus 1 — Jalankan script SQL

Di SQL Editor, jalankan (setelah `supabase-migrasi-p5.sql`):

```sql
-- ======================================================
-- supabase-bonus-kategori.sql — BONUS pertemuan 5
-- Memisahkan kategori jadi tabel sendiri, dihubungkan lewat foreign key.
-- Jalankan SESUDAH supabase-migrasi-p5.sql.
-- ======================================================

-- 1. Tabel kategori: nama kategori ditulis sekali saja di sini.
create table public.kategori (
  id   bigint generated always as identity primary key,
  nama text not null unique
);

-- 2. Kunci tabel (RLS), lalu izinkan semua orang membaca.
alter table public.kategori enable row level security;

create policy "kategori boleh dibaca"
  on public.kategori for select to anon, authenticated
  using (true);

-- 3. Isi tiga kategori yang sudah dipakai.
insert into public.kategori (nama) values ('Kuliner'), ('Fashion'), ('Kerajinan');

-- 4. Kolom foreign key di tabel umkm: menyimpan id kategori, bukan teksnya.
alter table public.umkm
  add column kategori_id bigint references public.kategori (id);

-- 5. Isi kolom baru dari teks kategori yang lama (cocokkan nama).
update public.umkm u
  set kategori_id = k.id
  from public.kategori k
  where k.nama = u.kategori;

-- 6. Setiap UMKM wajib punya kategori.
alter table public.umkm alter column kategori_id set not null;

-- 7. Hapus kolom teks lama. Namanya sama dengan tabel kategori, jadi kalau dibiarkan
--    akan bentrok saat tabel digabung (join).
alter table public.umkm drop column kategori;
```

**Cek hasil:** di Table Editor ada tabel baru **kategori** (3 baris), dan tabel `umkm` punya kolom **`kategori_id`** serta **tidak lagi punya** kolom `kategori`.

> **Peringatan:** setelah script ini dijalankan, kode pertemuan 5 yang lama (yang membaca `umkm.kategori`) tidak akan jalan sampai kamu mengerjakan Bonus 2.

## Bonus 2 — Ubah kode

Intinya: data kategori sekarang berupa objek `umkm.kategori.nama` (hasil join), dan form menyimpan `kategori_id`.

**1. `js/app.js`** — tiga perubahan kecil:

```javascript
// a) di fungsi ambilUmkm(): ikut ambil nama kategori
.select("*, kategori(nama)")

// b) di renderUmkm(): label kategori di kartu
<span class="badge">${escapeHtml(umkm.kategori.nama)}</span>

// c) di terapkanFilter(): bandingkan nama kategori
const kategoriCocok = kategoriDipilih === "Semua kategori" || umkm.kategori.nama === kategoriDipilih;
```

**2. `js/dashboard.js`** — ubah query, tampilan, dan form:

```javascript
// a) di muatTabel() dan renderStatistik(): pakai nama dari relasi
.select("*, kategori(nama)")
umkm.kategori.nama

// b) di mulaiEdit(): isi dropdown dengan id kategori
document.querySelector("#kategori").value = umkm.kategori_id;

// c) di isian (simpan): yang disimpan sekarang id kategori
kategori_id: Number(document.querySelector("#kategori").value),
```

**3. `js/dashboard.js`** — fungsi baru untuk mengisi dropdown dari tabel kategori, dipanggil bersama `muatTabel()` di baris paling akhir (`muatKategori();`):

```javascript
async function muatKategori() {
  const { data, error } = await supabaseClient
    .from("kategori")
    .select("*")
    .order("id", { ascending: true });

  if (error) {
    console.error("Gagal mengambil kategori:", error);
    return;
  }

  document.querySelector("#kategori").innerHTML = data
    .map((k) => `<option value="${escapeHtml(k.id)}">${escapeHtml(k.nama)}</option>`)
    .join("");
}
```

**Cek hasil:** Direktori dan tabel dashboard tetap menampilkan kategori seperti biasa, tapi sekarang datanya berasal dari tabel `kategori`. Dropdown di form tambah berisi kategori dari tabel itu. Coba tambah satu kategori baru lewat Table Editor: pilihan itu muncul di dropdown tanpa mengubah kode.

---

## Ringkasan Perubahan dari Pertemuan 4

| File | Status | Perubahan |
|---|---|---|
| `js/common.js` | Diubah | Fungsi username dibuang, sesi memakai `auth.getSession()`, navbar async |
| `login.html` | Diubah | Email + password, tombol Masuk dan Daftar |
| `js/login.js` | Diubah | `signInWithPassword` dan `signUp`, pesan error ramah |
| `dashboard.html` | Diubah | Kolom Aksi, id pada judul form dan tombol simpan |
| `css/dashboard.css` | Ditambah | Gaya tombol Edit/Hapus |
| `js/dashboard.js` | Diubah | Penjaga sesi Supabase, Edit, Hapus, cek `data.length`, `user_id` saat insert |
| `supabase-migrasi-p5.sql` | Baru | Kolom `user_id` dan policy baru |
| `index.html`, `css/style.css`, `js/app.js` | Tidak berubah | Halaman publik tetap membaca data |

## Kalau Error

Buka Console dulu (`F12`), pesan merahnya biasanya memberi petunjuk.

| Gejala | Kemungkinan penyebab | Solusi |
|---|---|---|
| Sebelum login data ada, **setelah login data hilang** | Policy baca belum untuk `authenticated` | Jalankan ulang `supabase-migrasi-p5.sql` (Langkah 2) |
| Console `column "user_id" does not exist` | Migrasi SQL belum dijalankan | Jalankan Langkah 2 |
| `Invalid login credentials` | Email atau password salah, atau akunnya belum dibuat | Klik **Daftar akun baru** dulu |
| `Email not confirmed`, atau muncul pesan "Cek emailmu" | Confirm email masih aktif | Matikan di Langkah 1 |
| `email rate limit exceeded` saat daftar | Confirm email aktif dan terlalu banyak email terkirim | Matikan Confirm email (Langkah 1) |
| "Password terlalu pendek" | Password kurang dari 6 karakter | Pakai password minimal 6 karakter |
| `new row violates row-level security policy` saat Simpan | Belum login, `dashboard.js` belum versi baru, atau migrasi belum dijalankan | Pastikan sudah login, pakai `dashboard.js` terbaru, dan jalankan Langkah 2 |
| Tombol Edit/Hapus tidak muncul di sebuah baris | Baris itu bukan milik akunmu, atau data bawaan (tanpa pemilik) | Tambah data sendiri lewat menu Tambah UMKM |
| Klik Hapus lalu muncul "Tidak ada data yang terhapus" | Bukan pemilik data itu | Normal. Itu aturan RLS bekerja |
| Edit berhasil tanpa pesan tapi data tidak berubah | Pemeriksaan `data.length === 0` belum ada di kode | Pakai `dashboard.js` terbaru dari Langkah 9 |
| Dashboard langsung kembali ke login | Belum login, atau sesi habis | Login lagi lewat `login.html` |
| Ikon tidak muncul | Font Awesome belum termuat | Cek koneksi internet |

## Latihan Mandiri

Tambahkan tampilan **"UMKM saya"** di dashboard: tabel hanya menampilkan UMKM milik user yang login. Petunjuk: tambahkan `.eq("user_id", user.id)` pada query `select` di `muatTabel()`.
