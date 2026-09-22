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
