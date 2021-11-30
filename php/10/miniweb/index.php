<?php 
    include('fio.php');
    //$content = file_get_contents('data.json');
    //$data = json_decode($content, true);
    $data = load_file('data.json');
    var_dump($data);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MINI WebShop</title>
</head>
<body>
    <h1>MINI WEBSHOP</h1>
    <ul>
        <?php foreach($data as $key => $value): ?>
        <li><a href="products.php?cat=<?=$key?>"><?=$key?></a></li>
        <?php endforeach; ?>
    </ul>
    <a href="orders.php">Orders</a>
</body>
</html>
