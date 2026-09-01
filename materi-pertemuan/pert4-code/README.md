# Pertemuan 4 — Database & Supabase (Create + Read)

> Kode untuk sesi ini belum dibuat — folder ini baru berisi materi. File kode akan ditambahkan menjelang/pada pertemuan 4, mengikuti pola `pert1-code`.

**Durasi:** 19.30–21.00 WIB
**Tools:** VS Code, Live Server, Supabase
**Output:** Peserta dapat membuat tabel di Supabase dan menghubungkan aplikasi untuk menyimpan (Create) serta menampilkan (Read) data sungguhan.

## Tujuan belajar

- Memahami kenapa data perlu disimpan di database, bukan hanya di array JavaScript.
- Memahami konsep tabel, baris, kolom, dan primary key.
- Memahami apa itu Supabase dan bedanya API key `anon` vs `service_role`.
- Membuat tabel di Supabase lewat Table Editor.
- Menghubungkan halaman web ke Supabase untuk insert dan select data.

## Rundown

| Waktu | Aktivitas |
|---|---|
| 19.30–19.40 | Pembukaan, ice breaking: "pernah nggak isi form panjang terus HP restart dan datanya hilang?" |
| 19.40–19.55 | Teori: kenapa butuh database, tabel, baris, kolom |
| 19.55–20.10 | Teori: Postgres, Supabase, API key |
| 20.10–20.30 | Hands-on: membuat project dan tabel di Supabase |
| 20.30–20.55 | Hands-on: menghubungkan halaman untuk insert dan select data |
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

### API Key: anon vs service_role

Setiap project Supabase punya dua kunci akses:

| Key | Kegunaan | Boleh dipakai di frontend? |
|---|---|---|
| `anon` (public) | Akses terbatas, dipakai di kode yang jalan di browser pengguna | **Ya**, aman untuk dilihat siapa saja |
| `service_role` | Akses penuh tanpa batasan apa pun, seperti "kunci master" | **Tidak pernah** — kalau bocor, siapa pun bisa membaca/menghapus semua data |

Analogi: `anon key` seperti kartu akses karyawan biasa (bisa masuk lobi, ruang kerja); `service_role key` seperti kartu akses ruang server pusat — kalau dipegang orang yang salah, seluruh sistem bisa dibobol.

Untuk kelas ini, kita **hanya memakai `anon key`** di kode frontend, dan tidak pernah menyentuh `service_role key`.

## Hands-on: Langkah demi Langkah

### Langkah 1 — Membuat project Supabase

1. Login ke [supabase.com](https://supabase.com/).
2. Klik **New Project**.
3. Isi nama project, misalnya `website-umkm`, dan buat password database (simpan baik-baik, jangan share ke orang lain).
4. Pilih region terdekat (misalnya Singapore), klik **Create new project**.
5. Tunggu 1–2 menit sampai status project berubah jadi aktif.

**Cek hasil:** dashboard project Supabase terbuka, ada menu sidebar Table Editor, Authentication, SQL Editor, dsb.

### Langkah 2 — Membuat tabel `umkm`

1. Di sidebar kiri, klik **Table Editor**.
2. Klik **New table**.
3. Nama tabel: `umkm`.
4. Biarkan opsi "Enable Row Level Security" **tetap aktif** (default) — nanti diatur lebih lanjut di pertemuan 5. Untuk sementara, kita akan buat policy sederhana di Langkah 3 supaya latihan hari ini tetap bisa jalan.
5. Tambahkan kolom (klik **+ Add column** untuk tiap baris):

   | Nama kolom | Tipe |
   |---|---|
   | `nama` | `text` |
   | `kategori` | `text` |
   | `alamat` | `text` |

   (Kolom `id` dan `created_at` sudah otomatis dibuat Supabase.)
6. Klik **Save**.

**Cek hasil:** tabel `umkm` muncul di daftar Table Editor dengan 0 baris, kolom sesuai yang dibuat.

### Langkah 3 — Mengizinkan akses baca dan tulis (policy dasar)

Supabase mengaktifkan **Row Level Security (RLS)** secara default, artinya tanpa aturan tambahan, tabel akan **menolak semua akses** dari `anon key`. Untuk latihan hari ini, kita buat policy sederhana yang mengizinkan semua orang membaca dan menambah data (aturan yang lebih ketat dipelajari pertemuan 5).

1. Di halaman tabel `umkm`, klik tab **Policies** (atau lewat menu **Authentication > Policies**).
2. Klik **New Policy** untuk tabel `umkm`, pilih template **"Enable read access for all users"**, simpan.
3. Klik **New Policy** lagi, pilih template **"Enable insert access for all users"**, simpan.

**Cek hasil:** tabel `umkm` punya 2 policy: satu untuk `SELECT`, satu untuk `INSERT`.

**Kalau error:** kalau lupa langkah ini, nanti kode JavaScript akan mengembalikan data kosong atau error "row-level security policy" meski tidak ada kesalahan penulisan kode.

### Langkah 4 — Mengisi data lewat Table Editor

1. Di tab **Table Editor**, klik **Insert > Insert row**.
2. Isi `nama`, `kategori`, `alamat` untuk 2–3 UMKM (boleh pakai data yang sama dari pertemuan sebelumnya).
3. Klik **Save**.

**Cek hasil:** baris baru muncul di tabel dengan `id` otomatis terisi (1, 2, dst).

### Langkah 5 — Mengambil Project URL dan anon key

1. Klik ikon gerigi (**Project Settings**) di sidebar, pilih **API**.
2. Salin nilai **Project URL** dan **anon public** key.

**Cek hasil:** dua nilai ini siap ditempel ke kode JavaScript pada langkah berikutnya.

### Langkah 6 — Memasang Supabase JS Client lewat CDN

Di `index.html`, tambahkan sebelum `<script src="app.js"></script>`:

```html
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/dist/umd/supabase.min.js"></script>
```

Di `app.js`, tambahkan paling atas (ganti dengan nilai milikmu sendiri):

```javascript
const SUPABASE_URL = "https://xxxxxxxxxxxx.supabase.co";
const SUPABASE_ANON_KEY = "isi-anon-key-kamu-di-sini";

const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
```

Penjelasan:
- `supabase.createClient(url, key)` — membuat koneksi ke project Supabase kamu, hasilnya disimpan di variabel `supabaseClient` untuk dipakai berkali-kali.

**Cek hasil:** tidak ada error merah di Console setelah refresh halaman.

**Kalau error:** kalau muncul `supabase is not defined`, cek urutan `<script>` — file CDN Supabase harus dimuat **sebelum** `app.js`.

### Langkah 7 — Mengambil data dari Supabase (Read/Select)

Ganti bagian `daftarUmkm` (array manual) dan pemanggilan `renderUmkm(daftarUmkm)` di `app.js` menjadi:

```javascript
async function ambilDanTampilkanUmkm() {
  const { data, error } = await supabaseClient
    .from("umkm")
    .select("*")
    .order("id", { ascending: true });

  if (error) {
    console.error("Gagal mengambil data:", error);
    return;
  }

  renderUmkm(data);
}

ambilDanTampilkanUmkm();
```

Penjelasan:
- `async function` — menandai function ini berisi proses yang butuh waktu (mengambil data lewat internet), sehingga perlu `await` di dalamnya.
- `await` — "tunggu dulu proses ini selesai sebelum lanjut ke baris berikutnya".
- `.from("umkm")` — pilih tabel `umkm`.
- `.select("*")` — ambil semua kolom.
- `.order("id", { ascending: true })` — urutkan berdasarkan `id` dari kecil ke besar.
- `{ data, error }` — Supabase selalu mengembalikan dua kemungkinan: `data` (berhasil) atau `error` (gagal). Selalu dicek keduanya.

**Cek hasil:** data UMKM yang diisi manual di Langkah 4 kini tampil di halaman web, diambil langsung dari Supabase — bukan dari array JavaScript lagi.

### Langkah 8 — Menyimpan data dari form (Create/Insert)

Ganti isi function `formKontak.addEventListener("submit", ...)` — kali ini kita ubah form kontak menjadi form tambah UMKM. Di `index.html`, ganti form di section kontak:

```html
<section id="kontak">
  <h2>Tambah UMKM Baru</h2>
  <form id="form-umkm">
    <label for="nama">Nama Usaha</label>
    <input type="text" id="nama" name="nama" placeholder="Nama usaha">

    <label for="kategori">Kategori</label>
    <input type="text" id="kategori" name="kategori" placeholder="Kuliner / Fashion / Kerajinan">

    <label for="alamat">Alamat</label>
    <input type="text" id="alamat" name="alamat" placeholder="Alamat usaha">

    <button type="submit">Simpan</button>
  </form>
</section>
```

Di `app.js`, ganti bagian validasi form lama dengan:

```javascript
const formUmkm = document.querySelector("#form-umkm");

formUmkm.addEventListener("submit", async function (event) {
  event.preventDefault();

  const nama = document.querySelector("#nama").value.trim();
  const kategori = document.querySelector("#kategori").value.trim();
  const alamat = document.querySelector("#alamat").value.trim();

  if (nama === "" || kategori === "" || alamat === "") {
    alert("Semua kolom wajib diisi!");
    return;
  }

  const { error } = await supabaseClient
    .from("umkm")
    .insert([{ nama: nama, kategori: kategori, alamat: alamat }]);

  if (error) {
    console.error("Gagal menyimpan data:", error);
    alert("Gagal menyimpan data. Cek Console untuk detail.");
    return;
  }

  alert("UMKM berhasil ditambahkan!");
  formUmkm.reset();
  ambilDanTampilkanUmkm();
});
```

Penjelasan:
- `.insert([{ ... }])` — Supabase menerima **array of object**, meski cuma menyimpan satu baris (tanda kurung siku `[ ]` tetap wajib).
- Setelah berhasil insert, kita panggil lagi `ambilDanTampilkanUmkm()` supaya kartu baru langsung muncul tanpa perlu refresh manual.

**Cek hasil:** isi form, klik Simpan, muncul alert sukses, dan kartu UMKM baru langsung muncul di halaman.

### Langkah 9 — Membuktikan data benar-benar tersimpan

1. Refresh halaman browser secara manual (`F5`).
2. Cek juga di Supabase Table Editor.

**Cek hasil:** data yang tadi ditambahkan lewat form **masih ada** setelah refresh, dan baris barunya juga muncul di Table Editor Supabase — bukti data tersimpan permanen di database, bukan di memori browser.

### Langkah 10 — Commit progres

```bash
git add .
git commit -m "Hubungkan aplikasi ke Supabase untuk create dan read data UMKM"
git push
```

**Cek hasil:** commit baru muncul di riwayat repository GitHub.

**Kalau error:** jangan pernah commit `service_role key`. `anon key` aman untuk ikut ter-commit karena memang didesain untuk publik, tapi tetap hindari kebiasaan menaruh key langsung di kode — di pertemuan 6 kita rapikan ini dengan environment variable.

### Hasil akhir sesi ini

Struktur folder:

```text
website-umkm/
├── index.html
├── style.css
├── app.js
└── .gitignore
```

Aplikasi kini terhubung ke database Postgres sungguhan lewat Supabase. Form menyimpan data baru (Create), dan halaman menampilkan data dari database (Read). Data bertahan meski halaman di-refresh atau dibuka di komputer lain.

## Catatan AI

Contoh prompt yang baik: "Jelaskan kenapa Supabase mengembalikan `{ data, error }` alih-alih langsung datanya saja. Jangan tuliskan kode lengkap punyaku." Selalu cek nilai `error` di Console sebelum menyalahkan kode HTML/CSS saat data tidak muncul.

## Latihan mandiri

Tambahkan kolom baru `nomor_telepon` (tipe `text`) pada tabel `umkm` lewat Table Editor, lalu tambahkan input untuk kolom itu di form dan pastikan data tersimpan serta tampil di kartu UMKM.

## Rangkuman

Database menyimpan data secara permanen dalam tabel berisi baris dan kolom, dengan `id` sebagai primary key. Supabase menyediakan Postgres siap pakai lewat JavaScript client, diakses memakai `anon key` dari frontend. Hari ini kita berhasil Create dan Read data sungguhan. Minggu depan kita lengkapi dengan Update, Delete, relasi antar tabel, dan sistem login.

## Istilah penting

| Istilah | Artinya |
|---|---|
| Database | Tempat penyimpanan data secara permanen dan terstruktur |
| Tabel | Kumpulan data sejenis, tersusun dalam baris dan kolom |
| Primary key | Kolom unik yang membedakan satu baris dengan baris lain |
| Postgres | Jenis database yang dipakai Supabase |
| Supabase | Layanan yang menyediakan Postgres, API, dan Auth siap pakai |
| anon key | Kunci akses publik yang aman dipakai di frontend |
| service_role key | Kunci akses penuh, tidak boleh pernah dipakai di frontend |
| Row Level Security (RLS) | Aturan yang membatasi siapa boleh mengakses baris data tertentu |
| async/await | Cara JavaScript menunggu proses yang butuh waktu, seperti mengambil data dari internet |

## Isi folder

- Belum ada kode — akan ditambahkan menjelang pertemuan 4, melanjutkan dari `pert3-code`.
