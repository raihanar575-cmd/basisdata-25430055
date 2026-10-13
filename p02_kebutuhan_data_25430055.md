# Dokumen Kebutuhan Data — Toko Daring

**NIM:** 25430055  
**Kode proyek:** `toko_055`  
**Parameter P:** 2

## 1. Latar Belakang dan Aktivitas Organisasi

Toko Daring merupakan organisasi fiktif yang menjual produk secara daring. Sistem basis data dirancang untuk mendukung pengelolaan katalog produk, data pelanggan, keranjang belanja, pesanan, pembayaran, dan pengiriman.

Aktivitas utama meliputi pengelolaan produk dan kategori, pendaftaran pelanggan, pengelolaan keranjang, pembuatan pesanan, pencatatan pembayaran, serta pembaruan status pengiriman. Analisis ini menjadi dasar awal perancangan ERD pada P03.

## 2. Aktor dan Proses Bisnis

### 2.1 Aktor

| Aktor | Peran |
|---|---|
| Pelanggan | Mendaftar, melihat produk, mengelola keranjang, membuat pesanan, dan melihat status pesanan |
| Admin | Mengelola produk, kategori, pesanan, dan pembayaran |
| Petugas Pengiriman | Memperbarui informasi pengiriman |
| Sistem | Membuat ID dan mencatat waktu secara otomatis |

### 2.2 Proses Bisnis

| Kode | Proses Bisnis | Aktor | Deskripsi |
|---|---|---|---|
| PB-01 | Mengelola Katalog Produk | Admin | Menambah, melihat, mengubah, dan menghapus data produk serta mengelola kategori |
| PB-02 | Mengelola Data Pelanggan | Pelanggan/Admin | Mendaftarkan pelanggan, melihat profil, dan memperbarui data yang diizinkan |
| PB-03 | Mengelola Keranjang Belanja | Pelanggan | Membuat keranjang, melihat isinya, menambah produk, mengubah jumlah, dan menghapus item |
| PB-04 | Memproses Pesanan | Pelanggan/Sistem | Membuat pesanan dari keranjang dan menyimpan rincian produk beserta harga saat pemesanan |
| PB-05 | Memproses Pembayaran dan Pengiriman | Admin/Petugas Pengiriman | Mencatat status pembayaran dan memperbarui status pengiriman |

---

## 3. Dokumen Sumber yang Dianalisis

Dokumen sumber berupa contoh fiktif **Nota Pesanan Toko Daring**. Contoh ini hanya untuk analisis, bukan bukti transaksi nyata.

| Elemen | Contoh |
|---|---|
| Nomor Pesanan | `ORD-2026-0001` |
| Tanggal Pesanan | 06-10-2026 |
| Nama Pelanggan | Pelanggan Contoh |
| Email | `pelanggan001@gmail.com` |
| Produk | Keyboard Mechanical |
| Jumlah | 1 |
| Harga saat pemesanan | Rp450.000 |
| Ongkos kirim | Rp15.000 |
| Alamat pengiriman | Jl. Contoh No. 10, Kota Contoh |
| Total pesanan | Rp465.000 |
| Status pembayaran | Dibayar |
| Status pengiriman | Diproses |

Dari nota tersebut, data dapat dikelompokkan menjadi pelanggan, pesanan, rincian produk yang dibeli, pembayaran, dan pengiriman. Harga saat transaksi perlu dibedakan dari harga produk di katalog karena harga katalog dapat berubah. Alamat tujuan dan ongkos kirim disimpan pada pesanan agar riwayat transaksi tetap menggambarkan kondisi saat pesanan dibuat.

Satu pesanan dapat berisi beberapa produk. Oleh karena itu, produk, jumlah, dan harga saat pemesanan perlu dicatat sebagai rincian pesanan.

---

## 4. Entitas Kandidat

| Entitas | Fungsi | Elemen Data Utama |
|---|---|---|
| Pelanggan | Menyimpan identitas pelanggan | `id_pelanggan`, `nama`, `email`, `no_telepon` |
| Kategori | Mengelompokkan produk | `id_kategori`, `nama_kategori` |
| Produk | Menyimpan katalog | `id_produk`, `nama_produk`, `harga`, `stok`, `id_kategori` |
| Keranjang | Menyimpan keranjang pelanggan | `id_keranjang`, `id_pelanggan`, `tanggal_dibuat` |
| Item Keranjang | Menyimpan produk dan jumlahnya di keranjang | `id_item_keranjang`, `id_keranjang`, `id_produk`, `jumlah` |
| Pesanan | Menyimpan informasi transaksi | `id_pesanan`, `id_pelanggan`, `tanggal_pesanan`, `alamat_pengiriman`, `ongkos_kirim`, `total_pesanan` |
| Detail Pesanan | Menyimpan produk dalam sebuah pesanan | `id_detail_pesanan`, `id_pesanan`, `id_produk`, `jumlah`, `harga_saat_pesanan` |
| Pembayaran | Menyimpan status pembayaran | `id_pembayaran`, `id_pesanan`, `status_pembayaran` |
| Pengiriman | Menyimpan informasi pengiriman | `id_pengiriman`, `id_pesanan`, `nomor_resi`, `status_pengiriman` |

**Catatan:** Detail Pesanan dipisahkan dari Pesanan karena satu pesanan dapat mencakup beberapa produk. Elemen lebih rinci dan hubungan antarentitas akan ditinjau saat membuat ERD P03.

---

## 5. Aturan Bisnis

| Kode | Aturan Bisnis |
|---|---|
| AB-01 | Setiap pelanggan memiliki ID yang unik. |
| AB-02 | Email pelanggan harus unik untuk setiap akun. |
| AB-03 | Setiap produk terhubung dengan satu kategori; satu kategori dapat memiliki banyak produk. |
| AB-04 | Seorang pelanggan hanya memiliki satu keranjang aktif pada satu waktu. |
| AB-05 | Seorang pelanggan dapat membuat banyak pesanan; setiap pesanan dimiliki satu pelanggan. |
| AB-06 | Setiap pesanan harus memiliki minimal satu detail pesanan. |
| AB-07 | Setiap detail pesanan merujuk pada satu produk dan menyimpan jumlah serta harga saat pemesanan. |
| AB-08 | Alamat pengiriman dan ongkos kirim disimpan pada pesanan agar riwayat transaksi tidak berubah ketika profil pelanggan berubah. |
| AB-09 | Untuk ruang lingkup awal, setiap pesanan memiliki satu catatan pembayaran dan paling banyak satu catatan pengiriman. |
| AB-10 | Pengiriman diproses setelah pembayaran dikonfirmasi. |

---

## 6. Kebutuhan Informasi

| Kode | Kebutuhan Informasi | Pertanyaan yang Dijawab |
|---|---|---|
| KI-01 | Daftar produk berdasarkan kategori | Produk apa saja yang termasuk kategori tertentu? |
| KI-02 | Isi keranjang pelanggan | Produk apa saja yang ada di keranjang dan berapa jumlahnya? |
| KI-03 | Riwayat pesanan pelanggan | Pesanan apa saja yang pernah dibuat pelanggan? |
| KI-04 | Rincian pesanan | Produk apa yang dibeli, berapa jumlahnya, dan berapa harga saat pembelian? |
| KI-05 | Status pembayaran dan pengiriman | Bagaimana status pembayaran dan pengiriman suatu pesanan? |

---

## 7. Matriks CRUD

Keterangan: **C** = Create, **R** = Read, **U** = Update, **D** = Delete. Tanda `—` berarti tidak ada operasi utama pada entitas tersebut dalam proses yang bersangkutan.

| Proses Bisnis | Pelanggan | Kategori | Produk | Keranjang | Item Keranjang | Pesanan | Detail Pesanan | Pembayaran | Pengiriman |
|---|---|---|---|---|---|---|---|---|---|
| PB-01 Mengelola Katalog Produk | — | C/R/U/D | C/R/U/D | — | — | — | — | — | — |
| PB-02 Mengelola Data Pelanggan | C/R/U | — | — | — | — | — | — | — | — |
| PB-03 Mengelola Keranjang Belanja | R | — | R | C/R/U | C/R/U/D | — | — | — | — |
| PB-04 Memproses Pesanan | R | — | R | R | R | C/R/U | C/R | — | — |
| PB-05 Memproses Pembayaran dan Pengiriman | R | — | — | — | — | R/U | R | C/R/U | C/R/U |

**Pemeriksaan CRUD:** Semua entitas memiliki operasi `C` pada proses yang sesuai. `Pelanggan` dibuat melalui pendaftaran; `Kategori` dan `Produk` melalui pengelolaan katalog; `Keranjang` dan `Item Keranjang` melalui pengelolaan keranjang; `Pesanan` dan `Detail Pesanan` melalui pemrosesan pesanan; serta `Pembayaran` dan `Pengiriman` melalui proses pembayaran dan pengiriman. Penghapusan tidak diberikan pada riwayat transaksi agar jejak transaksi tetap terjaga.

---

## 8. Kamus Data

Kamus data awal berisi **34 elemen inti**. Contoh nilai bersifat fiktif. Tipe data dan constraint teknis ditetapkan pada tahap perancangan tabel.

| Kode | Entitas | Elemen Data | Arti | Contoh | Penanggung Jawab |
|---|---|---|---|---|---|
| DD-01 | Pelanggan | `id_pelanggan` | Identitas unik pelanggan | `PLG001` | Sistem |
| DD-02 | Pelanggan | `nama` | Nama pelanggan | Pelanggan Contoh | Pelanggan |
| DD-03 | Pelanggan | `email` | Email akun pelanggan | `pelanggan001@example.com` | Pelanggan |
| DD-04 | Kategori | `id_kategori` | Identitas unik kategori | `KAT001` | Sistem |
| DD-05 | Kategori | `nama_kategori` | Nama kategori | Elektronik | Admin |
| DD-06 | Produk | `id_produk` | Identitas unik produk | `PRD001` | Sistem |
| DD-07 | Produk | `nama_produk` | Nama produk | Keyboard Mechanical | Admin |
| DD-08 | Produk | `harga` | Harga produk saat ini di katalog | `450000` | Admin |
| DD-09 | Produk | `stok` | Jumlah unit tersedia | `20` | Admin |
| DD-10 | Produk | `id_kategori` | Kategori produk | `KAT001` | Sistem |
| DD-11 | Keranjang | `id_keranjang` | Identitas unik keranjang | `CRT001` | Sistem |
| DD-12 | Keranjang | `id_pelanggan` | Pemilik keranjang | `PLG001` | Sistem |
| DD-13 | Item Keranjang | `id_keranjang` | Keranjang yang memuat item | `CRT001` | Sistem |
| DD-14 | Item Keranjang | `id_item_keranjang` | Identitas unik baris item keranjang | `ICK001` | Sistem |
| DD-15 | Item Keranjang | `id_produk` | Produk di dalam keranjang | `PRD001` | Pelanggan/Sistem |
| DD-16 | Item Keranjang | `jumlah` | Jumlah unit dalam keranjang | `2` | Pelanggan |
| DD-17 | Pesanan | `id_pesanan` | Identitas unik pesanan | `ORD-2026-0001` | Sistem |
| DD-18 | Pesanan | `id_pelanggan` | Pelanggan pemilik pesanan | `PLG001` | Sistem |
| DD-19 | Pesanan | `tanggal_pesanan` | Tanggal pesanan dibuat | `2026-10-06` | Sistem |
| DD-20 | Pesanan | `alamat_pengiriman` | Alamat tujuan pesanan yang disimpan saat transaksi | Jl. Contoh No. 10, Kota Contoh | Pelanggan |
| DD-21 | Pesanan | `ongkos_kirim` | Biaya pengiriman pesanan | `15000` | Sistem/Admin |
| DD-22 | Pesanan | `total_pesanan` | Total akhir pesanan | `915000` | Sistem |
| DD-23 | Detail Pesanan | `id_detail_pesanan` | Identitas unik baris rincian pesanan | `DPS001` | Sistem |
| DD-24 | Detail Pesanan | `id_pesanan` | Pesanan yang memuat rincian | `ORD-2026-0001` | Sistem |
| DD-25 | Detail Pesanan | `id_produk` | Produk yang dibeli | `PRD001` | Sistem |
| DD-26 | Detail Pesanan | `jumlah` | Jumlah unit yang dibeli | `2` | Pelanggan/Sistem |
| DD-27 | Detail Pesanan | `harga_saat_pesanan` | Harga per unit saat pesanan dibuat | `450000` | Sistem |
| DD-28 | Pembayaran | `id_pembayaran` | Identitas unik pembayaran | `PAY001` | Sistem |
| DD-29 | Pembayaran | `id_pesanan` | Pesanan yang dibayar | `ORD-2026-0001` | Sistem |
| DD-30 | Pembayaran | `status_pembayaran` | Status pembayaran pesanan | Dibayar | Admin/Sistem |
| DD-31 | Pengiriman | `id_pengiriman` | Identitas unik pengiriman | `SHP001` | Sistem |
| DD-32 | Pengiriman | `id_pesanan` | Pesanan yang dikirim | `ORD-2026-0001` | Sistem |
| DD-33 | Pengiriman | `nomor_resi` | Nomor pelacakan pengiriman | `RESI0001` | Petugas Pengiriman |
| DD-34 | Pengiriman | `status_pengiriman` | Status proses pengiriman | Diproses | Petugas Pengiriman |

**Catatan:** `harga` adalah harga katalog saat ini, sedangkan `harga_saat_pesanan` adalah harga per unit yang disimpan untuk menjaga riwayat transaksi. `alamat_pengiriman` dan `ongkos_kirim` disimpan pada pesanan agar tidak berubah ketika profil pelanggan atau tarif berubah.

---

## 9. Kebutuhan Nonfungsional Data

### 9.1 Volume Data
Berdasarkan parameter P, perkiraan awal volume transaksi adalah 50 transaksi per hari. Nilai ini merupakan parameter praktikum, bukan data transaksi nyata.

### 9.2 Retensi
Riwayat pesanan, pembayaran, dan pengiriman perlu dipertahankan untuk keperluan operasional dan pemeriksaan transaksi. Data transaksi tidak dihapus sembarangan.

### 9.3 Privasi
Nama, email, nomor telepon, dan alamat pelanggan hanya boleh diakses oleh pihak yang memerlukannya untuk menjalankan tugas. Contoh pada dokumen ini menggunakan data fiktif.

### 9.4 Hak Akses
- Pelanggan hanya dapat melihat profil dan transaksi miliknya.
- Admin dapat mengelola katalog serta memproses pesanan dan pembayaran.
- Petugas pengiriman dapat melihat informasi yang diperlukan untuk pengiriman dan memperbarui status pengiriman.
- Pengguna tanpa kewenangan tidak boleh mengakses data pribadi pelanggan.

---

## 10. Isu Kualitas Data

| Kode | Isu | Pemeriksaan Awal |
|---|---|---|
| QD-01 | Data pelanggan ganda | Memeriksa keunikan ID dan email |
| QD-02 | Data kontak tidak lengkap | Memeriksa kelengkapan email dan nomor telepon |
| QD-03 | Harga transaksi berbeda dari harga katalog | Memastikan harga saat pemesanan tersimpan pada detail pesanan |
| QD-04 | Stok bernilai negatif | Memastikan stok tidak kurang dari nol |
| QD-05 | Jumlah item tidak valid | Memastikan jumlah berupa bilangan bulat positif |
| QD-06 | Total pesanan tidak sesuai | Membandingkan jumlah subtotal dengan total ditambah ongkos kirim |
| QD-07 | Status pembayaran atau pengiriman tidak sesuai | Memeriksa status terhadap proses transaksi |

---

## 11. Parameter P

Dua digit terakhir NIM adalah `55`.

`P = (55 mod 9) + 1 = 1 + 1 = 2`

| Ketentuan | Perhitungan | Hasil |
|---|---|---|
| Parameter P | `(55 mod 9) + 1` | `2` |
| Maksimal item per transaksi | `P + 2` | `4 item` |
| Nilai diskon/denda sesuai modul | `P` | `2` (gunakan satuan dari modul) |
| Perkiraan transaksi harian | `40 + 5 × P` | `50 transaksi/hari` |

Nilai tersebut digunakan sebagai parameter latihan dan penyusunan data sampel sesuai modul.

---

## 12. Perbaikan Pernyataan Kebutuhan yang Kabur

Angka pada contoh revisi berikut merupakan usulan awal dan harus disesuaikan apabila modul atau dosen menetapkan ukuran berbeda.

| Pernyataan Awal | Pernyataan Revisi | Cara Pengujian |
|---|---|---|
| Sistem harus cepat mencari produk. | Pencarian menampilkan hasil maksimal 2 detik pada data uji berisi 1.000 produk. | Catat waktu respons pencarian pada data uji tersebut. |
| Data pelanggan harus aman. | Pelanggan hanya dapat melihat atau mengubah profil miliknya sendiri. | Uji akses menggunakan dua akun berbeda dan pastikan akses silang ditolak. |
| Laporan stok harus akurat. | Setelah transaksi berhasil, stok pada katalog harus sama dengan stok yang tersimpan di basis data. | Bandingkan stok sebelum dan sesudah transaksi uji. |

---

## 13. Catatan untuk P03

Dokumen ini menjadi dasar awal pembuatan ERD. Hubungan yang perlu diperiksa pada P03 meliputi:

- Satu kategori dapat memiliki banyak produk.
- Satu pelanggan dapat memiliki banyak pesanan.
- Satu pelanggan hanya memiliki satu keranjang aktif pada satu waktu.
- Satu pesanan memiliki satu atau lebih detail pesanan.
- Setiap detail pesanan merujuk pada satu produk.
- Setiap pesanan memiliki satu catatan pembayaran dan paling banyak satu catatan pengiriman sesuai penyederhanaan AB-09.

Hubungan dan kardinalitas final harus diperiksa kembali terhadap aturan bisnis serta kebutuhan informasi pada saat pembuatan ERD.

---

## 14. Pernyataan Penggunaan AI

AI digunakan untuk membantu meninjau konsistensi struktur dokumen dan menjelaskan konsep analisis kebutuhan data. Penulis bertanggung jawab memeriksa kesesuaian hasil dengan modul praktikum, memahami keputusan desain, dan memvalidasi isi akhir dokumen.
