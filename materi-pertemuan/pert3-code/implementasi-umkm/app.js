// ======================================================
// app.js — implementasi JavaScript ke website UMKM
// Kalau belum paham var/const, if/else, function, DOM, atau
// event, coba dulu semua file di folder fundamental-javascript/
// sebelum baca file ini.
// ======================================================

// ---------- 1. Data UMKM ----------
// Data yang sebelumnya ditulis manual sebagai 6 <article> di index.html,
// sekarang disimpan di sini sebagai array of object. Nanti dirender ulang
// jadi HTML oleh renderUmkm().
const daftarUmkm = [
  {
    nama: "Warung Bu Sari",
    kategori: "Kuliner",
    alamat: "Jl. Merdeka No. 10, Karawang",
    jam: "Buka 07.00 – 21.00",
    wa: "0812-3456-7810",
    foto: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&q=60&auto=format&fit=crop",
    alt: "Meja warung dengan aneka lauk siap saji",
  },
  {
    nama: "Batik Karawang Asli",
    kategori: "Fashion",
    alamat: "Jl. Kertabumi No. 5, Karawang",
    jam: "Buka 09.00 – 17.00",
    wa: "0813-2345-6705",
    foto: "https://images.unsplash.com/photo-1761515315375-1315503bb3ce?w=400&q=60&auto=format&fit=crop",
    alt: "Kain batik bermotif tradisional",
  },
  {
    nama: "Anyaman Bambu Pak Jaya",
    kategori: "Kerajinan",
    alamat: "Jl. Tuparev No. 22, Karawang",
    jam: "Buka 08.00 – 16.00",
    wa: "0857-1234-9902",
    foto: "https://images.unsplash.com/photo-1696574727184-a8cdb758d3bf?w=400&q=60&auto=format&fit=crop",
    alt: "Keranjang anyaman bambu",
  },
  {
    nama: "Kopi Rawa Gede",
    kategori: "Kuliner",
    alamat: "Jl. Ahmad Yani No. 3, Karawang",
    jam: "Buka 10.00 – 23.00",
    wa: "0821-9988-2214",
    foto: "https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&q=60&auto=format&fit=crop",
    alt: "Secangkir kopi hitam di atas meja kayu",
  },
  {
    nama: "Konveksi Sinar Tani",
    kategori: "Fashion",
    alamat: "Jl. Pangkal Perjuangan No. 18, Karawang",
    jam: "Buka 08.00 – 17.00",
    wa: "0838-4567-3321",
    foto: "https://images.unsplash.com/photo-1445205170230-053b83016050?w=400&q=60&auto=format&fit=crop",
    alt: "Mesin jahit dan gulungan kain",
  },
  {
    nama: "Gerabah Cikampek",
    kategori: "Kerajinan",
    alamat: "Jl. Ir. H. Juanda No. 45, Karawang",
    jam: "Buka 08.00 – 16.00",
    wa: "0896-7712-0043",
    foto: "https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=400&q=60&auto=format&fit=crop",
    alt: "Kumpulan gerabah tanah liat",
  },
];

// ---------- 2. Render kartu UMKM ke HTML ----------
// container-nya cuma dicari sekali di sini, dipakai ulang di dalam function.
const gridUmkm = document.querySelector(".grid-umkm");

function renderUmkm(data) {
  // Kosongkan dulu isi lama sebelum render ulang, supaya tidak numpuk.
  gridUmkm.innerHTML = "";

  // Kalau hasil filter/pencarian tidak ada, tampilkan pesan, jangan grid kosong.
  if (data.length === 0) {
    gridUmkm.innerHTML = `<p class="kosong">Tidak ada UMKM yang cocok.</p>`;
    return;
  }

  data.forEach((umkm) => {
    // Markup di bawah ini PERSIS sama seperti 1 <article class="kartu-umkm">
    // yang dulu ditulis manual di index.html — supaya CSS yang sudah ada
    // (kartu-foto, badge, kartu-isi, dst) tetap kena tanpa diubah sama sekali.
    gridUmkm.innerHTML += `
      <article class="kartu-umkm">
        <div class="kartu-foto">
          <img src="${umkm.foto}" alt="${umkm.alt}" loading="lazy" />
          <span class="badge">${umkm.kategori}</span>
        </div>
        <div class="kartu-isi">
          <h3>${umkm.nama}</h3>
          <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>${umkm.alamat}</span></p>
          <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> ${umkm.jam}</p>
          <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> ${umkm.wa}</p>
        </div>
      </article>
    `;
  });
}

// Render pertama kali begitu halaman dimuat — sebelum ini, .grid-umkm kosong.
renderUmkm(daftarUmkm);

// ---------- 3. Filter kategori + pencarian nama ----------
const inputCari = document.querySelector(".direktori-cari");
const selectKategori = document.querySelector(".direktori-kategori");

// Satu function yang membaca DUA kondisi sekaligus (kata kunci pencarian
// dan kategori yang dipilih), lalu menyaring array-nya bareng-bareng.
function terapkanFilter() {
  const kataKunci = inputCari.value.toLowerCase().trim();
  const kategoriDipilih = selectKategori.value; // teks opsi, misal "Kuliner" atau "Semua kategori"

  const hasil = daftarUmkm.filter((umkm) => {
    const namaCocok = umkm.nama.toLowerCase().includes(kataKunci);
    const kategoriCocok =
      kategoriDipilih === "Semua kategori" || umkm.kategori === kategoriDipilih;
    return namaCocok && kategoriCocok;
  });

  renderUmkm(hasil);
}

// "input" jalan tiap kali karakter diketik/dihapus — beda dengan "change"
// yang cuma jalan setelah pengguna selesai dan pindah dari elemennya.
inputCari.addEventListener("input", terapkanFilter);

// Untuk <select>, "change" jalan begitu pilihannya berubah.
selectKategori.addEventListener("change", terapkanFilter);

// ---------- 4. Validasi form kontak ----------
const formKontak = document.querySelector("#kontak form");

formKontak.addEventListener("submit", (event) => {
  // Mencegah perilaku bawaan form (reload halaman) saat submit.
  event.preventDefault();

  const nama = document.querySelector("#nama").value;
  const pesan = document.querySelector("#pesan").value;

  if (nama.trim() === "" || pesan.trim() === "") {
    alert("Nama dan pesan tidak boleh kosong!");
    return;
  }

  // Belum ada database (dipelajari pertemuan 4) — untuk sekarang, datanya
  // cuma dicatat di Console sebagai bukti form-nya sudah tervalidasi.
  console.log("Pesan terkirim:", { nama, pesan });
  alert("Terima kasih, " + nama + "! Pesanmu sudah tercatat di console.");
  formKontak.reset();
});
