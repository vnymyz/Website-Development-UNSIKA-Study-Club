// ======================================================
// login.js — halaman login (file BARU di pertemuan 4)
// Login cuma pakai username, tanpa password. Butuh common.js.
// ======================================================

// Sudah login? Langsung ke dashboard, tidak perlu isi lagi.
if (ambilUsername()) {
  location.replace("dashboard.html");
}

const formLogin = document.querySelector("#form-login");
const pesanLogin = document.querySelector("#pesan-login");

formLogin.addEventListener("submit", (event) => {
  event.preventDefault();

  const username = document.querySelector("#username").value.trim();

  if (username === "") {
    pesanLogin.textContent = "Username tidak boleh kosong.";
    return;
  }

  simpanUsername(username);
  location.href = "dashboard.html";
});
