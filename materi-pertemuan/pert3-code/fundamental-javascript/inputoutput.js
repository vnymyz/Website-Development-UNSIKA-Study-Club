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
