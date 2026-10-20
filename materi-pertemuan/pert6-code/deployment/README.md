# Pertemuan 6 — Deployment: GitHub, Vercel & Keamanan Database (RLS)

**Durasi:** 19.30–21.00 WIB
**Tools:** VS Code, Git, GitHub, Vercel, Supabase
**Output:** Aplikasi Katalog UMKM hasil pertemuan 4 dan 5 sudah ada di GitHub dan bisa dibuka siapa saja lewat link publik. Peserta paham kenapa datanya aman (RLS), punya README yang layak portofolio, dan paham ketentuan proyek akhir.

> Hari ini **tidak ada fitur baru**. Kodenya sama dengan pertemuan 5. Fokusnya: membawa aplikasi dari laptop sendiri ke internet, dan memastikan datanya tetap aman begitu semua orang bisa membukanya.
>
> Folder ini (`deployment/`) berisi panduan ini dan semua SQL Supabase yang dibutuhkan. Kodenya ada di `../website-umkm/`.

## Tujuan Belajar

- Memahami kenapa aplikasi perlu di-deploy, bukan hanya berjalan di `localhost`.

- Memahami perbedaan static hosting dan server.

- Mengunggah project ke GitHub lewat Git (`init`, `add`, `commit`, `push`).

- Men-deploy project dari GitHub ke Vercel, lalu mengatur Supabase supaya login jalan di alamat baru.

- Memahami key mana yang boleh ada di kode yang di-deploy, dan apa yang sebenarnya menjaga data.

- Memahami cara kerja Row Level Security (RLS) di aplikasi UMKM, dan kenapa XSS dan SQL injection tidak berhasil.

- Menjalankan SQL pengaman, audit keamanan, dan uji serangan di Supabase.

- Menulis README yang informatif dan layak portofolio.

- Memahami dasar debugging: Console, Network, dan pesan error Supabase.

- Memahami ketentuan proyek akhir.

## Rundown

| Waktu | Aktivitas |
|---|---|
| 19.30–19.40 | Pembukaan, cek kesiapan: akun GitHub, akun Vercel, project Supabase masing-masing |
| 19.40–19.55 | Teori: deploy, static hosting, Git/GitHub/Vercel, key di kode, RLS dan keamanan |
| 19.55–20.10 | Hands-on: siapkan project, jalankan SQL, tes lokal (Langkah 1–2) |
| 20.10–20.30 | Hands-on: Git dan push ke GitHub (Langkah 3–5) |
| 20.30–20.50 | Hands-on: deploy ke Vercel, atur Supabase, uji di HP (Langkah 6–9) |
| 20.50–20.55 | Auto-deploy dan README portofolio (Langkah 10–11) |
| 20.55–21.00 | Arahan proyek akhir dan tanya jawab |

Langkah 12 (debugging) dan 13 (audit dan uji keamanan) dikerjakan kalau waktu cukup, atau dibawa pulang.

## Isi Folder

```text
pert6-code/
├── README.md            pengantar singkat
├── deployment/          folder ini
│   ├── README.md                panduan ini
│   ├── 01-supabase-lengkap.sql  SATU file untuk semua setup (tabel, RLS, admin, pengaman, audit)
│   ├── 02-supabase-secure.sql   pengaman untuk database lama yang datanya mau dipertahankan
│   ├── 03-cek-keamanan.sql      audit keamanan (hanya membaca)
│   ├── 04-uji-serangan.sql      simulasi penyerang (data uji dibatalkan otomatis)
│   ├── 05-perawatan.sql         query perawatan harian (opsional)
│   ├── 06-admin.sql             role admin untuk database lama (jalur 02). Sudah ada di 01
│   └── 07-uji-admin.sql         uji role admin
└── website-umkm/        kode siap deploy (lanjutan pertemuan 4 dan 5)
    ├── index.html  login.html  dashboard.html
    ├── css/             style.css, dashboard.css
    ├── js/              common.js, app.js, login.js, dashboard.js
    ├── .gitignore
    └── README.md        contoh README portofolio
```

**Cara termudah: jalankan `01-supabase-lengkap.sql` saja.** Satu file itu sudah berisi semuanya: tabel, RLS dan policy, role admin, 6 data awal, pengaman, dan hasil audit di bagian bawah. File lain hanya untuk kebutuhan khusus.

| File | Dipakai kapan | Mengubah data? |
|---|---|---|
| **`01-supabase-lengkap.sql`** | **Jalur utama.** Project baru, atau project lama yang datanya boleh dihapus | **Ya**, menghapus tabel `umkm` lama lalu membuat ulang beserta 6 data awal |
| `02-supabase-secure.sql` | Jalur alternatif: database lama yang **datanya mau dipertahankan** | Tidak, hanya menambah aturan |
| `03-cek-keamanan.sql` | Memeriksa kapan pun. Isinya sama dengan hasil audit di akhir `01` | Tidak |
| `04-uji-serangan.sql` | Membuktikan aturan keamanan bekerja (24 uji) | Tidak, semuanya dibatalkan otomatis |
| `05-perawatan.sql` | Klaim data lama, hapus spam, lihat jumlah data per akun | Bagian A tidak, bagian B–D ya (dinonaktifkan secara bawaan) |
| `06-admin.sql` | Hanya kalau memakai jalur `02` dan mau role admin. Sudah termasuk di `01` | Tidak menghapus data, hanya mengubah aturan |
| `07-uji-admin.sql` | Membuktikan role admin bekerja (20 uji) | Tidak, semuanya dibatalkan otomatis |

- Peserta yang sudah punya project pertemuan 5 sendiri boleh memakai project-nya. Yang dibawa ke GitHub dan Vercel cukup folder project itu.

- Peserta yang project-nya belum selesai boleh menyalin folder `website-umkm/`, lalu mengganti key Supabase dengan milik sendiri (Langkah 1).

- Bedanya kode dengan pertemuan 5 ada di tiga hal kecil: batas panjang isian di form, pesan error dari database yang lebih jelas, dan versi library Supabase yang dikunci (`@2.117.2`). Selebihnya sama.

## Teori

### Kenapa Perlu Deploy

Selama 5 pertemuan, aplikasi hanya berjalan di `localhost` lewat Live Server, artinya **hanya bisa dibuka di komputer sendiri**. Supaya teman, dosen, atau recruiter bisa membukanya lewat link, aplikasi harus **di-deploy**: disalin ke komputer milik penyedia hosting yang menyala terus, lalu diberi alamat (URL) publik.

| | localhost | URL publik |
|---|---|---|
| Alamat | `127.0.0.1:5500` | `nama-project.vercel.app` |
| Siapa yang bisa buka | Hanya kamu | Siapa saja yang punya internet |
| Menyala kalau | Live Server dijalankan | Selalu |

### Static Hosting vs Server

- **Static hosting** menyimpan file HTML, CSS, dan JS apa adanya, lalu mengirimkannya ke browser yang meminta. Semua logika (JavaScript, koneksi Supabase) berjalan di **browser pengguna**.

- **Server (backend)** menjalankan kode di sisi server dulu sebelum mengirim hasilnya (misalnya Node.js).

- Aplikasi kita **tidak butuh server sendiri**, karena Supabase sudah berperan sebagai database dan sistem login. Jadi Vercel cukup menyajikan file kita sebagai **static site**, proses deploy paling sederhana.

### Git, GitHub, dan Vercel: Siapa Mengerjakan Apa

| Alat | Peran | Analogi |
|---|---|---|
| **Git** | Mencatat riwayat perubahan kode di laptop | Buku catatan versi |
| **GitHub** | Menyimpan repository di internet | Lemari penyimpanan online |
| **Vercel** | Mengambil kode dari GitHub dan menyajikannya sebagai website | Etalase toko |

Alurnya:

```text
1. Kamu ubah kode di laptop
2. git add, git commit, git push  →  kode naik ke GitHub
3. Vercel melihat ada perubahan di GitHub
4. Vercel menyiapkan website baru, URL publik langsung ter-update
```

Karena langkah 3 dan 4 otomatis, setiap kali kamu `git push`, Vercel **men-deploy ulang sendiri**. Tidak perlu upload manual.

### Key di Kode yang Di-deploy

Di `js/common.js` ada dua nilai: `SUPABASE_URL` dan `SUPABASE_KEY`. Website kita berjalan di browser, jadi key itu **otomatis terlihat** oleh siapa saja yang membuka website (klik kanan, View Source). Apakah itu bahaya? Tergantung jenis key-nya.

| Key | Boleh di kode yang di-deploy? | Kenapa |
|---|---|---|
| **Publishable key** (`sb_publishable_...`) | **Boleh** | Memang dirancang untuk publik. Kuasanya dibatasi oleh aturan RLS di database |
| **Secret key** (`sb_secret_...`) | **Tidak boleh, tidak di mana pun di kode** | Melewati semua aturan RLS. Siapa yang memegangnya bisa membaca, mengubah, dan menghapus seluruh data |

Jadi yang menjaga data bukan "key yang disembunyikan", tapi **RLS di database**. Itu sebabnya di pertemuan 5 kita repot menulis policy.

- Kalau secret key pernah tertulis di kode atau ter-push ke GitHub, anggap sudah bocor: buat key baru di dashboard Supabase dan nonaktifkan yang lama.

- Environment variable di Vercel baru berguna kalau project punya build step (misalnya React atau Next.js) atau server. Project kita file statis tanpa build, jadi nilainya tidak bisa "disisipkan" dari Vercel. Kebiasaan ini akan terpakai kalau nanti kamu pindah ke framework.

### Keamanan Website: RLS, XSS, dan SQL Injection

Begitu link dibagikan, siapa saja bisa mencoba merusak data. Berikut pertahanan yang dipasang di aplikasi ini, dan kenapa masing-masing bekerja.

**Prinsip utama: browser tidak bisa dipercaya.** Semua kode JavaScript kita ada di browser, dan siapa pun bisa membuka DevTools, mengubah kode, atau memanggil API Supabase langsung memakai Publishable key yang terlihat. Tombol Edit dan Hapus yang disembunyikan dari tampilan itu **hanya kosmetik**. Yang benar-benar menolak serangan adalah **database**.

#### Apa itu RLS

**Row Level Security (RLS)** adalah fitur Postgres: database memeriksa **setiap baris** terhadap aturan (policy) sebelum membolehkan baca, tambah, ubah, atau hapus. Dua hal yang perlu diingat:

- Begitu RLS dinyalakan di sebuah tabel, tabel itu **tertutup untuk semua orang**. Akses hanya terbuka kalau ada policy yang mengizinkan.

- Policy ditulis per aksi (`select`, `insert`, `update`, `delete`) dan per peran: `anon` untuk pengunjung yang belum login, `authenticated` untuk user yang sudah login.

`auth.uid()` adalah id user yang sedang login, dibaca database dari token login (JWT) yang sudah diverifikasi Supabase. User tidak bisa memalsukannya dari browser.

#### Empat policy di tabel `umkm`

| Aksi | Siapa | Aturan | Artinya |
|---|---|---|---|
| Baca (`select`) | `anon`, `authenticated` | `using (true)` | Semua orang boleh melihat katalog. Ini disengaja, katalog memang publik |
| Tambah (`insert`) | `authenticated` | `with check (user_id = auth.uid())` | Harus login, dan baris yang ditambahkan harus atas nama sendiri |
| Ubah (`update`) | `authenticated` | `using` dan `with check` sama-sama `user_id = auth.uid() or is_admin()` | Pemilik, atau admin. `using` memeriksa baris lama, `with check` memeriksa hasil ubahan |
| Hapus (`delete`) | `authenticated` | `using (user_id = auth.uid() or is_admin())` | Pemilik, atau admin |

Satu hal yang sering mengejutkan: kalau RLS menolak `update` atau `delete`, Supabase **tidak mengirim error**. Hasilnya hanya "0 baris berubah". Itu sebabnya `dashboard.js` memeriksa `data.length === 0`.

#### Lapisan tambahan dari `02-supabase-secure.sql`

RLS menjawab **siapa** yang boleh. Tapi belum menjawab **apa isi** yang boleh disimpan. Lapisan kedua:

| Pengaman | Cara kerja | Menutup celah |
|---|---|---|
| Batas panjang kolom | `check` constraint (nama 100, alamat 200, jam 50, wa 20, foto 500 karakter) | Isian raksasa lewat API |
| Foto wajib `https://` | `check (foto ~* '^https://')` | Link `javascript:` atau `data:` |
| Kategori terbatas | `check (kategori in ('Kuliner','Fashion','Kerajinan'))` | Kategori palsu |
| `dibuat_oleh` diisi database | Trigger `umkm_amankan` mengambilnya dari email akun login | Memalsukan nama pembuat |
| `user_id` dikunci | Trigger mengisi `user_id` saat tambah, dan mempertahankan nilai lama saat ubah | Mengalihkan data ke akun lain |
| Batas 20 data per akun | Trigger menghitung data milik akun | Spam data |

Aturan ini ada di database, jadi **tidak bisa dilewati** dengan mengubah JavaScript di browser.

#### XSS

**XSS** adalah menyisipkan kode (misalnya `<script>`) lewat isian, supaya kode itu dijalankan di browser orang lain.

- Semua data dari database ditampilkan lewat `escapeHtml()` (di `js/common.js`) sebelum masuk ke `innerHTML`. Karakter `<`, `>`, `"`, `'`, dan `&` diubah jadi teks biasa.

- Contoh: nama usaha `<script>alert(1)</script>` tampil sebagai teks apa adanya di halaman. Kodenya tidak dijalankan.

- Link foto ikut dijaga dua lapis: `escapeHtml()` di tampilan, dan constraint `https://` di database.

- Aturan praktis: **setiap data dari luar yang masuk ke `innerHTML` wajib lewat `escapeHtml()`**. Kalau lupa di satu tempat saja, di situlah celahnya. Lebih aman lagi memakai `textContent` untuk teks polos.

#### SQL injection

**SQL injection** adalah menyisipkan perintah SQL lewat isian, supaya database menjalankannya.

- Aplikasi ini **tidak pernah merangkai SQL dari isian pengguna**. `supabase-js` mengirim nilai sebagai **data terpisah** (parameter), bukan sebagai bagian perintah. Isian `'; drop table umkm; --` tersimpan sebagai teks biasa.

- Pencarian dan filter kategori berjalan di browser (JavaScript) terhadap data yang sudah diambil, jadi tidak dikirim ke database sebagai query.

- Satu-satunya SQL yang kita tulis (file `.sql`) dijalankan oleh kita sendiri di SQL Editor, bukan oleh pengunjung.

#### Yang TIDAK dilindungi oleh semua ini

Supaya tidak salah paham:

- **Data katalog terbuka untuk dibaca siapa saja.** Jangan menyimpan data rahasia (nomor pribadi, alamat rumah) di tabel ini.

- **Pendaftaran terbuka.** Siapa saja bisa membuat akun dan menambah data sampai batas 20 per akun. Pembatas tambahannya ada di pengaturan Supabase Auth (Langkah 13).

- **Secret key.** Kalau bocor, RLS tidak berlaku lagi. Pastikan tidak pernah ada di kode atau GitHub.

- **Tabel lain di project yang sama.** Tabel tanpa RLS bisa dibaca dan diubah siapa saja yang punya Publishable key. Itu yang diperiksa `03-cek-keamanan.sql`.

### Menulis README yang Layak Portofolio

README adalah halaman pertama yang dilihat orang saat membuka repository GitHub kamu, termasuk recruiter. README yang baik menjawab: **apa ini, kenapa dibuat, dan bagaimana menjalankannya**.

1. **Judul dan deskripsi singkat**: satu atau dua kalimat tentang aplikasinya.

2. **Screenshot**: gambar tampilan aplikasi. Recruiter sering tidak sempat mengklik link.

3. **Link demo**: URL Vercel.

4. **Fitur utama**: daftar poin.

5. **Tech stack**: teknologi yang dipakai.

6. **Cara menjalankan secara lokal**: langkah singkat.

7. **Anggota tim**: untuk proyek kelompok.

Contoh lengkapnya ada di `website-umkm/README.md`.

### Dasar Debugging

| Alat | Cara buka | Kegunaan |
|---|---|---|
| Console | `F12` lalu tab **Console** | Pesan error JavaScript dan hasil `console.log` |
| Network | `F12` lalu tab **Network** | Semua permintaan data (termasuk ke `supabase.co`) beserta status dan responsnya |
| Pesan error Supabase | `error` dari `{ data, error }` di kode | Alasan query gagal, misalnya `code`, `message` |

Kebiasaan debugging yang baik: baca pesan error **kata per kata**, termasuk nama file dan nomor barisnya, sebelum bertanya ke orang lain atau AI.

## Hands-on: Langkah demi Langkah

### Langkah 1 — Siapkan Project dan Database

**1a. Siapkan folder project.**

- Pakai project pertemuan 5-mu sendiri, **atau** salin folder `website-umkm/` dari `pert6-code/` ke tempat kerjamu.

- Buka folder itu di VS Code. Pastikan `index.html` ada di **akar folder** (bukan di dalam folder lain).

**1b. Pakai key project Supabase milikmu sendiri.**

Buka `js/common.js` dan cek dua baris ini:

```js
const SUPABASE_URL = "https://xxxxxxxxxxxx.supabase.co";
const SUPABASE_KEY = "sb_publishable_...";
```

- Ganti `SUPABASE_URL` dan `SUPABASE_KEY` dengan milik project-mu, dari dashboard Supabase (halaman API Keys, seperti di pertemuan 4).

- Pastikan yang dipakai **Publishable key**. Jangan pernah pakai Secret key.

**1c. Siapkan database.** Cukup satu file: `deployment/01-supabase-lengkap.sql`.

1. Buka file itu di VS Code. Cari bagian **6. Angkat emailmu jadi admin**, lalu ganti `GANTI-DENGAN-EMAILMU@contoh.com` dengan email akun yang kamu pakai login. Akun itu sudah harus terdaftar (lihat di Supabase menu **Authentication > Users**). Kalau belum, daftar dulu lewat aplikasi.

2. Buka Supabase, **SQL Editor**, klik **New query**.

3. Copy **seluruh isi** file, paste, lalu klik **Run**.

4. Kalau Supabase menampilkan peringatan "destructive operation" (karena ada `drop`), baca dulu, lalu konfirmasi.

- `01-supabase-lengkap.sql` menghapus tabel `umkm` lama lalu membuatnya lagi, jadi **semua data lama hilang** dan diganti 6 data contoh. Akun login tidak ikut terhapus.

- Aman dijalankan berulang. Hasilnya selalu kembali ke kondisi awal yang sama.

- Kalau datamu mau dipertahankan, pakai `02-supabase-secure.sql` (tanpa role admin), lalu `06-admin.sql` kalau butuh admin.

**Cek hasil:** di bawah SQL Editor muncul tabel 16 baris (hasil audit). Semuanya berstatus **AMAN** atau **INFO**, tidak ada **PERIKSA**. Baris terakhir (`Jumlah akun admin`) menunjukkan `1 akun` kalau emailmu ditemukan.

**Kalau error:**

- Baris `Jumlah akun admin` menunjukkan `0 akun` → emailmu tidak ditemukan atau salah ketik. Perbaiki emailnya di bagian 6, lalu jalankan ulang file itu (atau jalankan baris `insert into public.admin ...` saja).

- Pesan error di tengah jalan → jalankan ulang seluruh file dari awal. Jangan menjalankan sebagian saja.

### Langkah 2 — Tes di Lokal Dulu

Jangan deploy aplikasi yang belum jalan. Tes dulu di komputer sendiri:

1. Klik kanan `index.html`, pilih **Open with Live Server**.

2. Pastikan daftar UMKM tampil.

3. Klik **Login**, daftar akun (kalau belum), lalu masuk.

4. Di dashboard, coba tambah, edit, dan hapus satu data.

**Cek hasil:** semua fitur jalan di `localhost`.

**Kalau error:**

- Daftar kosong dan ada tulisan "Isi SUPABASE_URL dan SUPABASE_KEY dulu" → `js/common.js` belum diisi dengan benar.

- Ada pesan "Batas 20 UMKM per akun sudah tercapai" → itu aturan dari `02-supabase-secure.sql`, bukan error.

### Langkah 3 — Pasang dan Atur Git

1. Buka terminal VS Code (**Terminal > New Terminal**) dan cek Git:

```bash
git --version
```

2. Kalau belum pernah mengatur identitas, jalankan (ganti dengan datamu):

```bash
git config --global user.name "Nama Kamu"
git config --global user.email "emailgithub@contoh.com"
```

**Cek hasil:** `git --version` menampilkan nomor versi (misalnya `git version 2.x`).

**Kalau error:** `git is not recognized` → Git belum terpasang. Instal dari [git-scm.com](https://git-scm.com/), lalu tutup dan buka ulang VS Code.

### Langkah 4 — Buat Repository di GitHub

1. Buka [github.com](https://github.com/) dan login (daftar dulu kalau belum punya akun).

2. Klik tombol **+** di pojok kanan atas, lalu **New repository**.

3. Isi:

   - **Repository name:** `website-umkm` (huruf kecil, tanpa spasi).

   - **Public** (supaya recruiter bisa melihat).

   - **Jangan** centang "Add a README file", "Add .gitignore", atau "Choose a license". Project-mu sudah punya file sendiri, dan repo harus kosong supaya `push` pertama tidak bentrok.

4. Klik **Create repository**.

**Cek hasil:** halaman repo kosong terbuka, berisi petunjuk "Quick setup" dengan alamat repo seperti `https://github.com/namamu/website-umkm.git`. Salin alamat itu.

### Langkah 5 — Push Project ke GitHub

Di terminal VS Code, pastikan posisi terminal **di dalam folder project** (folder yang berisi `index.html`). Lalu jalankan satu per satu:

```bash
git init
git add .
git commit -m "Katalog UMKM: versi siap deploy"
git branch -M main
git remote add origin https://github.com/namamu/website-umkm.git
git push -u origin main
```

Penjelasan tiap baris:

- `git init` — mengubah folder ini jadi repository Git.

- `git add .` — menandai semua file untuk disimpan di commit berikutnya.

- `git commit -m "..."` — menyimpan "foto" kondisi kode saat ini, lengkap dengan catatannya.

- `git branch -M main` — menamai cabang utama `main`.

- `git remote add origin ...` — memberi tahu Git alamat repo di GitHub. Ganti `namamu` dengan username GitHub-mu.

- `git push -u origin main` — mengirim commit ke GitHub.

Saat `push` pertama, akan muncul jendela login GitHub di browser. Pilih **Sign in with your browser**, lalu izinkan.

**Cek hasil:** refresh halaman repo di GitHub. File `index.html`, folder `css`, `js`, dan `supabase` muncul, dan README tampil di bawahnya.

**Kalau error:**

- `fatal: not a git repository` → terminal belum berada di folder project. Cek dengan `pwd` atau buka folder yang benar lewat **File > Open Folder**.

- `remote origin already exists` → jalankan `git remote set-url origin https://github.com/namamu/website-umkm.git`.

- `Authentication failed` atau `Permission denied` → login GitHub di browser belum berhasil. Ulangi `git push -u origin main`.

- `failed to push some refs` karena repo tidak kosong (kamu mencentang README tadi) → hapus repo di GitHub (Settings > Danger Zone), lalu buat ulang tanpa file apa pun.

- Setelah `git add .`, cek dengan `git status` bahwa tidak ada file aneh (misalnya `notes.txt`, `.env`). File yang tertulis di `.gitignore` otomatis dilewati.

### Langkah 6 — Deploy ke Vercel

1. Buka [vercel.com](https://vercel.com/), klik **Sign Up**, lalu pilih **Continue with GitHub**. Izinkan akses.

2. Di dashboard, klik **Add New...** lalu **Project**.

3. Di daftar **Import Git Repository**, cari `website-umkm` lalu klik **Import**.

   - Kalau repo belum muncul, klik **Adjust GitHub App Permissions**, beri akses ke repo itu, lalu kembali.

4. Di halaman **Configure Project**, biarkan pengaturan bawaan, dengan tiga hal yang perlu dicek:

   - **Framework Preset:** `Other` (project kita bukan React atau Next.js).

   - **Root Directory:** `./` (akar repo).

   - **Build Command** dan **Output Directory:** kosongkan, tidak perlu diubah. Tidak ada proses build.

   - **Environment Variables:** tidak perlu diisi.

5. Klik **Deploy** dan tunggu (biasanya kurang dari satu menit).

**Cek hasil:** muncul layar sukses dengan konfeti dan tombol **Continue to Dashboard**. Di dashboard ada gambar pratinjau website dan alamat seperti `website-umkm-namamu.vercel.app`. Klik alamat itu, halaman utama Katalog UMKM terbuka.

**Kalau error:**

- Halaman **404 NOT_FOUND** → `index.html` tidak berada di akar repo (terbungkus folder lain). Dua pilihan: pindahkan file ke akar, atau di Vercel buka **Settings > General > Root Directory** lalu isi nama foldernya.

- Halaman tampil tanpa gaya atau gambar → huruf besar-kecil nama file berbeda (`Style.css` vs `style.css`). Windows tidak peduli, Vercel peduli. Samakan penulisannya, lalu push ulang.

- Halaman tampil tapi daftar UMKM kosong → lihat Langkah 8 dan Langkah 12.

**Alternatif untuk mentor:** kalau kode ada di repo besar (misalnya `Website-UNSIKA`), di langkah 4 isi **Root Directory** dengan `materi-pertemuan/pert6-code/website-umkm`.

### Langkah 7 — Atur Supabase untuk Alamat Baru

Login memakai email, dan Supabase perlu tahu alamat website-mu yang sebenarnya.

1. Salin URL Vercel-mu (misalnya `https://website-umkm-namamu.vercel.app`).

2. Buka dashboard Supabase, menu **Authentication**, lalu **URL Configuration**.

3. Isi:

   - **Site URL:** URL Vercel-mu.

   - **Redirect URLs:** klik **Add URL**, isi `https://website-umkm-namamu.vercel.app/**`.

4. Klik **Save changes**.

**Cek hasil:** pengaturan tersimpan.

Kenapa penting: kalau **Confirm email** aktif, Supabase mengirim link konfirmasi ke email pendaftar. Tanpa pengaturan ini, link itu mengarah ke `localhost` dan tidak bisa dibuka orang lain.

### Langkah 8 — Uji di URL Publik dan di HP

1. Buka URL Vercel di browser.

2. Coba semuanya: lihat daftar, cari, filter kategori, daftar akun, login, tambah, edit, hapus, logout.

3. Kirim link ke HP (lewat chat), lalu buka dengan **data seluler** (matikan WiFi), supaya terbukti benar-benar publik.

4. Minta temanmu membuka link itu, lalu coba edit atau hapus data milikmu. Harusnya ditolak. Itu RLS bekerja di website yang sudah live.

**Cek hasil:** semua fitur sama seperti di localhost, dan website terbuka dari perangkat lain di luar jaringanmu.

**Kalau error:**

- Daftar UMKM kosong, di Console ada error → `SUPABASE_URL` atau `SUPABASE_KEY` salah, atau lupa di-push. Cek `js/common.js`, perbaiki, `git add .`, `git commit`, `git push`.

- Pendaftaran berhasil tapi link konfirmasi di email mengarah ke `localhost` → ulangi Langkah 7.

- Login gagal dengan "Email not confirmed" → buka email, klik link konfirmasi dulu.

### Langkah 9 — Ganti Nama Alamat (Opsional)

Alamat bawaan Vercel kadang panjang. Kamu bisa menggantinya selama masih tersedia:

1. Di dashboard Vercel, buka project-mu, **Settings > Domains**.

2. Pilih domain `.vercel.app` yang ada, klik **Edit**, lalu isi nama baru, misalnya `umkm-karawang-namamu.vercel.app`.

3. Kalau alamat berubah, ulangi Langkah 7 dengan alamat yang baru.

**Cek hasil:** alamat baru bisa dibuka.

### Langkah 10 — Auto-Deploy: Push Sekali, Live Sendiri

1. Ubah sesuatu yang kecil, misalnya tulisan judul di `index.html`.

2. Simpan, lalu di terminal:

```bash
git add .
git commit -m "Ubah judul halaman"
git push
```

3. Di dashboard Vercel, buka tab **Deployments**.

**Cek hasil:** muncul deployment baru dengan status **Building**, lalu **Ready**, tanpa kamu menekan tombol Deploy. Refresh URL publik, perubahanmu sudah tampil.

**Kalau error:**

- Perubahan tidak tampil → pastikan `git push` berhasil (cek di GitHub bahwa commit terbaru ada), lalu refresh keras dengan `Ctrl + Shift + R`.

- Status deployment **Error** → klik deployment itu, baca log-nya.

### Langkah 11 — Rapikan README Portofolio

1. Buka `README.md` di project-mu (di `website-umkm/` sudah ada contohnya).

2. Ganti bagian ini:

   - Link demo: isi dengan URL Vercel-mu.

   - Anggota: isi namamu.

   - Screenshot: buat folder `screenshot/`, simpan gambar tampilan (halaman utama dan dashboard), lalu hapus tanda komentar `<!-- -->` pada baris gambar.

3. Cek tampilannya lewat **Open Preview** di VS Code (`Ctrl + Shift + V`).

4. Push:

```bash
git add .
git commit -m "Lengkapi README dengan link demo dan screenshot"
git push
```

**Cek hasil:** halaman utama repo di GitHub menampilkan README rapi lengkap dengan screenshot dan link demo yang bisa diklik.

### Langkah 12 — Latihan Debugging (Kalau Waktu Cukup)

1. Di `js/app.js` baris 11, ubah `".grid-umkm"` menjadi `".grid-umkmm"` (tambah satu huruf `m`).

2. Refresh halaman di Live Server, lalu buka Console (`F12`).

3. Baca pesan error yang muncul:

```text
Uncaught (in promise) TypeError: Cannot set properties of null (setting 'innerHTML')
    at ambilUmkm (app.js:66)
```

4. Cara membacanya:

   - `Cannot set properties of null` → kode mencoba mengisi sesuatu yang **tidak ditemukan** (`null`).

   - `app.js:66` → file dan baris tempat kejadian.

   - Baris itu `gridUmkm.innerHTML = ...`, dan `gridUmkm` berasal dari `querySelector(".grid-umkm")` di baris 11. Ternyata selector-nya salah ketik.

5. Kembalikan ke `".grid-umkm"`.

6. Latihan Network: buka tab **Network**, refresh, lalu cari permintaan ke `umkm?select=*` (alamat `supabase.co`). Klik, lalu lihat **Status** (200 = berhasil) dan tab **Response** (isi datanya).

**Cek hasil:** kamu bisa menunjukkan baris penyebab error hanya dari membaca pesan di Console.

### Langkah 13 — Audit dan Uji Keamanan Sebelum Link Disebar

Link publik berarti siapa saja bisa mencoba mendaftar dan menambah data. Lakukan tiga hal ini.

**13a. Audit: `03-cek-keamanan.sql`.**

Hasilnya sudah muncul di akhir `01-supabase-lengkap.sql`. Untuk memeriksa lagi kapan saja, jalankan `03-cek-keamanan.sql` di SQL Editor (hanya membaca). Hasilnya 16 baris. Cara membaca yang penting:

| No | Yang diperiksa | Harapan |
|---|---|---|
| 1 | RLS aktif di semua tabel `public` | `semua tabel aktif` |
| 2 | Tabel `umkm` punya 4 policy | `4 policy` |
| 3 | Policy tulis untuk `anon` atau `public` | `0` |
| 4 | Policy tulis yang meloloskan semua orang (`true`) | `0` |
| 5 | Insert, update, delete memeriksa `auth.uid()` | `3 dari 3 policy` |
| 6–7 | Constraint dan trigger dari file 02 | `3 dari 3`, `ada` |
| 8–10 | Fungsi `security definer`, dan view | `0` |
| 11–14 | Informasi: data tanpa pemilik, akun terdaftar, dll | `INFO` |
| 15–16 | Tabel `admin` tertutup dari API, dan jumlah admin | `RLS aktif, 0 policy`, `1 akun` |

**Cek hasil:** tidak ada baris berstatus **PERIKSA**.

**Kalau ada PERIKSA:** baca kolom `pemeriksaan` dan `hasil`. Baris 1 menyebut nama tabel yang RLS-nya mati. Perbaikinya `alter table public.nama_tabel enable row level security;` lalu buat policy yang sesuai.

**13b. Uji serangan: `04-uji-serangan.sql`.**

Skrip ini membuat tiga akun palsu, lalu berpura-pura jadi pengunjung dan user lain yang mencoba: menambah data tanpa login, mengubah dan menghapus data orang lain, memalsukan nama pembuat dan pemilik, mengirim nama 101 karakter, link `javascript:`, kategori palsu, dan menambah data ke-21.

- Jalankan di SQL Editor.

- Hasilnya muncul sebagai **pesan error berjudul "UJI SELESAI"**. Itu disengaja: error di akhir membatalkan semua akun dan data uji supaya databasemu tetap bersih.

- Baca laporannya. Tiap baris **LULUS** atau **GAGAL**.

**Cek hasil:** baris terakhir `TOTAL: 24 uji, 0 gagal`.

**Kalau ada GAGAL:** artinya ada aturan yang belum terpasang. Jalankan ulang `01-supabase-lengkap.sql` (atau `02-supabase-secure.sql` untuk database lama), lalu ulangi 13b. Uji role admin ada di `07-uji-admin.sql`.

**13c. Pengaturan di dashboard Supabase** (tidak bisa lewat SQL):

- [ ] Yang ada di `js/common.js` adalah **Publishable key**, bukan Secret key.

- [ ] Buka **Advisors > Security Advisor**, dan tidak ada peringatan merah tentang tabel tanpa RLS.

- [ ] Putuskan soal pendaftaran:

  - Nyalakan **Confirm email** (Authentication > Sign In / Providers > Email) supaya akun palsu lebih sulit dibuat.

  - Atau setelah kelas selesai, matikan pendaftaran baru lewat pengaturan **Allow new users to sign up** supaya katalog tidak dibanjiri akun.

- [ ] Sesekali jalankan `05-perawatan.sql` bagian A untuk melihat jumlah data per akun. Kalau ada akun yang jauh di atas yang lain, itu tanda spam.

### Hasil Akhir Sesi Ini

Struktur project yang di-push ke GitHub:

```text
website-umkm/
├── index.html
├── login.html
├── dashboard.html
├── css/
├── js/
├── .gitignore
└── README.md
```

File SQL (`deployment/`) tidak perlu ikut ke repo aplikasi. Simpan di repo kelas atau di komputermu sebagai arsip.

Aplikasi sudah live di URL publik Vercel, ter-update otomatis setiap `git push`, dan repository GitHub punya README yang layak dijadikan portofolio.

## Role Admin: Dua Role di Aplikasi

Aplikasi punya dua role. Semua pengaturannya sudah termasuk di `01-supabase-lengkap.sql` dan `js/dashboard.js` di `website-umkm/`.

| Role | Boleh apa |
|---|---|
| **User biasa** | Tambah data, dan ubah atau hapus **hanya data miliknya sendiri** |
| **Admin** | Tambah data sendiri, dan ubah atau hapus **semua data** (termasuk data bawaan tanpa pemilik) |

### Apa yang berubah dibanding pertemuan 5

| Bagian | Berubah? | Keterangan |
|---|---|---|
| Database (Supabase) | **Ya** | Tabel `admin`, fungsi `is_admin()`, dan policy ubah/hapus diperluas. Semuanya ada di `01-supabase-lengkap.sql` |
| `js/dashboard.js` | **Ya, sedikit** | Menanyakan `is_admin()` ke database, lalu menampilkan tombol Edit dan Hapus di semua baris kalau admin |
| HTML dan CSS | **Tidak** | Tidak ada elemen atau gaya baru |
| `index.html`, `login.js`, `app.js`, `common.js` | **Tidak** | Tetap sama |

Pembagian tugasnya: **database yang memutuskan** siapa boleh apa (RLS), dan **JavaScript hanya mengatur tampilan** tombol. Kalau JavaScript-nya tidak diubah, admin tetap diizinkan database, tapi tombolnya tidak muncul di baris milik orang lain.

Perubahan di `dashboard.js` cuma empat tempat, semuanya diberi komentar di file itu: tanya `is_admin()` saat halaman dibuka, label nama jadi `nama (admin)`, dan syarat tombol Edit/Hapus menjadi "milik sendiri **atau** admin". Kalau fungsi `is_admin()` belum ada di database, dashboard tetap jalan seperti user biasa.

### Cara mengangkat admin

Tidak ada akun admin bawaan dan tidak ada password yang ditulis di file SQL. Admin adalah akun biasa yang didaftarkan lewat aplikasi, lalu ditandai di database.

- **Saat menjalankan `01`:** ganti email di bagian 6 (lihat Langkah 1c).

- **Kapan saja setelahnya**, jalankan di SQL Editor (ganti emailnya), lalu logout dan login lagi:

```sql
insert into public.admin (user_id)
select id from auth.users where email = 'emailkamu@contoh.com'
on conflict do nothing;
```

- **Mencabut status admin:**

```sql
delete from public.admin
where user_id = (select id from auth.users where email = 'emailkamu@contoh.com');
```

### Uji role admin

**Uji otomatis:** jalankan `07-uji-admin.sql` di SQL Editor. Seperti `04`, hasilnya muncul sebagai pesan error berjudul "UJI SELESAI" dan semua data uji dibatalkan. Harapannya `TOTAL: 20 uji, 0 gagal`. Yang diuji antara lain: user biasa tidak bisa mengangkat dirinya jadi admin, tabel `admin` tertutup dari API, admin bisa mengubah dan menghapus data orang lain tanpa mengubah pemiliknya, dan batas 20 data tidak berlaku untuk admin.

**Uji manual dengan dua akun:**

1. Login sebagai user biasa: tombol Edit dan Hapus hanya muncul di barisnya sendiri.

2. Login sebagai admin: namamu tampil dengan tulisan `(admin)`, dan semua baris punya tombol Edit dan Hapus.

3. Sebagai admin, edit satu data milik user lain. Kolom "Dibuat oleh" tetap nama pembuat aslinya.

### Catatan keamanan untuk admin

- **Jangan menandai admin lewat `user_metadata`.** Isinya bisa diubah user sendiri dari browser, jadi siapa saja bisa menjadikan dirinya admin. Karena itu kita memakai tabel `admin` yang tertutup dari API.

- Tabel `admin` memakai RLS tanpa policy: tidak ada yang bisa membaca atau menulis lewat API. Hanya kamu dari SQL Editor.

- Fungsi `is_admin()` hanya bisa dipanggil user yang login, dan hanya menjawab `true` atau `false` untuk dirinya sendiri. Tidak ada cara untuk menanyakan "siapa saja adminnya" lewat API.

- Akun admin sebaiknya memakai password kuat, dan jangan dibagikan. Satu akun admin yang bocor berarti semua data bisa diubah.

**Kalau error:**

- Tombol Edit/Hapus admin tidak muncul → cek hasil audit bahwa `Jumlah akun admin` berisi `1 akun` atau lebih, lalu logout dan login lagi.

- Label `(admin)` tidak muncul padahal sudah diangkat → buka Console (`F12`) dan tab Network, lalu lihat permintaan `rpc/is_admin`. Kalau gagal, fungsinya belum ada: jalankan ulang `01` (atau `06` untuk jalur `02`).

- Admin mengedit data tapi muncul "Tidak ada data yang berubah" → policy ubah belum diperluas. Jalankan ulang `01` (atau `06`).

## Masalah yang Sering Muncul

| Gejala | Penyebab biasanya | Solusi |
|---|---|---|
| 404 di Vercel | `index.html` tidak di akar repo | Pindahkan ke akar, atau atur Root Directory |
| Halaman polos tanpa gaya | Huruf besar-kecil nama file beda | Samakan nama file dan isi `href`, lalu push |
| Daftar UMKM kosong di Vercel | Key atau URL salah, atau belum di-push | Cek `js/common.js`, lalu push |
| Link konfirmasi email ke `localhost` | Site URL Supabase belum diganti | Langkah 7 |
| Edit atau Hapus muncul "Kamu bukan pemilik" | Data milik akun lain, atau data bawaan tanpa pemilik | Normal. Itu aturan RLS |
| "Batas 20 UMKM per akun sudah tercapai" | Aturan dari `02-supabase-secure.sql` | Hapus data lama (`05-perawatan.sql` bagian C), atau naikkan angka batas di file 02 |
| Perubahan tidak tampil setelah push | Belum ter-push, atau cache browser | Cek commit di GitHub, lalu `Ctrl + Shift + R` |
| `git push` ditolak | Belum login GitHub, atau repo tidak kosong | Lihat daftar error di Langkah 5 |

## Arahan Proyek Akhir

Proyek akhir dikerjakan berkelompok (3–4 orang) setelah pertemuan ini selesai. Gunakan `panduan-proyek-akhir.md` sebagai checklist lengkap. Poin yang perlu disepakati kelompok di awal:

1. **Pilih topik.** Boleh melanjutkan tema UMKM, atau topik lain yang disetujui (ada ide cadangan di panduan proyek akhir).

2. **Bagi peran.** Misalnya satu orang fokus database, satu tampilan, satu logika JavaScript dan Supabase, satu deploy dan dokumentasi. Boleh tumpang tindih, asal semua paham keseluruhan kode.

3. **Rancang tabel database di awal**, sebelum menulis banyak kode. Mengubah struktur tabel di tengah jalan sering menimbulkan bug yang tidak perlu.

4. **Satu repository untuk satu kelompok.** Anggota lain diundang lewat **Settings > Collaborators** di GitHub.

5. **Commit sesering mungkin** dengan pesan yang jelas, supaya kontribusi tiap anggota tercatat.

6. **Pakai pola keamanan yang sama.** RLS aktif di semua tabel, hanya Publishable key di kode, dan `escapeHtml()` untuk semua data yang ditampilkan.

7. Semua anggota harus bisa menjelaskan kode timnya sendiri. AI boleh membantu menulis, tapi bukan pengganti pemahaman saat ditanya pengajar.

## Rangkuman

Aplikasi yang tadinya hanya berjalan di komputer sendiri kini bisa dibuka siapa saja lewat URL publik. Alurnya: kode di-`push` ke GitHub, Vercel men-deploy-nya, dan setiap `git push` berikutnya otomatis memperbarui website. Keamanan data dijaga oleh RLS di database, bukan oleh kunci yang disembunyikan. README yang baik membuat project layak dipajang sebagai portofolio. Seluruh kurikulum inti Website UNSIKA selesai, perjalanan berikutnya adalah proyek akhir kelompok.

## Istilah Penting

| Istilah | Artinya |
|---|---|
| Deploy | Menyalin dan menjalankan aplikasi di server publik supaya bisa diakses lewat internet |
| Static hosting | Layanan yang menyimpan dan mengirim file HTML, CSS, JS apa adanya |
| Repository (repo) | Folder project yang dilacak Git |
| Commit | "Foto" kondisi kode pada satu waktu, lengkap dengan catatan |
| Push | Mengirim commit dari laptop ke GitHub |
| Auto-deploy | Deploy ulang otomatis setiap ada perubahan baru di repository |
| Publishable key | Key Supabase yang boleh terlihat publik, kuasanya dibatasi RLS |
| Secret key | Key Supabase yang melewati RLS, tidak boleh ada di kode atau GitHub |
| Site URL | Alamat website yang dikenali Supabase untuk link login dan konfirmasi email |
| Trigger | Fungsi database yang berjalan otomatis sebelum atau sesudah data disimpan |
| README | File dokumentasi utama sebuah repository |
