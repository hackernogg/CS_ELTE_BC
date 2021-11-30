<?php 
    // process 
    // Task2/a
    /*-------------------
    $name = 'Jim raynor';
    var_dump($_GET);
    //http://webprogramozas.inf.elte.hu/hallgatok/bcfogs/9/?a=1&b=2&c[]=1&c[]=4
    */
    if( isset($_GET['name'])){
        $name = $_GET['name'];
    }
    //task2/b
    if( isset($_POST['nameFromForm'])){
        $nameFromForm = $_POST['nameFromForm'];
    }
    print_r($_SERVER);
    //render
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
    <p><?="hello world"?></p>
    <h1>task 2.</h1>
    <h2>a)</h2>
    <?php if (isset($name)) :?>
    <p>hello <?= $name ?>!</p>
    <?php endif; ?>
    <h2>b)</h2>
    <form method="post">
        <input name="nameFromForm">
        <input type="submit" value="Let's go">
    </form>
    <?php if (isset($nameFromForm)) :?>
    <p>hello <?= $nameFromForm ?>!</p>
    <?php endif; ?>
</body>
</html>
