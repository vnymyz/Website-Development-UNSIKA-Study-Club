# Pertemuan 3 — JavaScript Dasar & DOM

> Kode untuk sesi ini belum dibuat — folder ini baru berisi materi. File kode (`app.js`, dst.) akan ditambahkan menjelang/pada pertemuan 3, mengikuti pola `pert1-code`.

**Durasi:** 19.30–21.00 WIB
**Tools:** VS Code, Live Server, Git
**Output:** Peserta dapat membuat halaman interaktif: render data dari array, filter kategori, dan validasi form dengan JavaScript.

## Tujuan belajar

- Memahami variabel, tipe data, kondisi, dan perulangan di JavaScript.
- Menulis function untuk kode yang bisa dipakai ulang.
- Memahami array dan object untuk menyimpan data terstruktur.
- Memahami DOM dan cara JavaScript mengubah halaman secara dinamis.
- Menangani event seperti klik dan submit form.

## Rundown

| Waktu | Aktivitas |
|---|---|
| 19.30–19.40 | Pembukaan, ice breaking: "pernah nggak isi form terus tombolnya nggak ngapa-ngapain?" |
| 19.40–19.55 | Teori: variabel, tipe data, kondisi, loop, function |
| 19.55–20.10 | Teori: array, object, DOM |
| 20.10–20.35 | Hands-on: render daftar UMKM dari array memakai JavaScript |
| 20.35–20.55 | Hands-on: filter kategori dan validasi form |
| 20.55–21.00 | Rangkuman dan pengantar kuis 3 |

## Teori

### Apa itu JavaScript dan kapan ia berjalan

JavaScript adalah bahasa yang membuat halaman web bisa "bereaksi". Tanpa JavaScript, HTML dan CSS hanya menampilkan halaman diam — tombol tidak merespons, data tidak berubah tanpa reload.

JavaScript dijalankan oleh browser, tepat setelah HTML selesai dimuat (kalau ditempatkan dengan benar). File JavaScript dihubungkan ke HTML seperti CSS, tapi lewat tag `<script>`:

```html
<script src="app.js"></script>
```

Diletakkan sebelum `</body>` supaya HTML sudah selesai dibaca browser sebelum JavaScript mulai mencari elemen-elemennya.

### Variabel dan tipe data

Variabel adalah "kotak penyimpanan" untuk data yang bisa dipakai lagi nanti.

```javascript
let namaUsaha = "Warung Bu Sari";
const kategori = "Kuliner";
```

- `let` — nilainya boleh diubah nanti.
- `const` — nilainya tetap, tidak boleh diubah setelah diisi. Dipakai sebagai default kecuali memang perlu berubah.

Tipe data umum:

| Tipe | Contoh | Keterangan |
|---|---|---|
| `string` | `"Kuliner"` | Teks, diapit tanda kutip |
| `number` | `25000` | Angka, bulat maupun desimal |
| `boolean` | `true` / `false` | Benar atau salah |
| `undefined` | — | Variabel dibuat tapi belum diisi nilai |

### Operator dan kondisi

Operator perbandingan menghasilkan `true`/`false`, dipakai untuk mengambil keputusan.

```javascript
let stok = 5;

if (stok > 0) {
  console.log("Masih tersedia");
} else {
  console.log("Stok habis");
}
```

- `if` menjalankan blok kode hanya kalau kondisinya `true`.
- `else` menjalankan blok alternatif kalau kondisi `false`.
- Operator umum: `===` (sama dengan, harus dipakai ini bukan `==`), `!==` (tidak sama dengan), `>`, `<`, `>=`, `<=`.

> Slide visual: diagram percabangan (seperti diagram alur) dengan dua jalur "true" dan "false".

### Perulangan (loop)

Loop dipakai untuk mengulang kode tanpa menulis ulang manual, misalnya menampilkan banyak data UMKM satu per satu.

```javascript
for (let i = 0; i < 5; i++) {
  console.log("UMKM ke-" + i);
}
```

- `let i = 0` — mulai dari 0.
- `i < 5` — ulangi selama kondisi ini benar.
- `i++` — tambah 1 setiap putaran.

### Function: kode yang bisa dipakai berkali-kali

Function membungkus sekumpulan kode supaya bisa dipanggil ulang tanpa menulis dari awal.

```javascript
function formatRupiah(angka) {
  return "Rp " + angka.toLocaleString("id-ID");
}

console.log(formatRupiah(25000)); // Rp 25.000
```

- `function formatRupiah(angka)` — mendefinisikan function bernama `formatRupiah`, menerima satu parameter `angka`.
- `return` — mengirim balik hasil ke tempat function itu dipanggil.
- `formatRupiah(25000)` — memanggil function dengan nilai 25000.

### Array dan Object: menyimpan data terstruktur

Analogi:

- **Array** seperti daftar belanja — urutan penting, isinya sejenis.
- **Object** seperti KTP — setiap data punya nama/label (key) sendiri.

```javascript
const kategoriList = ["Kuliner", "Fashion", "Kerajinan"];

const umkm = {
  nama: "Warung Bu Sari",
  kategori: "Kuliner",
  alamat: "Jl. Merdeka No. 10, Karawang"
};

console.log(kategoriList[0]); // "Kuliner"
console.log(umkm.nama);        // "Warung Bu Sari"
```

Gabungan keduanya — **array of object** — adalah cara paling umum menyimpan banyak data terstruktur, dan ini pola yang sama dipakai saat kita ambil data dari database nanti di pertemuan 4:

```javascript
const daftarUmkm = [
  { nama: "Warung Bu Sari", kategori: "Kuliner", alamat: "Jl. Merdeka No. 10" },
  { nama: "Batik Karawang Asli", kategori: "Fashion", alamat: "Jl. Kertabumi No. 5" },
  { nama: "Anyaman Bambu Pak Jaya", kategori: "Kerajinan", alamat: "Jl. Tuparev No. 22" }
];
```

> Slide visual: tabel dengan kolom nama/kategori/alamat, tiap baris = satu object dalam array.

### DOM: halaman sebagai "pohon" yang bisa diubah JavaScript

**DOM (Document Object Model)** adalah representasi halaman HTML dalam bentuk struktur yang bisa dibaca dan diubah oleh JavaScript.

```text
document
 └── html
      ├── head
      └── body
           ├── header
           └── main
                └── section
                     └── article
```

JavaScript bisa "mencari" elemen di pohon ini, lalu mengubah isi atau tampilannya:

```javascript
const judul = document.querySelector("h1");
judul.textContent = "Selamat Datang di Katalog UMKM";
judul.style.color = "blue";
```

- `document.querySelector("h1")` — mencari elemen pertama yang cocok dengan selector CSS (`h1`, `.kartu`, `#header`, dll).
- `.textContent` — membaca atau mengubah teks di dalam elemen.
- `.style` — mengubah CSS elemen langsung lewat JavaScript.

### Event: bereaksi terhadap aksi pengguna

Event adalah "kejadian" seperti klik tombol, submit form, atau ketik di input. JavaScript bisa "mendengarkan" event ini lewat `addEventListener`.

```javascript
const tombol = document.querySelector("#tombol-filter");

tombol.addEventListener("click", function () {
  console.log("Tombol diklik!");
});
```

- `addEventListener("click", ...)` — jalankan function tertentu setiap kali elemen ini diklik.
- Function di dalamnya disebut **callback**, dipanggil otomatis saat event terjadi.

### Merender list data ke HTML

Menggabungkan array, loop, dan DOM: kita bisa mengubah data JavaScript menjadi tampilan HTML secara otomatis.

```javascript
function renderUmkm(data) {
  const container = document.querySelector("#daftar-umkm-container");
  container.innerHTML = "";

  data.forEach(function (item) {
    container.innerHTML += `
      <article class="kartu">
        <h3>${item.nama}</h3>
        <p>Kategori: ${item.kategori}</p>
        <p>Alamat: ${item.alamat}</p>
      </article>
    `;
  });
}
```

- `container.innerHTML = ""` — mengosongkan isi lama sebelum render ulang.
- `data.forEach(...)` — mengulang tiap item dalam array, sama seperti `for`, tapi lebih ringkas untuk array.
- Tanda kutip backtick `` ` `` `${item.nama}` — disebut **template literal**, cara menyisipkan variabel langsung ke dalam teks/HTML.

## Hands-on: Langkah demi Langkah

### Langkah 1 — Membuat file JavaScript dan menghubungkannya

1. Buat file baru `app.js` di folder `website-umkm`.
2. Di `index.html`, tambahkan sebelum `</body>`:

```html
<script src="app.js"></script>
```

3. Isi `app.js` dengan:

```javascript
console.log("app.js berhasil terhubung");
```

4. Simpan, buka `Inspect` (`F12`) di browser, klik tab **Console**.

**Cek hasil:** muncul tulisan "app.js berhasil terhubung" di Console.

**Kalau error:** kalau tidak muncul apa-apa, cek posisi `<script>` — harus setelah semua HTML di `<body>`, dan cek nama file sudah persis `app.js`.

### Langkah 2 — Menyiapkan data UMKM dalam array of object

Ganti isi `app.js` dengan:

```javascript
const daftarUmkm = [
  { nama: "Warung Bu Sari", kategori: "Kuliner", alamat: "Jl. Merdeka No. 10, Karawang" },
  { nama: "Batik Karawang Asli", kategori: "Fashion", alamat: "Jl. Kertabumi No. 5, Karawang" },
  { nama: "Anyaman Bambu Pak Jaya", kategori: "Kerajinan", alamat: "Jl. Tuparev No. 22, Karawang" },
  { nama: "Kopi Senja Karawang", kategori: "Kuliner", alamat: "Jl. Ahmad Yani No. 8, Karawang" }
];

console.log(daftarUmkm);
```

**Cek hasil:** di Console browser muncul array berisi 4 object, bisa diklik untuk dilihat isinya.

### Langkah 3 — Menyiapkan container di HTML

Di `index.html`, ganti isi section `daftar-umkm` — hapus tiga `<article>` yang ditulis manual dulu, ganti jadi:

```html
<section id="daftar-umkm">
  <h2>Daftar UMKM</h2>
  <div class="daftar-umkm" id="daftar-umkm-container"></div>
</section>
```

**Cek hasil:** section "Daftar UMKM" jadi kosong di browser (wajar, karena `<article>` manual sudah dihapus, JS belum merender apa-apa).

### Langkah 4 — Menulis function render dan memanggilnya

Tambahkan di `app.js`, di bawah `daftarUmkm`:

```javascript
function renderUmkm(data) {
  const container = document.querySelector("#daftar-umkm-container");
  container.innerHTML = "";

  data.forEach(function (item) {
    container.innerHTML += `
      <article class="kartu">
        <h3>${item.nama}</h3>
        <p>Kategori: ${item.kategori}</p>
        <p>Alamat: ${item.alamat}</p>
      </article>
    `;
  });
}

renderUmkm(daftarUmkm);
```

**Cek hasil:** empat kartu UMKM muncul kembali di halaman, kali ini dirender oleh JavaScript dari data array, bukan ditulis manual di HTML.

**Kalau error:** kalau container tetap kosong, buka Console — biasanya ada pesan error `querySelector` mengembalikan `null` karena `id` di HTML dan JavaScript tidak sama persis (perhatikan huruf besar/kecil dan tanda `-`).

### Langkah 5 — Menambahkan tombol filter kategori

Di `index.html`, tambahkan sebelum `<div id="daftar-umkm-container">`:

```html
<div class="filter">
  <button data-kategori="Semua">Semua</button>
  <button data-kategori="Kuliner">Kuliner</button>
  <button data-kategori="Fashion">Fashion</button>
  <button data-kategori="Kerajinan">Kerajinan</button>
</div>
```

Tambahkan di `app.js`, di bawah `renderUmkm(daftarUmkm);`:

```javascript
const tombolFilter = document.querySelectorAll(".filter button");

tombolFilter.forEach(function (tombol) {
  tombol.addEventListener("click", function () {
    const kategoriDipilih = tombol.dataset.kategori;

    if (kategoriDipilih === "Semua") {
      renderUmkm(daftarUmkm);
    } else {
      const hasilFilter = daftarUmkm.filter(function (item) {
        return item.kategori === kategoriDipilih;
      });
      renderUmkm(hasilFilter);
    }
  });
});
```

Penjelasan:
- `document.querySelectorAll(".filter button")` — mengambil **semua** tombol filter (beda dengan `querySelector` yang cuma ambil satu).
- `tombol.dataset.kategori` — membaca atribut `data-kategori` dari tombol yang diklik.
- `daftarUmkm.filter(...)` — membuat array baru berisi item yang kategorinya cocok.

**Cek hasil:** klik tombol "Kuliner" hanya menampilkan UMKM kategori Kuliner; klik "Semua" menampilkan semua lagi.

### Langkah 6 — Menambahkan validasi form kontak

Di `app.js`, tambahkan di baris paling bawah:

```javascript
const formKontak = document.querySelector("#kontak form");

formKontak.addEventListener("submit", function (event) {
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

Penjelasan:
- `event.preventDefault()` — mencegah form reload halaman secara default saat submit (perilaku bawaan browser).
- `.value` — membaca isi yang diketik pengguna di input/textarea.
- `.trim()` — menghapus spasi kosong di awal/akhir teks, supaya input " " (cuma spasi) tetap terdeteksi kosong.
- `formKontak.reset()` — mengosongkan kembali form setelah berhasil.

**Cek hasil:** submit form kosong memunculkan peringatan "tidak boleh kosong". Submit form terisi memunculkan ucapan terima kasih dan data tercatat di Console.

### Hasil akhir sesi ini

Struktur folder:

```text
website-umkm/
├── index.html
├── style.css
├── app.js
└── .gitignore
```

Halaman kini interaktif: data UMKM dirender dari array JavaScript, ada filter kategori yang berfungsi, dan form kontak sudah tervalidasi sebelum "dikirim" (masih di Console — pengiriman ke database dipelajari pertemuan 4).

## Catatan AI

Contoh prompt yang baik: "Jelaskan perbedaan `forEach` dan `filter` di JavaScript, dengan contoh array UMKM. Jangan tuliskan solusi filter kategori punyaku, cukup jelaskan cara kerjanya." Selalu jalankan kode di Console untuk memastikan output sesuai ekspektasi sebelum melanjutkan.

## Latihan mandiri

Tambahkan satu data UMKM baru pada array `daftarUmkm` dengan kategori "Kerajinan", lalu tambahkan satu tombol filter baru untuk kategori tersebut (kalau belum ada) dan pastikan filternya berfungsi.

## Rangkuman

JavaScript menghidupkan halaman lewat variabel, kondisi, loop, function, array/object, dan interaksi dengan DOM lewat event. Hari ini data UMKM masih tersimpan sementara di array — hilang setiap kali halaman di-refresh. Minggu depan kita hubungkan aplikasi ke database sungguhan memakai Supabase, supaya data yang ditambahkan pengguna benar-benar tersimpan.

## Istilah penting

| Istilah | Artinya |
|---|---|
| Variabel | Kotak penyimpanan data yang bisa dipakai ulang |
| Array | Kumpulan data berurutan |
| Object | Kumpulan data dengan pasangan key-value |
| DOM | Representasi struktur halaman HTML yang bisa dibaca/diubah JavaScript |
| Event | Kejadian seperti klik atau submit yang bisa direspons JavaScript |
| Callback | Function yang dijalankan otomatis saat event/kondisi tertentu terjadi |
| Template literal | Cara menyisipkan variabel ke dalam teks memakai backtick dan `${}` |

## Isi folder

- Belum ada kode — akan ditambahkan menjelang pertemuan 3, melanjutkan dari `pert2-code`.
