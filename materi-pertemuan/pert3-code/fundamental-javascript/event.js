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
