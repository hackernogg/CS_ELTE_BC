<?php
session_start();
$cart = $_SESSION['cart'];
$id = $_GET['id'];

unset($cart[$id]);

$_SESSION['cart'] = $cart;

header('Location: index.php');