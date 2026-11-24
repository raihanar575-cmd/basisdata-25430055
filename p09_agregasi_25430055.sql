-- ============================================================
-- P09: LAPORAN AGREGASI DAN GROUP BY - TOKO DARING
-- Nama : Raihan Ardani
-- NIM  : 25430055
-- Kelas: C
-- DB   : toko_055
-- DBMS : MariaDB 10.4.x
--
-- Prasyarat: jalankan DDL P05 dan data sampel P06 terlebih dahulu.
-- Semua laporan dijalankan dengan ONLY_FULL_GROUP_BY aktif.
-- Catat hasil aktual setelah menjalankan setiap kueri.
-- ============================================================

USE toko_055;

SET SESSION sql_mode =
    CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY');

SELECT @@sql_mode AS mode_sql_aktif;


-- ============================================================
-- LAPORAN 1
-- KI-01: Informasi produk berdasarkan kategori.
-- Pertanyaan: Berapa jumlah produk, total stok, dan rata-rata
-- harga pada setiap kategori?
-- Hasil yang diharapkan: Ringkasan untuk setiap kategori.
-- ============================================================

SELECT
    k.id_kategori,
    k.nama_kategori,
    COUNT(p.id_produk) AS jumlah_produk,
    COALESCE(SUM(p.stok), 0) AS total_stok,
    ROUND(AVG(p.harga), 2) AS rata_rata_harga
FROM kategori AS k
LEFT JOIN produk AS p
    ON p.id_kategori = k.id_kategori
GROUP BY
    k.id_kategori,
    k.nama_kategori
ORDER BY
    k.id_kategori;


-- ============================================================
-- LAPORAN 2
-- KI-03: Riwayat pesanan pelanggan.
-- Pertanyaan: Berapa jumlah pesanan dan total nilai pesanan
-- setiap pelanggan yang memiliki minimal tiga pesanan?
-- Hasil yang diharapkan: Pelanggan dengan >= 3 pesanan.
-- HAVING menyaring hasil pengelompokan.
-- ============================================================

SELECT
    pl.id_pelanggan,
    pl.nama,
    COUNT(ps.id_pesanan) AS jumlah_pesanan,
    SUM(ps.total_pesanan) AS total_nilai_pesanan,
    ROUND(AVG(ps.total_pesanan), 2) AS rata_rata_pesanan
FROM pelanggan AS pl
INNER JOIN pesanan AS ps
    ON ps.id_pelanggan = pl.id_pelanggan
GROUP BY
    pl.id_pelanggan,
    pl.nama
HAVING COUNT(ps.id_pesanan) >= 3
ORDER BY
    total_nilai_pesanan DESC;


-- ============================================================
-- LAPORAN 3
-- KI-04: Ringkasan nilai pesanan berdasarkan tanggal.
-- Pertanyaan: Berapa jumlah transaksi dan total omzet per
-- tanggal, serta berapa total keseluruhan omzet?
-- Hasil yang diharapkan: Ringkasan per tanggal dan grand total.
-- Baris tanggal NULL dari WITH ROLLUP adalah total keseluruhan.
-- ============================================================

SELECT
    DATE(tanggal_pesanan) AS tanggal,
    COUNT(id_pesanan) AS jumlah_pesanan,
    SUM(total_pesanan) AS total_omzet
FROM pesanan
GROUP BY DATE(tanggal_pesanan) WITH ROLLUP;


-- ============================================================
-- LAPORAN 4
-- KI-05: Ringkasan status pembayaran dan pengiriman.
-- Pertanyaan: Berapa jumlah pesanan untuk setiap kombinasi
-- status pembayaran dan status pengiriman?
-- Hasil yang diharapkan: Ringkasan per kombinasi status.
-- Pesanan tanpa data pengiriman tetap muncul dengan NULL.
-- ============================================================

SELECT
    pb.status_pembayaran,
    pg.status_pengiriman,
    COUNT(ps.id_pesanan) AS jumlah_pesanan
FROM pesanan AS ps
INNER JOIN pembayaran AS pb
    ON pb.id_pesanan = ps.id_pesanan
LEFT JOIN pengiriman AS pg
    ON pg.id_pesanan = ps.id_pesanan
GROUP BY
    pb.status_pembayaran,
    pg.status_pengiriman
ORDER BY
    pb.status_pembayaran,
    pg.status_pengiriman;


-- ============================================================
-- LAPORAN 5
-- KI-04: Ringkasan jumlah dan nilai produk yang terjual.
-- Pertanyaan: Berapa total kuantitas dan nilai penjualan
-- setiap produk berdasarkan detail pesanan?
-- Hasil yang diharapkan: Ringkasan per produk yang dipesan.
-- Produk tanpa detail pesanan tidak ditampilkan.
-- ============================================================

SELECT
    pr.id_produk,
    pr.nama_produk,
    SUM(dp.jumlah) AS total_kuantitas_terjual,
    SUM(dp.jumlah * dp.harga_saat_pesanan) AS total_nilai_penjualan
FROM produk AS pr
INNER JOIN detail_pesanan AS dp
    ON dp.id_produk = pr.id_produk
GROUP BY
    pr.id_produk,
    pr.nama_produk
ORDER BY
    total_kuantitas_terjual DESC,
    pr.nama_produk ASC;


-- ============================================================
-- AKHIR P09
-- Simpan screenshot SQL dan hasil untuk setiap laporan.
-- Catat hasil aktual pada laporan praktikum.
-- ============================================================
