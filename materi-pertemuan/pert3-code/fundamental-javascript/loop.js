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
