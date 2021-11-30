<?php
    include('fio.php');
    $cat = $_GET['cat'];

    $data = load_file('data.json');

    $products=$data[$cat];
 
    var_dump($products);
    var_dump($_POST);
    if ($_POST) {
        $orders = load_file('orders.json');

        $orders[] = $_POST;

        save_file('orders.json',$orders);

    }
    
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products</title>
</head>
<body>
    <a href="index.php">Back to main</a>
    <h1>Products <?=$cat?></h1>
    <form method="post">
    <p>Name: <input name="name"></p>
    <p>Address: <input name="address"></p>
    <ul>
        <?php foreach($products as $item):?>
        <li><input type="checkbox" value="<?=$item?>" name="products[]"> <?=$item?></li>
        <?php endforeach;?>
    </ul>
    <input type="submit" value="Order!">
    </form>
</body>
</html>
