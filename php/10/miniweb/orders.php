<?php 
    include('fio.php');
    $orders = load_file('orders.json');
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <a href="index.php">Back to main</a>
    <table>
        <?php foreach($orders as $order) :?>
          <tr>
            <td><?=$order['name'] ?></td>
            <td><?=$order['address'] ?></td>
            <td><?=implode(", ",$order['products']) ?></td>
          </tr>
        <?php endforeach;?>
    </table>
</body>
</html>
