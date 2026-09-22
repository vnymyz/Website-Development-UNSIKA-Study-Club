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
