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
