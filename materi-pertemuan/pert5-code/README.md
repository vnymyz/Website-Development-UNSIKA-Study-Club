# Pertemuan 5 — Update, Delete, Relasi Tabel & Autentikasi

> Kode untuk sesi ini belum dibuat — folder ini baru berisi materi. File kode akan ditambahkan menjelang/pada pertemuan 5, mengikuti pola `pert1-code`.

**Durasi:** 19.30–21.00 WIB
**Tools:** VS Code, Live Server, Supabase
**Output:** Peserta dapat melengkapi CRUD (Update, Delete), membuat relasi antar tabel, serta menambahkan sistem login dengan Supabase Auth dan Row Level Security dasar.

## Tujuan belajar

- Melengkapi CRUD dengan fitur Update dan Delete.
- Menambahkan pencarian dan pengurutan data.
- Memahami relasi antar tabel lewat foreign key.
- Memahami perbedaan autentikasi dan otorisasi.
- Membuat sistem login/register dengan Supabase Auth.
- Memahami dan menerapkan Row Level Security (RLS) dasar.

## Rundown

| Waktu | Aktivitas |
|---|---|
| 19.30–19.40 | Pembukaan, ice breoking: "kalau aplikasi tidak ada tombol edit/hapus, gimana rasanya?" |
| 19.40–19.50 | Teori: Update, Delete, pentingnya filter `.eq()` |
| 19.50–20.05 | Hands-on: tombol Edit dan Hapus + pencarian |
| 20.05–20.15 | Teori: relasi antar tabel (foreign key) |
| 20.15–20.25 | Hands-on: membuat tabel kategori dan query join |
| 20.25–20.35 | Teori: autentikasi, otorisasi, Row Level Security |
| 20.35–20.55 | Hands-on: login, register, dan RLS |
| 20.55–21.00 | Rangkuman dan pengantar kuis 5 |

## Teori

### Melengkapi CRUD: Update dan Delete

CRUD adalah singkatan dari empat operasi dasar terhadap data:

| Operasi | Kegunaan | Contoh di aplikasi kita |
|---|---|---|
| **C**reate | Menambah data baru | Form tambah UMKM (pertemuan 4) |
| **R**ead | Membaca/menampilkan data | Menampilkan daftar UMKM (pertemuan 4) |
| **U**pdate | Mengubah data yang sudah ada | Edit alamat UMKM yang salah ketik |
| **D**elete | Menghapus data | Menghapus UMKM yang sudah tutup |

Minggu lalu kita sudah membuat Create dan Read. Hari ini melengkapi dengan Update dan Delete.

### Kenapa `.eq()` sangat penting

Saat mengubah atau menghapus data, kita **wajib** menentukan baris mana yang dimaksud — biasanya lewat `id`.

```javascript
// BENAR: hanya mengubah baris dengan id = 3
await supabaseClient.from("umkm").update({ nama: "Nama Baru" }).eq("id", 3);

// SALAH: tanpa .eq(), berpotensi mengubah SEMUA baris di tabel
await supabaseClient.from("umkm").update({ nama: "Nama Baru" });
```

> Slide visual: ilustrasi dua skenario — satu map terhapus (benar) vs seluruh laci kosong (salah, tanpa filter).

Ini kesalahan paling umum dan paling berbahaya pada CRUD pemula: lupa `.eq()` saat update/delete bisa menghapus atau mengubah seluruh isi tabel dalam sekali klik.

### Pencarian dan pengurutan data

Supabase menyediakan berbagai method untuk memfilter data, contohnya:

```javascript
// Mencari nama yang mengandung kata tertentu (tidak peduli huruf besar/kecil)
await supabaseClient.from("umkm").select("*").ilike("nama", `%${kataKunci}%`);

// Mengurutkan data terbaru di atas
await supabaseClient.from("umkm").select("*").order("created_at", { ascending: false });
```

- `.ilike("nama", "%kopi%")` — mencari baris yang kolom `nama`-nya mengandung kata "kopi", huruf besar/kecil diabaikan. Tanda `%` berarti "boleh ada apa saja sebelum/sesudah".

### Relasi antar tabel: kenapa data dipecah jadi beberapa tabel

Sampai sekarang, kolom `kategori` di tabel `umkm` diisi manual sebagai teks bebas — bisa saja seseorang mengetik "kuliner", "Kuliner", atau "makanan" untuk hal yang sama. Ini bikin data tidak konsisten.

Solusinya: pisahkan kategori jadi tabel sendiri, lalu **hubungkan** dengan tabel UMKM.

Analogi: bayangkan data mahasiswa. Alih-alih menulis ulang nama jurusan lengkap di setiap baris mahasiswa, kampus punya tabel jurusan terpisah, dan tabel mahasiswa cukup menyimpan **nomor referensi** ke jurusan itu — nomor itu disebut **foreign key**.

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
- **Foreign key** di tabel `umkm` adalah `kategori_id` — nilainya merujuk ke `id` pada tabel `kategori`.
- Relasi ini disebut **one-to-many**: satu kategori bisa dimiliki oleh banyak UMKM.

> Slide visual: diagram di atas dengan panah dari `kategori_id` ke `id` tabel kategori.

Keuntungan relasi:
- Data konsisten — kategori hanya ditulis sekali di satu tempat.
- Kalau nama kategori perlu diubah, cukup ubah satu baris di tabel `kategori`, otomatis berlaku untuk semua UMKM terkait.

### Autentikasi vs Otorisasi

Dua istilah yang sering tertukar:

- **Autentikasi** — proses memastikan **siapa** penggunanya (login, cek email dan password).
- **Otorisasi** — proses memastikan **apa yang boleh dilakukan** pengguna itu setelah dikenali (misalnya, hanya pemilik data yang boleh menghapus datanya sendiri).

Analogi: autentikasi itu seperti satpam mengecek KTP di pintu masuk kantor; otorisasi itu seperti kartu akses yang menentukan ruangan mana saja yang boleh kamu masuki setelah masuk.

### Alur sign up, login, dan session

```text
1. Sign up   → user daftar dengan email + password
2. Login     → user masuk, Supabase memberi "session" (tanda sudah login)
3. Session   → disimpan di browser, dipakai untuk setiap permintaan berikutnya
4. Logout    → session dihapus, user dianggap keluar
```

Supabase Auth mengurus semua penyimpanan password secara aman (di-*hash*, tidak disimpan sebagai teks biasa) — kita tidak perlu membangun sistem ini dari nol.

### Row Level Security (RLS): kenapa penting

Ingat di pertemuan 4 kita membuat policy "izinkan semua orang membaca dan menambah data" — itu policy yang sangat longgar, cocok untuk latihan tapi berbahaya untuk aplikasi sungguhan.

Tanpa RLS yang tepat: **siapa pun** yang tahu `anon key` (yang memang publik) bisa mengubah atau menghapus data siapa saja, bukan cuma datanya sendiri.

RLS memungkinkan kita menulis aturan seperti: "user hanya boleh meng-update atau menghapus baris yang `user_id`-nya cocok dengan dirinya sendiri."

```text
Tanpa RLS ketat:  Siapa saja -> bisa ubah/hapus data siapa saja
Dengan RLS ketat: User A     -> hanya bisa ubah/hapus data milik User A
```

> Slide visual: dua user (A dan B) dengan panah — versi tanpa RLS saling menyerobot data, versi dengan RLS masing-masing terkunci ke datanya sendiri.

## Hands-on: Langkah demi Langkah

### Langkah 1 — Menambahkan tombol Edit dan Hapus

Ubah function `renderUmkm` di `app.js` supaya tiap kartu punya tombol:

```javascript
function renderUmkm(data) {
  const container = document.querySelector("#daftar-umkm-container");
  container.innerHTML = "";

  data.forEach(function (item) {
    container.innerHTML += `
      <article class="kartu" data-id="${item.id}">
        <h3>${item.nama}</h3>
        <p>Kategori: ${item.kategori}</p>
        <p>Alamat: ${item.alamat}</p>
        <button class="btn-edit" data-id="${item.id}">Edit</button>
        <button class="btn-hapus" data-id="${item.id}">Hapus</button>
      </article>
    `;
  });

  pasangEventTombolAksi();
}
```

**Cek hasil:** setiap kartu UMKM sekarang punya dua tombol tambahan di bawahnya (belum berfungsi, karena `pasangEventTombolAksi` belum dibuat).

### Langkah 2 — Menghapus data (Delete)

Tambahkan function ini di `app.js`, di bawah `renderUmkm`:

```javascript
function pasangEventTombolAksi() {
  document.querySelectorAll(".btn-hapus").forEach(function (tombol) {
    tombol.addEventListener("click", async function () {
      const id = tombol.dataset.id;
      const konfirmasi = confirm("Yakin ingin menghapus data ini?");
      if (!konfirmasi) return;

      const { error } = await supabaseClient.from("umkm").delete().eq("id", id);

      if (error) {
        console.error("Gagal menghapus:", error);
        alert("Gagal menghapus data.");
        return;
      }

      ambilDanTampilkanUmkm();
    });
  });
}
```

Penjelasan:
- `.delete().eq("id", id)` — menghapus **hanya** baris dengan `id` sesuai tombol yang diklik.
- `confirm(...)` — memunculkan dialog konfirmasi bawaan browser sebelum aksi berbahaya (hapus data) dijalankan.

**Cek hasil:** klik "Hapus" pada satu kartu memunculkan dialog konfirmasi, lalu kartu itu hilang setelah dikonfirmasi. Kartu lain tidak terpengaruh.

### Langkah 3 — Mengubah data (Update)

Tambahkan di dalam function `pasangEventTombolAksi`, setelah blok `.btn-hapus`:

```javascript
  document.querySelectorAll(".btn-edit").forEach(function (tombol) {
    tombol.addEventListener("click", async function () {
      const id = tombol.dataset.id;
      const namaBaru = prompt("Nama baru:");
      if (namaBaru === null || namaBaru.trim() === "") return;

      const { error } = await supabaseClient
        .from("umkm")
        .update({ nama: namaBaru.trim() })
        .eq("id", id);

      if (error) {
        console.error("Gagal mengubah:", error);
        alert("Gagal mengubah data.");
        return;
      }

      ambilDanTampilkanUmkm();
    });
  });
```

**Cek hasil:** klik "Edit" memunculkan kotak `prompt` berisi nama baru, setelah diisi, kartu ter-update dengan nama baru — hanya kartu yang diedit, yang lain tidak berubah.

**Kalau error:** kalau semua baris ikut berubah, cek kembali apakah `.eq("id", id)` benar-benar tertulis, dan pastikan `id` yang dikirim sesuai dengan tombol yang diklik.

### Langkah 4 — Menambahkan kotak pencarian

Di `index.html`, tambahkan sebelum `<div class="filter">`:

```html
<input type="text" id="kotak-cari" placeholder="Cari nama UMKM...">
```

Di `app.js`, tambahkan:

```javascript
const kotakCari = document.querySelector("#kotak-cari");

kotakCari.addEventListener("input", async function () {
  const kataKunci = kotakCari.value.trim();

  const { data, error } = await supabaseClient
    .from("umkm")
    .select("*")
    .ilike("nama", `%${kataKunci}%`)
    .order("id", { ascending: true });

  if (error) {
    console.error("Gagal mencari:", error);
    return;
  }

  renderUmkm(data);
});
```

**Cek hasil:** mengetik di kotak pencarian langsung menyaring kartu yang tampil sesuai kata kunci, tanpa reload halaman.

### Langkah 5 — Membuat tabel `kategori` dan relasinya

1. Di Supabase Table Editor, klik **New table**, beri nama `kategori`.
2. Tambahkan kolom `nama` (tipe `text`).
3. Buat policy read+insert untuk tabel ini seperti langkah pertemuan 4 (**Enable read access for all users**).
4. Isi 3 baris: "Kuliner", "Fashion", "Kerajinan".
5. Kembali ke tabel `umkm`, klik **New column**, beri nama `kategori_id`, tipe `int8`.
6. Pada opsi kolom, cari bagian **Foreign Key Relation**, hubungkan `kategori_id` ke `kategori.id`.
7. Update baris-baris `umkm` yang sudah ada: isi `kategori_id` sesuai kategori masing-masing (lihat `id` di tabel kategori).

**Cek hasil:** tabel `umkm` punya kolom baru `kategori_id` yang terhubung (linked) ke tabel `kategori`.

**Kalau error:** kalau opsi Foreign Key Relation tidak muncul, pastikan tipe data `kategori_id` (`int8`) sama dengan tipe `id` di tabel `kategori`.

### Langkah 6 — Query gabungan (join) dua tabel

Ganti bagian `.select("*")` pada `ambilDanTampilkanUmkm` menjadi:

```javascript
const { data, error } = await supabaseClient
  .from("umkm")
  .select("*, kategori(nama)")
  .order("id", { ascending: true });
```

Lalu di `renderUmkm`, ganti `${item.kategori}` menjadi `${item.kategori.nama}`.

Penjelasan: `select("*, kategori(nama)")` meminta Supabase mengambil semua kolom `umkm` **plus** kolom `nama` dari tabel `kategori` yang terhubung lewat `kategori_id` — inilah manfaat relasi, data digabung otomatis tanpa query terpisah.

**Cek hasil:** nama kategori tetap tampil di kartu, tapi sekarang datanya diambil dari tabel `kategori` lewat relasi, bukan teks bebas di tabel `umkm`.

### Langkah 7 — Mengaktifkan Supabase Auth (Email)

1. Di sidebar Supabase, klik **Authentication > Providers**.
2. Pastikan **Email** dalam kondisi aktif (biasanya sudah default aktif).
3. Di **Authentication > URL Configuration**, pastikan Site URL mengarah ke `http://localhost` untuk pengembangan lokal (nanti diubah lagi saat deploy di pertemuan 6).

**Cek hasil:** menu Authentication menampilkan daftar user (masih kosong) dan pengaturan provider Email aktif.

### Langkah 8 — Membuat form Register dan Login

Tambahkan section baru di `index.html`, sebelum section Kontak:

```html
<section id="auth">
  <h2>Login / Daftar</h2>
  <input type="email" id="auth-email" placeholder="Email">
  <input type="password" id="auth-password" placeholder="Password">
  <button id="btn-daftar">Daftar</button>
  <button id="btn-login">Login</button>
  <button id="btn-logout" style="display:none;">Logout</button>
  <p id="status-login"></p>
</section>
```

Tambahkan di `app.js`:

```javascript
const inputEmail = document.querySelector("#auth-email");
const inputPassword = document.querySelector("#auth-password");
const statusLogin = document.querySelector("#status-login");
const btnDaftar = document.querySelector("#btn-daftar");
const btnLogin = document.querySelector("#btn-login");
const btnLogout = document.querySelector("#btn-logout");

btnDaftar.addEventListener("click", async function () {
  const { error } = await supabaseClient.auth.signUp({
    email: inputEmail.value,
    password: inputPassword.value
  });

  if (error) {
    alert("Gagal daftar: " + error.message);
    return;
  }

  alert("Pendaftaran berhasil! Silakan login.");
});

btnLogin.addEventListener("click", async function () {
  const { error } = await supabaseClient.auth.signInWithPassword({
    email: inputEmail.value,
    password: inputPassword.value
  });

  if (error) {
    alert("Gagal login: " + error.message);
    return;
  }

  cekStatusLogin();
});

btnLogout.addEventListener("click", async function () {
  await supabaseClient.auth.signOut();
  cekStatusLogin();
});

async function cekStatusLogin() {
  const { data } = await supabaseClient.auth.getSession();

  if (data.session) {
    statusLogin.textContent = "Login sebagai: " + data.session.user.email;
    btnLogout.style.display = "inline-block";
    btnLogin.style.display = "none";
    btnDaftar.style.display = "none";
  } else {
    statusLogin.textContent = "Belum login.";
    btnLogout.style.display = "none";
    btnLogin.style.display = "inline-block";
    btnDaftar.style.display = "inline-block";
  }
}

cekStatusLogin();
```

Penjelasan:
- `auth.signUp({ email, password })` — mendaftarkan user baru.
- `auth.signInWithPassword({ email, password })` — login, hasilnya otomatis membuat session.
- `auth.getSession()` — mengecek apakah ada session aktif (user sedang login atau tidak).
- `auth.signOut()` — menghapus session (logout).

**Cek hasil:** daftar dengan email+password baru, lalu login — teks "Login sebagai: ..." muncul dan tombol berubah jadi Logout.

**Kalau error:** kalau Supabase minta verifikasi email, cek pengaturan **Authentication > Providers > Email > Confirm email** — untuk latihan kelas, opsi ini boleh dimatikan sementara agar tidak perlu cek inbox.

### Langkah 9 — Menyembunyikan tombol Edit/Hapus untuk yang belum login

Ubah `renderUmkm` supaya tombol Edit/Hapus hanya muncul kalau user sudah login:

```javascript
async function renderUmkm(data) {
  const { data: sesiData } = await supabaseClient.auth.getSession();
  const sudahLogin = sesiData.session !== null;

  const container = document.querySelector("#daftar-umkm-container");
  container.innerHTML = "";

  data.forEach(function (item) {
    const tombolAksi = sudahLogin
      ? `<button class="btn-edit" data-id="${item.id}">Edit</button>
         <button class="btn-hapus" data-id="${item.id}">Hapus</button>`
      : "";

    container.innerHTML += `
      <article class="kartu" data-id="${item.id}">
        <h3>${item.nama}</h3>
        <p>Kategori: ${item.kategori.nama}</p>
        <p>Alamat: ${item.alamat}</p>
        ${tombolAksi}
      </article>
    `;
  });

  pasangEventTombolAksi();
}
```

Catatan: `renderUmkm` sekarang jadi `async function` karena memakai `await` di dalamnya — pastikan semua tempat yang memanggilnya (misalnya di `ambilDanTampilkanUmkm`) tetap berjalan normal karena JavaScript otomatis menunggu `async function` selesai saat dipanggil dengan `await` atau di dalam function `async` lain.

**Cek hasil:** saat belum login, kartu UMKM tampil tanpa tombol Edit/Hapus. Setelah login, tombolnya muncul kembali.

### Langkah 10 — Mengaktifkan RLS ketat (dasar)

1. Di Supabase, buka tabel `umkm`, tab **Policies**.
2. Hapus policy lama **"Enable insert access for all users"**.
3. Buat policy baru dengan pilihan custom: **INSERT** hanya diizinkan untuk role `authenticated` (bukan `anon`). Supabase menyediakan template **"Enable insert for authenticated users only"** — pilih itu.
4. Lakukan hal sama untuk **UPDATE** dan **DELETE**: buat policy yang hanya mengizinkan role `authenticated`.
5. Biarkan policy **SELECT** tetap terbuka untuk semua orang (`anon` dan `authenticated`), supaya siapa pun tetap bisa melihat katalog tanpa login.

**Cek hasil:** logout dari aplikasi, coba tambah/edit/hapus data — aksi akan gagal dengan error dari Supabase terkait policy. Setelah login kembali, aksi berhasil normal.

**Kalau error:** kalau setelah login pun tetap gagal, pastikan `renderUmkm` dan tombol aksi benar-benar terpasang **setelah** proses login selesai (`cekStatusLogin()` dipanggil ulang setelah login berhasil).

### Langkah 11 — Commit progres

```bash
git add .
git commit -m "Tambah update, delete, relasi kategori, auth, dan RLS dasar"
git push
```

**Cek hasil:** commit baru tercatat di GitHub.

### Hasil akhir sesi ini

Struktur folder tetap sama, tapi `app.js` kini jauh lebih lengkap:

```text
website-umkm/
├── index.html
├── style.css
├── app.js
└── .gitignore
```

Aplikasi sekarang punya CRUD penuh, data kategori terpisah dan berelasi lewat foreign key, serta sistem login/register dengan RLS yang membatasi siapa boleh mengubah data.

## Catatan AI

Contoh prompt yang baik: "Jelaskan kenapa policy RLS untuk SELECT tetap dibiarkan terbuka untuk publik sementara INSERT/UPDATE/DELETE dibatasi. Jangan tuliskan policy lengkap punyaku." Selalu uji ulang aplikasi dalam kondisi logout untuk memastikan RLS benar-benar berfungsi, jangan hanya percaya karena kodenya "terlihat benar".

## Latihan mandiri

Tambahkan kolom `user_id` (tipe `uuid`) pada tabel `umkm`, isi otomatis dengan `id` user yang sedang login saat insert (`supabaseClient.auth.getSession()` untuk mendapatkan `user.id`), lalu buat policy RLS agar user hanya bisa **update dan delete data miliknya sendiri** (bandingkan `user_id` dengan `auth.uid()`).

## Rangkuman

CRUD lengkap butuh kehati-hatian, terutama filter `.eq()` pada Update dan Delete. Relasi antar tabel lewat foreign key menjaga data tetap konsisten. Autentikasi memastikan siapa penggunanya, sementara Row Level Security memastikan apa yang boleh mereka lakukan terhadap data. Minggu depan, aplikasi ini akan kita deploy ke internet lewat Vercel, sekaligus arahan untuk proyek akhir kelompok.

## Istilah penting

| Istilah | Artinya |
|---|---|
| CRUD | Create, Read, Update, Delete — empat operasi dasar terhadap data |
| Foreign key | Kolom yang merujuk ke primary key tabel lain, untuk membuat relasi |
| One-to-many | Jenis relasi di mana satu baris di tabel A bisa dimiliki banyak baris di tabel B |
| Autentikasi | Proses memastikan identitas pengguna (login) |
| Otorisasi | Proses menentukan apa yang boleh dilakukan pengguna |
| Session | Tanda bahwa pengguna sedang dalam status login |
| Row Level Security (RLS) | Aturan yang membatasi akses baca/tulis pada baris data tertentu |
| Policy | Satu aturan spesifik dalam RLS, misalnya "izinkan SELECT untuk semua orang" |

## Isi folder

- Belum ada kode — akan ditambahkan menjelang pertemuan 5, melanjutkan dari `pert4-code`.
