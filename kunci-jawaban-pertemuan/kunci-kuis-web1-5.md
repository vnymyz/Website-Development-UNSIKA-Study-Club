# Kunci Kuis Web 1–5

> Jawaban dapat memiliki variasi kalimat. Pahami logikanya, jangan hanya menyamakan teks.

## Kuis 1

1. Client seperti pembeli yang memesan, server seperti penjual yang menyiapkan dan mengirim.
2. HTML = struktur/isi, CSS = tampilan, JavaScript = interaksi.
3. Tag yang namanya menjelaskan fungsi bagian tersebut, contoh: `<header>`, `<section>`.
4. Menampilkan deskripsi teks jika gambar gagal dimuat, dan membantu aksesibilitas.
5. Halaman meloncat (scroll) ke elemen dengan `id="kontak"`.
6. `<!DOCTYPE html><html><head><title>Latihan Pertemuan 1</title></head><body></body></html>`.
7. `<header><h1>Toko Online Sederhana</h1><nav><a href="#">Beranda</a><a href="#">Produk</a></nav></header>`.
8. Tiga `<article>` masing-masing berisi `<h3>` nama dan `<p>` harga.
9. `<form><input type="text" name="nama"><button type="submit">Kirim</button></form>`.
10. `<footer><p>&copy; 2026 Toko Online Sederhana</p></footer>`.

## Kuis 2

1. Inline, internal, eksternal; eksternal paling disarankan karena rapi dan bisa dipakai ulang.
2. Content → padding → border → margin.
3. Elemen anak pindah ke baris baru jika tempat tidak cukup.
4. Aturan CSS yang aktif hanya pada kondisi lebar layar tertentu; dipakai untuk membuat tampilan responsif.
5. `commit` menyimpan perubahan secara lokal; `push` mengirim commit itu ke remote (GitHub).
6. `.kartu { padding: 16px; border-radius: 8px; }`.
7. `.daftar-produk { display: flex; gap: 12px; }`.
8. `@media (max-width: 600px) { .daftar-produk { flex-direction: column; } }`.
9. `<div class="p-4 bg-white shadow">...</div>`.
10. `git init`, `git add .`, `git commit -m "Commit pertama"`.

## Kuis 3

1. `let` bisa diubah nilainya, `const` tidak.
2. Array untuk data berurutan sejenis; object untuk data dengan key bernama.
3. DOM adalah representasi struktur halaman yang bisa diubah JavaScript; `querySelector` mencari elemen sesuai selector CSS.
4. Mencegah perilaku default form (reload halaman) saat disubmit.
5. `20`.
6. `function formatRupiah(angka) { return "Rp " + angka; }`.
7. `const produk = [{ nama: "Kaos Polos", harga: 75000 }, ...]; console.log(produk[0].nama);`.
8. `for (let i = 1; i <= 5; i++) { console.log(i); }`.
9. `document.querySelector("#judul").textContent = "Selamat Datang";`.
10. `document.querySelector("#tombol-cek").addEventListener("click", () => alert("Tombol ditekan"));`.

## Kuis 4

1. Data hilang saat refresh dan tidak dibagikan ke pengguna lain.
2. Kolom unik yang membedakan tiap baris; tanpa itu data sulit dibedakan/diacu.
3. `anon key` aman dipakai di frontend dengan akses terbatas; `service_role key` akses penuh, tidak boleh dipakai di frontend.
4. Menunggu proses asynchronous (misalnya query ke Supabase) selesai sebelum lanjut ke baris berikutnya.
5. Supaya kita bisa membedakan hasil berhasil (`data`) dan gagal (`error`) secara eksplisit.
6. `const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);`.
7. `await supabaseClient.from("produk").select("*").order("id", { ascending: true });`.
8. `await supabaseClient.from("produk").insert([{ nama: "Kaos", harga: 75000 }]);`.
9. `if (error) { console.error(error); }`.
10. Buka tabel di Table Editor → tab Policies → New Policy → pilih template "Enable read access for all users" → simpan.

## Kuis 5

1. Tanpa `.eq()`, operasi update/delete berpotensi mengenai semua baris di tabel, bukan hanya satu.
2. Contoh: kolom `jurusan_id` di tabel mahasiswa merujuk ke `id` pada tabel jurusan.
3. Autentikasi memastikan siapa penggunanya; otorisasi memastikan apa yang boleh dilakukannya.
4. Tanda bahwa user sedang login; dipakai supaya user tidak perlu login ulang di setiap aksi.
5. Supaya publik tetap bisa melihat katalog tanpa login, tapi hanya user yang login yang boleh mengubah data.
6. `await supabaseClient.from("produk").update({ nama: "Kaos Polos V2" }).eq("id", 1);`.
7. `await supabaseClient.from("produk").delete().eq("id", 3);`.
8. `await supabaseClient.from("produk").select("*, kategori(nama)");`.
9. `await supabaseClient.auth.signUp({ email, password });`.
10. `const { data } = await supabaseClient.auth.getSession(); if (data.session) console.log(data.session.user.email);`.
