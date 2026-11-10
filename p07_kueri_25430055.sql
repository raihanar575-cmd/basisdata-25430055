-- ============================================================
-- P07: KUERI SATU TABEL (SINGLE-TABLE QUERIES) - TOKO DARING
-- Nama     : Raihan Ardani
-- NIM      : 25430055
-- Database : toko_055
-- DBMS     : MariaDB 10.4.x
--
-- Acuan:
-- - KI-01: Informasi produk berdasarkan kategori.
-- - KI-02: Isi keranjang dan jumlah item.
-- - KI-03: Riwayat pesanan pelanggan.
-- - KI-04: Rincian produk, jumlah, dan harga saat pembelian.
-- - KI-05: Status pembayaran dan pengiriman.
--
-- Catatan:
-- Setiap query di bawah hanya membaca SATU tabel.
-- Jalankan query satu per satu di phpMyAdmin.
-- ============================================================

USE toko_055;

-- ------------------------------------------------------------
-- KUERI 01
-- KI-01
-- Pertanyaan: Produk apa saja yang namanya mengandung kata "Mouse"?
-- Harapan: Menampilkan produk yang nama_produk-nya mengandung Mouse.
-- Fitur: LIKE
-- Tabel: produk
-- ------------------------------------------------------------
SELECT id_produk, nama_produk, harga, stok
FROM produk
WHERE nama_produk LIKE '%Mouse%';


-- ------------------------------------------------------------
-- KUERI 02
-- KI-01
-- Pertanyaan: Produk apa saja yang harganya antara Rp100.000 dan Rp500.000?
-- Harapan: Menampilkan produk dalam rentang harga tersebut.
-- Fitur: BETWEEN
-- Tabel: produk
-- ------------------------------------------------------------
SELECT id_produk, nama_produk, harga
FROM produk
WHERE harga BETWEEN 100000 AND 500000
ORDER BY harga ASC;


-- ------------------------------------------------------------
-- KUERI 03
-- KI-01
-- Pertanyaan: Produk apa saja yang berasal dari kategori dengan ID 1, 2, atau 3?
-- Harapan: Menampilkan produk dari kategori yang dipilih.
-- Fitur: IN
-- Tabel: produk
-- ------------------------------------------------------------
SELECT id_produk, nama_produk, id_kategori
FROM produk
WHERE id_kategori IN (1, 2, 3)
ORDER BY id_kategori, nama_produk;


-- ------------------------------------------------------------
-- KUERI 04
-- KI-01
-- Pertanyaan: Bagaimana klasifikasi ketersediaan stok setiap produk?
-- Harapan: Setiap produk diberi label stok rendah, sedang, atau banyak.
-- Fitur: CASE
-- Tabel: produk
-- ------------------------------------------------------------
SELECT
    id_produk,
    nama_produk,
    stok,
    CASE
        WHEN stok < 10 THEN 'Stok Rendah'
        WHEN stok <= 30 THEN 'Stok Sedang'
        ELSE 'Stok Banyak'
    END AS kategori_stok
FROM produk
ORDER BY stok ASC;


-- ------------------------------------------------------------
-- KUERI 05
-- KI-02
-- Pertanyaan: Item keranjang mana yang memiliki jumlah 1, 2, atau 3?
-- Harapan: Menampilkan item keranjang dengan jumlah sesuai daftar.
-- Fitur: IN
-- Tabel: item_keranjang
-- ------------------------------------------------------------
SELECT id_item_keranjang, id_keranjang, id_produk, jumlah
FROM item_keranjang
WHERE jumlah IN (1, 2, 3)
ORDER BY id_keranjang;


-- ------------------------------------------------------------
-- KUERI 06
-- KI-03
-- Pertanyaan: Pesanan apa saja yang dibuat pada tanggal 4 sampai 6 Oktober 2026?
-- Harapan: Menampilkan pesanan dalam rentang tanggal tersebut.
-- Fitur: BETWEEN dan fungsi DATE()
-- Tabel: pesanan
-- ------------------------------------------------------------
SELECT
    id_pesanan,
    id_pelanggan,
    tanggal_pesanan,
    DATE(tanggal_pesanan) AS tanggal
FROM pesanan
WHERE DATE(tanggal_pesanan)
      BETWEEN '2026-10-04' AND '2026-10-06'
ORDER BY tanggal_pesanan;


-- ------------------------------------------------------------
-- KUERI 07
-- KI-03
-- Pertanyaan: Pesanan apa saja yang dibuat oleh pelanggan dengan ID 1 atau 3?
-- Harapan: Menampilkan pesanan milik pelanggan yang dipilih.
-- Fitur: IN dan fungsi YEAR()
-- Tabel: pesanan
-- ------------------------------------------------------------
SELECT
    id_pesanan,
    id_pelanggan,
    tanggal_pesanan,
    YEAR(tanggal_pesanan) AS tahun_pesanan
FROM pesanan
WHERE id_pelanggan IN (1, 3)
ORDER BY tanggal_pesanan;


-- ------------------------------------------------------------
-- KUERI 08
-- KI-04
-- Pertanyaan: Detail pesanan mana yang memiliki jumlah pembelian lebih dari satu?
-- Harapan: Menampilkan detail dengan jumlah minimal 2 unit.
-- Fitur: BETWEEN
-- Tabel: detail_pesanan
-- ------------------------------------------------------------
SELECT
    id_detail_pesanan,
    id_pesanan,
    id_produk,
    jumlah,
    harga_saat_pesanan
FROM detail_pesanan
WHERE jumlah BETWEEN 2 AND 10
ORDER BY jumlah DESC;


-- ------------------------------------------------------------
-- KUERI 09
-- KI-05
-- Pertanyaan: Bagaimana pengelompokan status pembayaran setiap pesanan?
-- Harapan: Menampilkan status pembayaran beserta label statusnya.
-- Fitur: CASE dan IN
-- Tabel: pembayaran
-- ------------------------------------------------------------
SELECT
    id_pembayaran,
    id_pesanan,
    status_pembayaran,
    CASE
        WHEN status_pembayaran = 'dibayar' THEN 'Pembayaran Berhasil'
        WHEN status_pembayaran = 'menunggu_verifikasi' THEN 'Menunggu Verifikasi'
        WHEN status_pembayaran = 'belum_bayar' THEN 'Belum Dibayar'
        WHEN status_pembayaran IN ('gagal', 'dibatalkan') THEN 'Tidak Berhasil'
        ELSE 'Status Lain'
    END AS keterangan_status
FROM pembayaran
ORDER BY id_pesanan;


-- ------------------------------------------------------------
-- KUERI 10
-- KI-05
-- Pertanyaan: Pengiriman mana yang belum memiliki nomor resi?
-- Harapan: Menampilkan baris pengiriman dengan nomor_resi NULL.
-- Fitur: IS NULL dan fungsi string UPPER()
-- Tabel: pengiriman
-- ------------------------------------------------------------
SELECT
    id_pengiriman,
    id_pesanan,
    UPPER(status_pengiriman) AS status_pengiriman,
    nomor_resi
FROM pengiriman
WHERE nomor_resi IS NULL;


-- ============================================================
-- AKHIR P07
-- Semua query menggunakan satu tabel per perintah SELECT.
-- Ambil screenshot query dan hasilnya satu per satu.
-- ============================================================
