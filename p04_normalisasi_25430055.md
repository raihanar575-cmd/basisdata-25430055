# Normalisasi Proyek Toko Daring — P04

**Nama:** Raihan Ardani  
**NIM:** 25430055  
**Kelas:** C  
**Database proyek:** `toko_055`  
**Acuan:** dokumen kebutuhan data P02 dan ERD konseptual P03.

Dokumen ini menerapkan normalisasi pada proyek Toko Daring. Dependensi fungsional diturunkan dari aturan bisnis P02 dan atribut pada ERD P03. Contoh data hanya membantu menjelaskan kasus, bukan menjadi bukti tunggal dependensi fungsional.

## 1. Relasi awal: UNF

Untuk memperlihatkan grup berulang, data pesanan dapat digambarkan secara konseptual sebagai berikut:

`PESANAN_UNF(id_pesanan, tanggal_pesanan, id_pelanggan, nama, email, alamat_pengiriman, ongkos_kirim, {id_produk, nama_produk, nama_kategori, jumlah, harga_saat_pesanan, subtotal}, total_pesanan, status_pembayaran, status_pengiriman)`

Grup `{...}` mewakili rincian produk yang dapat berulang dalam satu pesanan. Bentuk ini belum memenuhi 1NF karena satu pesanan dapat memiliki beberapa rincian produk dalam satu grup berulang.

## 2. Perubahan UNF ke 1NF

Grup berulang diuraikan sehingga setiap baris mewakili satu produk pada satu pesanan:

`PESANAN_1NF(id_pesanan, id_produk, tanggal_pesanan, id_pelanggan, nama_pelanggan, email_pelanggan, alamat_pengiriman, ongkos_kirim, nama_produk, nama_kategori, jumlah, harga_saat_pesanan, subtotal, total_pesanan, status_pembayaran, status_pengiriman)`

Pada bentuk ini, setiap kolom berisi satu nilai dan setiap baris mencatat satu produk dalam satu pesanan. Kombinasi `(id_pesanan, id_produk)` dapat menjadi kunci kandidat **hanya jika satu produk dicatat maksimal satu kali dalam satu pesanan**. Jika aturan proyek tidak menjamin hal tersebut, jangan menyatakan kombinasi itu unik; gunakan identitas baris detail seperti `id_detail_pesanan` dan tentukan kunci kandidat berdasarkan aturan yang benar-benar digunakan.

## 3. Dependensi fungsional

FD berikut disusun berdasarkan identitas entitas pada ERD P03 dan aturan bisnis P02. Untuk tabel pembayaran dan pengiriman, FD yang memakai `id_pesanan` sebagai penentu berlaku karena AB-09 menetapkan batasan satu pembayaran per pesanan dan paling banyak satu pengiriman per pesanan.

| FD | Relasi | Dependensi fungsional | Dasar/ketentuan |
|---|---|---|---|
| FD-01 | Pelanggan | `id_pelanggan → nama, email, no_telepon` | AB-01: ID pelanggan unik; atribut mengikuti entitas Pelanggan pada P02/P03 |
| FD-02 | Pelanggan | `email → id_pelanggan` | AB-02: email unik untuk setiap akun; berlaku jika email wajib terisi dan unik |
| FD-03 | Kategori | `id_kategori → nama_kategori` | ID kategori adalah identitas kategori pada ERD P03 |
| FD-04 | Produk | `id_produk → nama_produk, harga, stok, id_kategori` | ID produk mengidentifikasi satu produk dan atribut katalog saat ini; AB-03 mengatur hubungan produk-kategori |
| FD-05 | Keranjang | `id_keranjang → id_pelanggan, tanggal_dibuat` | ID keranjang mengidentifikasi satu keranjang pada ERD P03; AB-04 mengatur satu keranjang aktif per pelanggan |
| FD-06 | Item Keranjang | `id_item_keranjang → id_keranjang, id_produk, jumlah` | ID item mengidentifikasi satu baris item keranjang pada ERD P03 |
| FD-07 | Pesanan | `id_pesanan → id_pelanggan, tanggal_pesanan, alamat_pengiriman, ongkos_kirim, total_pesanan` | AB-05: pesanan dimiliki satu pelanggan; AB-08: alamat dan ongkos kirim disimpan pada pesanan; `total_pesanan` mengikuti keputusan nilai turunan di Bagian 7 |
| FD-08 | Detail Pesanan | `id_detail_pesanan → id_pesanan, id_produk, jumlah, harga_saat_pesanan` | AB-06 dan AB-07: pesanan memiliki detail; detail menyimpan produk, jumlah, dan harga saat pemesanan |
| FD-09 | Pembayaran | `id_pembayaran → id_pesanan, status_pembayaran` | ID pembayaran mengidentifikasi satu catatan pembayaran |
| FD-10 | Pembayaran | `id_pesanan → id_pembayaran, status_pembayaran` | AB-09: setiap pesanan memiliki satu catatan pembayaran; `id_pesanan` harus unik pada tabel Pembayaran |
| FD-11 | Pengiriman | `id_pengiriman → id_pesanan, nomor_resi, status_pengiriman` | ID pengiriman mengidentifikasi satu catatan pengiriman |
| FD-12 | Pengiriman | `id_pesanan → id_pengiriman, nomor_resi, status_pengiriman` | AB-09: paling banyak satu catatan pengiriman untuk satu pesanan; berlaku untuk pesanan yang memiliki catatan pengiriman dan `id_pesanan` unik pada tabel Pengiriman |

**Catatan pemeriksaan:** `id_produk` tidak menentukan `harga_saat_pesanan`. Harga katalog saat ini berada di Produk, sedangkan harga historis disimpan pada Detail Pesanan karena dapat berbeda dari harga katalog (AB-07). FD-02 harus dibaca bersama syarat email wajib dan unik. Pada skema final, batasan unik untuk `PEMBAYARAN.id_pesanan` dan `PENGIRIMAN.id_pesanan` mendukung FD-10 dan FD-12.

**Konsistensi kamus data:** ERD P03 memuat `no_telepon` pada Pelanggan dan `tanggal_dibuat` pada Keranjang, tetapi keduanya tidak tercantum di daftar 34 elemen kamus data P02 versi yang diperiksa. Perbarui kamus data P02 agar sama dengan ERD, atau dokumentasikan jika atribut tersebut sengaja diubah.

## 4. Perubahan 1NF ke 2NF

Pada relasi gabungan 1NF, jika `(id_pesanan, id_produk)` memang merupakan kunci kandidat, beberapa atribut bergantung hanya pada sebagian kunci:

- Atribut pesanan seperti `tanggal_pesanan`, `id_pelanggan`, `alamat_pengiriman`, dan `ongkos_kirim` bergantung pada `id_pesanan`.
- Atribut produk seperti `nama_produk` dan `nama_kategori` bergantung pada `id_produk`.
- `jumlah` dan `harga_saat_pesanan` bergantung pada baris detail pesanan, bukan hanya pada produk atau pesanan secara terpisah.

Untuk menghindari ketergantungan parsial, data dipisah berdasarkan entitas. Jika kombinasi `(id_pesanan, id_produk)` tidak dijamin unik, gunakan `id_detail_pesanan` sebagai identitas baris dan jelaskan kunci kandidat yang digunakan; jangan membuat asumsi keunikan tanpa dasar aturan bisnis.

Hasil pemisahan relasi:

- `PELANGGAN(id_pelanggan, nama, email, no_telepon)`
- `KATEGORI(id_kategori, nama_kategori)`
- `PRODUK(id_produk, nama_produk, harga, stok, id_kategori)`
- `KERANJANG(id_keranjang, id_pelanggan, tanggal_dibuat)`
- `ITEM_KERANJANG(id_item_keranjang, id_keranjang, id_produk, jumlah)`
- `PESANAN(id_pesanan, id_pelanggan, tanggal_pesanan, alamat_pengiriman, ongkos_kirim, total_pesanan)`
- `DETAIL_PESANAN(id_detail_pesanan, id_pesanan, id_produk, jumlah, harga_saat_pesanan)`
- `PEMBAYARAN(id_pembayaran, id_pesanan, status_pembayaran)`
- `PENGIRIMAN(id_pengiriman, id_pesanan, nomor_resi, status_pengiriman)`

## 5. Perubahan 2NF ke 3NF

3NF menghindari ketergantungan transitif atribut nonkunci pada kunci. Contohnya, `nama` dan `email` pelanggan tidak disalin ke setiap baris Pesanan karena identitas pelanggan menentukan atribut profilnya. `nama_kategori` disimpan di Kategori, sedangkan Produk menyimpan `id_kategori` sebagai referensi.

### Skema relasional usulan 3NF

1. `PELANGGAN(id_pelanggan PK, nama, email UNIQUE, no_telepon)`
2. `KATEGORI(id_kategori PK, nama_kategori)`
3. `PRODUK(id_produk PK, nama_produk, harga, stok, id_kategori FK)`
4. `KERANJANG(id_keranjang PK, id_pelanggan FK, tanggal_dibuat)`
5. `ITEM_KERANJANG(id_item_keranjang PK, id_keranjang FK, id_produk FK, jumlah)`
6. `PESANAN(id_pesanan PK, id_pelanggan FK, tanggal_pesanan, alamat_pengiriman, ongkos_kirim, total_pesanan)`
7. `DETAIL_PESANAN(id_detail_pesanan PK, id_pesanan FK, id_produk FK, jumlah, harga_saat_pesanan)`
8. `PEMBAYARAN(id_pembayaran PK, id_pesanan FK UNIQUE, status_pembayaran)`
9. `PENGIRIMAN(id_pengiriman PK, id_pesanan FK UNIQUE, nomor_resi, status_pengiriman)`

`UNIQUE` pada `PEMBAYARAN.id_pesanan` mencerminkan satu pembayaran per pesanan (AB-09). `UNIQUE` pada `PENGIRIMAN.id_pesanan` mencerminkan paling banyak satu pengiriman per pesanan (AB-09). Kewajiban setiap pesanan memiliki minimal satu detail (AB-06) dan aturan satu keranjang aktif per pelanggan (AB-04) memerlukan validasi/aturan tambahan; keduanya tidak otomatis ditegakkan hanya dengan FK biasa.

## 6. Pemeriksaan BCNF

BCNF mensyaratkan setiap penentu pada dependensi fungsional merupakan kunci kandidat. Berdasarkan FD di Bagian 3:

- `id_pelanggan`, `id_kategori`, `id_produk`, `id_keranjang`, `id_item_keranjang`, `id_pesanan`, `id_detail_pesanan`, `id_pembayaran`, dan `id_pengiriman` dirancang sebagai kunci primer tabel masing-masing.
- `email` merupakan kunci kandidat alternatif pada Pelanggan jika email wajib dan dibatasi `UNIQUE`.
- `id_pesanan` merupakan kunci kandidat pada Pembayaran jika dibatasi `UNIQUE`, sesuai AB-09.
- `id_pesanan` merupakan kunci kandidat pada Pengiriman jika dibatasi `UNIQUE`, sesuai batas paling banyak satu pengiriman per pesanan (AB-09).

Dengan batasan tersebut, setiap FD yang didaftarkan memiliki penentu berupa kunci kandidat. Maka skema usulan memenuhi pemeriksaan BCNF berdasarkan FD dan aturan yang dicantumkan di sini. Hasil ini perlu ditinjau ulang jika aturan bisnis atau batasan uniknya diubah.

## 7. Keputusan nilai turunan

| Nilai | Keputusan | Alasan |
|---|---|---|
| `subtotal` (`jumlah × harga_saat_pesanan`) | Tidak disimpan sebagai kolom pada skema konseptual; dihitung saat diperlukan | Nilainya dapat dihitung dari jumlah dan harga satuan historis sehingga menghindari perbedaan nilai akibat pembaruan yang tidak konsisten |
| `total_pesanan` | Disimpan sebagai snapshot akhir transaksi | Atribut ini tercantum pada kebutuhan P02. Nilainya harus sesuai dengan jumlah subtotal detail ditambah `ongkos_kirim` (dan dikurangi diskon jika aturan diskon diterapkan). Proses pembuatan pesanan harus menghitung dan menyimpan nilai ini secara konsisten |
| `harga_saat_pesanan` | Disimpan | Menjaga harga historis transaksi agar tidak berubah saat harga katalog diperbarui (AB-07) |
| `jumlah` | Disimpan | Nilai kuantitas yang dipilih/dibeli, bukan hasil perhitungan dari atribut lain |
| `ongkos_kirim` | Disimpan | AB-08 secara eksplisit menetapkan ongkos kirim disimpan pada pesanan dan nilainya dapat berubah pada transaksi yang berbeda |

Keputusan di atas mempertahankan `total_pesanan` seperti yang didefinisikan di P02 dan menegaskan bahwa aplikasi harus menjaga konsistensinya. Jika kelak total diputuskan untuk dihitung saja, keputusan tersebut harus diterapkan secara konsisten pada dokumen kebutuhan data dan skema relasional.

## 8. Anomali yang dikurangi

- **Anomali ubah:** nama pelanggan dan kategori disimpan pada tabel master masing-masing, bukan disalin di banyak baris transaksi atau produk.
- **Anomali sisip:** data pelanggan, kategori, atau produk dapat dicatat tanpa harus membuat pesanan, selama aturan relasi yang berlaku mengizinkannya.
- **Anomali hapus:** menghapus satu detail transaksi tidak mengharuskan penghapusan data master produk atau pelanggan.

## 9. Catatan perubahan ERD

Skema usulan mempertahankan sembilan entitas yang sudah ada pada ERD P03. Normalisasi ini memperjelas kunci alternatif/keunikan pada `email`, `PEMBAYARAN.id_pesanan`, dan `PENGIRIMAN.id_pesanan`. Jika perubahan tersebut diterapkan ke diagram, perbarui ERD dan catat perubahan yang benar-benar dibuat. ERD fisik dengan tipe data dan constraint teknis menjadi fokus P05.

## 10. Checklist sebelum dikumpulkan

- [x] Cocokkan FD dan kode AB dengan aturan bisnis P02.
- [x] Pastikan `email` wajib dan unik jika dipakai sebagai kunci kandidat alternatif.
- [x] Pastikan `id_pesanan` unik pada tabel Pembayaran dan Pengiriman sesuai AB-09.
- [x] Verifikasi asumsi kunci kandidat pada relasi 1NF.
- [x] Tampilkan tahapan UNF, 1NF, 2NF, dan 3NF.
- [x] Pastikan pemeriksaan BCNF didukung oleh FD dan kunci kandidat yang dicantumkan.
- [x] Sertakan alasan penyimpanan/penghitungan nilai turunan.
- [x] Ambil screenshot hasil tabel tahapan normalisasi dan masukkan ke laporan P04.
