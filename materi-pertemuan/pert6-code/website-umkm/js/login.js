// ======================================================
// login.js — halaman login dan daftar
// Login dan daftar memakai Supabase Auth (email + password). Butuh common.js.
// ======================================================

const formLogin = document.querySelector("#form-login");
const inputEmail = document.querySelector("#email");
const inputPassword = document.querySelector("#password");
const tombolDaftar = document.querySelector("#tombol-daftar");
const pesanLogin = document.querySelector("#pesan-login");

// Sudah login? Langsung ke dashboard, tidak perlu isi lagi.
ambilSesi().then((sesi) => {
  if (sesi) location.replace("dashboard.html");
});

function tampilPesan(teks, jenis) {
  pesanLogin.textContent = teks;
  pesanLogin.className = "status status-" + jenis; // "ok" atau "galat"
}

// Pesan dari Supabase berbahasa Inggris, yang umum kita terjemahkan.
function pesanRamah(error) {
  const teks = error.message || "";
  if (teks.includes("Invalid login credentials")) return "Email atau password salah.";
  if (teks.includes("Email not confirmed")) return "Email belum dikonfirmasi. Cek inbox emailmu.";
  if (teks.includes("already registered")) return "Email ini sudah terdaftar. Klik Masuk.";
  if (teks.includes("Password should be")) return "Password terlalu pendek (minimal 6 karakter).";
  return "Gagal: " + teks;
}

// Mengambil isian form. Mengembalikan null kalau belum lengkap.
function ambilIsian() {
  const email = inputEmail.value.trim();
  const password = inputPassword.value;

  if (email === "" || password === "") {
    tampilPesan("Email dan password wajib diisi.", "galat");
    return null;
  }
  if (!konfigurasiSiap()) {
    tampilPesan("Isi SUPABASE_URL dan SUPABASE_KEY dulu di js/common.js.", "galat");
    return null;
  }
  return { email, password };
}

// ---------- Masuk ----------
formLogin.addEventListener("submit", async (event) => {
  event.preventDefault();

  const isian = ambilIsian();
  if (!isian) return;

  tampilPesan("Memproses...", "ok");
  const { error } = await supabaseClient.auth.signInWithPassword(isian);

  if (error) {
    tampilPesan(pesanRamah(error), "galat");
    return;
  }
  location.href = "dashboard.html";
});

// ---------- Daftar ----------
tombolDaftar.addEventListener("click", async () => {
  const isian = ambilIsian();
  if (!isian) return;

  tampilPesan("Memproses...", "ok");
  const { data, error } = await supabaseClient.auth.signUp(isian);

  if (error) {
    tampilPesan(pesanRamah(error), "galat");
    return;
  }

  // Kalau "Confirm email" dimatikan di Supabase, sesi langsung ada.
  // Kalau masih aktif, user harus mengklik link di emailnya dulu.
  if (data.session) {
    location.href = "dashboard.html";
  } else {
    tampilPesan("Pendaftaran berhasil. Cek emailmu untuk konfirmasi, lalu klik Masuk.", "ok");
  }
});
