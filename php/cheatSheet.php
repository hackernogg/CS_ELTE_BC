<?php
// get from url
$_GET[""];

// check is set
if(isset($_GET['id'])) {
    // id index exists
}

// string to int
intval();

//Creating an array from a string separated by spaces
$pizza  = "piece1 piece2 piece3 piece4 piece5 piece6";
$pieces = explode(" ", $pizza);
echo $pieces[0]; // piece1
echo $pieces[1]; // piece2

//check substring
$a = 'How are you?';
if (strpos($a, 'are') !== false) {
    echo 'true';
}
//check is number
$string = "4521";
if ( is_numeric($string) ) {
    echo "\"{$string}\" is a number.";
} else {
    echo "\"{$string}\" is not a number.";
}

// $_POST 
<form method="post">
        <p>plz, put text in to both field, or just let both of them be empty</p>
        <h3>avalible Race type: Zerg,Terran,Protoss</h3>
        <h2>Race type<input name="raceType"></h2>
        <h3>avalible Attack type: Ground, Fly</h3>
        <h2>Attack type<input name="attackType"></h2>
        <input type="submit" name="table" value="show table">
    </form>
    <?php if($_POST && $_POST["raceType"]==""&&$_POST["attackType"]=="") :?>

?>
