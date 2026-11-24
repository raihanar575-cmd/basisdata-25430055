-- ============================================================
-- P10: Kueri Relasional (JOIN) - Proyek Toko Daring
-- Nama : Raihan Ardani
-- NIM  : 25430055
-- Kelas: C
-- Database: toko_055
-- DBMS: MariaDB 10.4.x
--
-- Prasyarat:
-- 1. Struktur tabel P05 dan data sampel P06 sudah tersedia.
-- 2. Mode ONLY_FULL_GROUP_BY aktif.
--
-- Milestone:
-- Minimal 5 kueri lintas tabel yang menjawab KI proyek.
-- Minimal 1 kueri tiga tabel, 1 LEFT JOIN untuk data tanpa pasangan,
-- dan 1 SELF JOIN atau JOIN dengan agregasi.
-- Setiap kueri mencantumkan jalur relasi ERD pada komentar.
-- ============================================================

USE toko_055;

SET SESSION sql_mode =
    CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY');

SELECT @@sql_mode AS mode_sql_aktif;


-- ============================================================
-- KUERI 1 - Produk beserta kategori
-- KI-01: Informasi produk berdasarkan kategori.
-- Pertanyaan: Apa nama kategori dari setiap produk?
-- Jalur ERD: kategori (1) -> (N) produk
-- Jenis: INNER JOIN
-- Hasil yang diharapkan: Daftar produk dengan nama kategorinya.
-- ============================================================

SELECT
    pr.id_produk,
    pr.nama_produk,
    k.nama_kategori,
    pr.harga,
    pr.stok
FROM produk AS pr
INNER JOIN kategori AS k
    ON k.id_kategori = pr.id_kategori
ORDER BY
    k.nama_kategori,
    pr.nama_produk;


-- ============================================================
-- KUERI 2 - Pesanan beserta pelanggan
-- KI-03: Riwayat pesanan pelanggan.
-- Pertanyaan: Siapa pelanggan untuk setiap pesanan?
-- Jalur ERD: pelanggan (1) -> (N) pesanan
-- Jenis: INNER JOIN
-- Hasil yang diharapkan: Daftar nomor pesanan, tanggal,
-- nama pelanggan, dan total pesanan.
-- ============================================================

SELECT
    ps.id_pesanan,
    ps.tanggal_pesanan,
    pl.id_pelanggan,
    pl.nama AS nama_pelanggan,
    ps.total_pesanan
FROM pesanan AS ps
INNER JOIN pelanggan AS pl
    ON pl.id_pelanggan = ps.id_pelanggan
ORDER BY
    ps.tanggal_pesanan,
    ps.id_pesanan;


-- ============================================================
-- KUERI 3 - Rincian pesanan dengan nama pelanggan dan produk
-- KI-04: Informasi produk, jumlah, dan harga saat pembelian.
-- Pertanyaan: Produk apa yang dibeli pada setiap pesanan,
-- oleh pelanggan siapa, berapa jumlah dan harga saat dibeli?
-- Jalur ERD:
-- pelanggan (1) -> (N) pesanan
-- pesanan (1) -> (N) detail_pesanan
-- produk (1) -> (N) detail_pesanan
-- Jenis: INNER JOIN tiga tabel relasi (empat tabel total).
-- Hasil yang diharapkan: Detail item pesanan dengan pelanggan
-- dan nama produk.
-- ============================================================

SELECT
    ps.id_pesanan,
    pl.nama AS nama_pelanggan,
    pr.nama_produk,
    dp.jumlah,
    dp.harga_saat_pesanan,
    (dp.jumlah * dp.harga_saat_pesanan) AS subtotal
FROM detail_pesanan AS dp
INNER JOIN pesanan AS ps
    ON ps.id_pesanan = dp.id_pesanan
INNER JOIN pelanggan AS pl
    ON pl.id_pelanggan = ps.id_pelanggan
INNER JOIN produk AS pr
    ON pr.id_produk = dp.id_produk
ORDER BY
    ps.id_pesanan,
    pr.nama_produk;


-- ============================================================
-- KUERI 4 - Semua produk termasuk yang belum pernah dipesan
-- KI-01 dan KI-04: Informasi produk dan penjualan.
-- Pertanyaan: Produk mana saja yang sudah atau belum pernah
-- muncul dalam detail pesanan?
-- Jalur ERD: produk (1) -> (0..N) detail_pesanan
-- Jenis: LEFT JOIN
-- Hasil yang diharapkan: Semua produk tampil. Produk yang belum
-- pernah dipesan memiliki nilai kolom pesanan bernilai NULL.
-- ============================================================

SELECT
    pr.id_produk,
    pr.nama_produk,
    dp.id_detail_pesanan,
    dp.id_pesanan,
    dp.jumlah
FROM produk AS pr
LEFT JOIN detail_pesanan AS dp
    ON dp.id_produk = pr.id_produk
ORDER BY
    pr.id_produk,
    dp.id_pesanan;


-- ============================================================
-- KUERI 5 - Total kuantitas dan nilai penjualan per kategori
-- KI-01 dan KI-04: Informasi produk berdasarkan kategori serta
-- jumlah dan harga produk pada transaksi.
-- Pertanyaan: Berapa kuantitas dan nilai penjualan setiap kategori?
-- Jalur ERD:
-- kategori (1) -> (N) produk
-- produk (1) -> (N) detail_pesanan
-- Jenis: JOIN dengan agregasi.
-- Hasil yang diharapkan: Ringkasan kuantitas dan nilai penjualan
-- untuk setiap kategori yang memiliki produk terjual.
-- ============================================================

SELECT
    k.id_kategori,
    k.nama_kategori,
    SUM(dp.jumlah) AS total_kuantitas_terjual,
    SUM(dp.jumlah * dp.harga_saat_pesanan) AS total_nilai_penjualan
FROM kategori AS k
INNER JOIN produk AS pr
    ON pr.id_kategori = k.id_kategori
INNER JOIN detail_pesanan AS dp
    ON dp.id_produk = pr.id_produk
GROUP BY
    k.id_kategori,
    k.nama_kategori
ORDER BY
    total_nilai_penjualan DESC;


-- ============================================================
-- AKHIR P10
-- Jalankan setiap kueri secara terpisah untuk dokumentasi.
-- Simpan screenshot hasil INNER JOIN dan LEFT JOIN,
-- termasuk hasil yang menunjukkan produk tanpa pasangan.
-- ============================================================
