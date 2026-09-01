# Website UNSIKA

Selamat datang di materi **Website UNSIKA**. Program ini dirancang untuk mahasiswa yang ingin belajar membangun aplikasi web dari nol: dari halaman statis sampai aplikasi CRUD dengan database dan login, lalu di-deploy ke internet.

Kelas berlangsung selama **6 pertemuan**, setiap **19.30–21.00 WIB**. Semua praktik dilakukan langsung di komputer sendiri memakai VS Code, sehingga peserta terbiasa dengan alur kerja developer sejak pertemuan pertama.

## Daftar Isi

1. [Tujuan Pembelajaran](#tujuan-pembelajaran)
2. [Alur Belajar](#alur-belajar)
3. [Cara Menggunakan Materi](#cara-menggunakan-materi)
4. [Struktur Folder](#struktur-folder)
5. [Tools yang Digunakan](#tools-yang-digunakan)
6. [Aturan Penggunaan AI](#aturan-penggunaan-ai)
7. [Latihan, Kuis, dan Penilaian](#latihan-kuis-dan-penilaian)
8. [Proyek Akhir](#proyek-akhir)

## Tujuan Pembelajaran

Setelah menyelesaikan program ini, peserta diharapkan mampu:

- Memahami cara kerja website: client, server, dan HTTP request/response.
- Menulis HTML semantik dan menata tampilan dengan CSS, Flexbox, serta Tailwind.
- Membuat halaman responsif yang enak dilihat di HP maupun laptop.
- Menggunakan JavaScript untuk membuat halaman interaktif dan memanipulasi DOM.
- Memahami konsep database dan menghubungkan aplikasi ke Supabase (Postgres).
- Membuat aplikasi CRUD (Create, Read, Update, Delete) lengkap dengan autentikasi.
- Menggunakan Git dan GitHub untuk versi kode dan kolaborasi tim.
- Melakukan deploy aplikasi ke Vercel sehingga bisa diakses lewat internet.

## Alur Belajar

| Pertemuan | Fokus | Hasil yang Diharapkan |
|---|---|---|
| 1 | Cara kerja web, setup VS Code, HTML semantik | Halaman HTML multi-section yang tampil di browser |
| 2 | CSS, box model, Flexbox, responsive, Tailwind, Git & GitHub | Halaman responsif, sudah ter-commit dan push ke repository |
| 3 | JavaScript dasar dan DOM | Halaman interaktif: filter, form, dan render data dari array |
| 4 | Konsep database dan Supabase (Create + Read) | Data dari form tersimpan di database dan tampil kembali setelah refresh |
| 5 | Update, Delete, relasi tabel, dan autentikasi | Aplikasi CRUD penuh dengan sistem login |
| 6 | Deploy ke Vercel dan GitHub dasar | Aplikasi live di URL publik, repository rapi |

## Rincian Alur Belajar

Studi kasus dipakai konsisten dari pertemuan 1 sampai 6: **katalog UMKM Karawang**. Tiap pertemuan melanjutkan langsung dari kode pertemuan sebelumnya — bukan proyek baru tiap minggu.

### Pertemuan 1 — Fondasi Web & HTML

- **Belajar apa:** cara kerja website (client-server, HTTP request/response), peran HTML/CSS/JavaScript, struktur dokumen HTML, tag semantik (`header`, `nav`, `main`, `section`, `footer`), tag konten umum (heading, paragraf, list, gambar, link), form input dasar, setup VS Code + Live Server.
- **Outcome:** halaman `index.html` statis berjalan di browser lewat Live Server — header + navigasi, daftar UMKM (3 kartu), section tentang, form kontak, footer. Masih polos, belum ada styling.

### Pertemuan 2 — CSS, Responsive Design & Git/GitHub

- **Belajar apa:** cara CSS menempel ke HTML, selector (tag/class/id), box model, Flexbox, media query untuk responsive, Tailwind CSS lewat CDN, Git (commit, repository, remote) dan alur `add → commit → push`, membuat repo di GitHub.
- **Outcome:** halaman pertemuan 1 jadi rapi dan responsif (enak dilihat di HP maupun laptop), sebagian sudah pakai Tailwind, dan seluruh kode sudah tersimpan di repository GitHub dengan riwayat commit.

### Pertemuan 3 — JavaScript Dasar & DOM

- **Belajar apa:** variabel (`let`/`const`), tipe data, kondisi `if/else`, perulangan `for`, function, array dan object, DOM (`querySelector`, `textContent`, `style`), event (`click`, `submit`), merender list data ke HTML, validasi form.
- **Outcome:** halaman jadi interaktif — daftar UMKM dirender dari array JavaScript (bukan HTML manual lagi), ada tombol filter kategori yang berfungsi, dan form kontak tervalidasi sebelum "terkirim" (masih tersimpan sementara, belum ke database).

### Pertemuan 4 — Database & Supabase (Create + Read)

- **Belajar apa:** kenapa data butuh database (bukan cuma array), konsep tabel/baris/kolom/primary key, apa itu Postgres dan Supabase, perbedaan `anon key` vs `service_role key`, memasang Supabase JS Client, query `select()` dan `insert()`, Row Level Security dasar (policy baca/tulis).
- **Outcome:** data UMKM tidak lagi disimpan di array — form menyimpan data baru ke database Postgres sungguhan (Create), dan halaman menampilkan data dari database (Read). Data tetap ada meski halaman di-refresh.

### Pertemuan 5 — Update, Delete, Relasi Tabel & Autentikasi

- **Belajar apa:** melengkapi CRUD dengan `update()` dan `delete()` (dan kenapa `.eq()` wajib dipakai), pencarian/filter data, relasi antar tabel lewat foreign key (tabel `kategori` terpisah dari `umkm`), autentikasi vs otorisasi, Supabase Auth (sign up, login, logout, session), Row Level Security ketat berbasis status login.
- **Outcome:** aplikasi CRUD penuh (tambah/lihat/ubah/hapus) dengan sistem login — tombol Edit/Hapus hanya muncul untuk yang sudah login, dan data kategori sudah berelasi lewat tabel terpisah.

### Pertemuan 6 — Deploy, README & Arahan Proyek Akhir

- **Belajar apa:** kenapa perlu deploy, static hosting, cara kerja Vercel, environment variable, cara menulis README yang layak portofolio, dasar debugging (Console, Network tab, pesan error Supabase).
- **Outcome:** aplikasi live di URL publik Vercel (bisa dibuka siapa saja, bukan cuma di laptop sendiri), auto-deploy tiap `git push`, repository GitHub punya README lengkap — siap dipajang sebagai portofolio. Kurikulum inti selesai, lanjut ke proyek akhir kelompok.

## Cara Menggunakan Materi

1. Baca modul sesuai urutan pada folder `materi-pertemuan`. Tiap folder `pertX-code` berisi `README.md` (materi lengkap), kode hasil hands-on, dan `pertemuan-X-web.pptx` — slide presentasi ringkas dari bagian Teori, untuk dipakai saat mengajar di kelas.
2. Pelajari bagian **Teori** untuk memahami konsep, lalu ikuti **Hands-on: Langkah demi Langkah** persis seperti instruksinya.
3. Kerjakan file latihan untuk sesi tersebut di folder `latihan-soal-pertemuan`.
4. Kerjakan kuis dan latihan secara mandiri sebelum melihat kunci.
5. Buka folder `kunci-jawaban-pertemuan` hanya setelah mencoba seluruh soal.
6. Catat error atau bagian yang belum dipahami untuk dibahas pada sesi tanya jawab.

> Belajar coding bukan tentang cepat menemukan jawaban, tetapi memahami alasan kode bekerja.

### Bahan Presentasi (PPT)

Tiap pertemuan punya file PowerPoint sendiri, isinya slide ringkas dari bagian Teori — dipakai mentor untuk mengajar di kelas. Klik link di bawah untuk langsung buka filenya:

- [Pertemuan 1 — pertemuan-1-web.pptx](materi-pertemuan/pert1-code/pertemuan-1-web.pptx)
- Pertemuan 2 — `materi-pertemuan/pert2-code/pertemuan-2-web.pptx` (belum tersedia)
- Pertemuan 3 — `materi-pertemuan/pert3-code/pertemuan-3-web.pptx` (belum tersedia)
- Pertemuan 4 — `materi-pertemuan/pert4-code/pertemuan-4-web.pptx` (belum tersedia)
- Pertemuan 5 — `materi-pertemuan/pert5-code/pertemuan-5-web.pptx` (belum tersedia)
- Pertemuan 6 — `materi-pertemuan/pert6-code/pertemuan-6-web.pptx` (belum tersedia)

Polanya: `materi-pertemuan/pertN-code/pertemuan-N-web.pptx`, di dalam folder pertemuan yang sama dengan `README.md` dan kodenya. Isi slide selalu ringkasan dari `README.md` pertemuan itu — kalau butuh detail lebih lengkap (penjelasan baris kode, langkah hands-on), buka `README.md`-nya, bukan PPT-nya.

### Membaca Markdown dengan nyaman di VS Code

Jika membuka materi melalui VS Code, klik kanan file Markdown (misalnya `pert1-code/README.md` atau `kuis-latihan-1.md`), lalu pilih **Open Preview**. VS Code akan menampilkan judul, tabel, kode, dan daftar isi dengan format yang lebih rapi.

Kamu juga dapat memakai shortcut `Ctrl + Shift + V` untuk membuka preview dari file Markdown yang sedang aktif.

## Struktur Folder

```text
Website-UNSIKA/
├── materi-pertemuan/             # Enam folder pertX-code: README (teori + hands-on) + kode + pertemuan-X-web.pptx
├── latihan-soal-pertemuan/       # Latihan praktik dan kuis sesi 1–6
├── kunci-jawaban-pertemuan/      # Kunci latihan dan kuis
├── latihan-soal-pilgan-pertemuan/ # Bank soal pilihan ganda untuk Google Form (khusus penyelenggara)
├── panduan-setup.md              # Setup VS Code, Git, GitHub, Supabase, Vercel
├── panduan-proyek-akhir.md       # Ketentuan proyek akhir kelompok
└── README.md                     # Panduan ini
```

## Tools yang Digunakan

| Kebutuhan | Tools |
|---|---|
| Editor kode | VS Code + ekstensi Live Server |
| Markup dan styling | HTML5, CSS3, Tailwind CSS (CDN) |
| Bahasa pemrograman | JavaScript (vanilla, ES6+) |
| Database dan backend | Supabase (Postgres, Auth, JS Client) |
| Versi kode dan kolaborasi | Git dan GitHub |
| Hosting/deploy | Vercel |

Lihat [panduan-setup.md](panduan-setup.md) sebelum memulai. Peserta wajib menyiapkan VS Code, Git, dan akun GitHub/Supabase/Vercel sebelum pertemuan dimulai.

## Aturan Penggunaan AI

AI boleh digunakan sebagai coding assistant untuk menjelaskan konsep, membantu membaca error, memberi contoh, atau mereview kode. Namun peserta tetap wajib:

- Membaca dan menjalankan kode sebelum menggunakannya.
- Memahami logika setiap bagian penting.
- Memodifikasi jawaban agar sesuai dengan studi kasus dan kebutuhannya sendiri.
- Mampu menjelaskan kode saat ditanya pengajar.

Jangan memasukkan password, API key rahasia (`service_role key`), data pribadi, atau data sensitif ke layanan AI maupun repository publik.

## Latihan, Kuis, dan Penilaian

- Setiap sesi memiliki latihan praktik untuk menguatkan materi.
- Setiap sesi memiliki kuis berisi **10 soal**: konsep/isian singkat dan membaca atau menulis potongan kode/HTML/CSS.
- Kunci jawaban tersedia terpisah untuk mendorong peserta mencoba secara mandiri terlebih dahulu.
- Saat menjawab, penjelasan logika lebih penting daripada kode yang sekadar berjalan.

## Proyek Akhir

Setelah sesi 6, peserta membentuk kelompok **3–4 orang** untuk membuat aplikasi web CRUD lengkap dengan database dan autentikasi. Tujuannya bukan sekadar tugas kelas — hasil akhirnya diharapkan layak dipajang sebagai portofolio kerja.

Output minimal proyek:

- Aplikasi web dengan tampilan responsif, minimal dua tabel database yang saling berelasi.
- Fitur CRUD penuh (tambah, lihat, ubah, hapus data) dan sistem login/register.
- Aplikasi ter-deploy dan bisa diakses lewat URL publik (Vercel).
- Repository GitHub berisi kode dan `README.md` yang lengkap.
- Kontribusi yang dapat dilacak dari setiap anggota kelompok lewat commit history.

Aturan lengkap, ide topik cadangan, dan rubrik awal tersedia di [panduan-proyek-akhir.md](panduan-proyek-akhir.md). Mekanisme presentasi dan tenggat akan mengikuti pengumuman penyelenggara.
