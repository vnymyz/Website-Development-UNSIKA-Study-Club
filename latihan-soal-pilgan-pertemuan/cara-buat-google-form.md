# Cara Membuat Google Form dari File CSV

Panduan ini untuk mengubah soal pilihan ganda (`pilgan-1.csv` sampai `pilgan-6.csv`) menjadi Google Form yang siap dibagikan ke peserta — tanpa perlu mengetik ulang soal satu per satu.

## Kenapa Tidak Tempel Manual Saja?

Google Form tidak punya tombol untuk mengimpor banyak soal sekaligus dari CSV atau file lain. Kalau soal ditempel manual satu per satu, untuk 10 soal per pertemuan itu mungkin masih kuat, tapi kalau harus bikin banyak Form dari beberapa pertemuan, itu memakan waktu dan gampang salah ketik/salah centang jawaban benar.

Solusinya: masukkan data ke Google Sheets, lalu jalankan sebuah **script** (kode otomatis bawaan Google, gratis, tidak perlu instal apa pun) yang membaca data itu dan **membuat Google Form secara otomatis** — termasuk menandai jawaban benarnya. Prosesnya cuma sekali klik "Run" setelah setup awal.

Ikuti langkah di bawah ini persis urutannya. Semua langkah dilakukan di browser, tidak perlu aplikasi tambahan.

## Langkah 1 — Buat Google Sheet Baru dan Impor CSV

1. Buka [sheets.google.com](https://sheets.google.com/), klik **Blank spreadsheet** untuk membuat sheet kosong.
2. Beri nama sheet, misalnya "Kuis Pertemuan 1 - Website UNSIKA" (klik judul "Untitled spreadsheet" di kiri atas untuk mengubahnya).
3. Klik menu **File > Import**.
4. Pilih tab **Upload**, lalu unggah file `pilgan-1.csv` (atau pertemuan lain yang mau dibuatkan Form-nya) dari komputer.
5. Pada jendela konfirmasi import, pilih **Replace current sheet**, lalu klik **Import data**.

**Cek hasil:** tabel muncul di Sheet dengan 7 kolom (No, Pertanyaan, Opsi A, Opsi B, Opsi C, Opsi D, Jawaban Benar) dan 10 baris soal, ditambah 1 baris header di paling atas.

**Kalau error:** kalau tabel muncul tapi semua data numpuk di satu kolom saja, ulangi Langkah 4 dan pastikan formatnya tetap CSV (bukan diubah jadi format lain saat disimpan dari komputer).

## Langkah 2 — Buka Apps Script dan Tempel Kode

1. Di Google Sheet yang sama, klik menu **Extensions > Apps Script**.
2. Tab baru akan terbuka menampilkan editor kode kosong dengan judul default `Code.gs`, berisi function kosong seperti `function myFunction() { }`.
3. **Hapus semua isi default** di editor itu (select all, lalu delete).
4. Salin (copy) seluruh kode di bawah ini, lalu tempel (paste) ke editor Apps Script yang sudah kosong tadi.

```javascript
function buatGoogleFormDariSheet() {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var data = sheet.getDataRange().getValues();

  // Ganti judul ini sesuai pertemuan yang sedang dibuatkan Form-nya
  var judulForm = "Kuis Pertemuan 1 — Website UNSIKA";

  var form = FormApp.create(judulForm);
  form.setIsQuiz(true);
  form.setDescription("Kuis pilihan ganda — Website UNSIKA. Pilih satu jawaban yang paling tepat.");

  // Baris pertama (index 0) adalah header kolom, jadi mulai dari baris ke-2
  for (var i = 1; i < data.length; i++) {
    var baris = data[i];

    var pertanyaan = baris[1];
    var opsiA = baris[2];
    var opsiB = baris[3];
    var opsiC = baris[4];
    var opsiD = baris[5];
    var jawabanBenar = String(baris[6]).trim().toUpperCase(); // "A", "B", "C", atau "D"

    if (!pertanyaan) continue; // lewati baris kosong kalau ada

    var petaOpsi = { A: opsiA, B: opsiB, C: opsiC, D: opsiD };
    var teksJawabanBenar = petaOpsi[jawabanBenar];

    var item = form.addMultipleChoiceItem();
    item.setTitle(pertanyaan).setPoints(1);

    var pilihan = [
      item.createChoice(opsiA, opsiA === teksJawabanBenar),
      item.createChoice(opsiB, opsiB === teksJawabanBenar),
      item.createChoice(opsiC, opsiC === teksJawabanBenar),
      item.createChoice(opsiD, opsiD === teksJawabanBenar)
    ];
    item.setChoices(pilihan);
  }

  Logger.log("Form berhasil dibuat!");
  Logger.log("Link edit (buat kamu): " + form.getEditUrl());
  Logger.log("Link isi (buat dibagikan ke peserta): " + form.getPublishedUrl());
}
```

5. Ganti bagian `var judulForm = "Kuis Pertemuan 1 — Website UNSIKA";` sesuai pertemuan yang sedang kamu buatkan Form-nya (misalnya jadi "Kuis Pertemuan 3 — Website UNSIKA" kalau lagi proses `pilgan-3.csv`).
6. Simpan project ini: tekan `Ctrl + S`, lalu beri nama misalnya "Generator Kuis Website UNSIKA" saat diminta.

**Cek hasil:** editor Apps Script menampilkan kode di atas tanpa garis merah error, dan judul project di kiri atas sudah berubah dari "Untitled project".

**Kalau error:** kalau ada garis merah bergelombang di kode, cek lagi apakah semua isi default sudah terhapus sebelum ditempel — kadang ada sisa tanda kurung `}` yang ketinggalan.

## Langkah 3 — Jalankan Script

1. Di bagian atas editor Apps Script, pastikan dropdown function menunjukkan `buatGoogleFormDariSheet` (biasanya sudah otomatis terpilih karena cuma ada 1 function).
2. Klik tombol **Run** (ikon segitiga/play).
3. Akan muncul jendela **Authorization required**. Klik **Review permissions**.
4. Pilih akun Google yang sedang dipakai. Kalau muncul peringatan "Google hasn't verified this app", klik **Advanced**, lalu klik **Go to (nama project) (unsafe)**. Ini **normal dan aman** — peringatan itu muncul karena script ini buatan sendiri, bukan aplikasi dari Google Play Store, bukan berarti berbahaya.
5. Klik **Allow** untuk mengizinkan script membuat Google Form atas nama akun kamu.

**Cek hasil:** script berjalan (muncul indikator loading di sebelah tombol Run), lalu setelah selesai muncul tanda centang hijau. Klik menu **View > Logs** (atau `Ctrl + Enter`) untuk melihat pesan "Form berhasil dibuat!" beserta dua link (link edit dan link isi).

**Kalau error:** kalau muncul pesan error di Logs seperti `Cannot read property of undefined`, biasanya artinya Sheet yang aktif bukan Sheet yang berisi data soal — pastikan tab Sheet yang sedang terbuka di Google Sheets (bukan Apps Script) memang tab yang tadi diimpor CSV-nya.

## Langkah 4 — Cek Form yang Sudah Jadi

1. Buka [Google Drive](https://drive.google.com/), Form baru akan muncul di paling atas dengan nama sesuai `judulForm` yang diisi di Langkah 2.
2. Buka Form itu, cek: 10 pertanyaan sudah muncul dengan 4 pilihan jawaban masing-masing.
3. Klik ikon **Settings (gerigi)** di Form, tab **Quiz**, pastikan opsi **Make this a quiz** dalam kondisi aktif (biasanya sudah otomatis aktif karena script memakai `setIsQuiz(true)`).
4. Untuk memastikan jawaban benar sudah ke-set otomatis: buka salah satu soal, klik **Answer key** di kiri bawah soal itu, cek opsi mana yang ditandai benar — cocokkan dengan kolom "Jawaban Benar" di file CSV/markdown aslinya.

**Cek hasil:** Form aktif dalam mode Quiz, semua 10 soal punya jawaban benar yang sudah ter-tandai otomatis sesuai data di CSV.

**Kalau error:** kalau ternyata ada jawaban yang salah tertandai, kemungkinan ada typo di kolom "Jawaban Benar" pada file CSV (misalnya tertulis huruf kecil `b` alih-alih `B` — script sudah menangani ini dengan `.toUpperCase()`, tapi pastikan tetap salah satu dari `A`/`B`/`C`/`D` persis, tanpa spasi tambahan).

## Mengulang untuk Pertemuan Lain

Script yang sama bisa dipakai berulang untuk `pilgan-2.csv` sampai `pilgan-6.csv`. Caranya:

1. Ulangi Langkah 1 dengan Sheet baru (atau ganti isi Sheet yang sama) untuk file CSV pertemuan lain.
2. Di Apps Script, ubah baris `var judulForm = "..."` sesuai nomor pertemuan yang baru.
3. Jalankan lagi (Langkah 3) — Form baru akan otomatis terbuat, tidak menimpa Form pertemuan sebelumnya karena `FormApp.create()` selalu membuat Form baru.

## Membagikan Form ke Peserta

Setelah Form jadi dan sudah dicek:

1. Klik tombol **Send** di kanan atas Form.
2. Pilih ikon link (🔗), klik **Copy** untuk menyalin link.
3. Bagikan link itu ke peserta lewat grup/kanal yang biasa dipakai study club.

> Jangan bagikan link **Edit** (yang muncul di Logs Apps Script) ke peserta — itu link untuk mengubah isi Form, bukan untuk mengisi kuis. Yang dibagikan ke peserta adalah link **Send**/publish dari Form itu sendiri.
