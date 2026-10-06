# Pertemuan 4 — Database & Supabase (Login, Read, Create)

> Kode lengkap ada di `implementasi-supabase/` (contoh jadi, key dummy) dan `mulai-dari-kosong/` (folder kosong untuk dikerjakan ulang). Panduan step-by-step ada di [`implementasi-supabase/README.md`](implementasi-supabase/README.md).

**Durasi:** 19.30–21.00 WIB
**Tools:** VS Code, Live Server, Supabase
**Output:** Peserta dapat membuat tabel di Supabase, menampilkan data UMKM dari database (Read), membuat login username sederhana, dan menambah data lewat dashboard (Create).

## Tujuan belajar

- Memahami kenapa data perlu disimpan di database, bukan hanya di array JavaScript.
- Memahami konsep tabel, baris, kolom, dan primary key.
- Memahami apa itu Supabase dan bedanya Publishable key vs Secret key.
- Membuat tabel di Supabase lewat SQL Editor.
- Menampilkan data dari Supabase ke Direktori UMKM (`select`).
- Membuat login username sederhana dan halaman dashboard yang dijaga.
- Menambah data UMKM lewat form di dashboard (`insert`).

## Rundown

| Waktu | Aktivitas |
|---|---|
| 19.30–19.40 | Pembukaan, ice breaking: "pernah nggak isi form panjang terus HP restart dan datanya hilang?" |
| 19.40–20.00 | Teori ringkas: kenapa butuh database, tabel/baris/kolom, Supabase, key, RLS |
| 20.00–20.15 | Hands-on: buat project dan tabel di Supabase (script SQL) |
| 20.15–20.30 | Hands-on: Direktori UMKM mengambil data dari Supabase (Read) |
| 20.30–20.45 | Hands-on: halaman login username + navbar |
| 20.45–20.55 | Hands-on: dashboard + tambah UMKM (Create) |
| 20.55–21.00 | Rangkuman dan pengantar kuis 4 |

## Teori

### Kenapa array JavaScript saja tidak cukup

Minggu lalu, data UMKM disimpan dalam array langsung di `app.js`. Masalahnya:

- Data itu **hilang setiap kali halaman di-refresh** — array dibuat ulang dari nol tiap kali file JavaScript dijalankan.
- Data itu **hanya ada di komputer masing-masing** — tidak dibagikan ke pengguna lain yang membuka halaman yang sama.
- Kalau ada 100 UMKM, menuliskannya manual di kode jadi tidak realistis.

Kita butuh tempat penyimpanan yang **permanen** dan bisa diakses dari mana saja: **database**.

> Slide visual: dua kotak — "Array di JavaScript (hilang saat refresh)" vs "Database (tetap ada meski browser ditutup)".

### Apa itu database, tabel, baris, dan kolom

Analogi: database itu seperti **lemari arsip** di kantor.

| Istilah database | Analogi lemari arsip |
|---|---|
| Database | Lemari arsip itu sendiri |
| Tabel | Satu laci, khusus untuk satu jenis data (misalnya laci "UMKM") |
| Baris (row) | Satu berkas/map di dalam laci — satu data UMKM |
| Kolom (column) | Kolom isian di formulir tiap berkas — nama, kategori, alamat |

```text
Tabel: umkm
┌────┬───────────────────────┬───────────┬──────────────────────────┐
│ id │ nama                  │ kategori  │ alamat                   │
├────┼───────────────────────┼───────────┼──────────────────────────┤
│ 1  │ Warung Bu Sari        │ Kuliner   │ Jl. Merdeka No. 10       │
│ 2  │ Batik Karawang Asli   │ Fashion   │ Jl. Kertabumi No. 5      │
└────┴───────────────────────┴───────────┴──────────────────────────┘
```

Setiap kolom punya **tipe data**, mirip tipe data di JavaScript: `text` (teks), `int8`/`numeric` (angka), `bool` (benar/salah), `timestamp` (tanggal-waktu).

### Primary key: identitas unik tiap baris

Setiap tabel butuh satu kolom yang nilainya **selalu unik** untuk membedakan satu baris dari baris lain, biasanya kolom `id`. Ini disebut **primary key** — seperti Nomor Induk Mahasiswa (NIM), tidak ada dua mahasiswa dengan NIM sama.

Supabase otomatis menyediakan kolom `id` bertipe angka yang bertambah otomatis (`1, 2, 3, ...`) setiap tabel baru dibuat.

### Apa itu Postgres

**PostgreSQL** (disingkat Postgres) adalah salah satu jenis database yang sangat umum dipakai di industri. Postgres menyimpan data dalam bentuk tabel-tabel seperti contoh di atas, dan punya bahasa khusus untuk mengambil/mengubah data yang disebut **SQL**.

Untuk kelas ini, kita tidak menulis SQL manual — Supabase menyediakan **JavaScript client** yang menerjemahkan kode JavaScript kita menjadi perintah SQL di belakang layar.

### Apa itu Supabase

Supabase adalah layanan yang menyediakan database Postgres siap pakai lewat internet, lengkap dengan:

- **Table Editor** — antarmuka visual untuk membuat tabel tanpa menulis SQL.
- **API otomatis** — begitu tabel dibuat, Supabase langsung menyediakan cara untuk mengakses data itu dari kode JavaScript.
- **Auth** — sistem login/register siap pakai (dipelajari pertemuan 5).

```text
Browser (JavaScript) --- kirim perintah lewat Supabase Client ---> Supabase (Postgres)
Browser (JavaScript) <--- kirim balik data ----------------------  Supabase (Postgres)
```

> Slide visual: diagram di atas dengan logo Supabase di tengah sebagai jembatan antara Browser dan Postgres.

### API Key: Publishable vs Secret

Setiap project Supabase punya dua jenis kunci akses:

| Key | Kegunaan | Boleh dipakai di frontend? |
|---|---|---|
| **Publishable key** (`sb_publishable_...`) | Akses terbatas, dipakai di kode yang jalan di browser pengguna | **Ya**, aman dilihat siapa saja |
| **Secret key** (`sb_secret_...`) | Akses penuh tanpa batasan apa pun, seperti "kunci master" | **Tidak pernah** — kalau bocor, siapa pun bisa membaca/menghapus semua data |

> Di tutorial lama, Publishable key disebut **anon key** dan Secret key disebut **service_role key**. Fungsinya sama, cuma namanya diganti Supabase. Kalau kamu menemukan nama lama di tutorial lain, anggap itu pasangannya.

Analogi: Publishable key seperti kartu akses karyawan biasa (bisa masuk lobi, ruang kerja); Secret key seperti kartu akses ruang server pusat — kalau dipegang orang yang salah, seluruh sistem bisa dibobol.

Untuk kelas ini, kita **hanya memakai Publishable key** di kode frontend, dan tidak pernah menyentuh Secret key.

### Row Level Security (RLS) dan Policy

Publishable key itu publik — siapa pun bisa melihatnya di kode website. Lalu apa yang mencegah orang sembarangan mengacak-acak data? Jawabannya **RLS**.

- **RLS aktif** artinya tabel "terkunci": semua akses ditolak.

- **Policy** adalah aturan yang membuka kunci itu sebagian, misalnya "boleh membaca" atau "boleh menambah".

- Di tabel `umkm` hari ini, kita buat dua policy: boleh **select** (membaca) dan boleh **insert** (menambah). Tidak ada policy edit atau hapus, jadi dua aksi itu otomatis ditolak.

Kalau tabel dikunci tapi lupa membuat policy baca, hasilnya data kosong **tanpa pesan error**. Ini jebakan yang sering bikin bingung.

### Login Sederhana: Username dan `localStorage`

Hari ini loginnya sengaja dibuat paling sederhana: cukup isi username, tanpa password.

- Username disimpan di **`localStorage`** — memori kecil di browser yang datanya tetap ada walau halaman di-refresh atau ditutup.

- Halaman dashboard mengecek: ada username di `localStorage`? Kalau tidak ada, pengunjung langsung dipindah ke halaman login.

- **Ini bukan keamanan sungguhan.** Siapa pun bisa mengetik username apa saja, atau mengisi `localStorage` lewat Console browser. Fungsinya cuma menandai "sudah login" supaya kita bisa belajar alurnya: login, dashboard, logout.

Login yang aman (dengan password dan verifikasi di server) memakai **Supabase Auth**, dipelajari di pertemuan berikutnya.

### Async dan Await

Mengambil data dari internet butuh waktu. JavaScript tidak mau menunggu diam-diam, jadi kita pakai `async` dan `await`:

- `async function` — menandai function yang berisi proses yang butuh waktu.

- `await` — "tunggu proses ini selesai dulu, baru lanjut ke baris berikutnya".

- Supabase selalu membalas `{ data, error }`: kalau berhasil `data` terisi, kalau gagal `error` terisi. Selalu cek `error` dulu.

## Hands-on: Langkah demi Langkah

Panduan lengkap (klik apa, file apa, kode lengkap, plus komentar penanda perubahan dari pertemuan 3) ada di **[`implementasi-supabase/README.md`](implementasi-supabase/README.md)**. Ringkasannya:

**Bagian A — Setup Supabase (di browser)**

1. Buat akun Supabase.

2. Buat project `website-umkm`.

3. Buat tabel `umkm` + isi 6 data awal: paste satu script SQL di **SQL Editor**, klik Run.

4. Cek tabel di **Table Editor**.

5. Ambil **Project URL** dan **Publishable key**.

**Bagian B — Kode (di folder `mulai-dari-kosong/`)**

6. Siapkan folder `css/` dan `js/`, salin `index.html` dan `style.css` dari pertemuan 3.

7. Buat `js/common.js` (koneksi Supabase, login username, navbar).

8. Ubah `index.html`, tambah blok CSS navbar, buat `js/app.js` -> isi URL + key -> **Read jalan** (titik berhenti 1).

9. Buat halaman login (`login.html`, `js/login.js`) dan dashboard (`dashboard.html`, `js/dashboard.js`, `css/dashboard.css`) -> **login + Create jalan** (titik berhenti 2).

10. Tes alur lengkap, lalu commit.

Hanya tiga hal baru yang dikerjakan: **login, Read, Create**. Edit dan Hapus dikerjakan di pertemuan 5. Section Kontak tidak diubah.

### Hasil akhir sesi ini

```text
pert4-code/
├── README.md                      <- teori (file ini)
├── implementasi-supabase/         <- hasil jadi + panduan step-by-step
│   ├── README.md
│   ├── supabase-setup.sql
│   ├── index.html
│   ├── login.html
│   ├── dashboard.html
│   ├── css/
│   │   ├── style.css
│   │   └── dashboard.css
│   └── js/
│       ├── common.js
│       ├── app.js
│       ├── login.js
│       └── dashboard.js
└── mulai-dari-kosong/             <- folder kosong buat dikerjakan ulang
```

Website UMKM kini terhubung ke database Postgres sungguhan lewat Supabase. Direktori menampilkan data dari database, pengunjung bisa login dengan username, dan dari dashboard bisa menambah UMKM baru. Data bertahan meski halaman di-refresh atau dibuka di komputer lain.

## Catatan AI

Contoh prompt yang baik: "Jelaskan kenapa Supabase mengembalikan `{ data, error }` alih-alih langsung datanya saja. Jangan tuliskan kode lengkap punyaku." Selalu cek nilai `error` di Console sebelum menyalahkan kode HTML/CSS saat data tidak muncul.

## Latihan mandiri

Tambahkan kategori baru **Jasa**: tambah `<option>Jasa</option>` di dropdown form `dashboard.html` dan di dropdown filter `index.html`, lalu tambah satu UMKM kategori Jasa lewat dashboard dan coba filter-nya di halaman utama.

## Rangkuman

Database menyimpan data secara permanen dalam tabel berisi baris dan kolom, dengan `id` sebagai primary key. Supabase menyediakan Postgres siap pakai lewat JavaScript client, diakses dari frontend memakai Publishable key, dan dilindungi aturan RLS. Hari ini Direktori UMKM sudah membaca data dari database (Read), ada login username sederhana dengan dashboard yang dijaga, dan data baru bisa ditambah lewat form (Create). Minggu depan kita lengkapi dengan Edit dan Hapus, lalu mengganti login username dengan login asli memakai Supabase Auth.

## Istilah penting

| Istilah | Artinya |
|---|---|
| Database | Tempat penyimpanan data secara permanen dan terstruktur |
| Tabel | Kumpulan data sejenis, tersusun dalam baris dan kolom |
| Primary key | Kolom unik yang membedakan satu baris dengan baris lain |
| Postgres | Jenis database yang dipakai Supabase |
| Supabase | Layanan yang menyediakan Postgres, API, dan Auth siap pakai |
| Publishable key | Kunci akses publik yang aman dipakai di frontend (dulu disebut anon key) |
| Secret key | Kunci akses penuh, tidak boleh pernah dipakai di frontend (dulu disebut service_role key) |
| Row Level Security (RLS) | Aturan yang membatasi siapa boleh mengakses baris data tertentu |
| Policy | Aturan di bawah RLS, misalnya "boleh membaca" atau "boleh menambah" |
| localStorage | Memori kecil di browser, datanya tetap ada setelah refresh |
| Login username | Login sederhana tanpa password, hanya penanda "sudah login", bukan keamanan sungguhan |
| async/await | Cara JavaScript menunggu proses yang butuh waktu, seperti mengambil data dari internet |

## Isi folder

- `implementasi-supabase/` — kode lengkap (key dummy) + panduan step-by-step `README.md` + `supabase-setup.sql`.
- `mulai-dari-kosong/` — folder kosong untuk mengerjakan panduan dari awal.
