# To Do — Website UNSIKA

Daftar kerjaan yang belum selesai per hari ini. Dicek dan diupdate tiap ada progres baru.

## Kode per Pertemuan

- [x] Pertemuan 1 — `pert1-code/index.html` selesai (hasil hands-on) + `pert1-code-bonus-multipage/` (opsional).
- [ ] Pertemuan 2 — kode (`style.css`, `.gitignore` di dalam proyek peserta, dst) belum dibuat. Materi (`README.md`) sudah lengkap.
- [x] Pertemuan 3 — kode selesai: `pert3-code/fundamental-javascript/` (playground konsep dasar) + `pert3-code/implementasi-umkm/` (lanjutan pert2-code, `app.js` render+filter+validasi). Materi sudah lengkap.
- [x] Pertemuan 4 — kode selesai: `pert4-code/implementasi-supabase/` (kode jadi, key dummy, panduan step-by-step) + `pert4-code/mulai-dari-kosong/` (folder kosong). Isi: Read dari Supabase, login username, dashboard, Create. Update/Delete sengaja belum ada (pertemuan 5). Belum diuji ke project Supabase asli — coba dulu pakai project sendiri sebelum kelas.
- [x] Pertemuan 5 — kode selesai: `pert5-code/implementasi-auth-crud/` (kode jadi, key dummy, panduan step-by-step, `supabase-migrasi-p5.sql`, folder `bonus-relasi-kategori/`) + `pert5-code/mulai-dari-pertemuan-4/` (titik awal). Isi: Edit, Hapus, Supabase Auth (email + password), RLS pemilik data. Teori `pert5-code/README.md` ditulis ulang. Belum diuji ke project Supabase asli — coba dulu: matikan Confirm email, jalankan SQL migrasi, daftar, login, tambah, edit, hapus, lalu coba hapus data bawaan (harus ditolak) dan login akun kedua.
- [ ] Cek `kuis-latihan-4.md` / `pilgan-4.md` (kalau sudah ada) terhadap isi pertemuan 4 yang baru.
- [x] Pertemuan 6 — selesai: `pert6-code/website-umkm/` (kode lanjutan pert5, key Supabase milik tutor, siap deploy) + `pert6-code/deployment/` (README GitHub + Vercel + RLS/keamanan, dan 5 file SQL: `01-supabase-lengkap`, `02-supabase-secure`, `03-cek-keamanan`, `04-uji-serangan`, `05-perawatan`) (role admin ikut di dalamnya). `01-supabase-lengkap.sql` = SATU file untuk semua setup (tabel, RLS, admin, pengaman, audit); `06`/`07` untuk jalur database lama. SQL diuji di Postgres lokal. Belum dijalankan di Supabase asli: ganti email admin di bagian 6 file `01`, jalankan, lalu `04` dan `07`, dan cek hasilnya sebelum kelas.
- [ ] Pertemuan 6 — `website-umkm/js/common.js` berisi key asli tutor (disengaja, untuk deploy). Jangan salin ke repo murid. Kunci jawaban latihan 6 (`kunci-latihan-web1-6.md`, di-gitignore) masih menulis "Tailwind CSS" dan perlu disesuaikan.

> Pola: kode ditambahkan menjelang/pada tiap pertemuan berlangsung, bukan sekaligus di awal — supaya tetap relevan dengan progres kelas yang sesungguhnya.

## PowerPoint per Pertemuan

- [x] Pertemuan 1 — `pert1-code/pertemuan-1-web.pptx` selesai (12 slide: cover, gambaran sesi, rundown, 8 sub-bab teori, penutup), tema matcha (hijau sage, krem, aksen gold).
- [ ] Pertemuan 2 — belum dibuat. Tinggal jalankan generator (sudah bertema matcha) ke `pert2-code/README.md`.
- [ ] Pertemuan 3 — belum dibuat.
- [ ] Pertemuan 4 — belum dibuat.
- [ ] Pertemuan 5 — belum dibuat.
- [ ] Pertemuan 6 — belum dibuat.
- [ ] Opsional: pasang plugin/tool design buat upgrade visual lebih lanjut (font custom, ikon daun matcha, dsb) — tema warna dasar sudah selesai lewat script, ini cuma polish tambahan kalau user mau.

## Kuis Pilihan Ganda (Slido)

Untuk Unsika Study Club — bank soal MCQ, terpisah dari `kuis-latihan-N.md` (esai/coding). Ada di folder `latihan-soal-pilgan-pertemuan/`. Platform: **Slido**, ditampilkan live oleh moderator saat kelas berlangsung (bukan link take-home).

- [x] Pertemuan 1 — `pilgan-1.md` + `pilgan-1.csv` selesai (10 soal). Menunggu konfirmasi format sebelum lanjut.
- [ ] Pertemuan 2 — belum dibuat.
- [ ] Pertemuan 3 — belum dibuat.
- [ ] Pertemuan 4 — belum dibuat.
- [ ] Pertemuan 5 — belum dibuat.
- [ ] Pertemuan 6 — belum dibuat.
- [x] `cara-import-slido.md` — panduan moderator: setup event, isi poll (import massal atau manual), jalankan live saat kelas. Menggantikan `cara-buat-google-form.md` (dihapus) setelah diketahui peserta pakai Slido, bukan Google Form.

## Keputusan yang Masih Menunggu

- [ ] Konfirmasi dari penyelenggara: apakah proyek akhir punya sesi presentasi atau hanya pengumpulan.
- [ ] Konfirmasi tenggat pengumpulan proyek akhir dan platform final (GitHub, Google Drive, atau keduanya).
- [ ] Tentukan apakah perlu dibuat SQL seed script untuk skema tabel contoh UMKM.
- [ ] Tentukan apakah perlu template starter repo (`index.html` + `style.css` + `app.js` + `.gitignore`) untuk dibagikan ke peserta.
- [ ] Detail lomba dari kampus peserta (format, batasan stack, tanggal) — belum ada info konkret. Kalau sudah ada, cek apakah materi 6 pertemuan sudah cukup atau perlu tambahan.

## Lain-lain

- [x] `.gitignore` di root `Website-UNSIKA` sudah diatur untuk file kerja internal yang tidak perlu ikut ter-commit.
- [x] Repo `Website-UNSIKA` sudah `git init`, commit, dan push ke GitHub.
