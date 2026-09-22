# Panduan: Bangun `implementasi-umkm/` dari `pert2-code`

Dokumen ini lanjutan dari `fundamental-javascript/` — kalau 9 konsep dasarnya belum dicoba, kerjakan itu dulu. Di sini konsep yang sama (variabel, function, array of object, DOM, event) dipakai buat bikin direktori UMKM pertemuan 2 beneran interaktif: kartu dirender dari data, filter kategori + pencarian jalan, dan form kontak tervalidasi.

## Lokasi Folder & File

Semua yang dikerjakan di panduan ini ada di:

```text
Website-UNSIKA/
└── materi-pertemuan/
    ├── pert2-code/              <- sumber, TIDAK diubah, cuma disalin dari sini
    │   ├── index.html
    │   ├── style.css
    │   └── getout.mp3
    └── pert3-code/
        ├── fundamental-javascript/   <- folder lain, konsep dasar JS (kerjakan duluan)
        └── implementasi-umkm/        <- folder yang dibangun di panduan ini
            ├── index.html    <- disalin dari pert2-code, lalu diubah di Langkah 2
            ├── style.css     <- disalin dari pert2-code, lalu ditambah sedikit di Langkah 4
            ├── app.js        <- file BARU, kosong di awal, diisi Langkah 3–7
            └── getout.mp3    <- disalin apa adanya, tidak diubah
```

**Cara pakai:** buat folder kosong `materi-pertemuan/pert3-code/implementasi-umkm/` (sejajar dengan `fundamental-javascript/`), lalu ikuti Langkah 1 sampai selesai di dalam folder itu. Tiap selesai satu langkah, buka `index.html` di folder itu pakai Live Server buat lihat hasilnya.

## Daftar Isi

1. [Titik Awal — Menyalin File Pertemuan 2 (Full Code)](#langkah-1--titik-awal--menyalin-file-pertemuan-2-full-code)
2. [Mengosongkan Kartu Manual & Menghubungkan `app.js` (Full Code)](#langkah-2--mengosongkan-kartu-manual--menghubungkan-appjs-full-code)
3. [Data UMKM sebagai Array of Object](#langkah-3--data-umkm-sebagai-array-of-object)
4. [Container & Function `renderUmkm()`](#langkah-4--container--function-renderumkm)
5. [Render Pertama Kali](#langkah-5--render-pertama-kali)
6. [Filter Kategori + Pencarian Nama (Digabung)](#langkah-6--filter-kategori--pencarian-nama-digabung)
7. [Validasi Form Kontak](#langkah-7--validasi-form-kontak)
8. [Selesai — Cek Ulang dan Verifikasi](#selesai--cek-ulang-dan-verifikasi)

---

## Langkah 1 — Titik Awal: Menyalin File Pertemuan 2 (Full Code)

Folder ini **tidak dimulai dari HTML kosong** — beda dengan `fundamental-javascript/`. Di sini kita lanjutin file yang sudah jadi di pertemuan 2, disalin apa adanya dulu, baru diubah di Langkah 2.

**Yang dilakukan:**
1. Buka `materi-pertemuan/pert2-code/`.
2. Salin 3 file berikut ke `materi-pertemuan/pert3-code/implementasi-umkm/` (folder baru, kalau belum ada, buat dulu):
   - `index.html`
   - `style.css`
   - `getout.mp3` (aset audio kecil yang dipakai di footer)

Isi persis `index.html` yang disalin (sama persis dengan `pert2-code/index.html`, kalau sudah dibangun sesuai `pert2-code/PANDUAN-LANDING-PAGE.md`):

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Katalog UMKM Karawang</title>

    <!-- Google Fonts: Plus Jakarta Sans, satu family buat judul (weight tebal) dan teks biasa (weight normal) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <!-- Font Awesome lewat CDN, dipakai buat ikon medsos di footer dan ikon telepon di kartu UMKM -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <!--
      HEADER
      "sticky" di style.css bikin header ini tetap kelihatan walau halaman
      discroll ke bawah. Ini salah satu contoh nyata `position: sticky`
      yang disebutkan sekilas di materi Position.
    -->
    <header>
      <!--
        header-inner pakai 3 kolom grid (kiri-tengah-kanan) supaya nav
        benar-benar di tengah header, bukan ikut menempel ke kanan
        seperti pola flexbox space-between biasa.
      -->
      <div class="header-inner">
        <span class="wordmark">UMKM Karawang</span>
        <nav>
          <a href="#daftar-umkm">UMKM</a>
          <a href="#tentang">Tentang</a>
          <a href="#kontak">Daftar</a>
        </nav>
        <span aria-hidden="true"></span>
      </div>
    </header>

    <main>
      <!--
        HERO
        Tiga foto ditumpuk sebagai latar (.hero-bg), masing-masing diberi
        animation-delay berbeda supaya bergantian muncul terus-menerus —
        murni CSS @keyframes, tidak ada JavaScript sama sekali. Di atasnya
        ada lapisan gelap transparan (.hero-overlay) supaya teks putih
        tetap kebaca di foto apa pun yang lagi tampil.
      -->
      <section class="hero">
        <div
          class="hero-bg"
          style="
            background-image: url(&quot;https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=1600&q=65&auto=format&fit=crop&quot;);
          "
        ></div>
        <div
          class="hero-bg hero-bg-2"
          style="
            background-image: url(&quot;https://images.unsplash.com/photo-1533900298318-6b8da08a523e?w=1600&q=65&auto=format&fit=crop&quot;);
          "
        ></div>
        <div
          class="hero-bg hero-bg-3"
          style="
            background-image: url(&quot;https://images.unsplash.com/photo-1519996529931-28324d5a630e?w=1600&q=65&auto=format&fit=crop&quot;);
          "
        ></div>
        <div class="hero-overlay" aria-hidden="true"></div>

        <div class="hero-inner">
          <h1>Usaha warga yang layak kamu temukan.</h1>
          <p>
            Direktori usaha kecil di Karawang — warung, kerajinan, dan busana
            yang dijalankan tetangga sendiri, bukan waralaba.
          </p>
          <div class="hero-cta">
            <a href="#daftar-umkm" class="btn-primary">Lihat direktori</a>
            <a href="#kontak" class="btn-ghost">Daftarkan usahamu</a>
          </div>
        </div>
      </section>

      <!--
        DIREKTORI
        Tiap UMKM ditulis sebagai <article> (bukan <div>) karena isinya
        memang "satu unit konten yang berdiri sendiri" — cocok dengan
        makna semantik <article>. class="reveal" dipakai script di bawah
        untuk animasi muncul saat discroll.

        Kotak pencarian, dropdown kategori, dan paginasi di bawah ini
        BARU TAMPILANNYA SAJA — belum benar-benar menyaring apa pun,
        karena logikanya (JavaScript) sengaja belum dibahas. Anggap ini
        "maket" tampilan dulu, fungsinya menyusul di materi selanjutnya.
      -->
      <section id="daftar-umkm" class="direktori reveal">
        <h2>Direktori</h2>

        <div class="direktori-toolbar">
          <input
            type="search"
            class="direktori-cari"
            placeholder="Cari nama UMKM..."
            aria-label="Cari UMKM"
          />
          <select class="direktori-kategori" aria-label="Filter kategori">
            <option>Semua kategori</option>
            <option>Kuliner</option>
            <option>Fashion</option>
            <option>Kerajinan</option>
          </select>
        </div>

        <div class="grid-umkm">
          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&q=60&auto=format&fit=crop"
                alt="Meja warung dengan aneka lauk siap saji"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Warung Bu Sari</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Merdeka No. 10, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 07.00 – 21.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0812-3456-7810</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1761515315375-1315503bb3ce?w=400&q=60&auto=format&fit=crop"
                alt="Kain batik bermotif tradisional"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Batik Karawang Asli</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Kertabumi No. 5, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 09.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0813-2345-6705</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1696574727184-a8cdb758d3bf?w=400&q=60&auto=format&fit=crop"
                alt="Keranjang anyaman bambu"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Anyaman Bambu Pak Jaya</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Tuparev No. 22, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0857-1234-9902</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&q=60&auto=format&fit=crop"
                alt="Secangkir kopi hitam di atas meja kayu"
                loading="lazy"
              />
              <span class="badge">Kuliner</span>
            </div>
            <div class="kartu-isi">
              <h3>Kopi Rawa Gede</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ahmad Yani No. 3, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 10.00 – 23.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0821-9988-2214</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1445205170230-053b83016050?w=400&q=60&auto=format&fit=crop"
                alt="Mesin jahit dan gulungan kain"
                loading="lazy"
              />
              <span class="badge">Fashion</span>
            </div>
            <div class="kartu-isi">
              <h3>Konveksi Sinar Tani</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Pangkal Perjuangan No. 18, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 17.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0838-4567-3321</p>
            </div>
          </article>

          <article class="kartu-umkm">
            <div class="kartu-foto">
              <img
                src="https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=400&q=60&auto=format&fit=crop"
                alt="Kumpulan gerabah tanah liat"
                loading="lazy"
              />
              <span class="badge">Kerajinan</span>
            </div>
            <div class="kartu-isi">
              <h3>Gerabah Cikampek</h3>
              <p class="alamat"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> <span>Jl. Ir. H. Juanda No. 45, Karawang</span></p>
              <p class="jam"><i class="fa-regular fa-clock" aria-hidden="true"></i> Buka 08.00 – 16.00</p>
              <p class="wa"><i class="fa-solid fa-phone" aria-hidden="true"></i> 0896-7712-0043</p>
            </div>
          </article>
        </div>

        <!-- Paginasi: tampilan saja, angka "aktif" ditandai lewat class, belum benar-benar berpindah halaman -->
        <nav class="pagination" aria-label="Navigasi halaman direktori">
          <a href="#daftar-umkm" aria-label="Halaman sebelumnya">‹</a>
          <a href="#daftar-umkm" class="aktif" aria-current="page">1</a>
          <a href="#daftar-umkm">2</a>
          <a href="#daftar-umkm">3</a>
          <a href="#daftar-umkm" aria-label="Halaman berikutnya">›</a>
        </nav>
      </section>

      <!-- TENTANG: disederhanakan, cuma judul + satu paragraf singkat + foto -->
      <section id="tentang" class="tentang reveal">
        <div class="tentang-teks">
          <h2>Tentang katalog ini</h2>
          <p>
            Dibuat supaya warga lebih mudah menemukan UMKM di sekitar
            Karawang — dan supaya pemilik usaha kecil punya satu tempat untuk
            dicari, tanpa harus bayar iklan. Pilih kategori di direktori,
            lalu hubungi langsung lewat WA atau form Kontak di bawah.
          </p>
        </div>
        <div class="tentang-gambar">
          <img
            src="https://images.unsplash.com/photo-1642473194881-c7425b3789f1?fm=jpg&amp;q=60&amp;w=800&amp;auto=format&amp;fit=crop"
            alt="Suasana pasar UMKM Karawang"
            loading="lazy"
          />
        </div>
      </section>

      <!--
        TESTIMONI
        Avatar cuma lingkaran berisi inisial nama (bukan foto orang
        sungguhan) — supaya tidak terkesan memakai identitas/wajah orang
        asli untuk testimoni yang sebetulnya contoh/dummy.
      -->
      <section class="testimoni reveal">
        <h2>Kata Warga</h2>
        <div class="testimoni-grid">
          <article class="testimoni-kartu">
            <p class="testimoni-teks">
              Pesan lewat WA gampang, makanannya masih anget pas sampai. Sejak
              tahu Warung Bu Sari dari sini, jadi langganan.
            </p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">R</span>
              <div>
                <p class="testimoni-nama">Rina</p>
                <p class="testimoni-lokasi">Warga Karawang Barat</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">
              Batiknya asli buatan tangan, bukan cetak. Harganya juga jujur
              dibanding beli di pasar yang suka dikira turis.
            </p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">D</span>
              <div>
                <p class="testimoni-nama">Dedi</p>
                <p class="testimoni-lokasi">Pelanggan Batik Karawang Asli</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">
              Enak karena tinggal cari kategori Kerajinan, langsung ketemu
              kontaknya. Gak perlu tanya-tanya ke tetangga dulu.
            </p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">S</span>
              <div>
                <p class="testimoni-nama">Sri</p>
                <p class="testimoni-lokasi">Warga Karawang Timur</p>
              </div>
            </div>
          </article>
        </div>
      </section>

      <!-- VIDEO: contoh tag <iframe> buat nanam video YouTube -->
      <section class="video-section reveal">
        <div class="video-copy">
          <div class="sub-label">Profil singkat</div>
          <h2>Lihat langsung kesehariannya</h2>
          <p>
            Video pendek ini merekam bagaimana salah satu UMKM di katalog ini
            beroperasi tiap hari — dari buka lapak sampai melayani pembeli
            pertama.
          </p>
        </div>
        <!--
          .video-frame di style.css pakai aspect-ratio: 16/9 supaya video
          selalu proporsional di layar berapa pun lebarnya, tanpa perlu
          angka width/height tetap seperti iframe biasa.
        -->
        <div class="video-frame">
          <iframe
            src="https://www.youtube.com/embed/IxX_QHay02M"
            title="Video profil UMKM"
            loading="lazy"
            allowfullscreen
          ></iframe>
        </div>
      </section>

      <!--
        LOKASI
        Peta Google Maps di sini pakai URL embed publik (bukan Maps
        JavaScript API), jadi tidak butuh API key sama sekali — cocok
        buat latihan karena bisa langsung ditiru tanpa daftar akun.
      -->
      <section id="lokasi" class="lokasi reveal">
        <div class="lokasi-peta">
          <iframe
            src="https://maps.google.com/maps?q=Karawang&t=&z=13&ie=UTF8&iwloc=&output=embed"
            title="Peta area Karawang"
            loading="lazy"
          ></iframe>
        </div>
        <div class="lokasi-daftar">
          <h2>Mau kerja sama atau daftarin UMKM-mu?</h2>
          <ul>
            <li><i class="fa-solid fa-envelope" aria-hidden="true"></i> halo@umkmkarawang.id</li>
            <li><i class="fa-regular fa-clock" aria-hidden="true"></i> Senin–Sabtu, jam 09.00–17.00</li>
          </ul>
          <div class="lokasi-sosial">
            <a
              href="https://wa.me/6281200001234"
              target="_blank"
              rel="noopener"
              aria-label="Chat WhatsApp UMKM Karawang"
              ><i class="fa-brands fa-whatsapp" aria-hidden="true"></i
            ></a>
            <a
              href="https://instagram.com/umkmkarawang"
              target="_blank"
              rel="noopener"
              aria-label="Instagram UMKM Karawang"
              ><i class="fa-brands fa-instagram" aria-hidden="true"></i
            ></a>
          </div>
        </div>
      </section>

      <!-- KONTAK: form pendaftaran UMKM baru -->
      <section id="kontak" class="kontak reveal">
        <div class="kontak-inner">
          <div class="kontak-copy">
            <h2>Punya usaha yang belum terdaftar?</h2>
            <p>
              Kirim nama dan pesan singkat, kami hubungi balik untuk proses
              pendaftarannya.
            </p>
          </div>
          <form>
            <label for="nama">Nama</label>
            <input type="text" id="nama" name="nama" placeholder="Nama kamu" />

            <label for="pesan">Pesan</label>
            <textarea
              id="pesan"
              name="pesan"
              placeholder="Ceritakan usahamu secara singkat..."
            ></textarea>

            <button type="submit">Kirim pesan</button>
          </form>
        </div>
      </section>
    </main>

    <footer>
      <div class="footer-inner">
        <p>&copy; 2026 Katalog UMKM Karawang</p>
        <div class="footer-sosial">
          <a href="#" aria-label="Instagram Katalog UMKM Karawang"
            ><i class="fa-brands fa-instagram" aria-hidden="true"></i
          ></a>
          <a href="#" aria-label="Facebook Katalog UMKM Karawang"
            ><i class="fa-brands fa-facebook" aria-hidden="true"></i
          ></a>
          <a href="#" aria-label="WhatsApp Katalog UMKM Karawang"
            ><i class="fa-brands fa-whatsapp" aria-hidden="true"></i
          ></a>
          <!-- Contoh tag <audio> — sengaja ditaruh kecil dan santai di sini, bukan di tengah konten -->
          <audio class="footer-audio" src="getout.mp3" controls></audio>
        </div>
      </div>
    </footer>

    <!-- Tombol "kembali ke atas": disembunyikan lewat CSS, dimunculkan lewat JS saat halaman sudah discroll cukup jauh -->
    <button id="ke-atas" class="ke-atas" aria-label="Kembali ke atas">
      <svg
        viewBox="0 0 24 24"
        width="20"
        height="20"
        fill="none"
        stroke="currentColor"
        stroke-width="2.5"
        stroke-linecap="round"
        stroke-linejoin="round"
      >
        <path d="M12 19V5"></path>
        <path d="M6 11l6-6 6 6"></path>
      </svg>
    </button>

    <script>
      // ---------- Navbar sembunyi saat scroll ke bawah ----------
      // Bandingkan posisi scroll sekarang dengan posisi sebelumnya:
      // kalau turun (scroll ke bawah) navbar disembunyikan, kalau naik
      // (scroll ke atas) navbar dimunculkan lagi.
      const headerEl = document.querySelector("header");
      let posisiScrollTerakhir = 0;
      window.addEventListener("scroll", () => {
        const posisiSekarang = window.scrollY;
        const scrollTurun = posisiSekarang > posisiScrollTerakhir;
        // Cuma disembunyikan kalau sudah scroll cukup jauh (80px), supaya
        // navbar tidak kedap-kedip saat baru sedikit digeser di paling atas.
        headerEl.classList.toggle(
          "sembunyi",
          scrollTurun && posisiSekarang > 80,
        );
        posisiScrollTerakhir = posisiSekarang;
      });

      // ---------- Tombol kembali ke atas ----------
      // Tombolnya cuma tampil kalau memang berguna: setelah discroll > 400px.
      const tombolKeAtas = document.getElementById("ke-atas");
      window.addEventListener("scroll", () => {
        tombolKeAtas.classList.toggle("tampil", window.scrollY > 400);
      });
      tombolKeAtas.addEventListener("click", () => {
        window.scrollTo({ top: 0, behavior: "smooth" });
      });

      // ---------- Reveal saat discroll ----------
      // IntersectionObserver mendeteksi kapan sebuah elemen masuk ke layar,
      // tanpa perlu menghitung posisi scroll secara manual.
      const revealObserver = new IntersectionObserver(
        (entries) => {
          entries.forEach((entry) => {
            if (entry.isIntersecting) {
              entry.target.classList.add("tampil");
              revealObserver.unobserve(entry.target); // cukup sekali, tidak diulang
            }
          });
        },
        { threshold: 0.12 },
      );
      document
        .querySelectorAll(".reveal")
        .forEach((el) => revealObserver.observe(el));
    </script>
  </body>
</html>
```

**Cek hasil:** buka `index.html` hasil salinan lewat Live Server — tampilannya harus identik 100% dengan `pert2-code/index.html` (direktori masih 6 kartu ditulis manual, dropdown kategori dan kotak cari belum ngapa-ngapain kalau dipakai). `style.css` disalin apa adanya juga, isinya sama persis dengan `pert2-code/style.css` — detail cara CSS itu sendiri dibangun dari nol sudah dijelaskan lengkap di `pert2-code/PANDUAN-LANDING-PAGE.md`, tidak diulang di sini karena tidak berubah sama sekali di langkah ini.

## Langkah 2 — Mengosongkan Kartu Manual & Menghubungkan `app.js` (Full Code)

Sekarang `index.html` di `implementasi-umkm/` (bukan yang di `pert2-code/`!) diubah supaya siap disambungkan ke JavaScript. Ada 3 perubahan dari versi Langkah 1:

1. Komentar HTML di atas toolbar Direktori diganti — sekarang beneran jalan, bukan "maket" tampilan lagi.
2. `<div class="grid-umkm">` yang tadinya berisi 6 `<article class="kartu-umkm">` ditulis manual, **dikosongkan** — jadi `<div class="grid-umkm"></div>`. Nanti diisi ulang oleh `app.js` di Langkah 5.
3. Tepat sebelum `</body>`, **setelah** `<script>` inline yang sudah ada (isinya navbar sembunyi, tombol kembali ke atas, reveal scroll — JANGAN dihapus), ditambahkan `<script src="app.js"></script>`.

Kenapa `app.js` dimuat *setelah* script inline yang lama, bukan sebelum atau menggantikannya? Supaya tidak ada konflik nama variabel (`headerEl`, `tombolKeAtas`, dst sudah dipakai di sana), dan supaya elemen-elemen yang dicari `app.js` (lewat `querySelector`) sudah pasti ada duluan di HTML sebelum dicari.

Buat juga file kosong `app.js` di folder yang sama (isinya diisi Langkah 3–7).

Isi lengkap `index.html` SETELAH 3 perubahan di atas — ini file utuh, tinggal copy-paste ganti seluruh isi `index.html` di `implementasi-umkm/`:

```html
<!doctype html>
<html lang="id">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Katalog UMKM Karawang</title>

    <!-- Google Fonts: Plus Jakarta Sans, satu family buat judul (weight tebal) dan teks biasa (weight normal) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <!-- Font Awesome lewat CDN, dipakai buat ikon medsos di footer dan ikon telepon di kartu UMKM -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <!--
      HEADER
      "sticky" di style.css bikin header ini tetap kelihatan walau halaman
      discroll ke bawah. Ini salah satu contoh nyata `position: sticky`
      yang disebutkan sekilas di materi Position.
    -->
    <header>
      <!--
        header-inner pakai 3 kolom grid (kiri-tengah-kanan) supaya nav
        benar-benar di tengah header, bukan ikut menempel ke kanan
        seperti pola flexbox space-between biasa.
      -->
      <div class="header-inner">
        <span class="wordmark">UMKM Karawang</span>
        <nav>
          <a href="#daftar-umkm">UMKM</a>
          <a href="#tentang">Tentang</a>
          <a href="#kontak">Daftar</a>
        </nav>
        <span aria-hidden="true"></span>
      </div>
    </header>

    <main>
      <!--
        HERO
        Tiga foto ditumpuk sebagai latar (.hero-bg), masing-masing diberi
        animation-delay berbeda supaya bergantian muncul terus-menerus —
        murni CSS @keyframes, tidak ada JavaScript sama sekali. Di atasnya
        ada lapisan gelap transparan (.hero-overlay) supaya teks putih
        tetap kebaca di foto apa pun yang lagi tampil.
      -->
      <section class="hero">
        <div
          class="hero-bg"
          style="
            background-image: url(&quot;https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=1600&q=65&auto=format&fit=crop&quot;);
          "
        ></div>
        <div
          class="hero-bg hero-bg-2"
          style="
            background-image: url(&quot;https://images.unsplash.com/photo-1533900298318-6b8da08a523e?w=1600&q=65&auto=format&fit=crop&quot;);
          "
        ></div>
        <div
          class="hero-bg hero-bg-3"
          style="
            background-image: url(&quot;https://images.unsplash.com/photo-1519996529931-28324d5a630e?w=1600&q=65&auto=format&fit=crop&quot;);
          "
        ></div>
        <div class="hero-overlay" aria-hidden="true"></div>

        <div class="hero-inner">
          <h1>Usaha warga yang layak kamu temukan.</h1>
          <p>
            Direktori usaha kecil di Karawang — warung, kerajinan, dan busana
            yang dijalankan tetangga sendiri, bukan waralaba.
          </p>
          <div class="hero-cta">
            <a href="#daftar-umkm" class="btn-primary">Lihat direktori</a>
            <a href="#kontak" class="btn-ghost">Daftarkan usahamu</a>
          </div>
        </div>
      </section>

      <!--
        DIREKTORI
        Tiap UMKM ditulis sebagai <article> (bukan <div>) karena isinya
        memang "satu unit konten yang berdiri sendiri" — cocok dengan
        makna semantik <article>. class="reveal" dipakai script di bawah
        untuk animasi muncul saat discroll.

        Kotak pencarian, dropdown kategori, dan kartu UMKM di bawah ini
        SEKARANG BENERAN JALAN lewat app.js — ketik di kotak cari atau
        ganti dropdown kategori, kartu di .grid-umkm ikut ke-filter.
        .grid-umkm sengaja dikosongkan di HTML, isinya dirender app.js
        dari array `daftarUmkm` (lihat app.js).
      -->
      <section id="daftar-umkm" class="direktori reveal">
        <h2>Direktori</h2>

        <div class="direktori-toolbar">
          <input
            type="search"
            class="direktori-cari"
            placeholder="Cari nama UMKM..."
            aria-label="Cari UMKM"
          />
          <select class="direktori-kategori" aria-label="Filter kategori">
            <option>Semua kategori</option>
            <option>Kuliner</option>
            <option>Fashion</option>
            <option>Kerajinan</option>
          </select>
        </div>

        <div class="grid-umkm"></div>

        <!-- Paginasi: tampilan saja, angka "aktif" ditandai lewat class, belum benar-benar berpindah halaman -->
        <nav class="pagination" aria-label="Navigasi halaman direktori">
          <a href="#daftar-umkm" aria-label="Halaman sebelumnya">‹</a>
          <a href="#daftar-umkm" class="aktif" aria-current="page">1</a>
          <a href="#daftar-umkm">2</a>
          <a href="#daftar-umkm">3</a>
          <a href="#daftar-umkm" aria-label="Halaman berikutnya">›</a>
        </nav>
      </section>

      <!-- TENTANG: disederhanakan, cuma judul + satu paragraf singkat + foto -->
      <section id="tentang" class="tentang reveal">
        <div class="tentang-teks">
          <h2>Tentang katalog ini</h2>
          <p>
            Dibuat supaya warga lebih mudah menemukan UMKM di sekitar
            Karawang — dan supaya pemilik usaha kecil punya satu tempat untuk
            dicari, tanpa harus bayar iklan. Pilih kategori di direktori,
            lalu hubungi langsung lewat WA atau form Kontak di bawah.
          </p>
        </div>
        <div class="tentang-gambar">
          <img
            src="https://images.unsplash.com/photo-1642473194881-c7425b3789f1?fm=jpg&amp;q=60&amp;w=800&amp;auto=format&amp;fit=crop"
            alt="Suasana pasar UMKM Karawang"
            loading="lazy"
          />
        </div>
      </section>

      <!--
        TESTIMONI
        Avatar cuma lingkaran berisi inisial nama (bukan foto orang
        sungguhan) — supaya tidak terkesan memakai identitas/wajah orang
        asli untuk testimoni yang sebetulnya contoh/dummy.
      -->
      <section class="testimoni reveal">
        <h2>Kata Warga</h2>
        <div class="testimoni-grid">
          <article class="testimoni-kartu">
            <p class="testimoni-teks">
              Pesan lewat WA gampang, makanannya masih anget pas sampai. Sejak
              tahu Warung Bu Sari dari sini, jadi langganan.
            </p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">R</span>
              <div>
                <p class="testimoni-nama">Rina</p>
                <p class="testimoni-lokasi">Warga Karawang Barat</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">
              Batiknya asli buatan tangan, bukan cetak. Harganya juga jujur
              dibanding beli di pasar yang suka dikira turis.
            </p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">D</span>
              <div>
                <p class="testimoni-nama">Dedi</p>
                <p class="testimoni-lokasi">Pelanggan Batik Karawang Asli</p>
              </div>
            </div>
          </article>

          <article class="testimoni-kartu">
            <p class="testimoni-teks">
              Enak karena tinggal cari kategori Kerajinan, langsung ketemu
              kontaknya. Gak perlu tanya-tanya ke tetangga dulu.
            </p>
            <div class="testimoni-orang">
              <span class="testimoni-avatar">S</span>
              <div>
                <p class="testimoni-nama">Sri</p>
                <p class="testimoni-lokasi">Warga Karawang Timur</p>
              </div>
            </div>
          </article>
        </div>
      </section>

      <!-- VIDEO: contoh tag <iframe> buat nanam video YouTube -->
      <section class="video-section reveal">
        <div class="video-copy">
          <div class="sub-label">Profil singkat</div>
          <h2>Lihat langsung kesehariannya</h2>
          <p>
            Video pendek ini merekam bagaimana salah satu UMKM di katalog ini
            beroperasi tiap hari — dari buka lapak sampai melayani pembeli
            pertama.
          </p>
        </div>
        <!--
          .video-frame di style.css pakai aspect-ratio: 16/9 supaya video
          selalu proporsional di layar berapa pun lebarnya, tanpa perlu
          angka width/height tetap seperti iframe biasa.
        -->
        <div class="video-frame">
          <iframe
            src="https://www.youtube.com/embed/IxX_QHay02M"
            title="Video profil UMKM"
            loading="lazy"
            allowfullscreen
          ></iframe>
        </div>
      </section>

      <!--
        LOKASI
        Peta Google Maps di sini pakai URL embed publik (bukan Maps
        JavaScript API), jadi tidak butuh API key sama sekali — cocok
        buat latihan karena bisa langsung ditiru tanpa daftar akun.
      -->
      <section id="lokasi" class="lokasi reveal">
        <div class="lokasi-peta">
          <iframe
            src="https://maps.google.com/maps?q=Karawang&t=&z=13&ie=UTF8&iwloc=&output=embed"
            title="Peta area Karawang"
            loading="lazy"
          ></iframe>
        </div>
        <div class="lokasi-daftar">
          <h2>Mau kerja sama atau daftarin UMKM-mu?</h2>
          <ul>
            <li><i class="fa-solid fa-envelope" aria-hidden="true"></i> halo@umkmkarawang.id</li>
            <li><i class="fa-regular fa-clock" aria-hidden="true"></i> Senin–Sabtu, jam 09.00–17.00</li>
          </ul>
          <div class="lokasi-sosial">
            <a
              href="https://wa.me/6281200001234"
              target="_blank"
              rel="noopener"
              aria-label="Chat WhatsApp UMKM Karawang"
              ><i class="fa-brands fa-whatsapp" aria-hidden="true"></i
            ></a>
            <a
              href="https://instagram.com/umkmkarawang"
              target="_blank"
              rel="noopener"
              aria-label="Instagram UMKM Karawang"
              ><i class="fa-brands fa-instagram" aria-hidden="true"></i
            ></a>
          </div>
        </div>
      </section>

      <!-- KONTAK: form pendaftaran UMKM baru -->
      <section id="kontak" class="kontak reveal">
        <div class="kontak-inner">
          <div class="kontak-copy">
            <h2>Punya usaha yang belum terdaftar?</h2>
            <p>
              Kirim nama dan pesan singkat, kami hubungi balik untuk proses
              pendaftarannya.
            </p>
          </div>
          <form>
            <label for="nama">Nama</label>
            <input type="text" id="nama" name="nama" placeholder="Nama kamu" />

            <label for="pesan">Pesan</label>
            <textarea
              id="pesan"
              name="pesan"
              placeholder="Ceritakan usahamu secara singkat..."
            ></textarea>

            <button type="submit">Kirim pesan</button>
          </form>
        </div>
      </section>
    </main>

    <footer>
      <div class="footer-inner">
        <p>&copy; 2026 Katalog UMKM Karawang</p>
        <div class="footer-sosial">
          <a href="#" aria-label="Instagram Katalog UMKM Karawang"
            ><i class="fa-brands fa-instagram" aria-hidden="true"></i
          ></a>
          <a href="#" aria-label="Facebook Katalog UMKM Karawang"
            ><i class="fa-brands fa-facebook" aria-hidden="true"></i
          ></a>
          <a href="#" aria-label="WhatsApp Katalog UMKM Karawang"
            ><i class="fa-brands fa-whatsapp" aria-hidden="true"></i
          ></a>
          <!-- Contoh tag <audio> — sengaja ditaruh kecil dan santai di sini, bukan di tengah konten -->
          <audio class="footer-audio" src="getout.mp3" controls></audio>
        </div>
      </div>
    </footer>

    <!-- Tombol "kembali ke atas": disembunyikan lewat CSS, dimunculkan lewat JS saat halaman sudah discroll cukup jauh -->
    <button id="ke-atas" class="ke-atas" aria-label="Kembali ke atas">
      <svg
        viewBox="0 0 24 24"
        width="20"
        height="20"
        fill="none"
        stroke="currentColor"
        stroke-width="2.5"
        stroke-linecap="round"
        stroke-linejoin="round"
      >
        <path d="M12 19V5"></path>
        <path d="M6 11l6-6 6 6"></path>
      </svg>
    </button>

    <script>
      // ---------- Navbar sembunyi saat scroll ke bawah ----------
      // Bandingkan posisi scroll sekarang dengan posisi sebelumnya:
      // kalau turun (scroll ke bawah) navbar disembunyikan, kalau naik
      // (scroll ke atas) navbar dimunculkan lagi.
      const headerEl = document.querySelector("header");
      let posisiScrollTerakhir = 0;
      window.addEventListener("scroll", () => {
        const posisiSekarang = window.scrollY;
        const scrollTurun = posisiSekarang > posisiScrollTerakhir;
        // Cuma disembunyikan kalau sudah scroll cukup jauh (80px), supaya
        // navbar tidak kedap-kedip saat baru sedikit digeser di paling atas.
        headerEl.classList.toggle(
          "sembunyi",
          scrollTurun && posisiSekarang > 80,
        );
        posisiScrollTerakhir = posisiSekarang;
      });

      // ---------- Tombol kembali ke atas ----------
      // Tombolnya cuma tampil kalau memang berguna: setelah discroll > 400px.
      const tombolKeAtas = document.getElementById("ke-atas");
      window.addEventListener("scroll", () => {
        tombolKeAtas.classList.toggle("tampil", window.scrollY > 400);
      });
      tombolKeAtas.addEventListener("click", () => {
        window.scrollTo({ top: 0, behavior: "smooth" });
      });

      // ---------- Reveal saat discroll ----------
      // IntersectionObserver mendeteksi kapan sebuah elemen masuk ke layar,
      // tanpa perlu menghitung posisi scroll secara manual.
      const revealObserver = new IntersectionObserver(
        (entries) => {
          entries.forEach((entry) => {
            if (entry.isIntersecting) {
              entry.target.classList.add("tampil");
              revealObserver.unobserve(entry.target); // cukup sekali, tidak diulang
            }
          });
        },
        { threshold: 0.12 },
      );
      document
        .querySelectorAll(".reveal")
        .forEach((el) => revealObserver.observe(el));
    </script>

    <!--
      app.js ditaruh SETELAH inline script di atas, dan setelah semua HTML
      di <body> — supaya document.querySelector di app.js selalu berhasil
      menemukan elemen (elemen sudah pasti ada duluan sebelum dicari).
    -->
    <script src="app.js"></script>
  </body>
</html>
```

**Cek hasil:** refresh halaman — section Direktori sekarang **kosong** (wajar, kartunya sudah dihapus dari HTML, `app.js` belum merender apa-apa). Buka Console, pastikan tidak ada error (`app.js` kosong tidak menghasilkan error apa pun).

## Langkah 3 — Data UMKM sebagai Array of Object

Isi `app.js`, mulai dengan data 6 UMKM asli (bukan data baru — persis yang dulu ditulis manual di HTML pertemuan 2):

```javascript
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
```

- Ini array of object — persis konsep yang dipelajari di `arrayobject.js`, cuma sekarang datanya nyata dan lebih banyak fieldnya (nama, kategori, alamat, jam, wa, foto, alt).
- Belum ada perubahan tampilan sama sekali — data ini baru "disimpan", belum "dirender".

**Cek hasil:** buka Console, ketik `daftarUmkm` lalu Enter — muncul array berisi 6 object, bisa diklik untuk lihat isinya. Halaman masih kosong seperti langkah sebelumnya.

## Langkah 4 — Container & Function `renderUmkm()`

Tambahkan di bawah `daftarUmkm`:

```javascript
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
```

- `document.querySelector(".grid-umkm")` — sama seperti `dom.js`, mencari elemen sekali di awal, disimpan ke variabel, dipakai berkali-kali (tidak perlu `querySelector` ulang tiap kali function dipanggil).
- Template literal (backtick + `${}`) — persis seperti dipelajari di README Teori, dipakai buat menyisipkan tiap field object ke dalam markup HTML.
- Pengecekan `data.length === 0` sengaja ditulis dari awal di sini, bukan ditambah belakangan — supaya `renderUmkm()` sejak awal siap dipakai buat hasil filter yang mungkin kosong nanti di Langkah 6.

Sesuaikan juga CSS-nya — tambahkan di `style.css`, tepat di bawah aturan `.grid-umkm`:

```css
/* Pesan ini dirender app.js kalau hasil filter/pencarian tidak ada yang cocok */
.grid-umkm .kosong {
  grid-column: 1 / -1;
  text-align: center;
  padding: 40px 20px;
  color: var(--matcha-mid);
  font-size: 0.95rem;
}
```

**Cek hasil:** function-nya sudah didefinisikan, tapi belum ada yang memanggilnya — halaman masih kosong. Ini wajar, lanjut ke langkah berikutnya.

## Langkah 5 — Render Pertama Kali

Tambahkan satu baris di bawah function `renderUmkm`:

```javascript
// Render pertama kali begitu halaman dimuat — sebelum ini, .grid-umkm kosong.
renderUmkm(daftarUmkm);
```

**Cek hasil:** refresh halaman — 6 kartu UMKM muncul kembali, tampilannya identik dengan versi manual pertemuan 2. Bedanya sekarang datanya berasal dari array JavaScript, bukan ditulis di HTML.

**Kalau error:** kalau kartu tidak muncul sama sekali, buka Console — biasanya `querySelector(".grid-umkm")` mengembalikan `null` karena classnya salah ketik, atau `app.js` dimuat sebelum `<div class="grid-umkm">` ada di HTML.

## Langkah 6 — Filter Kategori + Pencarian Nama (Digabung)

Tambahkan di bawah `renderUmkm(daftarUmkm);`:

```javascript
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
```

Kenapa kategori dan pencarian digabung jadi satu function, bukan dua function terpisah? Supaya dua-duanya bisa aktif **bersamaan** — misalnya pilih kategori "Kuliner" DAN ketik "kopi", hasilnya harus UMKM yang kategorinya Kuliner **dan** namanya mengandung "kopi". Kalau dipisah jadi dua function sendiri-sendiri, salah satu bakal "menimpa" hasil yang lain.

**Cek hasil:**
- Ganti dropdown ke "Kuliner" — cuma Warung Bu Sari dan Kopi Rawa Gede yang muncul.
- Balikin ke "Semua kategori", ketik "batik" di kotak cari — cuma Batik Karawang Asli yang muncul.
- Kombinasikan: pilih "Kuliner", ketik "kopi" — cuma Kopi Rawa Gede yang muncul.
- Ketik nama yang tidak ada, misalnya "zzz" — muncul pesan "Tidak ada UMKM yang cocok." (ini yang disiapkan di Langkah 4).

**Kalau error:** kalau ketik di kotak cari tidak ada efeknya sama sekali, cek event yang dipasang di `inputCari` — harus `"input"`, bukan `"click"` (tidak ada yang diklik di kotak teks).

## Langkah 7 — Validasi Form Kontak

Tambahkan di bagian paling bawah `app.js`:

```javascript
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
```

Bagian ini konsepnya sama persis seperti dipelajari di `inputoutput.js` (baca `.value`) dan `event.js` (`addEventListener`) — cuma event-nya sekarang `"submit"` pada `<form>`, bukan `"click"` pada `<button>`.

**Cek hasil:** scroll ke section Kontak, klik "Kirim pesan" tanpa isi apa-apa — muncul peringatan "Nama dan pesan tidak boleh kosong!". Isi nama dan pesan, klik lagi — muncul ucapan terima kasih, form jadi kosong lagi, dan di Console muncul `Pesan terkirim: {...}`.

**Kalau error:** kalau form malah reload halaman (bukan cuma tampil alert), cek `event.preventDefault()` sudah dipanggil di baris paling atas function submit.

## Selesai — Cek Ulang dan Verifikasi

`app.js` sekarang lengkap 4 bagian: data, render, filter, dan validasi form. File akhirnya persis sama dengan `app.js` yang ada di folder ini. Struktur akhirnya:

```text
implementasi-umkm/
├── index.html
├── style.css
├── app.js
└── getout.mp3
```

Cek ulang semuanya sekaligus:

1. Direktori menampilkan 6 kartu UMKM, tampilannya identik dengan pertemuan 2.
2. Dropdown kategori dan kotak cari sama-sama berfungsi, dan bisa dikombinasikan.
3. Kombinasi yang tidak match apa pun menampilkan pesan "Tidak ada UMKM yang cocok.", bukan grid kosong.
4. Form kontak menolak submit kosong, menerima submit terisi, dan mencatat datanya di Console.
5. Buka Console — tidak ada error merah sama sekali dari awal buka halaman sampai selesai coba semua fitur.

Kalau semua sudah beres, folder pertemuan 3 sudah lengkap dua-duanya — `fundamental-javascript/` (konsep dasar) dan `implementasi-umkm/` (penerapan nyata). Detail konsep lebih lengkap ada di `README.md` satu tingkat di atas folder ini.
