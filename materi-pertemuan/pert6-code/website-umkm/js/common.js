// ======================================================
// common.js — dipakai semua halaman
// Isinya: koneksi Supabase, sesi login (Supabase Auth), dan navbar.
// ======================================================

// ---------- 1. Koneksi Supabase ----------
// GANTI dua nilai ini dengan milik project Supabase kamu sendiri.
const SUPABASE_URL = "https://iaivokyozwnyfwnceepm.supabase.co";
const SUPABASE_KEY = "sb_publishable_xQstWDBGfMTC9UrjuHqpUQ_idBLgoHn";

// Library Supabase (dari CDN di HTML) menyediakan window.supabase
const { createClient } = window.supabase;
const supabaseClient = createClient(SUPABASE_URL, SUPABASE_KEY);

// true kalau URL dan key sudah diganti (bukan nilai contoh di atas)
function konfigurasiSiap() {
  return (
    !SUPABASE_URL.includes("xxxxxxxxxxxx") && !SUPABASE_KEY.includes("ISI_KEY")
  );
}

// ---------- 2. Pengaman teks ----------
// Mengubah karakter berbahaya (< > " ') jadi teks biasa, supaya data dari
// form tidak bisa menyisipkan kode HTML/JavaScript ke halaman.
function escapeHtml(teks) {
  return String(teks ?? "")
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#39;");
}

// Foto bawaan kalau pengguna tidak mengisi kolom foto
const FOTO_DEFAULT =
  "https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=400&q=60&auto=format&fit=crop";

// ---------- 3. Sesi login (Supabase Auth) ----------
// Mengembalikan sesi kalau sudah login, atau null kalau belum.
// Sesi disimpan Supabase di browser dan diperbarui otomatis.
async function ambilSesi() {
  const { data } = await supabaseClient.auth.getSession();
  return data.session;
}

// Nama yang ditampilkan: bagian email sebelum tanda @
function namaTampil(user) {
  return (user.email || "").split("@")[0];
}

// ---------- 4. Navbar ----------
// Membaca sesi Supabase: link Login kalau belum masuk, atau nama user kalau sudah.
async function renderNavbarAuth() {
  const tempat = document.querySelector("#auth-navbar");
  if (!tempat) return;

  const sesi = await ambilSesi();
  tempat.innerHTML = sesi
    ? `<a href="dashboard.html">Halo, ${escapeHtml(namaTampil(sesi.user))}</a>`
    : `<a href="login.html">Login</a>`;
}

renderNavbarAuth();
