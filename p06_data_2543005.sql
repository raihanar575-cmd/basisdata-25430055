USE toko_055;

-- PERINGATAN: mengosongkan isi sembilan tabel proyek sebelum seed ulang.
-- Jalankan hanya jika data lama boleh diganti. DDL P05 harus sudah dijalankan.

DELETE FROM item_keranjang;
DELETE FROM detail_pesanan;
DELETE FROM pengiriman;
DELETE FROM pembayaran;
DELETE FROM keranjang;
DELETE FROM pesanan;
DELETE FROM produk;
DELETE FROM kategori;
DELETE FROM pelanggan;

ALTER TABLE item_keranjang AUTO_INCREMENT=1;
ALTER TABLE detail_pesanan AUTO_INCREMENT=1;
ALTER TABLE pengiriman AUTO_INCREMENT=1;
ALTER TABLE pembayaran AUTO_INCREMENT=1;
ALTER TABLE keranjang AUTO_INCREMENT=1;
ALTER TABLE pesanan AUTO_INCREMENT=1;
ALTER TABLE produk AUTO_INCREMENT=1;
ALTER TABLE kategori AUTO_INCREMENT=1;
ALTER TABLE pelanggan AUTO_INCREMENT=1;

INSERT INTO pelanggan (id_pelanggan,nama,email,no_telepon) VALUES
(1,'Nadia Prameswari','nadia.prameswari@example.com','081234560101'),
(2,'Bima Mahendra','bima.mahendra@example.com','081234560102'),
(3,'Salsa Kirana','salsa.kirana@example.com','081234560103'),
(4,'Daffa Wiratama','daffa.wiratama@example.com','081234560104'),
(5,'Intan Maharani','intan.maharani@example.com','081234560105');

INSERT INTO kategori (id_kategori,nama_kategori) VALUES
(1,'Perangkat Komputer'),(2,'Aksesori Digital'),(3,'Peralatan Menulis'),
(4,'Perlengkapan Kerja'),(5,'Penyimpanan Data');

INSERT INTO produk (id_produk,id_kategori,nama_produk,harga,stok) VALUES
(1,1,'Keyboard Mekanik Karsa K87',450000,24),
(2,1,'Mouse Optik Nusa M320',125000,40),
(3,1,'Headset Arunika H50',285000,18),
(4,2,'USB Hub Loka 4-Port',95000,35),
(5,2,'Mousepad Tenun Awan',65000,50),
(6,3,'Buku Catatan Aksara A5',38000,60),
(7,3,'Pulpen Gel Rona 0.5',12000,100),
(8,4,'Lampu Meja Nirmala',175000,20),
(9,5,'Flash Drive Sagara 64GB',110000,30),
(10,5,'SSD Eksternal Lintas 512GB',725000,12);

INSERT INTO keranjang (id_keranjang,id_pelanggan,tanggal_dibuat) VALUES
(1,1,'2026-10-01 09:15:00'),(2,2,'2026-10-01 10:20:00'),
(3,3,'2026-10-02 13:05:00'),(4,4,'2026-10-03 08:40:00'),
(5,5,'2026-10-03 15:30:00');

INSERT INTO item_keranjang (id_item_keranjang,id_produk,id_keranjang,jumlah) VALUES
(1,1,1,1),(2,5,1,2),(3,2,2,1),(4,4,2,1),(5,6,3,3),
(6,7,3,5),(7,3,4,1),(8,8,4,1),(9,9,5,2),(10,10,5,1);

-- 20 pesanan pada empat tanggal berbeda.
INSERT INTO pesanan (id_pesanan,id_pelanggan,tanggal_pesanan,alamat_pengiriman,ongkos_kirim,total_pesanan) VALUES
(1,1,'2026-10-04 09:10:00','Jl. Melati No. 12, Metro',15000,465000),
(2,2,'2026-10-04 10:25:00','Jl. Kenanga No. 8, Metro',12000,137000),
(3,3,'2026-10-04 13:40:00','Jl. Mawar No. 21, Bandar Lampung',18000,132000),
(4,4,'2026-10-04 16:05:00','Jl. Teratai No. 5, Bandar Lampung',15000,300000),
(5,5,'2026-10-04 18:20:00','Jl. Dahlia No. 17, Metro',12000,232000),
(6,1,'2026-10-05 08:15:00','Jl. Melati No. 12, Metro',15000,205000),
(7,2,'2026-10-05 09:45:00','Jl. Kenanga No. 8, Metro',12000,462000),
(8,3,'2026-10-05 11:30:00','Jl. Mawar No. 21, Bandar Lampung',18000,193000),
(9,4,'2026-10-05 14:10:00','Jl. Teratai No. 5, Bandar Lampung',15000,140000),
(10,5,'2026-10-05 17:50:00','Jl. Dahlia No. 17, Metro',12000,737000),
(11,1,'2026-10-06 08:30:00','Jl. Melati No. 12, Metro',15000,145000),
(12,2,'2026-10-06 10:00:00','Jl. Kenanga No. 8, Metro',12000,462000),
(13,3,'2026-10-06 12:20:00','Jl. Mawar No. 21, Bandar Lampung',18000,113000),
(14,4,'2026-10-06 15:45:00','Jl. Teratai No. 5, Bandar Lampung',15000,300000),
(15,5,'2026-10-06 19:05:00','Jl. Dahlia No. 17, Metro',12000,122000),
(16,1,'2026-10-07 09:00:00','Jl. Melati No. 12, Metro',15000,140000),
(17,2,'2026-10-07 11:15:00','Jl. Kenanga No. 8, Metro',12000,88000),
(18,3,'2026-10-07 13:25:00','Jl. Mawar No. 21, Bandar Lampung',18000,193000),
(19,4,'2026-10-07 16:40:00','Jl. Teratai No. 5, Bandar Lampung',15000,110000),
(20,5,'2026-10-07 19:10:00','Jl. Dahlia No. 17, Metro',12000,137000);

INSERT INTO detail_pesanan (id_detail_pesanan,id_pesanan,id_produk,jumlah,harga_saat_pesanan) VALUES
(1,1,1,1,450000),(2,2,2,1,125000),(3,3,6,3,38000),
(4,4,3,1,285000),(5,5,9,2,110000),(6,6,4,2,95000),
(7,7,1,1,450000),(8,8,8,1,175000),(9,9,2,1,125000),
(10,10,10,1,725000),(11,11,5,2,65000),(12,12,1,1,450000),
(13,13,4,1,95000),(14,14,3,1,285000),(15,15,9,1,110000),
(16,16,2,1,125000),(17,17,6,2,38000),(18,18,8,1,175000),
(19,19,4,1,95000),(20,20,2,1,125000);

-- ENUM persis sesuai DDL P05 yang diunggah.
INSERT INTO pembayaran (id_pembayaran,id_pesanan,status_pembayaran) VALUES
(1,1,'dibayar'),(2,2,'dibayar'),(3,3,'dibayar'),(4,4,'menunggu_verifikasi'),
(5,5,'dibayar'),(6,6,'dibayar'),(7,7,'dibayar'),(8,8,'dibayar'),
(9,9,'gagal'),(10,10,'dibayar'),(11,11,'dibayar'),(12,12,'dibayar'),
(13,13,'menunggu_verifikasi'),(14,14,'dibayar'),(15,15,'dibayar'),
(16,16,'dibayar'),(17,17,'dibayar'),(18,18,'dibayar'),
(19,19,'dibatalkan'),(20,20,'dibayar');

-- 15 pengiriman; hanya untuk pesanan dengan status pembayaran dibayar.
INSERT INTO pengiriman (id_pengiriman,id_pesanan,nomor_resi,status_pengiriman) VALUES
(1,1,'SAG-261004-0001','diterima'),
(2,2,'SAG-261004-0002','dikirim'),
(3,3,'SAG-261004-0003','dalam_perjalanan'),
(4,5,'SAG-261004-0005','diterima'),
(5,6,'SAG-261005-0006','dikirim'),
(6,7,'SAG-261005-0007','diproses'),
(7,8,'SAG-261005-0008','dalam_perjalanan'),
(8,10,'SAG-261005-0010','dikirim'),
(9,11,'SAG-261006-0011','diterima'),
(10,12,'SAG-261006-0012','diproses'),
(11,14,'SAG-261006-0014','dikirim'),
(12,15,'SAG-261006-0015','diproses'),
(13,16,'SAG-261007-0016','diproses'),
(14,18,'SAG-261007-0018','dalam_perjalanan'),
(15,20,'SAG-261007-0020','diproses');

SELECT 'pelanggan' AS tabel,COUNT(*) AS jumlah FROM pelanggan
UNION ALL SELECT 'kategori',COUNT(*) FROM kategori
UNION ALL SELECT 'produk',COUNT(*) FROM produk
UNION ALL SELECT 'keranjang',COUNT(*) FROM keranjang
UNION ALL SELECT 'item_keranjang',COUNT(*) FROM item_keranjang
UNION ALL SELECT 'pesanan',COUNT(*) FROM pesanan
UNION ALL SELECT 'detail_pesanan',COUNT(*) FROM detail_pesanan
UNION ALL SELECT 'pembayaran',COUNT(*) FROM pembayaran
UNION ALL SELECT 'pengiriman',COUNT(*) FROM pengiriman;

SELECT DATE(tanggal_pesanan) AS tanggal,COUNT(*) AS jumlah_pesanan
FROM pesanan GROUP BY DATE(tanggal_pesanan) ORDER BY tanggal;
