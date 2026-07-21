-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 21, 2026 at 06:16 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `warmindo_sembada`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_activity_logs`
--

CREATE TABLE `admin_activity_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `action` varchar(80) NOT NULL,
  `entity_type` varchar(80) NOT NULL,
  `entity_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` text NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(120) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(80) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `icon`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Mi Instan', 'mi-instan', 'Kreasi mi hangat dengan topping pilihan.', '🍜', 1, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(2, 'Menu Nasi', 'menu-nasi', 'Menu nasi mengenyangkan untuk makan utama.', '🍛', 2, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(3, 'Camilan', 'camilan', 'Camilan hangat untuk teman nongkrong.', '🍞', 3, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(4, 'Minuman', 'minuman', 'Minuman hangat dan dingin yang menyegarkan.', '🥤', 4, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(5, 'Paket Hemat', 'paket-hemat', 'Paket praktis dengan harga anak kos.', '⭐', 5, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00');

-- --------------------------------------------------------

--
-- Table structure for table `galleries`
--

CREATE TABLE `galleries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(160) NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `galleries`
--

INSERT INTO `galleries` (`id`, `title`, `image`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Suasana hangat Warmindo Sembada', 'assets/images/gallery/galeri-1.jpg', 1, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(2, 'Tempat nyaman untuk nongkrong', 'assets/images/gallery/galeri-2.jpg', 2, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(3, 'Menu favorit pelanggan', 'assets/images/gallery/galeri-3.jpg', 3, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(4, 'Pelayanan ramah setiap hari', 'assets/images/gallery/galeri-4.jpg', 4, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_code` varchar(40) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_name` varchar(120) NOT NULL,
  `customer_phone` varchar(30) NOT NULL,
  `customer_email` varchar(160) DEFAULT NULL,
  `order_type` enum('dine_in','pickup','delivery') NOT NULL,
  `table_number` varchar(20) DEFAULT NULL,
  `delivery_address` text DEFAULT NULL,
  `delivery_note` text DEFAULT NULL,
  `customer_note` text DEFAULT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `service_fee` decimal(12,2) NOT NULL DEFAULT 0.00,
  `delivery_fee` decimal(12,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total` decimal(12,2) NOT NULL,
  `payment_method` enum('cash','bank_transfer','qris') NOT NULL,
  `payment_status` enum('unpaid','uploaded','verified','rejected','paid_cash') NOT NULL DEFAULT 'unpaid',
  `order_status` enum('pending_payment','waiting_verification','processing','ready','delivering','completed','cancelled') NOT NULL,
  `estimated_ready_at` datetime DEFAULT NULL,
  `cancelled_reason` text DEFAULT NULL,
  `cancelled_by` bigint(20) UNSIGNED DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  `stock_restored_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_name_snapshot` varchar(160) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `spicy_level` tinyint(3) UNSIGNED DEFAULT NULL,
  `note` text DEFAULT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `subtotal` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_item_toppings`
--

CREATE TABLE `order_item_toppings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_item_id` bigint(20) UNSIGNED NOT NULL,
  `topping_id` bigint(20) UNSIGNED DEFAULT NULL,
  `topping_name_snapshot` varchar(120) NOT NULL,
  `topping_price` decimal(12,2) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_status_histories`
--

CREATE TABLE `order_status_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(40) NOT NULL,
  `note` text DEFAULT NULL,
  `changed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_requests`
--

CREATE TABLE `password_reset_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `token_hash` char(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `method` enum('cash','bank_transfer','qris') NOT NULL,
  `expected_amount` decimal(12,2) NOT NULL,
  `received_amount` decimal(12,2) DEFAULT NULL,
  `proof_image` varchar(255) DEFAULT NULL,
  `status` enum('unpaid','uploaded','verified','rejected','paid_cash') NOT NULL DEFAULT 'unpaid',
  `rejection_reason` text DEFAULT NULL,
  `verified_by` bigint(20) UNSIGNED DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(160) NOT NULL,
  `slug` varchar(180) NOT NULL,
  `sku` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `promo_price` decimal(12,2) DEFAULT NULL,
  `stock` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `image` varchar(255) NOT NULL DEFAULT 'assets/images/placeholders/product.svg',
  `spicy_available` tinyint(1) NOT NULL DEFAULT 0,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_best_seller` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `preparation_minutes` smallint(5) UNSIGNED NOT NULL DEFAULT 15,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `slug`, `sku`, `description`, `price`, `promo_price`, `stock`, `image`, `spicy_available`, `is_featured`, `is_best_seller`, `is_active`, `preparation_minutes`, `created_at`, `updated_at`) VALUES
(1, 1, 'Indomie Sembada Special', 'indomie-sembada-special', 'WS-MI-001', 'Indomie goreng racikan khas Sembada dengan telur, sayur, bakso, dan bumbu spesial.', 18000.00, NULL, 45, 'assets/images/products/indomie-sembada-special.jpg', 1, 1, 1, 1, 15, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(2, 1, 'Indomie Goreng Aceh', 'indomie-goreng-aceh', 'WS-MI-002', 'Mi goreng dengan aroma rempah Aceh, gurih dan pedas menggoda.', 16000.00, 14500.00, 35, 'assets/images/products/indomie-goreng-aceh.jpg', 1, 1, 1, 1, 15, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(3, 1, 'Indomie Soto Medan', 'indomie-soto-medan', 'WS-MI-003', 'Mi kuah soto hangat dengan sentuhan jeruk nipis dan sayuran.', 14000.00, NULL, 30, 'assets/images/products/indomie-soto-medan.jpg', 1, 0, 0, 1, 12, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(4, 1, 'Indomie Goreng Original', 'indomie-goreng-original', 'WS-MI-004', 'Indomie goreng klasik dengan telur dan sayuran segar.', 12000.00, NULL, 50, 'assets/images/products/indomie-goreng-original.jpg', 1, 0, 0, 1, 10, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(5, 1, 'Indomie Keju Pedas', 'indomie-keju-pedas', 'WS-MI-005', 'Mi pedas creamy dengan taburan keju parut melimpah.', 17000.00, NULL, 28, 'assets/images/products/indomie-keju-pedas.jpg', 1, 1, 0, 1, 15, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(6, 2, 'Nasi Magelangan', 'nasi-magelangan', 'WS-NS-001', 'Perpaduan nasi goreng dan mi dengan telur serta sayuran.', 15000.00, NULL, 38, 'assets/images/products/nasi-magelangan.jpg', 1, 1, 1, 1, 18, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(7, 2, 'Nasi Gila Pedas', 'nasi-gila-pedas', 'WS-NS-002', 'Nasi hangat dengan tumisan sosis, bakso, telur, dan saus pedas.', 22000.00, 20000.00, 24, 'assets/images/products/nasi-gila-pedas.jpg', 1, 1, 1, 1, 20, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(8, 2, 'Nasi Goreng Sembada', 'nasi-goreng-sembada', 'WS-NS-003', 'Nasi goreng khas Sembada dengan telur mata sapi dan acar.', 19000.00, NULL, 32, 'assets/images/products/nasi-goreng-sembada.jpg', 1, 1, 0, 1, 18, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(9, 3, 'Pisang Bakar Cokelat', 'pisang-bakar-cokelat', 'WS-CM-001', 'Pisang bakar lembut dengan cokelat dan susu kental manis.', 15000.00, NULL, 20, 'assets/images/products/pisang-bakar-cokelat.jpg', 0, 0, 1, 1, 12, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(10, 3, 'Pisang Bakar Cokelat Keju', 'pisang-bakar-cokelat-keju', 'WS-CM-002', 'Pisang bakar dengan cokelat, keju, dan susu yang melimpah.', 18000.00, NULL, 18, 'assets/images/products/pisang-bakar-cokelat-keju.jpg', 0, 1, 0, 1, 12, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(11, 3, 'Roti Bakar Cokelat Keju', 'roti-bakar-cokelat-keju', 'WS-CM-003', 'Roti bakar renyah berisi cokelat dan keju.', 16000.00, NULL, 26, 'assets/images/products/roti-bakar-cokelat-keju.jpg', 0, 0, 1, 1, 10, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(12, 3, 'Gorengan Platter', 'gorengan-platter', 'WS-CM-004', 'Pilihan gorengan renyah untuk dinikmati bersama.', 14000.00, NULL, 30, 'assets/images/products/gorengan-platter.jpg', 0, 1, 0, 1, 10, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(13, 4, 'Es Teh Manis Jumbo', 'es-teh-manis-jumbo', 'WS-MN-001', 'Es teh manis segar dalam ukuran jumbo.', 5000.00, NULL, 80, 'assets/images/products/es-teh-manis-jumbo.jpg', 0, 1, 1, 1, 5, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(14, 4, 'Teh Tarik Klasik', 'teh-tarik-klasik', 'WS-MN-002', 'Teh tarik creamy dengan rasa teh yang kuat.', 12000.00, NULL, 40, 'assets/images/products/teh-tarik-klasik.jpg', 0, 1, 0, 1, 7, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(15, 4, 'Kopi Susu Aren', 'kopi-susu-aren', 'WS-MN-003', 'Kopi susu lembut dengan manis alami gula aren.', 15000.00, 13000.00, 36, 'assets/images/products/kopi-susu-aren.jpg', 0, 1, 1, 1, 7, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(16, 4, 'Jeruk Panas', 'jeruk-panas', 'WS-MN-004', 'Minuman jeruk hangat dengan rasa segar alami.', 8000.00, NULL, 45, 'assets/images/products/jeruk-panas.jpg', 0, 0, 0, 1, 5, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(17, 5, 'Paket Hemat Sembada', 'paket-hemat-sembada', 'WS-PH-001', 'Indomie goreng original, telur, dan es teh manis.', 20000.00, 18000.00, 25, 'assets/images/products/paket-hemat-sembada.jpg', 1, 1, 1, 1, 15, '2026-07-19 09:57:00', '2026-07-19 09:57:00');

-- --------------------------------------------------------

--
-- Table structure for table `product_toppings`
--

CREATE TABLE `product_toppings` (
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `topping_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_toppings`
--

INSERT INTO `product_toppings` (`product_id`, `topping_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
(3, 6),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
(4, 6),
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(5, 5),
(5, 6),
(6, 1),
(6, 2),
(6, 3),
(6, 4),
(6, 5),
(6, 6),
(7, 1),
(7, 2),
(7, 3),
(7, 4),
(7, 5),
(7, 6),
(8, 1),
(8, 2),
(8, 3),
(8, 4),
(8, 5),
(8, 6),
(17, 1),
(17, 2),
(17, 3),
(17, 4),
(17, 5),
(17, 6);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_type` varchar(30) NOT NULL DEFAULT 'text',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `setting_key`, `setting_value`, `setting_type`, `updated_at`) VALUES
(1, 'business_name', 'Warmindo Sembada', 'text', '2026-07-19 09:57:00'),
(2, 'whatsapp', '6281234567890', 'text', '2026-07-19 09:57:00'),
(3, 'address', 'Jl. Sembada Raya No. 17, Jakarta', 'textarea', '2026-07-19 09:57:00'),
(4, 'opening_hours', 'Setiap hari, 10.00–23.00 WIB', 'text', '2026-07-19 09:57:00'),
(5, 'delivery_fee', '8000', 'number', '2026-07-19 09:57:00'),
(6, 'service_fee', '2000', 'number', '2026-07-19 09:57:00'),
(7, 'bank_name', 'Bank BCA', 'text', '2026-07-19 09:57:00'),
(8, 'bank_account_number', '1234567890', 'text', '2026-07-19 09:57:00'),
(9, 'bank_account_holder', 'Warmindo Sembada', 'text', '2026-07-19 09:57:00'),
(10, 'qris_image', 'assets/images/payment/qris-demo.svg', 'image', '2026-07-19 09:57:00'),
(11, 'instagram', '@warmindosembada', 'text', '2026-07-19 09:57:00'),
(12, 'facebook', 'Warmindo Sembada', 'text', '2026-07-19 09:57:00'),
(13, 'logo', 'assets/images/logo/logo.svg', 'image', '2026-07-19 09:57:00'),
(14, 'maps_embed_url', 'https://www.google.com/maps?q=Jakarta&output=embed', 'url', '2026-07-19 09:57:00');

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_name` varchar(120) NOT NULL,
  `rating` tinyint(3) UNSIGNED NOT NULL DEFAULT 5,
  `content` text NOT NULL,
  `product_name` varchar(160) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `testimonials`
--

INSERT INTO `testimonials` (`id`, `customer_name`, `rating`, `content`, `product_name`, `is_active`, `created_at`) VALUES
(1, 'Dimas Pratama', 5, 'Rasa mi spesialnya konsisten dan porsinya pas. Tempatnya juga nyaman untuk ngobrol.', 'Indomie Sembada Special', 1, '2026-07-19 09:57:00'),
(2, 'Nadia Putri', 5, 'Nasi gila pedasnya benar-benar bikin nagih. Proses pesan lewat website mudah.', 'Nasi Gila Pedas', 1, '2026-07-19 09:57:00'),
(3, 'Fajar Ramadhan', 4, 'Harga bersahabat dan pilihan toppingnya lengkap. Cocok untuk anak kos.', 'Paket Hemat Sembada', 1, '2026-07-19 09:57:00');

-- --------------------------------------------------------

--
-- Table structure for table `toppings`
--

CREATE TABLE `toppings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `stock` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `toppings`
--

INSERT INTO `toppings` (`id`, `name`, `price`, `stock`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Telur Mata Sapi', 4000.00, 100, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(2, 'Keju Parut', 3000.00, 80, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(3, 'Kornet', 5000.00, 60, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(4, 'Bakso 3 pcs', 5000.00, 90, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(5, 'Sosis', 5000.00, 70, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(6, 'Sayuran', 2000.00, 120, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `email` varchar(160) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','customer') NOT NULL DEFAULT 'customer',
  `avatar` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `password_hash`, `role`, `avatar`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Admin Sembada', 'admin@sembada.test', '081200000001', '$2y$10$M5OAz0T0Lw1l0mqki0WIBeIIWYPRI1ClOfbA3QPLjT.AWfjZxBR7y', 'admin', NULL, 1, '2026-07-19 09:57:00', '2026-07-21 10:49:58'),
(2, 'Pelanggan Demo', 'pelanggan@sembada.test', '081200000002', '$2y$12$XqWybx2h9oR3YpoDuhtsR.NoAKzmiuEKtlCdDub3EIec4u5Pgc2Fm', 'customer', NULL, 1, '2026-07-19 09:57:00', '2026-07-19 09:57:00'),
(3, 'fadhil zahiruddin munawwar', 'fadhilzuraganfadhil@gmail.com', '085294414467', '$2y$10$iTVXoCmUAFvH7PL3gP3YZuWvOoD82sXCQUazJLuwKbNXCnaT4Al56', 'customer', NULL, 1, '2026-07-21 11:14:45', '2026-07-21 11:14:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_activity_logs`
--
ALTER TABLE `admin_activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_logs_user_created` (`user_id`,`created_at`),
  ADD KEY `idx_logs_entity` (`entity_type`,`entity_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_categories_active_sort` (`is_active`,`sort_order`);

--
-- Indexes for table `galleries`
--
ALTER TABLE `galleries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_galleries_active_sort` (`is_active`,`sort_order`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_code` (`order_code`),
  ADD KEY `fk_orders_cancelled_by` (`cancelled_by`),
  ADD KEY `idx_orders_phone_code` (`customer_phone`,`order_code`),
  ADD KEY `idx_orders_status_created` (`order_status`,`created_at`),
  ADD KEY `idx_orders_payment_created` (`payment_status`,`created_at`),
  ADD KEY `idx_orders_user_created` (`user_id`,`created_at`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_items_order` (`order_id`),
  ADD KEY `idx_order_items_product` (`product_id`);

--
-- Indexes for table `order_item_toppings`
--
ALTER TABLE `order_item_toppings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_oit_topping` (`topping_id`),
  ADD KEY `idx_oit_item` (`order_item_id`);

--
-- Indexes for table `order_status_histories`
--
ALTER TABLE `order_status_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_history_user` (`changed_by`),
  ADD KEY `idx_history_order_created` (`order_id`,`created_at`);

--
-- Indexes for table `password_reset_requests`
--
ALTER TABLE `password_reset_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token_hash` (`token_hash`),
  ADD KEY `fk_reset_user` (`user_id`),
  ADD KEY `idx_reset_expiry` (`expires_at`,`used_at`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_id` (`order_id`),
  ADD KEY `fk_payments_verified_by` (`verified_by`),
  ADD KEY `idx_payments_status_created` (`status`,`created_at`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD KEY `fk_products_category` (`category_id`),
  ADD KEY `idx_products_catalog` (`is_active`,`category_id`,`stock`),
  ADD KEY `idx_products_featured` (`is_featured`,`is_best_seller`),
  ADD KEY `idx_products_created` (`created_at`);

--
-- Indexes for table `product_toppings`
--
ALTER TABLE `product_toppings`
  ADD PRIMARY KEY (`product_id`,`topping_id`),
  ADD KEY `fk_pt_topping` (`topping_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_testimonials_active` (`is_active`,`created_at`);

--
-- Indexes for table `toppings`
--
ALTER TABLE `toppings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `idx_toppings_active_stock` (`is_active`,`stock`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `idx_users_role_active` (`role`,`is_active`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_activity_logs`
--
ALTER TABLE `admin_activity_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `galleries`
--
ALTER TABLE `galleries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_item_toppings`
--
ALTER TABLE `order_item_toppings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_status_histories`
--
ALTER TABLE `order_status_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `password_reset_requests`
--
ALTER TABLE `password_reset_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `toppings`
--
ALTER TABLE `toppings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_activity_logs`
--
ALTER TABLE `admin_activity_logs`
  ADD CONSTRAINT `fk_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_cancelled_by` FOREIGN KEY (`cancelled_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_item_toppings`
--
ALTER TABLE `order_item_toppings`
  ADD CONSTRAINT `fk_oit_item` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_oit_topping` FOREIGN KEY (`topping_id`) REFERENCES `toppings` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_status_histories`
--
ALTER TABLE `order_status_histories`
  ADD CONSTRAINT `fk_history_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_history_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `password_reset_requests`
--
ALTER TABLE `password_reset_requests`
  ADD CONSTRAINT `fk_reset_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_payments_verified_by` FOREIGN KEY (`verified_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `product_toppings`
--
ALTER TABLE `product_toppings`
  ADD CONSTRAINT `fk_pt_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pt_topping` FOREIGN KEY (`topping_id`) REFERENCES `toppings` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
