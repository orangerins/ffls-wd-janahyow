-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 14, 2025 at 06:04 PM
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
-- Database: `ffls`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(40) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `username`, `password`) VALUES
(1, 'admin', 'admin123');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(30) DEFAULT NULL,
  `middle_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `contact_number` varchar(11) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `barangay` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `province` varchar(50) DEFAULT NULL,
  `zip_code` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `username` varchar(40) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `first_name`, `middle_name`, `last_name`, `contact_number`, `street`, `barangay`, `city`, `province`, `zip_code`, `email`, `username`, `password`) VALUES
(1, 'Orange', NULL, 'Mercado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'Janah', NULL, 'Baltazar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'Christian', NULL, 'Usman', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'Rusthine', NULL, 'Micabalo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'Nicole', NULL, 'Bihag', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'Angel', NULL, 'Saraña', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 'Jamby', NULL, 'Gaspayad', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'Jhochelle', NULL, 'Montante', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 'Orange', 'Suarez', 'Mercado', '09754776042', 'Purok 16 Zone 1', 'Palao', 'Iligan City', 'Lanao Del Norte', '9200', 'mercadoorange@gmail.com', 'Orange', 'tunxt287'),
(10, 'Benedict', 'Suarez', 'Conzon', '09366142212', 'Purok 16 Zone 1', 'Palao', 'Iligan City', 'Lanao Del Norte', '9200', 'benedict@gmail.com', 'benny', 'benny1'),
(11, 'Hatdog', NULL, 'Hatdog', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`item_id`, `item_name`, `category`, `quantity`, `price`) VALUES
(1, 'Surf Fabric Conditioner', 'Cleaning Supplies', 13, 10.00),
(2, 'Plastic Bag', 'Packaging', 30, 2.00),
(4, 'Surf Liquid Detergent', 'Cleaning Supplies', 12, 12.00);

-- --------------------------------------------------------

--
-- Table structure for table `laundry_request`
--

CREATE TABLE `laundry_request` (
  `laundry_request_id` int(11) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `date_placed` date DEFAULT NULL,
  `status` enum('Pending','Washing','Drying','Folding','Ready for Pick-up','Completed') DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `weight` decimal(10,2) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `wash_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `laundry_request`
--

INSERT INTO `laundry_request` (`laundry_request_id`, `item_id`, `admin_id`, `date_placed`, `status`, `total_price`, `weight`, `customer_id`, `wash_type`) VALUES
(12, NULL, NULL, '2025-05-12', 'Drying', 72.00, 8.00, 1, 'Wash Only'),
(13, NULL, NULL, '2025-05-12', 'Pending', 72.00, 8.00, 4, 'Wash Only'),
(14, NULL, NULL, '2025-05-13', 'Pending', 382.00, 16.00, 8, 'Full Service'),
(15, NULL, NULL, '2004-01-04', 'Pending', 372.00, 10.00, 11, 'Full Service'),
(16, NULL, NULL, '2025-05-14', 'Pending', 87.00, 8.00, 1, 'wash-only'),
(24, NULL, NULL, '2025-05-05', 'Pending', 137.00, 16.00, 1, 'wash-only'),
(25, NULL, NULL, '2025-05-14', 'Pending', 397.00, 16.00, 1, 'full-service'),
(26, NULL, NULL, '2025-05-14', 'Pending', 1477.00, 64.00, 1, 'full-service'),
(27, NULL, NULL, '2025-05-14', 'Pending', 1477.00, 64.00, 1, 'full-service'),
(28, NULL, NULL, '2025-05-19', 'Pending', 237.00, 32.00, 1, 'wash-only'),
(29, NULL, NULL, '2025-05-19', 'Pending', 237.00, 32.00, 1, 'wash-only'),
(30, NULL, NULL, '2025-05-19', 'Pending', 237.00, 32.00, 1, 'wash-only');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `laundry_request_id` int(11) DEFAULT NULL,
  `amount_paid` decimal(10,2) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `status` enum('Paid','Balance') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `laundry_request`
--
ALTER TABLE `laundry_request`
  ADD PRIMARY KEY (`laundry_request_id`),
  ADD KEY `fk_admin` (`admin_id`),
  ADD KEY `fk_item_id` (`item_id`),
  ADD KEY `fk_customer_request` (`customer_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_laundry_request_id` (`laundry_request_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `laundry_request`
--
ALTER TABLE `laundry_request`
  MODIFY `laundry_request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `laundry_request`
--
ALTER TABLE `laundry_request`
  ADD CONSTRAINT `fk_admin` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
  ADD CONSTRAINT `fk_customer_request` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `fk_item_id` FOREIGN KEY (`item_id`) REFERENCES `inventory` (`item_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `fk_laundry_request_id` FOREIGN KEY (`laundry_request_id`) REFERENCES `laundry_request` (`laundry_request_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
