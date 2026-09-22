# Pertemuan 3 — JavaScript Dasar & DOM

`fundamental-javascript/` dan `implementasi-umkm/` di folder ini adalah **hasil akhir** hands-on sesi ini. Buka lewat Live Server (klik kanan `index.html` di VS Code → **Open with Live Server**). Kalau ikut kelas dari awal, jangan buka dulu — ikuti bagian Hands-on di bawah dan bikin sendiri; folder ini jadi jaring pengaman kalau tertinggal.

**Durasi:** 19.30–21.00 WIB
**Tools:** VS Code, Live Server, Git
**Output:** Peserta dapat membuat halaman interaktif: render data dari array, filter kategori + pencarian, dan validasi form dengan JavaScript.

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
| 19.55–20.10 | Teori: array, object, DOM, event |
| 20.10–20.25 | Hands-on: coba satu-satu file di `fundamental-javascript/` |
| 20.25–20.55 | Hands-on: render UMKM dari array, filter + pencarian, validasi form di `implementasi-umkm/` |
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

Menggabungkan array, loop, dan DOM: kita bisa mengubah data JavaScript menjadi tampilan HTML secara otomatis. Ini pola yang sama nanti dipakai buat render kartu UMKM asli di `implementasi-umkm/`:

```javascript
function renderUmkm(data) {
  const container = document.querySelector(".grid-umkm");
  container.innerHTML = "";

  data.forEach(function (item) {
    container.innerHTML += `
      <article class="kartu-umkm">
        <h3>${item.nama}</h3>
        <p>Kategori: ${item.kategori}</p>
      </article>
    `;
  });
}
```

- `container.innerHTML = ""` — mengosongkan isi lama sebelum render ulang.
- `data.forEach(...)` — mengulang tiap item dalam array, sama seperti `for`, tapi lebih ringkas untuk array.
- Tanda kutip backtick `` ` `` `${item.nama}` — disebut **template literal**, cara menyisipkan variabel langsung ke dalam teks/HTML.

Sampai sini semua contohnya masih sederhana. Sekarang mari diterapkan ke web UMKM yang sudah dibuat pertemuan 2 — mulai dari coba dulu satu-satu konsepnya, baru sambungkan ke web asli.

## Hands-on: Langkah demi Langkah

Ada dua folder kode di sini. Kerjakan **Bagian A** dulu sampai semua paham, baru lanjut **Bagian B**.

### Bagian A — Latihan Fundamental (`fundamental-javascript/`)

Satu file = satu konsep. Buka `fundamental-javascript/index.html` lewat Live Server, lalu buka juga `Inspect (F12) > Console` — sebagian hasilnya cuma muncul di Console, bukan di halaman.

#### Langkah 1 — `var.js`: variabel dan tipe data

Buka file `var.js`, baca kodenya, lalu lihat hasilnya di section "1. Variabel & Tipe Data" dan di Console.

**Cek hasil:** di halaman muncul teks nama usaha + kategori. Di Console muncul 4 baris `typeof` (`string`, `number`, `boolean`, `undefined`).

#### Langkah 2 — `condition.js`: if/else

Buka `condition.js`. Coba ubah nilai `stok` jadi `0`, simpan, refresh halaman.

**Cek hasil:** teks berubah dari "Masih tersedia" jadi "Stok habis".

#### Langkah 3 — `loop.js`: perulangan for

Buka `loop.js`. Coba ubah angka `5` di `i <= 5` jadi `10`.

**Cek hasil:** section "3. Perulangan" menampilkan angka 1 sampai 10, bukan cuma sampai 5.

#### Langkah 4 — `function.js`: function

Buka `function.js`. Coba panggil `formatRupiah` dengan angka lain, misalnya `formatRupiah(500000)`, tambahkan `console.log`-nya.

**Cek hasil:** muncul `Rp 500.000` di Console.

#### Langkah 5 — `arrayobject.js`: array dan object

Buka `arrayobject.js`. Coba tambah satu produk baru di `daftarProduk`.

**Cek hasil:** kalau ambil `daftarProduk[2].nama`, muncul nama produk baru yang barusan ditambahkan.

#### Langkah 6 — `consolelog.js`: console.log

Buka `consolelog.js` dan buka Console-nya. Coba tambah satu `console.log` sendiri dengan data apa saja.

**Cek hasil:** muncul beberapa jenis data di Console (teks, angka, boolean, object) — bukti `console.log` bisa menampilkan tipe data apa pun.

#### Langkah 7 — `inputoutput.js`: input dan output

Ketik nama kamu di kotak input section "7. Input & Output", klik tombol "Sapa Aku".

**Cek hasil:** muncul teks "Halo, [nama kamu]!" di bawah tombol. Coba klik tanpa isi apa-apa — muncul "Ketik nama dulu ya!".

#### Langkah 8 — `dom.js`: querySelector, textContent, style

Buka `dom.js`, lihat section "8. DOM" — teksnya sudah berubah otomatis begitu halaman dimuat. Coba ganti warnanya di kode (`targetDom.style.color`).

**Cek hasil:** teks di section itu berubah warna/tebal sesuai yang diubah di kode.

#### Langkah 9 — `event.js`: addEventListener

Klik tombol "Klik Aku" di section "9. Event" beberapa kali.

**Cek hasil:** angka jumlah klik di bawah tombol terus bertambah setiap diklik.

Sudah paham semua 9 konsep di atas? Lanjut ke Bagian B.

### Bagian B — Implementasi ke Website UMKM Pertemuan 2 (`implementasi-umkm/`)

Folder ini lanjutan dari `pert2-code` — HTML dan CSS-nya sama persis, bedanya sekarang ditambah `app.js` supaya direktori UMKM-nya beneran jalan (bukan cuma tampilan).

#### Langkah 1 — Menghubungkan `app.js` ke `index.html`

1. Cek di `implementasi-umkm/index.html`, sebelum `</body>` sudah ada baris:

```html
<script src="app.js"></script>
```

2. Buka `Inspect (F12) > Console`, refresh halaman.

**Cek hasil:** tidak ada error merah di Console. Kartu UMKM di section Direktori sudah muncul (dirender `app.js`, bukan ditulis manual lagi di HTML).

**Kalau error:** kalau muncul error `app.js` tidak ditemukan, cek nama file dan lokasinya — harus persis satu folder dengan `index.html`.

#### Langkah 2 — Data UMKM sebagai array of object

Buka `app.js`, lihat variabel `daftarUmkm` di paling atas — isinya 6 UMKM yang sama seperti yang dulu ditulis manual di HTML pertemuan 2, sekarang jadi data.

**Cek hasil:** di Console, ketik `daftarUmkm` lalu Enter — muncul array berisi 6 object, bisa diklik untuk lihat isinya.

#### Langkah 3 — Function `renderUmkm()`

Baca function `renderUmkm(data)` di `app.js`. Perhatikan markup yang dibuat lewat template literal — persis sama dengan struktur `<article class="kartu-umkm">` yang dulu ditulis manual, supaya CSS-nya tetap kena.

**Cek hasil:** tampilan 6 kartu UMKM di halaman sama persis dengan versi pertemuan 2 — bedanya sekarang datanya dari JavaScript, bukan HTML manual.

**Kalau error:** kalau kartu tidak muncul sama sekali, buka Console — biasanya `querySelector(".grid-umkm")` mengembalikan `null` karena classnya salah ketik atau elemennya belum ada saat `app.js` dijalankan.

#### Langkah 4 — Memfungsikan dropdown kategori

Baca bagian `selectKategori.addEventListener("change", ...)` di `app.js`. Coba ganti dropdown "Semua kategori" di halaman jadi "Kuliner".

**Cek hasil:** kartu yang tampil cuma UMKM kategori Kuliner (Warung Bu Sari, Kopi Rawa Gede). Balikin ke "Semua kategori", semua kartu muncul lagi.

#### Langkah 5 — Memfungsikan pencarian nama

Baca function `terapkanFilter()` — perhatikan cara dia baca DUA input sekaligus (kotak cari dan dropdown kategori), digabung pakai `&&` di dalam `filter()`. Coba ketik "batik" di kotak cari.

**Cek hasil:** cuma kartu "Batik Karawang Asli" yang muncul. Coba kombinasikan: pilih kategori "Kuliner" lalu ketik "kopi" — cuma "Kopi Rawa Gede" yang muncul.

**Kalau error:** kalau hasil pencarian tidak berubah sama sekali, cek event yang dipasang di `inputCari` — harus `"input"`, bukan `"click"` (tidak ada yang diklik di kotak teks).

#### Langkah 6 — Pesan "tidak ditemukan"

Coba ketik nama yang tidak ada di daftar, misalnya "zzz".

**Cek hasil:** muncul teks "Tidak ada UMKM yang cocok." di tempat kartu, bukan halaman kosong tanpa keterangan.

#### Langkah 7 — Validasi form kontak

Scroll ke section Kontak. Klik "Kirim pesan" tanpa mengisi apa-apa.

**Cek hasil:** muncul peringatan "Nama dan pesan tidak boleh kosong!". Isi nama dan pesan, klik lagi — muncul ucapan terima kasih, form jadi kosong lagi, dan di Console muncul `Pesan terkirim: {...}`.

**Kalau error:** kalau form malah reload halaman, cek `event.preventDefault()` sudah dipanggil di paling atas function submit.

Soal paginasi (angka 1/2/3 di bawah kartu) — itu masih tampilan saja, belum difungsikan. Logikanya mirip dengan yang baru dipelajari (motong array, render ulang), boleh dicoba sendiri sebagai latihan tambahan kalau penasaran.

### Hasil akhir sesi ini

Struktur folder:

```text
pert3-code/
├── README.md
├── fundamental-javascript/
│   ├── index.html
│   ├── style.css
│   ├── var.js
│   ├── condition.js
│   ├── loop.js
│   ├── function.js
│   ├── arrayobject.js
│   ├── consolelog.js
│   ├── inputoutput.js
│   ├── dom.js
│   └── event.js
└── implementasi-umkm/
    ├── index.html
    ├── style.css
    └── app.js
```

Direktori UMKM di `implementasi-umkm/` sekarang beneran interaktif: kartu dirender dari array JavaScript, filter kategori dan pencarian nama sama-sama jalan (bisa dikombinasikan), dan form kontak sudah tervalidasi sebelum "dikirim" (masih di Console — pengiriman ke database dipelajari pertemuan 4).

## Catatan AI

Contoh prompt yang baik: "Jelaskan perbedaan `forEach` dan `filter` di JavaScript, dengan contoh array UMKM. Jangan tuliskan solusi filter kategori punyaku, cukup jelaskan cara kerjanya." Selalu jalankan kode di Console untuk memastikan output sesuai ekspektasi sebelum melanjutkan.

## Latihan mandiri

Tambahkan satu data UMKM baru di `daftarUmkm` (`implementasi-umkm/app.js`) dengan kategori bebas, lalu pastikan dia ikut muncul/hilang dengan benar saat dropdown kategori dan kotak pencarian dicoba.

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

- `fundamental-javascript/` — 9 file JS latihan konsep dasar, satu file satu topik, dipelajari duluan sebelum lanjut ke bawah. Mau ngetik dari nol tahu urutannya persis gimana? Ada `README.md` di dalam folder itu sendiri, isinya 13 langkah build-from-scratch lengkap sama daftar isi.
- `implementasi-umkm/` — lanjutan `pert2-code`, sekarang punya `app.js` yang bikin direktori UMKM-nya beneran jalan (render dari array, filter kategori + pencarian, validasi form). Ada juga `README.md` di dalamnya, isinya panduan build-from-scratch mulai dari file pertemuan 2 sampai jadi interaktif.
