<?php
$products = [
  '1' => 'Warm tea cup',
  '2' => 'Hot chocolate mug',
  '3' => 'Dreamy music headset',
  '4' => 'Calm tenderness',
  '5' => 'Peace inside',
];

// solution starts here

?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cart</title>
  <link rel="stylesheet" href="index.css">
</head>
<body>
  <h1>XMas webshop</h1>
  <h2>Products</h2>
  <ul>
    <?php for($i = 1; $i <=count($products) ;$i=$i+1):?>
      <li>
      <?= $products[$i]?>
      <a href="add.php?id=<?=$i?>">Add to cart</a>
    </li>
    <?php endfor; ?>
  </ul>

  <h2>Cart</h2>
  <ul>
    <li>
      Product1
      <a href="???">⊖</a>
      3x
      <a href="???">⊕</a>
      <a href="???">Delete</a>
    </li>
  </ul>
</body>
</html>