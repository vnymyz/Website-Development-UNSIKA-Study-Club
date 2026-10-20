# Pertemuan 6 — Deploy, Keamanan Database & Arahan Proyek Akhir

**Durasi:** 19.30–21.00 WIB
**Tools:** VS Code, Git, GitHub, Vercel, Supabase

Pertemuan terakhir ini **tidak menambah fitur**. Kode aplikasi sama dengan pertemuan 5. Hari ini kita membawa aplikasi Katalog UMKM ke internet, lalu memastikan datanya aman begitu semua orang bisa membukanya.

## Isi Folder

```text
pert6-code/
├── README.md            halaman ini
├── deployment/          panduan + semua SQL Supabase
│   ├── README.md                panduan lengkap (mulai dari sini)
│   ├── 01-supabase-lengkap.sql  SATU file untuk semua setup (jalankan ini saja)
│   ├── 02-supabase-secure.sql   pengaman untuk database lama yang datanya mau dipertahankan
│   ├── 03-cek-keamanan.sql      audit keamanan (hanya membaca)
│   ├── 04-uji-serangan.sql      simulasi penyerang (data uji dibatalkan otomatis)
│   ├── 05-perawatan.sql         query perawatan harian (opsional)
│   ├── 06-admin.sql             role admin untuk database lama (sudah ada di 01)
│   └── 07-uji-admin.sql         uji role admin
└── website-umkm/        kode aplikasi yang di-push ke GitHub dan di-deploy ke Vercel
```

## Mulai dari Mana

1. Buka **[`deployment/README.md`](deployment/README.md)**. Isinya teori dan langkah demi langkah: GitHub, Vercel, RLS dan keamanan, debugging, sampai arahan proyek akhir.

2. Kodenya ada di **[`website-umkm/`](website-umkm/)**. Di dalamnya ada `README.md` contoh README portofolio.

## Yang Dipelajari

- Upload project ke GitHub dengan Git.

- Deploy ke Vercel dan auto-deploy setiap `git push`.

- Mengatur Supabase supaya login jalan di alamat publik.

- Cara kerja RLS di aplikasi UMKM, dan kenapa XSS dan SQL injection tidak berhasil.

- Mengaudit dan menguji keamanan database dengan SQL.

- Menulis README yang layak portofolio.

- Debugging dasar: Console dan Network.
