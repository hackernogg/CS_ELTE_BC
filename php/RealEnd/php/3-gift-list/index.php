
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gift list</title>
  <link rel="stylesheet" href="index.css">
</head>
<body>
  <?php 
    $json = file_get_contents('members.json');
    $data = json_decode($json);

 
  ?>
  <h1>Gift list</h1>
  <h2>My family members</h2>
  <ul>

    <?php $i = 0?>
    <?php foreach($data as $people):?>
      <?php $i = $i + 1;?>
      <?php $people_inf_array = get_object_vars($people);?>
      <li ><a href="member.php?id=<?=$i?>"><?=$people_inf_array["name"]?> </a> </li>
      <?php ?>
    <?php endforeach ?>
  </ul>
</body>
</html>