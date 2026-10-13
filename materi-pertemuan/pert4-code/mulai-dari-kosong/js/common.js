// ======================================================
// common.js — dipakai semua halaman (file BARU di pertemuan 4)
// Isinya: koneksi Supabase, login username, dan navbar.
// ======================================================

// ---------- [BARU P4] 1. Koneksi Supabase ----------
// GANTI dua nilai ini dengan milik project Supabase kamu sendiri.
const SUPABASE_URL = "https://iaivokyozwnyfwnceepm.supabase.co";
const SUPABASE_KEY = "sb_publishable_xQstWDBGfMTC9UrjuHqpUQ_idBLgoHn";

// Library Supabase (dari CDN di HTML) menyediakan window.supabase
const { createClient } = window.supabase;
const supabaseClient = createClient(SUPABASE_URL, SUPABASE_KEY);

// [BARU P4] true kalau URL dan key sudah diganti (bukan nilai contoh di atas)
function konfigurasiSiap() {
  return (
    !SUPABASE_URL.includes("xxxxxxxxxxxx") && !SUPABASE_KEY.includes("ISI_KEY")
  );
}

// ---------- [BARU P4] 2. Pengaman teks ----------
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

// ---------- [BARU P4] 3. Login username ----------
// Username disimpan di localStorage (memori browser, tetap ada setelah refresh).
// Ini BUKAN keamanan sungguhan — cuma penanda "sudah login" untuk belajar.
const KUNCI_USERNAME = "usernameUmkm";

function ambilUsername() {
  return localStorage.getItem(KUNCI_USERNAME);
}

function simpanUsername(nama) {
  localStorage.setItem(KUNCI_USERNAME, nama);
}

function hapusUsername() {
  localStorage.removeItem(KUNCI_USERNAME);
}

// ---------- [BARU P4] 4. Navbar ----------
// Belum login: tampil link "Login". Sudah login: tampil "Halo, username".
function renderNavbarAuth() {
  const tempat = document.querySelector("#auth-navbar");
  if (!tempat) return;

  const username = ambilUsername();
  tempat.innerHTML = username
    ? `<a href="dashboard.html">Halo, ${escapeHtml(username)}</a>`
    : `<a href="login.html">Login</a>`;
}

renderNavbarAuth();
