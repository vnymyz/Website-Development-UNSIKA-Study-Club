// ======================================================
// dashboard.js — halaman dashboard
// Fitur: sidebar, daftar UMKM (Read), tambah (Create), edit (Update),
// hapus (Delete). Login memakai Supabase Auth. Butuh common.js.
// Penanda: [BARU P5] ditambah, [UBAH P5] diubah, [SAMA P4] tidak berubah.
// ======================================================

// [UBAH P5] Penjaga login. Dulu cek username di localStorage, sekarang cek
// sesi Supabase Auth. Belum login langsung ditendang ke halaman login.
async function mulai() {
  const sesi = await ambilSesi();
  if (!sesi) {
    location.replace("login.html");
    return;
  }
  mulaiDashboard(sesi.user);
}
mulai();

function mulaiDashboard(user) {
  // Lolos cek login, baru tampilkan halaman (sebelumnya disembunyikan CSS)
  document.body.classList.remove("belum-dicek");

  const nama = namaTampil(user);
  document.querySelector("#nama-user").textContent = nama;
  document.querySelector("#avatar-user").textContent = nama
    .charAt(0)
    .toUpperCase();

  const formUmkm = document.querySelector("#form-umkm");
  const statusForm = document.querySelector("#status-form");
  const tubuhTabel = document.querySelector("#tubuh-tabel");
  const statistik = document.querySelector("#statistik");
  const jumlahUmkm = document.querySelector("#jumlah-umkm");
  const judulHalaman = document.querySelector("#judul-halaman");
  const judulForm = document.querySelector("#judul-form");
  const tombolSimpan = document.querySelector("#tombol-simpan");
  const sidebar = document.querySelector("#sidebar");
  const lapisanSidebar = document.querySelector("#lapisan-sidebar");
  const toast = document.querySelector("#toast");

  // [BARU P5] idDiedit = null artinya form sedang mode "Tambah".
  // Kalau berisi angka id, form sedang mode "Edit" untuk baris itu.
  let idDiedit = null;
  // [BARU P5] Salinan data terakhir dari Supabase, dipakai saat tombol Edit diklik
  let dataTerakhir = [];

  // ---------- [SAMA P4] Sidebar: ganti tampilan (Daftar / Tambah) ----------
  function bukaTampilan(tampilan) {
    document.querySelectorAll(".view").forEach((view) => {
      view.hidden = view.id !== "view-" + tampilan;
    });
    document.querySelectorAll(".menu-item[data-view]").forEach((tombol) => {
      tombol.classList.toggle("aktif", tombol.dataset.view === tampilan);
    });
    if (tampilan === "daftar") {
      judulHalaman.textContent = "Daftar UMKM";
    } else {
      judulHalaman.textContent = idDiedit ? "Edit UMKM" : "Tambah UMKM";
    }
    tutupSidebar();
  }

  // Klik menu "Tambah UMKM" selalu membuka form kosong (mode Tambah)
  document.querySelectorAll(".menu-item[data-view]").forEach((tombol) => {
    tombol.addEventListener("click", () => {
      if (tombol.dataset.view === "tambah") selesaiEdit();
      bukaTampilan(tombol.dataset.view);
    });
  });

  // ---------- [SAMA P4] Sidebar di layar HP: buka / tutup ----------
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

  // ---------- [UBAH P5] Logout ----------
  // Dulu menghapus username. Sekarang signOut() menghapus sesi di Supabase.
  document
    .querySelector("#tombol-logout")
    .addEventListener("click", async () => {
      await supabaseClient.auth.signOut();
      location.replace("index.html");
    });

  // ---------- [SAMA P4] Toast: pesan singkat yang hilang sendiri ----------
  let waktuToast;
  function tampilToast(pesan) {
    toast.textContent = pesan;
    toast.classList.add("tampil");
    clearTimeout(waktuToast);
    waktuToast = setTimeout(() => toast.classList.remove("tampil"), 3500);
  }

  // ---------- Read: ringkasan + tabel daftar UMKM ----------
  function renderStatistik(data) {
    const hitung = (kategori) =>
      data.filter((umkm) => umkm.kategori === kategori).length;
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

  // [BARU P5] Tombol Edit/Hapus hanya untuk baris milik user yang login.
  // Baris lain (termasuk data bawaan sistem) diberi tanda strip.
  function htmlAksi(umkm) {
    if (umkm.user_id !== user.id) {
      return `<span class="aksi-kosong" title="Bukan datamu">—</span>`;
    }
    const id = escapeHtml(umkm.id);
    return `
      <button type="button" class="tombol-kecil" data-aksi="edit" data-id="${id}">Edit</button>
      <button type="button" class="tombol-kecil tombol-bahaya" data-aksi="hapus" data-id="${id}">Hapus</button>`;
  }

  async function muatTabel() {
    if (!konfigurasiSiap()) {
      tubuhTabel.innerHTML = `<tr><td colspan="8" class="galat">Isi SUPABASE_URL dan SUPABASE_KEY dulu di js/common.js.</td></tr>`;
      return;
    }

    tubuhTabel.innerHTML = `<tr><td colspan="8">Memuat data...</td></tr>`;

    const { data, error } = await supabaseClient
      .from("umkm")
      .select("*")
      .order("id", { ascending: true });

    if (error) {
      console.error("Gagal mengambil data:", error);
      tubuhTabel.innerHTML = `<tr><td colspan="8" class="galat">Gagal mengambil data. Buka Console (F12).</td></tr>`;
      return;
    }

    dataTerakhir = data;
    renderStatistik(data);
    jumlahUmkm.textContent = data.length + " usaha";
    tubuhTabel.innerHTML = data
      .map(
        (umkm, urutan) => `
        <tr>
          <td class="nomor">${urutan + 1}</td>
          <td><img class="foto-kecil" src="${escapeHtml(umkm.foto)}" alt="" loading="lazy" /></td>
          <td><strong>${escapeHtml(umkm.nama)}</strong><small>${escapeHtml(umkm.alamat)}</small></td>
          <td><span class="pil">${escapeHtml(umkm.kategori)}</span></td>
          <td>${escapeHtml(umkm.jam)}</td>
          <td>${escapeHtml(umkm.wa)}</td>
          <td>${escapeHtml(umkm.dibuat_oleh)}</td>
          <td class="aksi">${htmlAksi(umkm)}</td>
        </tr>`,
      )
      .join("");
  }

  // ---------- Form: pesan status + mode Tambah / Edit ----------
  function tampilStatus(pesan, jenis) {
    statusForm.textContent = pesan;
    statusForm.className = "status status-" + jenis; // "ok" atau "galat"
  }

  // [UBAH P5] Mengembalikan form ke mode Tambah (kosong)
  function selesaiEdit() {
    idDiedit = null;
    formUmkm.reset();
    statusForm.textContent = "";
    statusForm.className = "status";
    judulForm.textContent = "Tambah UMKM baru";
    tombolSimpan.textContent = "Simpan";
  }

  // [BARU P5] Mengisi form dengan data baris yang mau diedit
  function mulaiEdit(id) {
    const umkm = dataTerakhir.find((item) => String(item.id) === String(id));
    if (!umkm) return;

    idDiedit = umkm.id;
    document.querySelector("#nama").value = umkm.nama;
    document.querySelector("#kategori").value = umkm.kategori;
    document.querySelector("#alamat").value = umkm.alamat;
    document.querySelector("#jam").value = umkm.jam;
    document.querySelector("#wa").value = umkm.wa;
    document.querySelector("#foto").value =
      umkm.foto === FOTO_DEFAULT ? "" : umkm.foto;

    judulForm.textContent = "Edit UMKM";
    tombolSimpan.textContent = "Simpan perubahan";
    statusForm.textContent = "";
    statusForm.className = "status";
    bukaTampilan("tambah");
  }

  // [BARU P5] Delete: konfirmasi dulu, baru hapus HANYA baris dengan id itu
  async function hapusUmkm(id) {
    const umkm = dataTerakhir.find((item) => String(item.id) === String(id));
    if (!umkm) return;
    if (
      !confirm(
        `Hapus "${umkm.nama}"? Data yang dihapus tidak bisa dikembalikan.`,
      )
    )
      return;

    // .eq("id", id) WAJIB. Tanpa filter ini, yang terhapus bisa seluruh tabel.
    // .select() di belakang membuat Supabase mengembalikan baris yang benar-benar terhapus.
    const { data, error } = await supabaseClient
      .from("umkm")
      .delete()
      .eq("id", id)
      .select();

    if (error) {
      console.error("Gagal menghapus:", error);
      tampilToast("Gagal menghapus. Buka Console (F12).");
      return;
    }

    // RLS yang menolak TIDAK menghasilkan error, cuma 0 baris yang terhapus.
    if (data.length === 0) {
      tampilToast("Tidak ada data yang terhapus. Kamu bukan pemilik data ini.");
      return;
    }

    tampilToast("UMKM berhasil dihapus.");
    await muatTabel();
  }

  // [BARU P5] Satu pendengar untuk semua tombol Edit/Hapus di tabel.
  // Tabel digambar ulang tiap data dimuat, jadi pendengar dipasang di <tbody>
  // (induknya), bukan di tiap tombol. Cara ini disebut event delegation.
  tubuhTabel.addEventListener("click", (event) => {
    const tombol = event.target.closest("button[data-aksi]");
    if (!tombol) return;

    if (tombol.dataset.aksi === "edit") mulaiEdit(tombol.dataset.id);
    if (tombol.dataset.aksi === "hapus") hapusUmkm(tombol.dataset.id);
  });

  document.querySelector("#tombol-batal").addEventListener("click", () => {
    selesaiEdit();
    bukaTampilan("daftar");
  });

  // ---------- Create (tambah) dan Update (edit) ----------
  formUmkm.addEventListener("submit", async (event) => {
    event.preventDefault();

    // [UBAH P5] Cek sesi lagi sebelum menulis data, jaga-jaga sesi sudah habis
    const sesi = await ambilSesi();
    if (!sesi) {
      location.replace("login.html");
      return;
    }

    if (!konfigurasiSiap()) {
      tampilStatus(
        "Isi SUPABASE_URL dan SUPABASE_KEY dulu di js/common.js.",
        "galat",
      );
      return;
    }

    const isian = {
      nama: document.querySelector("#nama").value.trim(),
      kategori: document.querySelector("#kategori").value,
      alamat: document.querySelector("#alamat").value.trim(),
      jam: document.querySelector("#jam").value.trim(),
      wa: document.querySelector("#wa").value.trim(),
      foto: document.querySelector("#foto").value.trim() || FOTO_DEFAULT,
    };

    if (
      isian.nama === "" ||
      isian.alamat === "" ||
      isian.jam === "" ||
      isian.wa === ""
    ) {
      tampilStatus("Nama, alamat, jam, dan WA wajib diisi.", "galat");
      return;
    }

    if (idDiedit === null) {
      // ----- Create: insert() menerima array of object -----
      // [UBAH P5] user_id diisi id user yang login (dicek RLS), dibuat_oleh diisi nama
      const { error } = await supabaseClient
        .from("umkm")
        .insert([
          { ...isian, user_id: user.id, dibuat_oleh: namaTampil(user) },
        ]);

      if (error) {
        console.error("Gagal menyimpan data:", error);
        tampilStatus(
          "Gagal menyimpan. Buka Console (F12) untuk detailnya.",
          "galat",
        );
        return;
      }
      tampilToast("UMKM berhasil ditambahkan!");
    } else {
      // ----- [BARU P5] Update: ubah HANYA baris dengan id yang sedang diedit -----
      const { data, error } = await supabaseClient
        .from("umkm")
        .update(isian)
        .eq("id", idDiedit)
        .select();

      if (error) {
        console.error("Gagal mengubah data:", error);
        tampilStatus(
          "Gagal mengubah. Buka Console (F12) untuk detailnya.",
          "galat",
        );
        return;
      }

      // RLS yang menolak tidak menghasilkan error, cuma 0 baris yang berubah.
      if (data.length === 0) {
        tampilStatus(
          "Tidak ada data yang berubah. Kamu bukan pemilik data ini.",
          "galat",
        );
        return;
      }
      tampilToast("Perubahan berhasil disimpan.");
    }

    selesaiEdit();
    bukaTampilan("daftar"); // kembali ke daftar supaya hasilnya langsung kelihatan
    await muatTabel(); // muat ulang tabel + ringkasan
  });

  muatTabel();
}
