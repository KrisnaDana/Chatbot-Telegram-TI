/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.4.22-MariaDB : Database - officialti_bot
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `barang` */

DROP TABLE IF EXISTS `barang`;

CREATE TABLE `barang` (
  `id_barang` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) NOT NULL,
  `harga` varchar(255) NOT NULL,
  `jumlah` int(11) NOT NULL DEFAULT 0,
  `id_toko` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id_barang`),
  KEY `id_toko` (`id_toko`),
  CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`id_toko`) REFERENCES `toko` (`id_toko`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `barang` */

insert  into `barang`(`id_barang`,`nama`,`harga`,`jumlah`,`id_toko`) values 
(1,'Nasi Goreng','12000',10,1),
(2,'Baju Sate','120000',12,3),
(3,'Baju Wibu','120000',-4,3),
(4,'Susu Indomilk','9000',3,4);

/*Table structure for table `inbox` */

DROP TABLE IF EXISTS `inbox`;

CREATE TABLE `inbox` (
  `id_inbox` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pesan` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_inbox`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4;

/*Data for the table `inbox` */

insert  into `inbox`(`id_inbox`,`pesan`,`timestamp`) values 
(1,'/start','2022-05-27 14:18:39'),
(2,'/start','2022-05-27 14:18:39'),
(3,'/help','2022-05-27 14:18:39'),
(4,'/list_toko','2022-05-27 14:18:39'),
(5,'/list_pesanan','2022-05-27 14:18:39'),
(6,'3','2022-05-27 14:18:39'),
(7,'/list_pesanan','2022-05-27 14:18:39'),
(8,'/upload_bukti_pembayaran','2022-05-27 14:18:39'),
(9,'3','2022-05-27 14:18:39'),
(10,'/verif_pesanan','2022-05-27 14:18:39'),
(11,'3','2022-05-27 14:18:39'),
(12,'/verif_pesanan','2022-05-27 14:18:39'),
(13,'3','2022-05-27 14:18:39'),
(14,'/verif_pesanan','2022-05-27 14:18:39'),
(15,'3','2022-05-27 14:18:39'),
(16,'/start','2022-05-27 14:18:39'),
(17,'/daftar_toko','2022-05-27 14:18:39'),
(18,'toko testing','2022-05-27 14:18:39'),
(19,'/tambah_barang','2022-05-27 14:18:39'),
(20,'4','2022-05-27 14:18:39'),
(21,'Susu Indomilk','2022-05-27 14:18:39'),
(22,'3','2022-05-27 14:18:39'),
(23,'9000','2022-05-27 14:18:39'),
(24,'/help','2022-05-27 14:18:39'),
(25,'/list_pesanan','2022-05-27 14:18:39'),
(26,'4','2022-05-27 14:18:39'),
(27,'/verifikasi_pesanan','2022-05-27 14:18:39'),
(28,'4','2022-05-27 14:18:39'),
(29,'/list_pesanan','2022-05-27 14:19:09'),
(30,'4','2022-05-27 14:19:19'),
(31,'/verifikasi_pesanan','2022-05-27 14:19:22'),
(32,'5','2022-05-27 14:20:00'),
(33,'/verifikasi_pesanan','2022-05-27 14:20:03'),
(34,'/help','2022-05-27 14:21:54'),
(35,'/list_toko','2022-05-27 14:21:56'),
(36,'/list_barang','2022-05-27 14:22:00'),
(37,'4','2022-05-27 14:22:04'),
(38,'/buat_pesanan','2022-05-27 14:22:11'),
(39,'4','2022-05-27 14:22:16'),
(40,'4','2022-05-27 14:22:21'),
(41,'1','2022-05-27 14:22:28'),
(42,'/upload_bukti_pembayaran','2022-05-27 14:22:33'),
(43,'10','2022-05-27 14:22:41');

/*Table structure for table `outbox` */

DROP TABLE IF EXISTS `outbox`;

CREATE TABLE `outbox` (
  `id_outbox` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pesan` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_outbox`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4;

/*Data for the table `outbox` */

insert  into `outbox`(`id_outbox`,`pesan`,`timestamp`) values 
(1,'BERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/list_toko - UNTUK MELIHAT DAFTAR TOKO\n/list_barang - UNTUK MELIHAT LIST BARANG\n/buat_pesanan - UNTUK MEMBUAT PESANAN\n/upload_bukti_pembayaran - UNTUK UPLOAD BUKTI PEMBAYARAN','2022-05-27 14:18:56'),
(2,'BERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/list_toko - UNTUK MELIHAT DAFTAR TOKO\n/list_barang - UNTUK MELIHAT LIST BARANG\n/buat_pesanan - UNTUK MEMBUAT PESANAN\n/upload_bukti_pembayaran - UNTUK UPLOAD BUKTI PEMBAYARAN','2022-05-27 14:18:56'),
(3,'BERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/list_toko - UNTUK MELIHAT DAFTAR TOKO\n/list_barang - UNTUK MELIHAT LIST BARANG\n/buat_pesanan - UNTUK MEMBUAT PESANAN\n/upload_bukti_pembayaran - UNTUK UPLOAD BUKTI PEMBAYARAN','2022-05-27 14:18:56'),
(4,'BERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/list_toko - UNTUK MELIHAT DAFTAR TOKO\n/list_barang - UNTUK MELIHAT LIST BARANG\n/buat_pesanan - UNTUK MEMBUAT PESANAN\n/upload_bukti_pembayaran - UNTUK UPLOAD BUKTI PEMBAYARAN','2022-05-27 14:18:56'),
(5,'BERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/list_toko - UNTUK MELIHAT DAFTAR TOKO\n/list_barang - UNTUK MELIHAT LIST BARANG\n/buat_pesanan - UNTUK MEMBUAT PESANAN\n/upload_bukti_pembayaran - UNTUK UPLOAD BUKTI PEMBAYARAN','2022-05-27 14:18:56'),
(6,'\nLIST TOKO YANG TERSEDIA :\n\n- Kedai Runcit\n- Kedai Uncle Muthu\n- Toko Test\n\n    ','2022-05-27 14:18:56'),
(7,'\nLIST PESANAN TOKO (ID_Toko):\n1. Kedai Runcit\n2. Kedai Uncle Muthu\n3. Toko Test\n\nPILIH ID TOKO YANG INGIN DILIHAT LIST PESANANNYA\n    ','2022-05-27 14:18:56'),
(8,'\n============================================\nLIST PEMESANAN:\n[Tanggal] [Barang] [Jumlah] [Total] [Status]\n============================================\n- [2022-05-27] [Baju Wibu] [1] [3] [verified]\n- [2022-05-27] [Baju Wibu] [10000000] [3] [unverified]\n- [2022-05-27] [Baju Wibu] [2] [3] [unverified]\n- [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n- [2022-05-27] [Baju Wibu] [12] [3] [unverified]\n- [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n- [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n- [2022-05-27] [Baju Wibu] [360000] [3] [unverified]\n\n    ','2022-05-27 14:18:56'),
(9,'\nLIST PESANAN TOKO (ID_Toko):\n1. Kedai Runcit\n2. Kedai Uncle Muthu\n3. Toko Test\n\nPILIH ID TOKO YANG INGIN DILIHAT LIST PESANANNYA\n    ','2022-05-27 14:18:56'),
(10,'\n============================================\nLIST PEMESANAN :\n[ID] [Tanggal] [Barang] [Jumlah] [Total] [Status]\n============================================\n\n-  [3] [2022-05-27] [Baju Wibu] [10000000] [3] [unverified]\n-  [4] [2022-05-27] [Baju Wibu] [2] [3] [unverified]\n-  [5] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [6] [2022-05-27] [Baju Wibu] [12] [3] [unverified]\n-  [7] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [8] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [9] [2022-05-27] [Baju Wibu] [360000] [3] [unverified]\n\n    ','2022-05-27 14:18:56'),
(11,'DATA PENJUALAN BERHASIL DIPILIH\nBERIKUTNYA MASUKKAN BUKTI PEMBAYARAN BERUPA GAMBAR','2022-05-27 14:18:56'),
(12,'BUKTI PEMBAYARAN BERHASIL DIKIRIMKAN','2022-05-27 14:18:56'),
(13,'\nList Pesanan\n\n============================================\n[ID] [Tanggal] [Barang] [Jumlah] [Total] [Status]\n============================================\n\n-  [3] [2022-05-27] [Baju Wibu] [10000000] [3] [unverified]\n-  [4] [2022-05-27] [Baju Wibu] [2] [3] [unverified]\n-  [5] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [6] [2022-05-27] [Baju Wibu] [12] [3] [unverified]\n-  [7] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [8] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [9] [2022-05-27] [Baju Wibu] [360000] [3] [unverified]\n\n    ','2022-05-27 14:18:56'),
(14,'\nList Pesanan\n\n============================================\n[ID] [Tanggal] [Barang] [Jumlah] [Total] [Status]\n============================================\n\n-  [3] [2022-05-27] [Baju Wibu] [10000000] [3] [unverified]\n-  [4] [2022-05-27] [Baju Wibu] [2] [3] [unverified]\n-  [5] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [6] [2022-05-27] [Baju Wibu] [12] [3] [unverified]\n-  [7] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [8] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [9] [2022-05-27] [Baju Wibu] [360000] [3] [unverified]\n\n    ','2022-05-27 14:18:56'),
(15,'\nList Pesanan\n\n============================================\n[ID] [Tanggal] [Barang] [Jumlah] [Total] [Status]\n============================================\n\n-  [3] [2022-05-27] [Baju Wibu] [10000000] [3] [unverified]\n-  [4] [2022-05-27] [Baju Wibu] [2] [3] [unverified]\n-  [5] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [6] [2022-05-27] [Baju Wibu] [12] [3] [unverified]\n-  [7] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [8] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [9] [2022-05-27] [Baju Wibu] [360000] [3] [unverified]\n\n    ','2022-05-27 14:18:56'),
(16,'PESANAN BERHASIL DI VERIFIKASI','2022-05-27 14:18:56'),
(17,'SELAMAT DATANG\nBERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/daftar_toko - UNTUK MENDAFTARKAN TOKO\n/tambah_barang - UNTUK MENAMBAHKAN BARANG\n/list_pesanan - UNTUK LIST PESANAN\n/verifikasi_pesanan - UNTUK MEMVERIFIKASI PESANAN','2022-05-27 14:18:56'),
(18,'MASUKKAN NAMA TOKO ANDA: ','2022-05-27 14:18:56'),
(19,'DATA BERHASIL DISIMPAN','2022-05-27 14:18:56'),
(20,'\nTAMBAH TOKO (ID_Toko):\n1. Kedai Runcit\n2. Kedai Uncle Muthu\n3. Toko Test\n4. toko testing\n\nPILIH ID TOKO YANG INGIN DITAMBAHKAN BARANG\n    ','2022-05-27 14:18:56'),
(21,'MASUKKAN NAMA BARANG','2022-05-27 14:18:56'),
(22,'MASUKKAN JUMLAH BARANG','2022-05-27 14:18:56'),
(23,'MASUKKAN HARGA BARANG','2022-05-27 14:18:56'),
(24,'\nBARANG BERHASIL DITAMBAHKAN\n\nLIST BARANG:\n- Susu Indomilk [Rp.9000]\n\n    ','2022-05-27 14:18:56'),
(25,'BERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/daftar_toko - UNTUK MENDAFTARKAN TOKO\n/tambah_barang - UNTUK MENAMBAHKAN BARANG\n/list_pesanan - UNTUK LIST PESANAN\n/verifikasi_pesanan - UNTUK MEMVERIFIKASI PESANAN','2022-05-27 14:18:56'),
(26,'\nLIST PESANAN TOKO (ID_Toko):\n1. Kedai Runcit\n2. Kedai Uncle Muthu\n3. Toko Test\n4. toko testing\n\nPILIH ID TOKO YANG INGIN DILIHAT LIST PESANANNYA\n    ','2022-05-27 14:18:56'),
(27,'\n============================================\nLIST PEMESANAN:\n[Tanggal] [Barang] [Jumlah] [Total] [Status]\n============================================\n\n    ','2022-05-27 14:18:56'),
(28,'\nList Pesanan\n\n============================================\n[ID] [Tanggal] [Barang] [Jumlah] [Total] [Status]\n============================================\n\n-  [4] [2022-05-27] [Baju Wibu] [2] [3] [unverified]\n-  [5] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [6] [2022-05-27] [Baju Wibu] [12] [3] [unverified]\n-  [7] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [8] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [9] [2022-05-27] [Baju Wibu] [360000] [3] [unverified]\n\n    ','2022-05-27 14:18:56'),
(29,'PESANAN BERHASIL DI VERIFIKASI','2022-05-27 14:18:56'),
(30,'\nLIST PESANAN TOKO (ID_Toko):\n1. Kedai Runcit\n2. Kedai Uncle Muthu\n3. Toko Test\n4. toko testing\n\nPILIH ID TOKO YANG INGIN DILIHAT LIST PESANANNYA\n    ','2022-05-27 14:19:09'),
(31,'\n============================================\nLIST PEMESANAN:\n[Tanggal] [Barang] [Jumlah] [Total] [Status]\n============================================\n\n    ','2022-05-27 14:19:19'),
(32,'\nList Pesanan\n\n============================================\n[ID] [Tanggal] [Barang] [Jumlah] [Total] [Status]\n============================================\n\n-  [5] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [6] [2022-05-27] [Baju Wibu] [12] [3] [unverified]\n-  [7] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [8] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [9] [2022-05-27] [Baju Wibu] [360000] [3] [unverified]\n\n    ','2022-05-27 14:19:22'),
(33,'PESANAN BERHASIL DI VERIFIKASI','2022-05-27 14:20:01'),
(34,'\nList Pesanan\n\n============================================\n[ID] [Tanggal] [Barang] [Jumlah] [Total] [Status]\n============================================\n\n-  [6] [2022-05-27] [Baju Wibu] [12] [3] [unverified]\n-  [7] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [8] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [9] [2022-05-27] [Baju Wibu] [360000] [3] [unverified]\n\n    ','2022-05-27 14:20:03'),
(35,'BERIKUT ADALAH PERINTAH YANG DAPAT DIGUNAKAN: \n/start - UNTUK MEMULAI BOT\n/end - UNTUK MENGAKHIRI BOT\n/list_toko - UNTUK MELIHAT DAFTAR TOKO\n/list_barang - UNTUK MELIHAT LIST BARANG\n/buat_pesanan - UNTUK MEMBUAT PESANAN\n/upload_bukti_pembayaran - UNTUK UPLOAD BUKTI PEMBAYARAN','2022-05-27 14:21:54'),
(36,'\nLIST TOKO YANG TERSEDIA :\n\n- Kedai Runcit\n- Kedai Uncle Muthu\n- Toko Test\n- toko testing\n\n    ','2022-05-27 14:21:56'),
(37,'\nLIST TOKO (ID. TOKO):\n1. Kedai Runcit\n2. Kedai Uncle Muthu\n3. Toko Test\n4. toko testing\n\nPILIH ID TOKO UNTUK MELIHAT BARANG\n    ','2022-05-27 14:22:00'),
(38,'\nLIST BARANG:\n- Susu Indomilk [Rp.9000]\n\n    ','2022-05-27 14:22:04'),
(39,'\nLIST TOKO (ID. TOKO):\n1. Kedai Runcit\n2. Kedai Uncle Muthu\n3. Toko Test\n4. toko testing\n\nPILIH ID TOKO UNTUK MEMESAN\n    ','2022-05-27 14:22:11'),
(40,'\nLIST BARANG (ID. BARANG):\n4. Susu Indomilk [Rp.9000]\n\nPILIH ID BARANG UNTUK MEMILIH BARANG\n    ','2022-05-27 14:22:16'),
(41,'MASUKKAN JUMLAH PESANAN','2022-05-27 14:22:21'),
(42,'TOTAL = RP.9000\nPESANAN BERHASIL DITAMBAHKAN','2022-05-27 14:22:28'),
(43,'\n============================================\nLIST PEMESANAN :\n[ID] [Tanggal] [Barang] [Jumlah] [Total] [Status]\n============================================\n\n-  [6] [2022-05-27] [Baju Wibu] [12] [3] [unverified]\n-  [7] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [8] [2022-05-27] [Baju Wibu] [3] [3] [unverified]\n-  [9] [2022-05-27] [Baju Wibu] [360000] [3] [unverified]\n-  [10] [2022-05-27] [Susu Indomilk] [9000] [4] [unverified]\n\n    ','2022-05-27 14:22:33'),
(44,'DATA PENJUALAN BERHASIL DIPILIH\nBERIKUTNYA MASUKKAN BUKTI PEMBAYARAN BERUPA GAMBAR','2022-05-27 14:22:41'),
(45,'BUKTI PEMBAYARAN BERHASIL DIKIRIMKAN','2022-05-27 14:22:50');

/*Table structure for table `pembayaran` */

DROP TABLE IF EXISTS `pembayaran`;

CREATE TABLE `pembayaran` (
  `id_pembayaran` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_penjualan` bigint(20) unsigned NOT NULL,
  `gambar` text NOT NULL,
  PRIMARY KEY (`id_pembayaran`),
  KEY `id_penjualan` (`id_penjualan`),
  CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_penjualan`) REFERENCES `penjualan` (`id_penjualan`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `pembayaran` */

insert  into `pembayaran`(`id_pembayaran`,`id_penjualan`,`gambar`) values 
(2,3,'https://api.telegram.org/file/bot5259374638:AAFHek9SJ1TaJ9YljlpwfuZvkaZPAO-EA7E/photos/file_0.jpg'),
(3,10,'https://api.telegram.org/file/bot5259374638:AAFHek9SJ1TaJ9YljlpwfuZvkaZPAO-EA7E/photos/file_0.jpg');

/*Table structure for table `penjualan` */

DROP TABLE IF EXISTS `penjualan`;

CREATE TABLE `penjualan` (
  `id_penjualan` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tanggal` date NOT NULL,
  `status_pesanan` varchar(255) NOT NULL,
  `jumlah` int(11) NOT NULL DEFAULT 0,
  `total` bigint(20) NOT NULL DEFAULT 0,
  `id_barang` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id_penjualan`),
  KEY `id_barang` (`id_barang`),
  CONSTRAINT `penjualan_ibfk_1` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `penjualan` */

insert  into `penjualan`(`id_penjualan`,`tanggal`,`status_pesanan`,`jumlah`,`total`,`id_barang`) values 
(2,'2022-05-27','verified',1,1,3),
(3,'2022-05-27','verified',12,10000000,3),
(4,'2022-05-27','verified',2,2,3),
(5,'2022-05-27','verified',3,3,3),
(6,'2022-05-27','unverified',12,12,3),
(7,'2022-05-27','unverified',3,3,3),
(8,'2022-05-27','unverified',3,3,3),
(9,'2022-05-27','unverified',3,360000,3),
(10,'2022-05-27','unverified',1,9000,4);

/*Table structure for table `toko` */

DROP TABLE IF EXISTS `toko`;

CREATE TABLE `toko` (
  `id_toko` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) NOT NULL,
  PRIMARY KEY (`id_toko`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `toko` */

insert  into `toko`(`id_toko`,`nama`) values 
(1,'Kedai Runcit'),
(2,'Kedai Uncle Muthu'),
(3,'Toko Test'),
(4,'toko testing');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
