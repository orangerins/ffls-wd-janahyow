<?php
session_start();
include('db_connection.php');

$insertSql = "
    INSERT INTO payment (laundry_request_id, amount_paid, payment_date, payment_method)
    SELECT lr.laundry_request_id, lr.total_price, DATE(lr.date_placed), 'Cash'
    FROM laundry_request lr
    LEFT JOIN payment p ON p.laundry_request_id = lr.laundry_request_id
    WHERE p.laundry_request_id IS NULL
";
$conn->query($insertSql);


function getAllPayments($conn): array {
    $sql = "
    SELECT p.payment_id, p.laundry_request_id, p.amount_paid, p.payment_date, 
           p.payment_method, c.first_name, c.last_name
    FROM payment p
    JOIN laundry_request lr ON lr.laundry_request_id = p.laundry_request_id
    JOIN customer c ON lr.customer_id = c.customer_id
    ORDER BY p.payment_date DESC
";

    $result = $conn->query($sql);
    $payments = [];

    if ($result && $result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $payments[] = $row;
        }
    }

    return $payments;
}

$payments = getAllPayments($conn);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FreshFold Laundry - Payments</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
            text-decoration: none;
        }

        body {
            background: #f8f9fa;
            display: flex;
            flex-direction: column;
            height: 100vh;
            overflow: hidden;
        }

        header {
            background: #82b8ef;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 20px;
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            z-index: 1000;
            height: 60px;
        }

        .logo-menu {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        #menu-btn {
            background: none;
            border: none;
            cursor: pointer;
        }

        #menu-btn img {
            width: 25px;
            height: 25px;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 5px;
            position: relative;
        }

        .user-profile img {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .user-profile span {
            font-size: 14px;
        }

        .logout-box {
            position: absolute;
            top: 30px;
            right: 0;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 5px;
            display: none;
            z-index: 1001;
        }

        .logout-box a {
            display: block;
            padding: 10px 20px;
            color: #165a91;
            font-size: 14px;
        }

        .logout-box a:hover {
            background-color: #f0f0f0;
        }

        .sidebar {
            background: #96c7f9;
            width: 240px;
            height: 100vh;
            position: fixed;
            left: -240px;
            top: 60px;
            padding-top: 10px;
            transition: left 0.3s ease-in-out;
            z-index: 999;
        }

        .sidebar.active {
            left: 0;
        }

        .sidebar ul {
            list-style: none;
        }

        .sidebar ul li {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
        }

        .sidebar ul li img {
            width: 24px;
            height: 24px;
        }

        .sidebar ul li a {
            color: white;
            font-size: 16px;
        }

        .main-content {
            margin-top: 60px;
            padding: 20px;
            margin-left: 0;
            transition: margin-left 0.3s ease-in-out;
        }

        .main-content.shift {
            margin-left: 260px;
        }

        h1 {
            margin-bottom: 20px;
            color: #333;
        }

        .search-bar {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }

        .search-bar input {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            flex: 1;
            max-width: 300px;
        }

        .search-bar button {
            padding: 8px 15px;
            background-color: #82b8ef;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .status-pending { color: #ffc107; font-weight: bold; }
        .status-completed { color: #28a745; font-weight: bold; }
        .status-cancelled { color: #dc3545; font-weight: bold; }

        .no-results {
            padding: 20px;
            text-align: center;
            color: #666;
            font-style: italic;
            display: none;
        }
    </style>
</head>
<body>
     <header>
        <div class="logo-menu">
            <img src="FFLSlogo.png" alt="FreshFold Logo" style="height: 50px;">
            <button id="menu-btn"><img src="m-icon.png" alt="Menu"></button>
        </div>
        <div class="user-profile" id="logout-btn">
            <span>Admin</span>
            <img src="ad-icon.png" alt="User Icon" id="profile-icon">
            <div class="logout-box" id="logout-box">
                <a href="login.html">Logout</a>
            </div>
        </div>
    </header>

    <div class="sidebar" id="sidebar">
        <ul>
            <li><img src="d-icon.png"><a href="admin-dashboard.php">Dashboard</a></li>
            <li><img src="O-icon.png"><a href="admin-orders.php">Orders</a></li>
            <li><img src="c-icon.png"><a href="admin-customers.php">Customers</a></li>
            <li><img src="i-icon.png"><a href="admin-inventory.php">Inventory</a></li>
            <li><img src="p-icon.png"><a href="admin-Paymentsss.php">Payments</a></li>
            <li><img src="rp-icon.png"><a href="admin-reports.php">Reports</a></li>
        </ul>
    </div>


    <div class="main-content" id="mainContent">
        <h1>Payments</h1>
        <div class="search-bar">
            <input type="text" id="searchInput" placeholder="Search by customer name" onkeyup="searchPayments()">
            <button onclick="searchPayments()"><i class="fas fa-search"></i> Search</button>
        </div>

        <table id="paymentsTable">
            <thead>
                <tr>
                    <th>Payment ID</th>
                    <th>Order #</th>
                    <th>Customer Name</th>
                    <th>Payment Date</th>
                    <th>Amount Paid</th>
                    <th>Payment Method</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="paymentsTableBody">
                <?php foreach ($payments as $payment): ?>
                    <tr>
                        <td><?= htmlspecialchars($payment['payment_id']) ?></td>
                        <td><?= htmlspecialchars($payment['laundry_request_id']) ?></td>
                        <td><?= htmlspecialchars($payment['first_name'] . ' ' . $payment['last_name']) ?></td>
                        <td><?= htmlspecialchars($payment['payment_date']) ?></td>
                        <td>₱<?= number_format($payment['amount_paid'], 2) ?></td>
                        <td><?= htmlspecialchars($payment['payment_method']) ?></td>
                        <td class="status-completed">Paid</td>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        <div id="noResults" class="no-results" style="display:none;">No payments found matching your search.</div>
    </div>

    <script>
        function searchPayments() {
            const filter = document.getElementById('searchInput').value.toLowerCase();
            const rows = document.querySelectorAll('#paymentsTableBody tr');
            const noResults = document.getElementById('noResults');

            let found = false;
            rows.forEach(row => {
                const name = row.cells[2].textContent.toLowerCase();
                if (name.includes(filter)) {
                    row.style.display = '';
                    found = true;
                } else {
                    row.style.display = 'none';
                }
            });

            noResults.style.display = found ? 'none' : 'block';
        }

        document.getElementById('menu-btn').onclick = function () {
            document.getElementById('sidebar').classList.toggle('active');
            document.getElementById('mainContent').classList.toggle('shift');
        };

        document.getElementById('logout-btn').onclick = function () {
            const box = document.getElementById('logout-box');
            box.style.display = box.style.display === 'block' ? 'none' : 'block';
        };
    </script>
</body>
</html>
