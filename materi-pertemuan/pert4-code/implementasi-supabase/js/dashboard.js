// ======================================================
// dashboard.js — halaman dashboard (file BARU di pertemuan 4)
// Fitur: sidebar, ringkasan + daftar UMKM (Read), tambah UMKM (Create).
// Butuh common.js.
// ======================================================

// [BARU P4] Penjaga login: belum login langsung ditendang ke halaman login.
if (!ambilUsername()) {
  location.replace("login.html");
} else {
  mulaiDashboard();
}

function mulaiDashboard() {
  // Lolos cek login, baru tampilkan halaman (sebelumnya disembunyikan CSS)
  document.body.classList.remove("belum-dicek");

  const username = ambilUsername();
  document.querySelector("#nama-user").textContent = username;
  document.querySelector("#avatar-user").textContent = username.charAt(0).toUpperCase();

  const formUmkm = document.querySelector("#form-umkm");
  const statusForm = document.querySelector("#status-form");
  const tubuhTabel = document.querySelector("#tubuh-tabel");
  const statistik = document.querySelector("#statistik");
  const jumlahUmkm = document.querySelector("#jumlah-umkm");
  const judulHalaman = document.querySelector("#judul-halaman");
  const sidebar = document.querySelector("#sidebar");
  const lapisanSidebar = document.querySelector("#lapisan-sidebar");
  const toast = document.querySelector("#toast");

  // ---------- Sidebar: ganti tampilan (Daftar / Tambah) ----------
  function bukaTampilan(nama) {
    document.querySelectorAll(".view").forEach((view) => {
      view.hidden = view.id !== "view-" + nama;
    });
    document.querySelectorAll(".menu-item[data-view]").forEach((tombol) => {
      tombol.classList.toggle("aktif", tombol.dataset.view === nama);
    });
    judulHalaman.textContent = nama === "daftar" ? "Daftar UMKM" : "Tambah UMKM";
    tutupSidebar();
  }

  document.querySelectorAll(".menu-item[data-view]").forEach((tombol) => {
    tombol.addEventListener("click", () => bukaTampilan(tombol.dataset.view));
  });

  // ---------- Sidebar di layar HP: buka / tutup ----------
  function tutupSidebar() {
    sidebar.classList.remove("terbuka");
    lapisanSidebar.classList.remove("tampil");
  }

  document.querySelector("#tombol-menu").addEventListener("click", () => {
    sidebar.classList.add("terbuka");
    lapisanSidebar.classList.add("tampil");
  });
  lapisanSidebar.addEventListener("click", tutupSidebar);
  document.addEventListener("keydown", (event) => {
    if (event.key === "Escape") tutupSidebar();
  });

  // ---------- Logout ----------
  document.querySelector("#tombol-logout").addEventListener("click", () => {
    hapusUsername();
    location.replace("login.html");
  });

  // ---------- Toast: pesan singkat yang hilang sendiri ----------
  let waktuToast;
  function tampilToast(pesan) {
    toast.textContent = pesan;
    toast.classList.add("tampil");
    clearTimeout(waktuToast);
    waktuToast = setTimeout(() => toast.classList.remove("tampil"), 3500);
  }

  // ---------- Read: ringkasan + tabel daftar UMKM ----------
  function renderStatistik(data) {
    const hitung = (kategori) => data.filter((umkm) => umkm.kategori === kategori).length;
    const kartu = [
      ["fa-store", "Total UMKM", data.length],
      ["fa-utensils", "Kuliner", hitung("Kuliner")],
      ["fa-shirt", "Fashion", hitung("Fashion")],
      ["fa-hands", "Kerajinan", hitung("Kerajinan")],
    ];
    statistik.innerHTML = kartu
      .map(
        ([ikon, label, jumlah]) => `
        <div class="stat">
          <span class="stat-ikon"><i class="fa-solid ${ikon}" aria-hidden="true"></i></span>
          <div><strong>${jumlah}</strong><span>${label}</span></div>
        </div>`,
      )
      .join("");
  }

  async function muatTabel() {
    if (!konfigurasiSiap()) {
      tubuhTabel.innerHTML = `<tr><td colspan="6" class="galat">Isi SUPABASE_URL dan SUPABASE_KEY dulu di js/common.js.</td></tr>`;
      return;
    }

    tubuhTabel.innerHTML = `<tr><td colspan="6">Memuat data...</td></tr>`;

    const { data, error } = await supabaseClient
      .from("umkm")
      .select("*")
      .order("id", { ascending: true });

    if (error) {
      console.error("Gagal mengambil data:", error);
      tubuhTabel.innerHTML = `<tr><td colspan="6" class="galat">Gagal mengambil data. Buka Console (F12).</td></tr>`;
      return;
    }

    renderStatistik(data);
    jumlahUmkm.textContent = data.length + " usaha";
    tubuhTabel.innerHTML = data
      .map(
        (umkm) => `
        <tr>
          <td><img class="foto-kecil" src="${escapeHtml(umkm.foto)}" alt="" loading="lazy" /></td>
          <td><strong>${escapeHtml(umkm.nama)}</strong><small>${escapeHtml(umkm.alamat)}</small></td>
          <td><span class="pil">${escapeHtml(umkm.kategori)}</span></td>
          <td>${escapeHtml(umkm.jam)}</td>
          <td>${escapeHtml(umkm.wa)}</td>
          <td>${escapeHtml(umkm.dibuat_oleh)}</td>
        </tr>`,
      )
      .join("");
  }

  // ---------- Create: simpan UMKM baru ----------
  function tampilStatus(pesan, jenis) {
    statusForm.textContent = pesan;
    statusForm.className = "status status-" + jenis; // "ok" atau "galat"
  }

  function kosongkanForm() {
    formUmkm.reset();
    statusForm.textContent = "";
    statusForm.className = "status";
  }

  document.querySelector("#tombol-batal").addEventListener("click", () => {
    kosongkanForm();
    bukaTampilan("daftar");
  });

  formUmkm.addEventListener("submit", async (event) => {
    event.preventDefault();

    // Cek login lagi, jaga-jaga sesi sudah hilang (mis. logout di tab lain)
    if (!ambilUsername()) {
      location.replace("login.html");
      return;
    }

    if (!konfigurasiSiap()) {
      tampilStatus("Isi SUPABASE_URL dan SUPABASE_KEY dulu di js/common.js.", "galat");
      return;
    }

    const nama = document.querySelector("#nama").value.trim();
    const kategori = document.querySelector("#kategori").value;
    const alamat = document.querySelector("#alamat").value.trim();
    const jam = document.querySelector("#jam").value.trim();
    const wa = document.querySelector("#wa").value.trim();
    const foto = document.querySelector("#foto").value.trim();

    if (nama === "" || alamat === "" || jam === "" || wa === "") {
      tampilStatus("Nama, alamat, jam, dan WA wajib diisi.", "galat");
      return;
    }

    // insert() menerima array of object, walau cuma satu baris
    const { error } = await supabaseClient.from("umkm").insert([
      {
        nama: nama,
        kategori: kategori,
        alamat: alamat,
        jam: jam,
        wa: wa,
        foto: foto || FOTO_DEFAULT, // kosong -> pakai foto bawaan
        dibuat_oleh: ambilUsername(),
      },
    ]);

    if (error) {
      console.error("Gagal menyimpan data:", error);
      tampilStatus("Gagal menyimpan. Buka Console (F12) untuk detailnya.", "galat");
      return;
    }

    kosongkanForm();
    bukaTampilan("daftar"); // kembali ke daftar supaya data baru langsung kelihatan
    await muatTabel(); // muat ulang tabel + ringkasan
    tampilToast("UMKM berhasil ditambahkan!");
  });

  muatTabel();
}
