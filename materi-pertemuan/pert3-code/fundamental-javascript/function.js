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
