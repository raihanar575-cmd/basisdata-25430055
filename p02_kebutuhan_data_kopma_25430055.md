# Dokumen Kebutuhan Data Kopma

**Pertemuan:** 2 — Analisis Kebutuhan Pengelolaan Data  
**NIM:** 25430055  
**Basis data praktikum:** `kopma_055`

## 1. Latar Belakang
Koperasi Mahasiswa (Kopma) menjual barang kebutuhan mahasiswa. Aktivitas utamanya meliputi pengelolaan anggota, barang dan stok, penjualan, pemasok, serta pembelian barang. Pencatatan terstruktur dibutuhkan agar kasir dapat melayani transaksi, petugas gudang mengelola stok, dan ketua memantau laporan.

## 2. Aktor dan Proses Bisnis

### 2.1 Aktor

| Aktor | Tanggung jawab |
|---|---|
| Ketua | Mengawasi operasional dan memeriksa laporan |
| Kasir | Mendaftarkan anggota bila diperlukan dan mencatat penjualan |
| Petugas gudang | Mengelola barang, stok, pemasok, dan pembelian |
| Anggota | Mahasiswa terdaftar yang dapat memperoleh diskon dan poin loyalitas |
| Pembeli umum | Membeli tanpa menjadi anggota |
| Pemasok | Menyediakan barang untuk Kopma |

### 2.2 Proses bisnis

| Kode | Proses bisnis | Aktor utama | Ringkasan |
|---|---|---|---|
| PB-01 | Mendaftarkan anggota | Kasir | Mencatat identitas dan status anggota |
| PB-02 | Mengelola barang | Petugas gudang | Mencatat barang, harga, stok, dan batas minimum |
| PB-03 | Melayani penjualan | Kasir | Membuat nota dan mencatat barang, kuantitas, harga, serta pembayaran |
| PB-04 | Mengelola data petugas | Ketua | Mencatat dan memperbarui data serta peran petugas |
| PB-05 | Mengelola pemasok | Petugas gudang | Mencatat informasi pemasok |
| PB-06 | Mencatat pembelian stok | Petugas gudang | Mencatat faktur dan barang yang dibeli |
| PB-07 | Memantau operasional | Ketua | Memeriksa laporan penjualan dan stok |

## 3. Dokumen Sumber

| Dokumen/sumber | Elemen yang diperoleh | Kegunaan |
|---|---|---|
| Formulir pendaftaran anggota | Nomor anggota, NIM, nama, program studi, nomor HP, status aktif | Mencatat anggota |
| Nota penjualan | Nomor nota, tanggal-jam, kasir, anggota opsional, barang, kuantitas, harga saat transaksi, pembayaran | Mencatat transaksi |
| Daftar barang | Kode, nama, kategori, harga jual, stok, batas minimum | Mengelola barang |
| Faktur pemasok | Nomor faktur, tanggal, pemasok, barang, kuantitas, harga beli | Mencatat pembelian |
| Wawancara | Peran petugas dan masalah pencatatan harga, stok, serta anggota | Memvalidasi kebutuhan |

### Contoh dokumen sumber fiktif: Nota Penjualan

Contoh berikut dibuat khusus untuk analisis kebutuhan dan bukan transaksi nyata.

| Elemen nota | Contoh nilai |
|---|---|
| Nomor nota | `KOP-2026-0001` |
| Tanggal dan waktu | `2026-10-06 10:15` |
| Petugas/kasir | `PTG001` |
| Anggota | `ANG001` |
| Barang | Buku Tulis A5 |
| Kuantitas | `2` |
| Harga satuan saat transaksi | `Rp5.000` |
| Subtotal | `Rp10.000` |
| Poin diperoleh | `1` |
| Poin digunakan | `0` |
| Diskon anggota 5% | `Rp500` |
| Total dibayar | `Rp9.500` |

**Hasil analisis dokumen:** Nomor nota dan waktu transaksi menjadi atribut Penjualan. Barang, kuantitas, dan harga satuan menjadi atribut Detail Penjualan karena satu nota dapat memuat beberapa barang. Identitas anggota bersifat opsional karena Kopma juga melayani pembeli umum. Kasir dicatat sebagai petugas yang melayani transaksi. Untuk latihan loyalitas, subtotal belanja Rp10.000 oleh anggota menghasilkan 1 poin; contoh ini menerapkan diskon anggota 5% sebesar Rp500 sehingga total dibayar Rp9.500. Poin dihitung dari subtotal sebelum diskon agar aturan perhitungan konsisten.


## 4. Entitas Kandidat dan Elemen Data

| Entitas kandidat | Elemen data utama | Sumber |
|---|---|---|
| Anggota | Nomor anggota, NIM, nama, program studi, nomor HP, status aktif, saldo poin | Formulir pendaftaran dan catatan transaksi |
| Barang | Kode, nama, kategori, harga jual, stok, batas minimum stok | Daftar barang |
| Penjualan | Nomor nota, tanggal-jam, kasir, anggota opsional, pembayaran, poin diperoleh, poin digunakan | Nota penjualan |
| Detail penjualan | Nomor nota, barang, kuantitas, harga saat transaksi | Nota penjualan |
| Petugas | Kode petugas, nama, peran (kasir/gudang/ketua) | Wawancara |
| Pemasok | Kode, nama, telepon, alamat | Faktur pemasok |
| Pembelian | Nomor faktur, tanggal, pemasok | Faktur pemasok |
| Detail pembelian | Pembelian, barang, kuantitas, harga beli | Faktur pemasok |

Entitas “Pembelian dan detailnya” dipisahkan menjadi Pembelian dan Detail pembelian karena satu faktur dapat memuat beberapa jenis barang.

## 5. Aturan Bisnis

| Kode | Aturan bisnis |
|---|---|
| AB-01 | Setiap nota memiliki nomor unik dan minimal satu baris barang. |
| AB-02 | Penjualan boleh tanpa anggota. Jika anggota dicantumkan, anggota harus aktif untuk memperoleh diskon 5%. |
| AB-03 | Stok tidak boleh negatif; penjualan ditolak jika kuantitas melebihi stok tersedia. |
| AB-04 | Harga pada nota disimpan per baris detail dan tidak berubah ketika harga barang diperbarui. |
| AB-05 | NIM anggota unik; anggota dapat dicari menggunakan nomor anggota atau NIM. |
| AB-06 | Pembelian stok dilakukan ketika stok barang kurang dari batas minimum. |
| AB-07 | Setiap kelipatan penuh belanja Rp10.000 oleh anggota menghasilkan 1 poin loyalitas. |
| AB-08 | Sebanyak 50 poin dapat ditukar dengan potongan harga Rp5.000. |
| AB-09 | Poin loyalitas hanya diberikan kepada anggota yang teridentifikasi pada transaksi. |
| AB-10 | Penukaran poin tidak boleh melebihi saldo poin anggota. |

## 6. Kebutuhan Informasi

| Kode | Kebutuhan informasi | Data yang diperlukan |
|---|---|---|
| KI-01 | Omzet dan jumlah nota per hari dan per bulan | Penjualan, Detail penjualan |
| KI-02 | Lima barang terlaris per bulan berdasarkan kuantitas | Detail penjualan, Barang |
| KI-03 | Barang dengan stok di bawah batas minimum | Barang |
| KI-04 | Sepuluh anggota dengan belanja terbesar per bulan | Penjualan, Detail penjualan, Anggota |
| KI-05 | Saldo poin loyalitas anggota | Anggota dan transaksi penjualan |
| KI-06 | Jumlah poin yang diperoleh dan digunakan per transaksi | Penjualan, Anggota |

## 7. Matriks CRUD

Keterangan: **C** = Create, **R** = Read, **U** = Update, **D** = Delete.

| Proses bisnis | Anggota | Barang | Penjualan | Detail penjualan | Petugas | Pemasok | Pembelian | Detail pembelian |
|---|---|---|---|---|---|---|---|---|
| PB-01 Mendaftarkan anggota | C/R/U | — | — | — | — | — | — | — |
| PB-02 Mengelola barang | — | C/R/U/D | — | — | — | — | — | — |
| PB-03 Melayani penjualan | R/U | R/U | C/R/U | C/R | R | — | — | — |
| PB-04 Mengelola data petugas | — | — | — | — | C/R/U/D | — | — | — |
| PB-05 Mengelola pemasok | — | — | — | — | — | C/R/U/D | — | — |
| PB-06 Mencatat pembelian stok | — | R/U | — | — | R | R | C/R | C/R |
| PB-07 Memantau operasional | R | R | R | R | R | R | R | R |

Penghapusan transaksi historis perlu dibatasi agar catatan penjualan dan pembelian tetap dapat ditelusuri.

## 8. Kamus Data Awal

Kamus data ringkas ini berisi **27 elemen inti** yang mencakup delapan entitas kandidat. Kunci teknis dan tipe data rinci dapat ditetapkan saat menyusun ERD dan skema relasional. Contoh data bersifat fiktif.

| Kode | Elemen data | Entitas | Keterangan | Penanggung jawab |
|---|---|---|---|---|
| DD-01 | `no_anggota` | Anggota | Nomor anggota; unik | Ketua |
| DD-02 | `nim_anggota` | Anggota | NIM anggota; unik | Ketua |
| DD-03 | `nama_anggota` | Anggota | Nama lengkap anggota | Ketua |
| DD-04 | `status_aktif` | Anggota | Status keanggotaan | Ketua |
| DD-05 | `saldo_poin` | Anggota | Saldo poin loyalitas anggota | Kasir |
| DD-06 | `kode_barang` | Barang | Kode barang; unik | Petugas gudang |
| DD-07 | `nama_barang` | Barang | Nama barang | Petugas gudang |
| DD-08 | `harga_jual_barang` | Barang | Harga jual saat ini | Petugas gudang |
| DD-09 | `stok_barang` | Barang | Stok tersedia | Petugas gudang |
| DD-10 | `batas_minimum_stok` | Barang | Batas minimum stok | Petugas gudang |
| DD-11 | `no_nota_penjualan` | Penjualan | Nomor nota; unik | Kasir |
| DD-12 | `tgl_penjualan` | Penjualan | Tanggal dan waktu transaksi | Kasir |
| DD-13 | `anggota_penjualan` | Penjualan | Anggota terkait; boleh kosong untuk pembeli umum | Kasir |
| DD-14 | `total_penjualan` | Penjualan | Nilai akhir yang harus dibayar setelah diskon dan penukaran poin | Kasir |
| DD-15 | `bayar_penjualan` | Penjualan | Nilai pembayaran yang diterima | Kasir |
| DD-16 | `poin_diperoleh` | Penjualan | Poin yang diperoleh pada transaksi | Kasir |
| DD-17 | `poin_digunakan` | Penjualan | Poin yang ditukar pada transaksi | Kasir |
| DD-18 | `barang_detail` | Detail penjualan | Barang pada baris transaksi | Kasir |
| DD-19 | `qty_detail_penjualan` | Detail penjualan | Kuantitas; harus positif | Kasir |
| DD-20 | `harga_satuan_detail_penjualan` | Detail penjualan | Harga per unit saat transaksi | Kasir |
| DD-21 | `kode_petugas` | Petugas | Kode petugas | Ketua |
| DD-22 | `kode_pemasok` | Pemasok | Kode pemasok | Petugas gudang |
| DD-23 | `no_faktur_pembelian` | Pembelian | Nomor faktur pembelian | Petugas gudang |
| DD-24 | `tgl_pembelian` | Pembelian | Tanggal faktur/pembelian dicatat | Petugas gudang |
| DD-25 | `barang_detail_pembelian` | Detail pembelian | Barang pada baris faktur pembelian | Petugas gudang |
| DD-26 | `qty_detail_pembelian` | Detail pembelian | Jumlah unit barang yang dibeli; harus positif | Petugas gudang |
| DD-27 | `harga_beli_detail` | Detail pembelian | Harga beli per unit barang | Petugas gudang |

**Catatan loyalitas:** `saldo_poin` menyimpan saldo anggota, sedangkan `poin_diperoleh` dan `poin_digunakan` mencatat perubahan poin pada transaksi. Saldo harus diperbarui dan divalidasi setiap kali poin diperoleh atau ditukar.

## 9. Kebutuhan Nonfungsional

| Aspek | Kebutuhan |
|---|---|
| Volume | Sistem menangani pencatatan penjualan dan pembelian harian serta laporan berkala. |
| Retensi | Riwayat transaksi dipertahankan untuk pemeriksaan nota dan laporan; jangka waktu ditetapkan pengurus. |
| Privasi | NIM dan nomor HP anggota hanya digunakan untuk administrasi koperasi. |
| Hak akses | Kasir mengelola penjualan; petugas gudang mengelola barang, pemasok, dan pembelian; ketua mengawasi data dan laporan. |
| Integritas | Nomor nota dan NIM harus unik; kuantitas valid; stok tidak boleh negatif. |
| Audit | Transaksi dapat ditelusuri melalui nomor nota, waktu, dan petugas yang melayani. |

## 10. Isu Kualitas Data

| Isu | Dampak | Penanganan |
|---|---|---|
| Harga transaksi lama berubah mengikuti harga terbaru | Nota lama tidak akurat | Simpan harga saat transaksi pada Detail penjualan |
| Stok negatif | Laporan persediaan salah | Validasi stok sebelum penjualan |
| Anggota tercatat lebih dari sekali | Riwayat anggota terpecah | Pastikan NIM dan nomor anggota unik |
| Anggota tidak ditemukan | Diskon/poin tidak dapat diberikan dengan benar | Cari berdasarkan nomor anggota atau NIM |
| Informasi pemasok tidak lengkap | Pembelian sulit ditindaklanjuti | Validasi data pemasok |
| Saldo poin tidak cocok | Penukaran poin salah | Catat poin diperoleh/digunakan dan validasi saldo |

## 11. Latihan Poin Loyalitas

- Setiap kelipatan penuh subtotal belanja Rp10.000 oleh anggota menghasilkan 1 poin sebelum diskon. Contoh: subtotal Rp25.000 menghasilkan 2 poin.
- 50 poin dapat ditukar dengan potongan harga Rp5.000.
- Penukaran hanya dapat dilakukan jika saldo poin mencukupi.
- Pembeli umum tidak memperoleh poin anggota.

## 12. Perbaikan Pernyataan Kebutuhan yang Kabur

| Pernyataan awal | Pernyataan yang lebih spesifik dan dapat diuji |
|---|---|
| “Data anggota harus aman.” | Akses ke NIM dan nomor HP dibatasi kepada petugas yang memerlukannya untuk tugas koperasi; pengguna tanpa hak akses harus ditolak. |
| “Sistem harus cepat mencari barang.” | Pencarian barang berdasarkan kode atau nama menampilkan hasil maksimal 2 detik pada lingkungan uji lokal yang normal. |
| “Laporan stok harus akurat.” | Setelah transaksi berhasil, stok sama dengan stok awal ditambah barang masuk dikurangi barang terjual dan tidak boleh negatif. |

## 13. Parameter P

Dua digit terakhir NIM adalah `55`, sehingga:

`P = (55 mod 9) + 1 = 2`

| Ketentuan praktikum | Perhitungan | Hasil |
|---|---|---|
| Parameter P | `(55 mod 9) + 1` | `2` |
| Maksimal item per transaksi jika ketentuan ini berlaku pada tugas | `P + 2` | `4 item` |
| Perkiraan transaksi harian jika ketentuan ini berlaku pada tugas | `40 + 5 × P` | `50 transaksi/hari` |

Nilai diskon anggota 5% dan aturan poin loyalitas pada skenario Kopma tetap mengikuti aturan bisnis yang tertulis di atas. Gunakan nilai P untuk parameter yang memang diminta oleh modul, dan jangan mengubah aturan skenario tanpa instruksi.

## 14. Ringkasan

Analisis kebutuhan Kopma mencakup anggota, barang, petugas, pemasok, penjualan, detail penjualan, pembelian, dan detail pembelian. Harga transaksi disimpan pada detail penjualan agar nota lama tidak berubah saat harga barang diperbarui. Aturan poin loyalitas ditambahkan sesuai latihan; rincian tabel dan kunci teknis ditetapkan pada tahap pemodelan berikutnya.

## 15. Checklist Sebelum Dikumpulkan

- [ ] Periksa isi dokumen terhadap instruksi Pertemuan 2.
- [ ] Pastikan tabel proses bisnis, entitas, aturan, KI, CRUD, dan kamus data konsisten.
- [ ] Pastikan dapat menjelaskan aturan poin loyalitas.
- [ ] Pastikan contoh nota fiktif dan analisis elemen datanya konsisten dengan entitas dan kamus data.
- [ ] Pastikan perhitungan P sesuai dua digit terakhir NIM.
- [ ] Simpan sebagai `p02_kebutuhan_data_kopma_25430055.md`.
- [ ] Commit dan push ke repositori GitHub.
