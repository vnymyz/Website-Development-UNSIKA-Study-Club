# Kunci Latihan Web 1–6

> Jawaban dapat memiliki variasi. Pahami logikanya, jangan hanya menyamakan teks kode.

## Latihan 1

```html
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>Latihan Pertemuan 1</title>
</head>
<body>
  <header>
    <h1>Toko Online Sederhana</h1>
    <nav>
      <a href="#beranda">Beranda</a>
      <a href="#produk">Produk</a>
    </nav>
  </header>

  <section id="produk">
    <article>
      <h3>Kaos Polos</h3>
      <p>Rp 75.000</p>
    </article>
    <article>
      <h3>Celana Jeans</h3>
      <p>Rp 150.000</p>
    </article>
    <article>
      <h3>Topi Baseball</h3>
      <p>Rp 50.000</p>
    </article>
  </section>

  <form>
    <input type="text" name="nama" placeholder="Nama kamu">
    <button type="submit">Kirim</button>
  </form>

  <footer>
    <p>&copy; 2026 Toko Online Sederhana</p>
  </footer>
</body>
</html>
```

Tag semantik (`header`, `section`, `article`, `footer`) memudahkan pembaca kode memahami struktur halaman tanpa perlu membaca isinya secara detail.

## Latihan 2

```css
.kartu {
  padding: 16px;
  border-radius: 8px;
}

.daftar-produk {
  display: flex;
  gap: 12px;
}

@media (max-width: 600px) {
  .daftar-produk {
    flex-direction: column;
  }
}
```

```html
<div class="p-4 bg-white shadow">Kartu produk</div>
```

```bash
git init
git add .
git commit -m "Commit pertama"
```

Flexbox `row` (default) cocok untuk layar lebar; media query mengubahnya jadi `column` di layar sempit supaya tetap enak dibaca di HP.

## Latihan 3

```javascript
function formatRupiah(angka) {
  return "Rp " + angka.toLocaleString("id-ID");
}

const produk = [
  { nama: "Kaos Polos", harga: 75000 },
  { nama: "Celana Jeans", harga: 150000 }
];
console.log(produk[0].nama); // "Kaos Polos"

for (let i = 1; i <= 5; i++) {
  console.log(i);
}

document.querySelector("#judul").textContent = "Selamat Datang";

document.querySelector("#tombol-cek").addEventListener("click", function () {
  alert("Tombol ditekan");
});
```

`querySelector` mengembalikan elemen pertama yang cocok; kalau `id` di HTML dan JavaScript tidak sama persis, hasilnya `null` dan baris berikutnya akan error.

## Latihan 4

```javascript
const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

const { data, error } = await supabaseClient
  .from("produk")
  .select("*")
  .order("id", { ascending: true });

const { error: errorInsert } = await supabaseClient
  .from("produk")
  .insert([{ nama: "Kaos Polos", harga: 75000 }]);

if (error) {
  console.error("Gagal mengambil data:", error);
}
```

Langkah policy: buka tabel di Table Editor → tab Policies → **New Policy** → pilih template "Enable read access for all users" → simpan. Policy ini wajib ada, kalau tidak, `select()` akan mengembalikan array kosong meski data sebenarnya ada di tabel.

## Latihan 5

```javascript
await supabaseClient.from("produk").update({ nama: "Kaos Polos V2" }).eq("id", 1);

await supabaseClient.from("produk").delete().eq("id", 3);

const { data } = await supabaseClient.from("produk").select("*, kategori(nama)");

await supabaseClient.auth.signUp({
  email: "budi@example.com",
  password: "password123"
});

const { data: sesiData } = await supabaseClient.auth.getSession();
if (sesiData.session) {
  console.log(sesiData.session.user.email);
}
```

`.eq("id", 1)` pada `update()`/`delete()` wajib ditulis agar operasi hanya mengenai satu baris yang dituju, bukan seluruh tabel.

## Latihan 6

```bash
git add .
git commit -m "Update fitur pencarian"
git push
```

```markdown
# Katalog Produk Sederhana

Aplikasi web untuk menampilkan dan mengelola data produk.

## Fitur
- Menampilkan daftar produk
- Tambah, ubah, hapus produk

## Tech Stack
- HTML, CSS, Tailwind CSS, JavaScript, Supabase, Vercel

## Cara Menjalankan Secara Lokal
1. Clone repository ini
2. Buka folder di VS Code
3. Klik kanan `index.html`, pilih "Open with Live Server"
```

Langkah hubungkan GitHub ke Vercel:

```text
1. Login ke Vercel dengan akun GitHub
2. Klik Add New > Project
3. Pilih repository yang sesuai
4. Klik Import lalu Deploy
```

Langkah debugging data tidak muncul di URL Vercel:

```text
1. Buka Console di URL Vercel, cek pesan error
2. Cek pengaturan Site URL / Redirect URL di Supabase Authentication
3. Pastikan SUPABASE_URL dan anon key di kode yang ter-deploy sudah benar
```
