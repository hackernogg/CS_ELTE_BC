<?php
session_start();
$cart = $_SESSION['cart'];
$id = $_GET['id'];
$count = $_GET['count'] ?? 1;

if (!isset($cart[$id])) {
  $cart[$id] = 0;
}
$cart[$id] += $count;
if ($cart[$id] <= 0) {
  unset($cart[$id]);
}

$_SESSION['cart'] = $cart;

header('Location: index.php');