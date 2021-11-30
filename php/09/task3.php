<?php
    if(isset($_POST['color'])){
        $color = $_POST['color'];
    }

    else if(isset($_GET['color'])){
        $color = $_GET['color'];
    }
    
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task 3</title>
</head>
<body 
<?php if (isset($color)) : ?>
style="background-color: #<?=$color?>"
<?php endif ; ?>
>
    <a href="task3.php?color=0000ff">BLUE </a>
    <a href="task3.php?color=ffff00">YELLOW </a>
    <a href="task3.php?color=ff0000">RED </a>

    <form method="post">
        <input name= "color" />
        <input type="submit" value="set color" />

    </form>
    
</body>
</html>
