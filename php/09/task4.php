<?php 
 $a = "";
 $b = "";

if($_POST){
    $errors = array();
    $a = $_POST['a'];
    $b = $_POST['b'];

    // validate a 
    if($a == ""){
        $errors[] = "a is not set";
    }else if(!is_numeric($a)){
        $errors[] = "a is not a number";
    }else if ($a == 0){
        $errors[] = "a can not be 0";
    }
    //Validate b
    if(!$b){
        $errors[] = "b is not set";
    }else if(!is_numeric($b)){
        $errors[] = "b is not a number";
    }
    if(!$errors){
        $result = linEq($a,$b);
    }
    
}

function linEq($a,$b){
    return -$b / $a;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Linear equation</title>
</head>
<body>
    <form method="post">
        <p>a=<input name = "a" value="<?=$a ?>"/></p>
        <p>b=<input name = "b" value="<?=$b ?>"/></p>
        <p><input type = "submit" value="calc" /></p>

    </form>
        <!-- sol -->
        <?php if (isset($result)) : ?>
        <p><?= $result ?></p>
        <?php endif ; ?>
        <!-- errors -->
        <?php if (isset($errors) && $errors) : ?>
        <ul>
            <?php foreach ($errors as $error) : ?>
                <li><?=$error ?></li>
            <?php endforeach; ?>
        </ul>
        <?php endif ; ?>
</body>
</html>
