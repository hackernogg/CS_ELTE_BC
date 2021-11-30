<?php
$data = array();

$stream = @fopen('data.csv','r');
if($stream){
    while($row = fgetcsv($stream,0,";")){
        $data[] = $row;
    }
    fclose($stream);
}
var_dump($data);
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
    <table>
        <?php foreach($data as $item) :?>
            <tr>
                <td><?= $item[0] ?> </td>
                <td><?= $item[1] ?> </td>
                <td><?= $item[2] ?> </td>
            </tr>
        <?php endforeach; ?>
    </table>
    
</body>
</html>
