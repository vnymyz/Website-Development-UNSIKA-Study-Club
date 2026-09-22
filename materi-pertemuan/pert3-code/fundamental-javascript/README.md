# Panduan: Bangun `fundamental-javascript/` dari Nol

Dokumen ini buat yang mau paham cara folder `fundamental-javascript/` dibangun langkah demi langkah — bukan cuma buka file jadi terus bingung asalnya dari mana. Tiap langkah nambah sedikit, dan hasilnya bisa langsung dicoba di browser sebelum lanjut ke langkah berikutnya.

**Cara pakai:** siapkan folder kosong bernama `fundamental-javascript`, ikuti urutan di bawah dari Langkah 1. Tiap selesai satu langkah, buka `index.html` pakai Live Server (klik kanan file itu di VS Code → **Open with Live Server**) buat lihat hasilnya. Jangan lompat langkah — tiap langkah nyambung ke langkah sebelumnya.

## Daftar Isi

1. [Kerangka HTML Paling Dasar](#langkah-1--kerangka-html-paling-dasar)
2. [Isi `<head>` dan Menghubungkan `style.css`](#langkah-2--isi-head-dan-menghubungkan-stylecss)
3. [CSS Dasar (Lengkap Sekali Jalan)](#langkah-3--css-dasar-lengkap-sekali-jalan)
4. [Header, Footer, dan Kerangka `<main>`](#langkah-4--header-footer-dan-kerangka-main)
5. [Section 1 — Variabel & Tipe Data (`var.js`)](#langkah-5--section-1--variabel--tipe-data-varjs)
6. [Section 2 — Kondisi (`condition.js`)](#langkah-6--section-2--kondisi-conditionjs)
7. [Section 3 — Perulangan (`loop.js`)](#langkah-7--section-3--perulangan-loopjs)
8. [Section 4 — Function (`function.js`)](#langkah-8--section-4--function-functionjs)
9. [Section 5 — Array & Object (`arrayobject.js`)](#langkah-9--section-5--array--object-arrayobjectjs)
10. [Section 6 — Console Log (`consolelog.js`)](#langkah-10--section-6--console-log-consolelogjs)
11. [Section 7 — Input & Output (`inputoutput.js`)](#langkah-11--section-7--input--output-inputoutputjs)
12. [Section 8 — DOM (`dom.js`)](#langkah-12--section-8--dom-domjs)
13. [Section 9 — Event (`event.js`)](#langkah-13--section-9--event-eventjs)
14. [Selesai — Cek Ulang dan Lanjut](#selesai--cek-ulang-dan-lanjut)

---

## Langkah 1 — Kerangka HTML Paling Dasar

Setiap halaman HTML butuh kerangka minimal ini dulu sebelum diisi apa-apa. Buat file `index.html`:

```html
<!doctype html>
<html lang="id">
  <head>
  </head>
  <body>
  </body>
</html>
```

- `<!doctype html>` — bilang ke browser "ini dokumen HTML5", wajib jadi baris pertama.
- `<html lang="id">` — elemen pembungkus seluruh halaman, `lang="id"` bilang isinya Bahasa Indonesia (bantu screen reader dan mesin pencari).
- `<head>` — tempat metadata (judul, link CSS, dst), tidak tampil di halaman.
- `<body>` — tempat semua yang benar-benar tampil ke pengguna.

**Coba buka di browser:** halaman putih kosong, tidak ada tulisan apa-apa. Itu wajar — belum diisi apa-apa.

## Langkah 2 — Isi `<head>` dan Menghubungkan `style.css`

Lengkapi `<head>`, lalu buat file `style.css` kosong di folder yang sama:

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Latihan Fundamental JavaScript</title>
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
  </body>
</html>
```

- `<meta charset="UTF-8" />` — biar karakter khusus (tanda petik miring, emoji, dst) tampil benar, bukan simbol aneh.
- `<meta name="viewport" ...>` — biar halaman menyesuaikan lebar layar HP, bukan tampil kekecilan.
- `<title>` — judul tab browser.
- `<link rel="stylesheet" href="style.css" />` — menghubungkan file CSS terpisah, sama seperti pertemuan 2.

**Coba buka di browser:** masih putih kosong (CSS-nya belum diisi), tapi cek tab judul browser sudah berubah jadi "Latihan Fundamental JavaScript". Buka `Inspect (F12) > Console`, pastikan tidak ada error merah soal `style.css` tidak ketemu.

## Langkah 3 — CSS Dasar (Lengkap Sekali Jalan)

Beda dengan CSS di pertemuan 2 yang ditambah section per section, di sini semua style-nya generik dan dipakai bareng semua bagian — jadi ditulis sekali penuh. Isi `style.css`:

```css
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: "Segoe UI", system-ui, sans-serif;
  color: #1f2937;
  background-color: #f6f3e7;
  line-height: 1.6;
  padding: 24px;
}

header {
  max-width: 760px;
  margin: 0 auto 32px;
}

header h1 {
  color: #33422b;
  margin-bottom: 8px;
}

header code {
  background-color: #e9efe1;
  padding: 2px 6px;
  border-radius: 4px;
}

main {
  max-width: 760px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

section {
  background-color: white;
  border: 1px solid #ddd6c4;
  border-radius: 12px;
  padding: 20px 24px;
}

section h2 {
  color: #33422b;
  font-size: 1.1rem;
  margin-bottom: 8px;
}

section h2 code {
  font-size: 0.9rem;
  background-color: #e9efe1;
  padding: 2px 6px;
  border-radius: 4px;
}

.keterangan {
  color: #555;
  font-size: 0.92rem;
  margin-bottom: 12px;
}

.output {
  background-color: #f6f3e7;
  border: 1px dashed #c9a66b;
  border-radius: 8px;
  padding: 10px 14px;
  font-family: "Consolas", monospace;
  font-size: 0.9rem;
  min-height: 20px;
  white-space: pre-wrap;
}

input[type="text"] {
  padding: 8px 12px;
  border: 1px solid #ddd6c4;
  border-radius: 6px;
  font-family: inherit;
  font-size: 0.95rem;
  margin-right: 8px;
}

button {
  background-color: #c9a66b;
  color: #1e2a18;
  border: none;
  padding: 8px 18px;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.9rem;
  cursor: pointer;
}

button:hover {
  background-color: #33422b;
  color: white;
}

footer {
  max-width: 760px;
  margin: 32px auto 0;
  color: #7c9473;
  font-size: 0.88rem;
  text-align: center;
}
```

Beberapa yang perlu diperhatikan:
- `* { box-sizing: border-box; }` — reset dasar, sama seperti pertemuan 2, biar padding/border tidak bikin lebar elemen melar.
- `.output` — kotak putus-putus warna gold ini nanti jadi tempat hasil tiap latihan JavaScript ditulis. Belum kepakai sekarang karena elemennya belum ada.
- `section` — tiap konsep nanti dibungkus `<section>` terpisah, makanya distyle jadi kotak putih dengan border.
- `button` dan `input[type="text"]` — belum kepakai juga, disiapkan duluan buat langkah Input & Output dan Event nanti.

**Coba buka di browser:** halaman masih kosong (karena `<body>` belum ada isinya), tapi kalau di-inspect elemen `<body>` sudah kena `padding: 24px` dan warna background krem.

## Langkah 4 — Header, Footer, dan Kerangka `<main>`

Isi `<body>` dengan header (penjelasan umum), placeholder `<main>` kosong (nanti diisi 9 section satu-satu), dan footer:

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Latihan Fundamental JavaScript</title>
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <header>
      <h1>Latihan Fundamental JavaScript</h1>
      <p>
        Satu section = satu konsep. Buka <strong>Inspect (F12) &gt; Console</strong>
        sebelum mulai — sebagian besar hasilnya muncul di sana, bukan cuma di halaman.
        Coba ganti-ganti nilai di tiap file <code>.js</code>, simpan, lalu refresh
        buat lihat efeknya sendiri.
      </p>
    </header>

    <main>
    </main>

    <footer>
      <p>
        Detail penjelasan tiap konsep ada di <code>README.md</code> pertemuan ini.
        Sudah selesai semua? Lanjut ke folder <code>implementasi-umkm/</code>.
      </p>
    </footer>
  </body>
</html>
```

- `<header>` isinya statis — judul halaman + pengingat buka Console dulu. Tidak berubah lagi sampai akhir.
- `<main>` sengaja dikosongkan dulu — 9 langkah berikutnya isinya nambah satu `<section>` ke sini, satu per satu.
- `<footer>` juga statis — arahan ke README dan folder berikutnya. Ditaruh dari awal biar tidak lupa nambahnya belakangan.

**Coba buka di browser:** sekarang sudah kelihatan judul "Latihan Fundamental JavaScript" dan paragraf pengantar di atas (dibungkus kotak putih dari CSS header), lalu ruang kosong, lalu teks footer kecil warna sage di bawah. Bagian tengah (`<main>`) masih kosong — itu tempat section-section berikutnya.

## Langkah 5 — Section 1: Variabel & Tipe Data (`var.js`)

Mulai isi `<main>`. Tambahkan section pertama, tepat di dalam `<main>`:

```html
    <main>
      <!-- 1. Variabel & tipe data -->
      <section id="demo-var">
        <h2>1. Variabel &amp; Tipe Data — <code>var.js</code></h2>
        <p class="keterangan"><code>let</code> vs <code>const</code>, dan empat tipe data dasar.</p>
        <p id="hasil-var" class="output"></p>
      </section>
    </main>
```

Lalu buat file baru `var.js` di folder yang sama, isinya:

```javascript
// ======================================================
// 1. Variabel & Tipe Data
// ======================================================

// let: nilainya boleh diubah lagi nanti.
let namaUsaha = "Warung Bu Sari";

// const: nilainya tetap, tidak boleh diubah setelah diisi.
// Dipakai sebagai default kecuali memang perlu berubah.
const kategori = "Kuliner";

// Empat tipe data dasar di JavaScript:
const contohString = "Kuliner"; // teks, diapit tanda kutip
const contohNumber = 25000; // angka, bulat maupun desimal
const contohBoolean = true; // benar atau salah
let contohUndefined; // dibuat tapi belum diisi nilai apa pun

// Cek tipe data sebuah nilai pakai typeof
console.log(typeof contohString); // "string"
console.log(typeof contohNumber); // "number"
console.log(typeof contohBoolean); // "boolean"
console.log(typeof contohUndefined); // "undefined"

// Tulis hasilnya ke halaman juga, biar kelihatan tanpa buka Console
document.querySelector("#hasil-var").textContent =
  `${namaUsaha} (${kategori}) — contoh tipe data: string, number, boolean, undefined`;
```

Terakhir, hubungkan file JS-nya — tambahkan sebelum `</body>`, setelah `</footer>`:

```html
    <script src="var.js"></script>
  </body>
</html>
```

**Cek hasil:** section "1. Variabel & Tipe Data" muncul, kotak output-nya berisi teks `Warung Bu Sari (Kuliner) — contoh tipe data: string, number, boolean, undefined`. Buka Console — muncul 4 baris `typeof` (`string`, `number`, `boolean`, `undefined`).

**Kalau error:** kalau kotak output kosong, buka Console — biasanya ada `querySelector` mengembalikan `null` karena id di HTML (`#hasil-var`) dan di `var.js` tidak sama persis.

## Langkah 6 — Section 2: Kondisi (`condition.js`)

Tambahkan section kedua, tepat di bawah section pertama (masih di dalam `<main>`):

```html
      <!-- 2. Kondisi -->
      <section id="demo-condition">
        <h2>2. Kondisi (if/else) — <code>condition.js</code></h2>
        <p class="keterangan">Cek stok barang: kalau lebih dari 0, tersedia; kalau tidak, habis.</p>
        <p id="hasil-condition" class="output"></p>
      </section>
```

Buat file `condition.js`:

```javascript
// ======================================================
// 2. Kondisi (if / else)
// ======================================================

let stok = 5;

if (stok > 0) {
  console.log("Masih tersedia");
} else {
  console.log("Stok habis");
}

// Operator perbandingan yang dipakai: === (sama dengan, bukan ==),
// !== (tidak sama dengan), >, <, >=, <=

function cekStok(jumlah) {
  if (jumlah > 0) {
    return "Masih tersedia (" + jumlah + " item)";
  } else {
    return "Stok habis";
  }
}

document.querySelector("#hasil-condition").textContent = cekStok(stok);
```

Tambahkan satu baris lagi di deretan `<script>`, di bawah `var.js`:

```html
    <script src="var.js"></script>
    <script src="condition.js"></script>
  </body>
</html>
```

**Cek hasil:** section "2. Kondisi" muncul dengan teks "Masih tersedia (5 item)". Coba ubah `stok` jadi `0` di `condition.js`, simpan, refresh — teksnya berubah jadi "Stok habis".

## Langkah 7 — Section 3: Perulangan (`loop.js`)

Tambahkan section ketiga, di bawah section Kondisi:

```html
      <!-- 3. Loop -->
      <section id="demo-loop">
        <h2>3. Perulangan (for) — <code>loop.js</code></h2>
        <p class="keterangan">Mencetak angka 1 sampai 5 tanpa menulis <code>console.log</code> lima kali.</p>
        <p id="hasil-loop" class="output"></p>
      </section>
```

Buat file `loop.js`:

```javascript
// ======================================================
// 3. Perulangan (for)
// ======================================================

// let i = 0    -> mulai dari 0
// i < 5        -> ulangi selama kondisi ini benar
// i++          -> tambah 1 setiap putaran
let hasilLoop = "";

for (let i = 1; i <= 5; i++) {
  console.log("Angka ke-" + i);
  hasilLoop += i + " ";
}

document.querySelector("#hasil-loop").textContent = hasilLoop.trim();
```

Tambahkan ke deretan `<script>`:

```html
    <script src="var.js"></script>
    <script src="condition.js"></script>
    <script src="loop.js"></script>
  </body>
</html>
```

**Cek hasil:** section "3. Perulangan" muncul dengan teks `1 2 3 4 5`. Di Console muncul 5 baris "Angka ke-1" sampai "Angka ke-5". Coba ubah `i <= 5` jadi `i <= 10` — hasilnya ikut sampai angka 10.

## Langkah 8 — Section 4: Function (`function.js`)

Tambahkan section keempat:

```html
      <!-- 4. Function -->
      <section id="demo-function">
        <h2>4. Function — <code>function.js</code></h2>
        <p class="keterangan"><code>formatRupiah(angka)</code>: menerima angka, mengembalikan teks berformat.</p>
        <p id="hasil-function" class="output"></p>
      </section>
```

Buat file `function.js`:

```javascript
// ======================================================
// 4. Function
// ======================================================

// function formatRupiah(angka) -> mendefinisikan function bernama
// formatRupiah, menerima satu parameter "angka".
// return -> mengirim balik hasil ke tempat function ini dipanggil.
function formatRupiah(angka) {
  return "Rp " + angka.toLocaleString("id-ID");
}

console.log(formatRupiah(25000)); // Rp 25.000
console.log(formatRupiah(150000)); // Rp 150.000

document.querySelector("#hasil-function").textContent =
  `formatRupiah(25000) = ${formatRupiah(25000)}`;
```

Tambahkan ke deretan `<script>`:

```html
    <script src="var.js"></script>
    <script src="condition.js"></script>
    <script src="loop.js"></script>
    <script src="function.js"></script>
  </body>
</html>
```

**Cek hasil:** section "4. Function" muncul dengan teks `formatRupiah(25000) = Rp 25.000`. Di Console muncul `Rp 25.000` dan `Rp 150.000`.

## Langkah 9 — Section 5: Array & Object (`arrayobject.js`)

Tambahkan section kelima:

```html
      <!-- 5. Array & Object -->
      <section id="demo-arrayobject">
        <h2>5. Array &amp; Object — <code>arrayobject.js</code></h2>
        <p class="keterangan">Array of object: beberapa produk, tiap produk punya nama dan harga.</p>
        <p id="hasil-arrayobject" class="output"></p>
      </section>
```

Buat file `arrayobject.js`:

```javascript
// ======================================================
// 5. Array & Object
// ======================================================

// Array: daftar belanja — urutan penting, isinya sejenis.
const kategoriList = ["Kuliner", "Fashion", "Kerajinan"];
console.log(kategoriList[0]); // "Kuliner"

// Object: KTP — setiap data punya nama/label (key) sendiri.
const produk = {
  nama: "Kaos Polos",
  harga: 75000,
};
console.log(produk.nama); // "Kaos Polos"

// Gabungan keduanya: array of object — cara paling umum menyimpan
// banyak data terstruktur.
const daftarProduk = [
  { nama: "Kaos Polos", harga: 75000 },
  { nama: "Topi", harga: 45000 },
];

console.log(daftarProduk[0].nama); // "Kaos Polos"

document.querySelector("#hasil-arrayobject").textContent =
  `Produk pertama: ${daftarProduk[0].nama}, harga Rp ${daftarProduk[0].harga}`;
```

Tambahkan ke deretan `<script>`:

```html
    <script src="var.js"></script>
    <script src="condition.js"></script>
    <script src="loop.js"></script>
    <script src="function.js"></script>
    <script src="arrayobject.js"></script>
  </body>
</html>
```

**Cek hasil:** section "5. Array & Object" muncul dengan teks `Produk pertama: Kaos Polos, harga Rp 75000`. Di Console: `Kuliner` dan `Kaos Polos`.

## Langkah 10 — Section 6: Console Log (`consolelog.js`)

Tambahkan section keenam — ini satu-satunya section yang tidak menulis apa pun ke halaman, cuma ke Console:

```html
      <!-- 6. Console log -->
      <section id="demo-consolelog">
        <h2>6. Console Log — <code>consolelog.js</code></h2>
        <p class="keterangan">
          Bagian ini <strong>tidak nulis apa-apa ke halaman</strong> — semua hasilnya
          cuma muncul di tab Console. Buka Console sekarang buat lihat.
        </p>
      </section>
```

Buat file `consolelog.js`:

```javascript
// ======================================================
// 6. Console Log
// ======================================================
// console.log() dipakai buat "mengintip" nilai variabel tanpa harus
// menulisnya ke halaman — cara paling umum cek kode jalan benar atau
// tidak. Buka tab Console (F12), semua baris di bawah ini muncul di sana.

console.log("Ini teks biasa");
console.log(123); // angka
console.log(true); // boolean
console.log({ nama: "Warung Bu Sari", kategori: "Kuliner" }); // object, bisa diklik buat lihat isinya

// Bisa gabung beberapa nilai sekaligus, dipisah koma
const nama = "Alya";
const umur = 20;
console.log("Nama:", nama, "- Umur:", umur);
```

Tambahkan ke deretan `<script>`:

```html
    <script src="var.js"></script>
    <script src="condition.js"></script>
    <script src="loop.js"></script>
    <script src="function.js"></script>
    <script src="arrayobject.js"></script>
    <script src="consolelog.js"></script>
  </body>
</html>
```

**Cek hasil:** section "6. Console Log" muncul di halaman (cuma teks keterangan, kotak output-nya memang tidak ada). Buka Console — muncul 5 baris: teks biasa, angka, boolean, object (bisa diklik), dan baris "Nama: Alya - Umur: 20".

## Langkah 11 — Section 7: Input & Output (`inputoutput.js`)

Tambahkan section ketujuh — section ini punya `<input>` dan `<button>`:

```html
      <!-- 7. Input & Output -->
      <section id="demo-inputoutput">
        <h2>7. Input &amp; Output — <code>inputoutput.js</code></h2>
        <p class="keterangan">Ketik nama, klik tombol, lihat hasilnya ditulis ke halaman.</p>
        <input type="text" id="input-nama" placeholder="Ketik nama kamu..." />
        <button id="tombol-sapa">Sapa Aku</button>
        <p id="hasil-inputoutput" class="output"></p>
      </section>
```

Buat file `inputoutput.js`:

```javascript
// ======================================================
// 7. Input & Output
// ======================================================
// Baca isi <input> pakai .value, lalu tulis hasilnya ke elemen lain
// pakai .textContent — pola paling dasar dari "input" dan "output"
// yang nanti dipakai lagi di form validasi.

const inputNama = document.querySelector("#input-nama");
const tombolSapa = document.querySelector("#tombol-sapa");
const hasilOutput = document.querySelector("#hasil-inputoutput");

tombolSapa.addEventListener("click", () => {
  const nama = inputNama.value; // .value -> membaca isi yang diketik pengguna

  if (nama.trim() === "") {
    hasilOutput.textContent = "Ketik nama dulu ya!";
    return;
  }

  hasilOutput.textContent = "Halo, " + nama + "!";
});
```

Tambahkan ke deretan `<script>`:

```html
    <script src="var.js"></script>
    <script src="condition.js"></script>
    <script src="loop.js"></script>
    <script src="function.js"></script>
    <script src="arrayobject.js"></script>
    <script src="consolelog.js"></script>
    <script src="inputoutput.js"></script>
  </body>
</html>
```

**Cek hasil:** ketik nama di kotak, klik "Sapa Aku" — muncul "Halo, [nama kamu]!" di bawah tombol. Klik tanpa isi apa-apa — muncul "Ketik nama dulu ya!".

**Kalau error:** kalau klik tombol tidak ngapa-ngapain, cek urutan `<script>` — file `inputoutput.js` harus dimuat setelah elemen `<input>` dan `<button>` ada di HTML (di sini sudah aman karena semua script ditaruh di akhir `<body>`).

## Langkah 12 — Section 8: DOM (`dom.js`)

Tambahkan section kedelapan:

```html
      <!-- 8. DOM -->
      <section id="demo-dom">
        <h2>8. DOM — <code>dom.js</code></h2>
        <p class="keterangan">
          <code>querySelector</code>, <code>.textContent</code>, dan <code>.style</code>
          dipakai buat ubah teks dan warna paragraf di bawah ini — otomatis begitu
          halaman dimuat, tanpa diklik.
        </p>
        <p id="target-dom" class="output">Teks ini akan diubah oleh dom.js</p>
      </section>
```

Perhatikan `<p id="target-dom">` sudah diisi teks placeholder — nanti diganti otomatis oleh `dom.js` begitu halaman dimuat, tanpa perlu diklik apa pun.

Buat file `dom.js`:

```javascript
// ======================================================
// 8. DOM (Document Object Model)
// ======================================================
// document.querySelector("selector") -> mencari elemen pertama yang
// cocok dengan selector CSS (tag, .class, atau #id).
// .textContent -> membaca/mengubah teks di dalam elemen.
// .style -> mengubah CSS elemen langsung lewat JavaScript.

const targetDom = document.querySelector("#target-dom");

targetDom.textContent = "Teks ini SUDAH diubah oleh dom.js";
targetDom.style.color = "#33422b";
targetDom.style.fontWeight = "bold";
```

Tambahkan ke deretan `<script>`:

```html
    <script src="var.js"></script>
    <script src="condition.js"></script>
    <script src="loop.js"></script>
    <script src="function.js"></script>
    <script src="arrayobject.js"></script>
    <script src="consolelog.js"></script>
    <script src="inputoutput.js"></script>
    <script src="dom.js"></script>
  </body>
</html>
```

**Cek hasil:** begitu halaman dimuat/direfresh, section "8. DOM" langsung menampilkan teks "Teks ini SUDAH diubah oleh dom.js" berwarna hijau tua dan tebal — bukan teks placeholder aslinya. Coba ganti warnanya di `dom.js` (`targetDom.style.color`), refresh, lihat warnanya berubah.

## Langkah 13 — Section 9: Event (`event.js`)

Tambahkan section kesembilan, section terakhir:

```html
      <!-- 9. Event -->
      <section id="demo-event">
        <h2>9. Event — <code>event.js</code></h2>
        <p class="keterangan"><code>addEventListener("click", ...)</code> — klik tombolnya.</p>
        <button id="tombol-event">Klik Aku</button>
        <p id="hasil-event" class="output"></p>
      </section>
```

Buat file `event.js`:

```javascript
// ======================================================
// 9. Event
// ======================================================
// addEventListener("click", ...) -> jalankan function tertentu
// setiap kali elemen ini diklik. Function di dalamnya disebut
// callback, dipanggil otomatis saat event terjadi.

const tombolEvent = document.querySelector("#tombol-event");
const hasilEvent = document.querySelector("#hasil-event");

let jumlahKlik = 0;

tombolEvent.addEventListener("click", function () {
  jumlahKlik = jumlahKlik + 1;
  hasilEvent.textContent = "Tombol sudah diklik " + jumlahKlik + " kali";
});
```

Tambahkan baris terakhir ke deretan `<script>` — sekarang lengkap semua 9:

```html
    <script src="var.js"></script>
    <script src="condition.js"></script>
    <script src="loop.js"></script>
    <script src="function.js"></script>
    <script src="arrayobject.js"></script>
    <script src="consolelog.js"></script>
    <script src="inputoutput.js"></script>
    <script src="dom.js"></script>
    <script src="event.js"></script>
  </body>
</html>
```

**Cek hasil:** klik tombol "Klik Aku" di section terakhir beberapa kali — angka jumlah klik di bawahnya terus bertambah tiap kali diklik ("Tombol sudah diklik 1 kali", "2 kali", dst).

## Selesai — Cek Ulang dan Lanjut

File akhir yang dihasilkan sekarang persis sama dengan `index.html`, `style.css`, dan 9 file `.js` yang ada di folder `fundamental-javascript/` ini. Struktur akhirnya:

```text
fundamental-javascript/
├── index.html
├── style.css
├── var.js
├── condition.js
├── loop.js
├── function.js
├── arrayobject.js
├── consolelog.js
├── inputoutput.js
├── dom.js
└── event.js
```

Cek ulang semuanya sekaligus: buka `index.html` lewat Live Server, scroll dari atas ke bawah — harus ada 9 kotak section berurutan, semua kotak output-nya terisi (kecuali section 6 yang memang cuma nulis ke Console), dan tombol-tombol di section 7 & 9 berfungsi saat diklik. Buka Console, pastikan tidak ada error merah sama sekali.

Kalau semua sudah beres, lanjut ke folder `implementasi-umkm/` — langkah-langkahnya ada di `README.md` pertemuan ini, bagian **Hands-on: Langkah demi Langkah → Bagian B**. Di sana konsep yang sama (variabel, function, array of object, DOM, event) dipakai buat bikin direktori UMKM pertemuan 2 beneran interaktif.
