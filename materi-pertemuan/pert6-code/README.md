# Pertemuan 6 — Deploy, README & Arahan Proyek Akhir

> Kode untuk sesi ini belum dibuat — folder ini baru berisi materi. File kode akan ditambahkan menjelang/pada pertemuan 6, mengikuti pola `pert1-code`.

**Durasi:** 19.30–21.00 WIB
**Tools:** VS Code, Git, GitHub, Vercel
**Output:** Peserta dapat men-deploy aplikasi ke internet, menulis README yang layak portofolio, dan memahami ketentuan proyek akhir.

## Tujuan belajar

- Memahami kenapa aplikasi perlu di-deploy, bukan hanya berjalan di localhost.
- Memahami perbedaan static hosting dan server.
- Melakukan deploy aplikasi ke Vercel lewat GitHub.
- Menulis README yang informatif dan layak portofolio.
- Memahami dasar debugging: Console, Network tab, dan pesan error Supabase.
- Memahami ketentuan dan rubrik proyek akhir.

## Rundown

| Waktu | Aktivitas |
|---|---|
| 19.30–19.40 | Pembukaan, cek kesiapan repo dan akun Vercel tiap peserta |
| 19.40–19.55 | Teori: hosting, static vs server, cara kerja Vercel |
| 19.55–20.20 | Hands-on: deploy aplikasi ke Vercel |
| 20.20–20.35 | Teori + hands-on: menulis README yang layak portofolio |
| 20.35–20.45 | Teori: debugging dasar (Console, Network, error Supabase) |
| 20.45–20.55 | Arahan proyek akhir dan pembagian kelompok |
| 20.55–21.00 | Penutup dan sesi tanya jawab |

## Teori

### Kenapa perlu deploy

Selama 5 pertemuan, aplikasi hanya berjalan di `localhost` lewat Live Server — artinya **hanya bisa dibuka di komputer sendiri**. Supaya teman, dosen, atau recruiter bisa membuka aplikasi lewat link, aplikasi harus **di-deploy**: disalin dan dijalankan di server milik penyedia hosting, lalu diberi alamat (URL) publik.

> Slide visual: dua kotak — "localhost (cuma kamu)" vs "URL publik (siapa saja dengan internet)".

### Static hosting vs server

- **Static hosting** — menyimpan file HTML/CSS/JS apa adanya, lalu mengirimkannya langsung ke browser yang meminta. Cocok untuk aplikasi seperti kita, karena semua logika (JavaScript, koneksi Supabase) berjalan di **browser pengguna**, bukan di server.
- **Server (backend)** — menjalankan kode di sisi server sebelum mengirim hasil ke browser (misalnya Node.js/Express). Aplikasi kita **tidak butuh ini** karena Supabase sudah berperan sebagai backend/database siap pakai.

Karena stack kita murni HTML/CSS/JS + Supabase (diakses langsung dari browser), Vercel bisa men-deploy proyek ini sebagai **static site** — proses paling sederhana yang tersedia.

### Cara kerja Vercel

```text
1. Kamu push kode ke GitHub
2. Vercel "mengintip" repo GitHub kamu (lewat koneksi akun)
3. Vercel mengambil salinan kode, menyiapkannya jadi website
4. Vercel memberi URL publik, misalnya: website-umkm.vercel.app
```

Keuntungan besar: setiap kali kamu `git push` perubahan baru ke GitHub, Vercel **otomatis** men-deploy ulang versi terbaru — tidak perlu upload manual.

> Slide visual: diagram 4 langkah di atas sebagai alur horizontal dengan ikon GitHub dan Vercel.

### Environment variable: kenapa key sebaiknya tidak ditulis langsung di kode

Sampai sekarang, `SUPABASE_URL` dan `SUPABASE_ANON_KEY` ditulis langsung di `app.js`. Untuk proyek kecil/latihan ini cukup aman karena `anon key` memang didesain untuk publik. Namun kebiasaan yang lebih baik (dan wajib untuk proyek akhir) adalah memisahkan nilai konfigurasi dari kode utama, supaya:

- Lebih mudah diganti tanpa mengubah logika aplikasi.
- Lebih mudah diaudit — jelas terlihat bagian mana yang berisi konfigurasi sensitif.
- Kalau di masa depan pindah ke stack yang punya `service_role key` atau kredensial rahasia lain, pola ini mencegah key tersebut ikut ter-commit ke GitHub tanpa sengaja.

### Menulis README yang layak portofolio

README adalah halaman pertama yang dilihat orang saat membuka repository GitHub kamu — termasuk recruiter. README yang baik menjawab pertanyaan: **apa ini, kenapa dibuat, dan bagaimana menjalankannya**.

Struktur README yang baik:

1. **Judul dan deskripsi singkat** — satu-dua kalimat tentang aplikasi ini.
2. **Fitur utama** — daftar poin, misalnya "CRUD data UMKM", "Login/register", "Pencarian real-time".
3. **Tech stack** — teknologi yang dipakai.
4. **Screenshot** — gambar tampilan aplikasi (sangat membantu recruiter yang malas klik link).
5. **Cara menjalankan secara lokal** — langkah-langkah singkat.
6. **Link demo** — URL Vercel yang sudah di-deploy.
7. **Anggota tim** (untuk proyek kelompok).

> Slide visual: contoh README yang bagus vs README kosong cuma judul.

### Dasar debugging

Tiga alat yang paling sering dipakai saat aplikasi tidak berjalan sesuai harapan:

| Alat | Cara buka | Kegunaan |
|---|---|---|
| Console | `F12 > Console` | Melihat pesan error JavaScript dan hasil `console.log` |
| Network | `F12 > Network` | Melihat semua permintaan data (termasuk ke Supabase) dan responsnya |
| Pesan error Supabase | Dari `{ data, error }` di kode | Menjelaskan kenapa query gagal (misalnya policy RLS menolak akses) |

Kebiasaan debugging yang baik: baca pesan error **kata per kata** sebelum bertanya ke orang lain atau AI — banyak error JavaScript sudah menyebutkan file dan baris yang bermasalah.

## Hands-on: Langkah demi Langkah

### Langkah 1 — Merapikan struktur folder sebelum deploy

Pastikan struktur proyek seperti ini sebelum lanjut:

```text
website-umkm/
├── index.html
├── style.css
├── app.js
├── .gitignore
└── README.md
```

Kalau `README.md` belum ada, buat file baru dengan nama itu di root folder.

### Langkah 2 — Menulis README

Isi `README.md` dengan struktur berikut (sesuaikan detail dengan aplikasimu):

```markdown
# Katalog UMKM Karawang

Aplikasi web untuk menampilkan, menambah, mengubah, dan menghapus data UMKM di Karawang. Dibuat sebagai proyek latihan kelas Website UNSIKA.

## Fitur

- Menampilkan daftar UMKM dari database
- Tambah, ubah, dan hapus data UMKM (CRUD)
- Pencarian dan filter kategori
- Login dan register (Supabase Auth)
- Data UMKM dan kategori saling berelasi

## Tech Stack

- HTML, CSS, Tailwind CSS
- JavaScript (vanilla)
- Supabase (Postgres, Auth)
- Vercel (hosting)

## Cara Menjalankan Secara Lokal

1. Clone repository ini.
2. Buka folder proyek di VS Code.
3. Klik kanan `index.html`, pilih "Open with Live Server".

## Demo

https://nama-project-kamu.vercel.app
```

**Cek hasil:** file README menampilkan format rapi saat dibuka lewat **Open Preview** di VS Code.

### Langkah 3 — Commit dan push final sebelum deploy

```bash
git add .
git commit -m "Tambah README dan rapikan proyek sebelum deploy"
git push
```

**Cek hasil:** repository GitHub menampilkan `README.md` langsung sebagai halaman utama repo.

### Langkah 4 — Mendaftar dan menghubungkan Vercel ke GitHub

1. Buka [vercel.com](https://vercel.com/), login memakai akun GitHub.
2. Klik **Add New > Project**.
3. Cari repository `website-umkm` dalam daftar, klik **Import**.

**Cek hasil:** halaman konfigurasi project Vercel terbuka, menampilkan nama repo yang benar.

### Langkah 5 — Melakukan deploy

1. Pada halaman konfigurasi, biarkan pengaturan default (Framework Preset: **Other**, karena ini bukan proyek React/Next.js).
2. Klik **Deploy**.
3. Tunggu proses build selesai (biasanya di bawah 1 menit untuk static site).

**Cek hasil:** Vercel menampilkan halaman sukses dengan tombol **Visit**, dan memberi URL publik seperti `website-umkm-namamu.vercel.app`.

**Kalau error:** kalau halaman muncul tapi kosong/blank, cek Console di URL Vercel — biasanya path file CSS/JS salah karena huruf besar/kecil berbeda (Vercel sensitif huruf besar/kecil, beda dengan Windows).

### Langkah 6 — Menguji aplikasi di URL publik

1. Klik **Visit** untuk membuka URL live.
2. Coba semua fitur: lihat daftar UMKM, cari, filter, tambah data (kalau sudah login), login/logout.
3. Buka URL yang sama di HP (lewat data seluler, bukan WiFi yang sama, untuk memastikan benar-benar publik).

**Cek hasil:** semua fitur berjalan sama seperti di localhost, dan aplikasi bisa diakses dari perangkat lain di luar jaringan yang sama.

**Kalau error:** kalau data tidak muncul di URL publik tapi muncul di localhost, cek pengaturan **Authentication > URL Configuration** di Supabase — Site URL/Redirect URL mungkin masih diarah ke `localhost` saja dan perlu ditambahkan URL Vercel.

### Langkah 7 — Auto-deploy saat push baru

1. Buat perubahan kecil di kode, misalnya ubah teks judul di `index.html`.
2. `git add .`, `git commit -m "Update judul halaman"`, `git push`.
3. Buka dashboard Vercel, lihat tab **Deployments**.

**Cek hasil:** muncul deployment baru secara otomatis tanpa perlu klik Deploy manual lagi, dan URL live ikut ter-update setelah build selesai.

### Langkah 8 — Latihan debugging bersama

1. Sengaja buat kesalahan kecil: ubah `#daftar-umkm-container` di `app.js` menjadi `#daftar-umkm-containerr` (tambah huruf).
2. Refresh halaman, buka Console.
3. Baca pesan error yang muncul, cari tahu maksudnya, lalu perbaiki kembali.

**Cek hasil:** paham bahwa pesan error di Console biasanya sudah cukup jelas menunjukkan lokasi masalah, dan terbiasa membaca error sebelum panik.

### Hasil akhir sesi ini

Struktur folder final:

```text
website-umkm/
├── index.html
├── style.css
├── app.js
├── .gitignore
└── README.md
```

Aplikasi sudah live di URL publik Vercel, ter-update otomatis setiap `git push`, dan repository GitHub punya README yang layak ditunjukkan sebagai portofolio.

## Arahan Proyek Akhir

Proyek akhir dikerjakan berkelompok (3–4 orang) setelah pertemuan ini selesai. Gunakan `panduan-proyek-akhir.md` sebagai checklist lengkap. Poin penting yang perlu disepakati kelompok di awal:

1. **Pilih topik** — boleh melanjutkan tema UMKM, atau topik lain yang disetujui (lihat ide cadangan di panduan proyek akhir).
2. **Bagi peran** — misalnya satu orang fokus struktur database, satu fokus tampilan/CSS, satu fokus logika JavaScript/Supabase, satu fokus deploy dan dokumentasi. Peran boleh tumpang tindih asal semua paham keseluruhan kode.
3. **Rancang tabel database di awal** sebelum menulis banyak kode — perubahan struktur tabel di tengah jalan sering menyebabkan bug yang tidak perlu.
4. **Commit sesering mungkin**, dengan pesan yang jelas, supaya kontribusi tiap anggota tercatat.
5. Semua anggota harus bisa menjelaskan kode timnya sendiri — AI boleh membantu menulis, tapi bukan pengganti pemahaman saat ditanya pengajar.

## Rangkuman

Aplikasi yang tadinya hanya berjalan di komputer sendiri kini bisa diakses siapa saja lewat URL publik, berkat Vercel yang otomatis men-deploy ulang setiap ada `git push`. README yang baik membuat proyek layak dipajang sebagai portofolio. Selamat, seluruh kurikulum inti Website UNSIKA sudah selesai — perjalanan berikutnya adalah proyek akhir kelompok.

## Istilah penting

| Istilah | Artinya |
|---|---|
| Deploy | Proses menyalin dan menjalankan aplikasi di server publik agar bisa diakses lewat internet |
| Static hosting | Layanan yang menyimpan dan mengirim file HTML/CSS/JS apa adanya tanpa proses server tambahan |
| Environment variable | Nilai konfigurasi yang dipisahkan dari kode utama |
| Auto-deploy | Proses deploy ulang otomatis setiap ada perubahan baru di repository |
| README | File dokumentasi utama sebuah repository, biasanya halaman pertama yang dibaca orang |

## Isi folder

- Belum ada kode — akan ditambahkan menjelang pertemuan 6, melanjutkan dari `pert5-code`.
