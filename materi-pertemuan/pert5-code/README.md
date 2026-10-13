# Pertemuan 5 — Edit, Hapus, Login Asli, dan Hak Akses

> Kode lengkap ada di `implementasi-auth-crud/` (hasil jadi, key dummy) dan `mulai-dari-pertemuan-4/` (titik awal, salinan hasil pertemuan 4). Panduan step-by-step ada di [`implementasi-auth-crud/README.md`](implementasi-auth-crud/README.md).

**Durasi:** 19.30–21.00 WIB
**Tools:** VS Code, Live Server, Supabase
**Output:** Peserta dapat melengkapi CRUD (Update dan Delete), mengganti login username dengan Supabase Auth (email + password), dan membatasi hak akses lewat Row Level Security, sehingga hanya pemilik data yang boleh mengubah atau menghapus datanya.

## Tujuan belajar

- Melengkapi CRUD dengan fitur Update dan Delete di dashboard.

- Memahami kenapa `.eq()` wajib saat update dan delete.

- Memahami perbedaan autentikasi dan otorisasi.

- Membuat daftar, login, dan logout dengan Supabase Auth.

- Membatasi hak akses data dengan Row Level Security (RLS) dan `auth.uid()`.

- Memahami relasi antar tabel lewat foreign key (praktiknya sebagai bonus).

## Rundown

| Waktu | Aktivitas |
|---|---|
| 19.30–19.40 | Pembukaan: login username pertemuan 4 itu sebenarnya "hiasan". Kenapa? |
| 19.40–19.55 | Teori: Update, Delete, pentingnya `.eq()` |
| 19.55–20.15 | Hands-on: tombol Edit dan Hapus di dashboard |
| 20.15–20.30 | Teori: autentikasi vs otorisasi, session, RLS |
| 20.30–20.50 | Hands-on: Supabase Auth + RLS pemilik data |
| 20.50–20.55 | Teori singkat: relasi antar tabel (foreign key); praktiknya bonus |
| 20.55–21.00 | Rangkuman dan pengantar kuis 5 |

## Teori

### Review: apa yang sudah ada, apa yang masih bolong

Di pertemuan 4 kita membuat Read, Create, dan login username. Sekarang kita tinjau yang masih kurang:

| Hal | Kondisi pertemuan 4 | Masalahnya |
|---|---|---|
| Login | Username disimpan di `localStorage` | Siapa saja bisa mengetik username apa pun. Tidak ada password |
| Tambah data | Policy `anon` boleh `insert` | Orang yang tahu URL + key bisa menambah data **tanpa lewat dashboard** |
| Edit dan Hapus | Belum ada | CRUD belum lengkap |

Login username itu cuma "tanda di tampilan". Yang menentukan siapa boleh melakukan apa di database adalah **aturan di Supabase (RLS)**, dan aturan itu belum mengenal siapa penggunanya. Hari ini kita perbaiki dua-duanya.

### Melengkapi CRUD: Update dan Delete

| Operasi | Kegunaan | Contoh di aplikasi kita |
|---|---|---|
| **C**reate | Menambah data baru | Form tambah UMKM (pertemuan 4) |
| **R**ead | Membaca data | Tabel dan kartu UMKM (pertemuan 4) |
| **U**pdate | Mengubah data yang sudah ada | Memperbaiki alamat yang salah ketik |
| **D**elete | Menghapus data | Menghapus UMKM yang sudah tutup |

### Kenapa `.eq()` sangat penting

Saat mengubah atau menghapus, kita **wajib** menyebut baris mana yang dimaksud, biasanya lewat `id`.

```javascript
// BENAR: hanya mengubah baris dengan id = 3
await supabaseClient.from("umkm").update({ nama: "Nama Baru" }).eq("id", 3);

// BERBAHAYA: tanpa .eq(), yang diubah SEMUA baris yang boleh disentuh
await supabaseClient.from("umkm").update({ nama: "Nama Baru" });
```

- `.eq("id", 3)` artinya "yang kolom `id`-nya sama dengan 3".

- Lupa `.eq()` pada `delete()` bisa menghapus seluruh isi tabel dalam sekali jalan. Ini kesalahan paling berbahaya pada CRUD pemula.

- Biasakan: tulis `.eq()` **dulu**, baru isi datanya.

### RLS menolak diam-diam: cek hasilnya

Ada jebakan yang bikin bingung. Kalau RLS menolak sebuah `update()` atau `delete()`, Supabase **tidak mengembalikan error**. Dia cuma mengubah **nol baris**, dan kodenya terlihat sukses.

```javascript
const { data, error } = await supabaseClient
  .from("umkm")
  .delete()
  .eq("id", 3)
  .select();          // minta baris yang benar-benar terhapus dikembalikan

if (error) { /* gagal karena masalah teknis */ }
if (data.length === 0) { /* tidak ada yang terhapus: ditolak aturan, atau id tidak ada */ }
```

- `.select()` di belakang `update()` / `delete()` membuat Supabase mengembalikan baris yang benar-benar terkena.

- Kalau `data.length === 0`, berarti tidak ada yang berubah, dan pengguna perlu diberi tahu.

### Satu pendengar untuk banyak tombol (event delegation)

Tabel di dashboard digambar ulang setiap data dimuat, jadi tombol Edit dan Hapus-nya juga dibuat ulang. Memasang pendengar klik di tiap tombol itu merepotkan.

- Solusinya, pasang **satu** pendengar di `<tbody>` (induknya), lalu cek tombol mana yang diklik lewat `event.target.closest("button[data-aksi]")`.

- Tombol membawa info lewat atribut `data-aksi="edit"` dan `data-id="7"`, dibaca lewat `tombol.dataset.aksi` dan `tombol.dataset.id`.

### Autentikasi vs Otorisasi

Dua istilah yang sering tertukar:

- **Autentikasi** — memastikan **siapa** penggunanya. Contoh: login dengan email dan password.

- **Otorisasi** — memastikan **apa yang boleh dilakukan** pengguna itu. Contoh: hanya pemilik data yang boleh menghapus datanya.

Analogi: autentikasi itu satpam mengecek KTP di pintu masuk. Otorisasi itu kartu akses yang menentukan ruangan mana saja yang boleh kamu masuki.

Login username di pertemuan 4 tidak punya keduanya: tidak ada pemeriksaan siapa kamu, dan tidak ada pembatasan apa yang boleh kamu lakukan.

### Supabase Auth: daftar, login, session, logout

Supabase Auth mengurus akun pengguna untuk kita. Password disimpan dalam bentuk **hash** (diacak satu arah), bukan teks biasa, jadi kita tidak perlu membangun sistem ini dari nol.

```text
1. signUp                 -> user mendaftar dengan email + password
2. signInWithPassword     -> user masuk, Supabase memberi "session"
3. session                -> disimpan di browser, dikirim di setiap permintaan berikutnya
4. signOut                -> session dihapus, user dianggap keluar
```

```javascript
await supabaseClient.auth.signUp({ email, password });
await supabaseClient.auth.signInWithPassword({ email, password });
const { data } = await supabaseClient.auth.getSession();   // data.session = null kalau belum login
await supabaseClient.auth.signOut();
```

- **Session** adalah tanda "sudah login". Isinya mengenali siapa user-nya, dan disimpan Supabase di browser supaya tetap login walau halaman di-refresh.

- `getSession()` mengembalikan sesi kalau ada, atau `null` kalau belum login. Itu yang dipakai untuk memeriksa login di setiap halaman.

- **Confirm email:** secara bawaan Supabase meminta pengguna mengklik link di email sebelum bisa login. Di kelas ini fitur itu **dimatikan sementara** (lihat panduan), supaya tidak perlu membuka inbox.

### Row Level Security: aturan tiap baris

Di pertemuan 4 kita sudah kenal RLS dan policy. Hari ini policy-nya kita buat mengenali siapa penggunanya:

```sql
create policy "umkm pemilik boleh mengubah"
  on public.umkm for update to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));
```

| Bagian | Artinya |
|---|---|
| `to authenticated` | Berlaku untuk user yang sudah login. Pengunjung biasa memakai role `anon` |
| `auth.uid()` | Id user yang sedang login, dikirim otomatis oleh Supabase |
| `using (...)` | Syarat baris yang **boleh disentuh** (baris yang sudah ada) |
| `with check (...)` | Syarat **hasil akhir** (baris setelah diubah atau yang baru dimasukkan) |

Aturan yang kita pakai di tabel `umkm`:

| Aksi | Siapa yang boleh |
|---|---|
| Baca (`select`) | **Semua orang**, termasuk yang belum login. Ini katalog publik |
| Tambah (`insert`) | User yang login, atas namanya sendiri |
| Ubah (`update`) dan Hapus (`delete`) | Hanya **pemilik** baris (`user_id` sama dengan user yang login) |

Itulah jawaban untuk "kenapa baca dibuka untuk semua tapi tulis dibatasi": katalog harus bisa dilihat siapa saja, tapi mengubah isinya harus ada pemiliknya.

> Slide visual: dua user (A dan B). Tanpa RLS ketat, saling menimpa data. Dengan RLS ketat, tiap user terkunci ke datanya sendiri.

### Menyembunyikan tombol bukan keamanan

Di dashboard, tombol Edit dan Hapus hanya tampil di baris milik user yang login. Tapi itu hanya **kemudahan tampilan**.

- Orang yang paham tetap bisa mengirim permintaan `delete` langsung ke Supabase.

- Yang benar-benar menolaknya adalah **RLS di server**, bukan tombol yang disembunyikan.

- Aturan praktis: pembatasan yang penting harus ada di database, bukan hanya di JavaScript.

### Jebakan policy: login tapi data tidak muncul

Role `anon` dan `authenticated` itu **dua role berbeda**. Policy baca dari pertemuan 4 hanya untuk `anon`. Begitu user login, dia berganti jadi `authenticated`, dan policy lama tidak berlaku lagi. Akibatnya setelah login, data tiba-tiba kosong.

- Karena itu script migrasi menghapus policy baca lama dan membuat yang baru: `to anon, authenticated`.

- Gejalanya mudah diingat: **sebelum login data ada, setelah login data hilang** = policy baca belum untuk `authenticated`.

### Relasi antar tabel: foreign key

Sampai sekarang kolom `kategori` di tabel `umkm` berisi teks bebas. Orang bisa mengetik "kuliner", "Kuliner", atau "makanan" untuk hal yang sama, sehingga data tidak konsisten.

Solusinya: pisahkan kategori jadi tabel sendiri, lalu **hubungkan** dengan tabel `umkm`.

```text
Tabel: kategori                    Tabel: umkm
┌────┬───────────┐                ┌────┬──────────────┬───────────────┐
│ id │ nama      │                │ id │ nama         │ kategori_id   │
├────┼───────────┤                ├────┼──────────────┼───────────────┤
│ 1  │ Kuliner   │  <-------------│ 1  │ Warung Bu... │ 1             │
│ 2  │ Fashion   │  <-------------│ 2  │ Batik Kar... │ 2             │
└────┴───────────┘                └────┴──────────────┴───────────────┘
```

- **Primary key** di tabel `kategori` adalah `id`.

- **Foreign key** di tabel `umkm` adalah `kategori_id`: nilainya merujuk ke `id` di tabel `kategori`.

- Hubungannya **one-to-many**: satu kategori dimiliki banyak UMKM.

- Analogi: tabel mahasiswa tidak menulis ulang nama jurusan lengkap di tiap baris. Cukup menyimpan **nomor jurusan** yang merujuk ke tabel jurusan.

Mengambil data dari dua tabel sekaligus (join) dilakukan di `select()`:

```javascript
const { data } = await supabaseClient
  .from("umkm")
  .select("*, kategori(nama)");   // semua kolom umkm + nama dari tabel kategori
```

Praktik langkah demi langkahnya ada di bagian **Bonus** panduan: boleh dilewati kalau waktu kelas habis.

## Hands-on: Langkah demi Langkah

Panduan lengkap (klik apa, file apa, kode lengkap, plus komentar penanda perubahan dari pertemuan 4) ada di **[`implementasi-auth-crud/README.md`](implementasi-auth-crud/README.md)**. Ringkasannya:

**Bagian A — Supabase (di browser)**

1. Matikan **Confirm email** di pengaturan Authentication.

2. Jalankan script `supabase-migrasi-p5.sql` di **SQL Editor**: menambah kolom `user_id` dan mengganti policy.

**Bagian B — Kode (lanjut dari folder pertemuan 4, atau mulai dari `mulai-dari-pertemuan-4/`)**

3. `js/common.js`: sesi login memakai Supabase Auth.

4. `login.html` + `js/login.js`: form email + password, tombol Masuk dan Daftar. **Titik berhenti 1: daftar dan login jalan.**

5. `dashboard.html` + `css/dashboard.css` + `js/dashboard.js`: kolom Aksi, tombol Edit dan Hapus, update dan delete dengan `.eq()` dan `.select()`. **Titik berhenti 2: CRUD lengkap dan hak akses jalan.**

6. Tes dengan dua akun: akun kedua tidak bisa mengubah atau menghapus data akun pertama.

7. **Bonus:** relasi tabel `kategori`.

8. Commit.

Yang **tidak berubah** dari pertemuan 4: `index.html`, `css/style.css`, `js/app.js`. Halaman publik tetap hanya membaca data.

### Hasil akhir sesi ini

```text
pert5-code/
├── README.md                          <- teori (file ini)
├── implementasi-auth-crud/            <- hasil jadi + panduan step-by-step
│   ├── README.md
│   ├── supabase-migrasi-p5.sql
│   ├── index.html  login.html  dashboard.html
│   ├── css/  style.css  dashboard.css
│   ├── js/   common.js  app.js  login.js  dashboard.js
│   └── bonus-relasi-kategori/         <- bonus: tabel kategori + foreign key
└── mulai-dari-pertemuan-4/            <- titik awal (hasil pertemuan 4)
```

Aplikasi sekarang punya CRUD lengkap, login asli lewat Supabase Auth, dan aturan hak akses di database: pengunjung hanya bisa membaca, user yang login bisa menambah, dan hanya pemilik data yang bisa mengubah atau menghapus.

## Catatan AI

Contoh prompt yang baik: "Jelaskan kenapa `delete()` yang ditolak RLS tidak mengembalikan error, dan bagaimana cara mendeteksinya di supabase-js. Jangan tuliskan kode lengkap dashboard punyaku." Selalu uji dengan **dua akun** dan dalam keadaan **logout**. Jangan hanya percaya karena kodenya "terlihat benar".

## Latihan mandiri

Tambahkan tombol atau tampilan **"UMKM saya"** di dashboard: tabel hanya menampilkan UMKM milik user yang sedang login. Petunjuk: tambahkan `.eq("user_id", user.id)` pada query `select`, dan pikirkan kapan filter ini sebaiknya aktif (selalu, atau hanya lewat tombol).

## Rangkuman

CRUD lengkap menuntut kehati-hatian, terutama `.eq()` pada Update dan Delete, dan kebiasaan memeriksa hasilnya karena RLS menolak secara diam-diam. Autentikasi memastikan siapa penggunanya (Supabase Auth: `signUp`, `signInWithPassword`, `getSession`, `signOut`), sedangkan otorisasi memastikan apa yang boleh dia lakukan (Row Level Security dengan `auth.uid()`). Membaca data dibuka untuk semua orang, sementara menambah, mengubah, dan menghapus dibatasi. Relasi antar tabel lewat foreign key menjaga data tetap konsisten. Minggu depan aplikasi ini kita deploy ke internet lewat Vercel, sekaligus arahan untuk proyek akhir kelompok.

## Istilah penting

| Istilah | Artinya |
|---|---|
| CRUD | Create, Read, Update, Delete: empat operasi dasar terhadap data |
| `.eq()` | Filter "sama dengan", wajib dipakai pada Update dan Delete |
| Autentikasi | Memastikan siapa penggunanya (login) |
| Otorisasi | Memastikan apa yang boleh dilakukan pengguna |
| Supabase Auth | Layanan Supabase untuk daftar, login, dan sesi pengguna |
| Session | Tanda bahwa user sudah login, disimpan di browser |
| `getSession()` | Mengecek apakah ada session aktif |
| `auth.uid()` | Id user yang sedang login, dipakai di policy RLS |
| Role `anon` / `authenticated` | Pengunjung belum login / user yang sudah login |
| `using` / `with check` | Syarat baris yang boleh disentuh / syarat hasil akhir sebuah perubahan |
| Event delegation | Memasang satu pendengar di elemen induk untuk melayani banyak elemen di dalamnya |
| Foreign key | Kolom yang merujuk ke primary key di tabel lain |
| One-to-many | Satu baris di tabel A dimiliki banyak baris di tabel B |
| Join | Mengambil data dari dua tabel yang berelasi dalam satu query |
| Publishable key | Kunci akses publik yang aman dipakai di frontend (dulu disebut anon key) |

## Isi folder

- `implementasi-auth-crud/` — kode lengkap (key dummy), panduan `README.md`, `supabase-migrasi-p5.sql`, dan folder `bonus-relasi-kategori/`.

- `mulai-dari-pertemuan-4/` — titik awal: salinan hasil pertemuan 4 (key dummy) beserta `supabase-setup.sql`.
