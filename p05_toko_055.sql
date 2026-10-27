-- ============================================================
-- P05: DDL ERD FISIK TOKO DARING
-- Database : toko_055
-- DBMS     : MariaDB 10.4.x
-- Storage  : InnoDB
-- Catatan  : Nilai ENUM ditentukan berdasarkan asumsi karena
--            daftar nilai ENUM tidak terlihat pada ERD.
-- ============================================================

CREATE DATABASE IF NOT EXISTS toko_055
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE toko_055;

-- 1. Pelanggan
CREATE TABLE IF NOT EXISTS pelanggan (
    id_pelanggan INT NOT NULL AUTO_INCREMENT,
    nama         VARCHAR(100) NOT NULL,
    email        VARCHAR(150) NOT NULL,
    no_telepon   VARCHAR(20) NULL,
    CONSTRAINT pk_pelanggan PRIMARY KEY (id_pelanggan),
    CONSTRAINT uq_pelanggan_email UNIQUE (email)
) ENGINE=InnoDB;

-- 2. Kategori
CREATE TABLE IF NOT EXISTS kategori (
    id_kategori   INT NOT NULL AUTO_INCREMENT,
    nama_kategori VARCHAR(100) NOT NULL,
    CONSTRAINT pk_kategori PRIMARY KEY (id_kategori)
) ENGINE=InnoDB;

-- 3. Produk
CREATE TABLE IF NOT EXISTS produk (
    id_produk   INT NOT NULL AUTO_INCREMENT,
    id_kategori INT NOT NULL,
    nama_produk VARCHAR(150) NOT NULL,
    harga       DECIMAL(12,2) NOT NULL,
    stok        INT NOT NULL,
    CONSTRAINT pk_produk PRIMARY KEY (id_produk),
    CONSTRAINT chk_produk_harga CHECK (harga >= 0),
    CONSTRAINT chk_produk_stok CHECK (stok >= 0),
    CONSTRAINT fk_produk_kategori
        FOREIGN KEY (id_kategori) REFERENCES kategori (id_kategori)
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 4. Keranjang
CREATE TABLE IF NOT EXISTS keranjang (
    id_keranjang  INT NOT NULL AUTO_INCREMENT,
    id_pelanggan  INT NOT NULL,
    tanggal_dibuat DATETIME NOT NULL,
    CONSTRAINT pk_keranjang PRIMARY KEY (id_keranjang),
    CONSTRAINT fk_keranjang_pelanggan
        FOREIGN KEY (id_pelanggan) REFERENCES pelanggan (id_pelanggan)
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 5. Item keranjang (entitas asosiatif)
CREATE TABLE IF NOT EXISTS item_keranjang (
    id_item_keranjang INT NOT NULL AUTO_INCREMENT,
    id_produk         INT NOT NULL,
    id_keranjang      INT NOT NULL,
    jumlah            INT NOT NULL,
    CONSTRAINT pk_item_keranjang PRIMARY KEY (id_item_keranjang),
    CONSTRAINT chk_item_keranjang_jumlah CHECK (jumlah > 0),
    CONSTRAINT fk_item_keranjang_produk
        FOREIGN KEY (id_produk) REFERENCES produk (id_produk)
        ON UPDATE CASCADE,
    CONSTRAINT fk_item_keranjang_keranjang
        FOREIGN KEY (id_keranjang) REFERENCES keranjang (id_keranjang)
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 6. Pesanan
CREATE TABLE IF NOT EXISTS pesanan (
    id_pesanan        INT NOT NULL AUTO_INCREMENT,
    id_pelanggan      INT NOT NULL,
    tanggal_pesanan   DATETIME NOT NULL,
    alamat_pengiriman VARCHAR(255) NOT NULL,
    ongkos_kirim      DECIMAL(12,2) NOT NULL,
    total_pesanan     DECIMAL(12,2) NOT NULL,
    CONSTRAINT pk_pesanan PRIMARY KEY (id_pesanan),
    CONSTRAINT chk_pesanan_ongkos_kirim CHECK (ongkos_kirim >= 0),
    CONSTRAINT chk_pesanan_total CHECK (total_pesanan >= 0),
    CONSTRAINT fk_pesanan_pelanggan
        FOREIGN KEY (id_pelanggan) REFERENCES pelanggan (id_pelanggan)
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 7. Detail pesanan (entitas asosiatif)
CREATE TABLE IF NOT EXISTS detail_pesanan (
    id_detail_pesanan  INT NOT NULL AUTO_INCREMENT,
    id_pesanan         INT NOT NULL,
    id_produk          INT NOT NULL,
    jumlah             INT NOT NULL,
    harga_saat_pesanan DECIMAL(12,2) NOT NULL,
    CONSTRAINT pk_detail_pesanan PRIMARY KEY (id_detail_pesanan),
    CONSTRAINT chk_detail_pesanan_jumlah CHECK (jumlah > 0),
    CONSTRAINT chk_detail_pesanan_harga CHECK (harga_saat_pesanan >= 0),
    CONSTRAINT fk_detail_pesanan_pesanan
        FOREIGN KEY (id_pesanan) REFERENCES pesanan (id_pesanan)
        ON UPDATE CASCADE,
    CONSTRAINT fk_detail_pesanan_produk
        FOREIGN KEY (id_produk) REFERENCES produk (id_produk)
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 8. Pembayaran
-- Asumsi ENUM status_pembayaran: belum_bayar, menunggu_verifikasi,
-- dibayar, gagal, dibatalkan. Sesuaikan dengan aturan bisnis P05 bila perlu.
CREATE TABLE IF NOT EXISTS pembayaran (
    id_pembayaran    INT NOT NULL AUTO_INCREMENT,
    id_pesanan       INT NOT NULL,
    status_pembayaran ENUM(
        'belum_bayar',
        'menunggu_verifikasi',
        'dibayar',
        'gagal',
        'dibatalkan'
    ) NOT NULL,
    CONSTRAINT pk_pembayaran PRIMARY KEY (id_pembayaran),
    CONSTRAINT uq_pembayaran_pesanan UNIQUE (id_pesanan),
    CONSTRAINT fk_pembayaran_pesanan
        FOREIGN KEY (id_pesanan) REFERENCES pesanan (id_pesanan)
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 9. Pengiriman
-- Asumsi ENUM status_pengiriman: belum_dikirim, diproses, dikirim,
-- dalam_perjalanan, diterima, gagal. Sesuaikan dengan aturan bisnis P05.
CREATE TABLE IF NOT EXISTS pengiriman (
    id_pengiriman   INT NOT NULL AUTO_INCREMENT,
    id_pesanan      INT NOT NULL,
    nomor_resi      VARCHAR(50) NULL,
    status_pengiriman ENUM(
        'belum_dikirim',
        'diproses',
        'dikirim',
        'dalam_perjalanan',
        'diterima',
        'gagal'
    ) NOT NULL,
    CONSTRAINT pk_pengiriman PRIMARY KEY (id_pengiriman),
    CONSTRAINT uq_pengiriman_pesanan UNIQUE (id_pesanan),
    CONSTRAINT fk_pengiriman_pesanan
        FOREIGN KEY (id_pesanan) REFERENCES pesanan (id_pesanan)
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Verifikasi struktur setelah script dijalankan
SHOW TABLES;
SHOW CREATE TABLE pelanggan;
SHOW CREATE TABLE produk;
SHOW CREATE TABLE keranjang;
SHOW CREATE TABLE item_keranjang;
SHOW CREATE TABLE pesanan;
SHOW CREATE TABLE detail_pesanan;
SHOW CREATE TABLE pembayaran;
SHOW CREATE TABLE pengiriman;
