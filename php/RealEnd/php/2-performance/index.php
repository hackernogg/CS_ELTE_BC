<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="index.css">
    <title>Performance</title>
    <style>

    p    {color: red;}
</style>
</head>
<body>
    <h1>Performance</h1>
    <?php 
    $nomistake = true;
    ?>
    <form action="index.php" method="get" novalidate>
        <label for="i1">Number of children:</label> <input type="text" name="num_children" id="i1" value = "<?=$_GET["num_children"]?>"> <br>
        <?php 
        $isword = false;
        $isneg = false;
        $isempty = false;
        
        if($_GET["num_children"] != ""){
            
            if(is_numeric($_GET["num_children"])){
                $child_num =intval($_GET["num_children"]);
                if($child_num<=0){
                    $isneg = true;
                    $nomistake = false;
                }
            }else{
                $isword = true;
                $nomistake = false;
            }
        }else{
            $isempty = true;
            $nomistake = false;
        };?>
        <?php if($isempty == true):?>
            <p>plz enter something</p>
        <?php endif ;?>
        <?php if($isneg == true):?>
            <p>plz enter postive int</p>
        <?php endif ;?>
        <?php if($isword == true):?>
            <p>plz enter int</p>
        <?php endif ;?>
        <label for="i2">Children's names:</label> <input type="text" name="children_names" id="i2" value = "<?=$_GET["children_names"]?>"> <br>
        <?php 
        
        $noname = false;
        $notEqual = false;
        if($_GET["children_names"] != ""){
            $name_string = $_GET["children_names"];
            $name_array = explode(",", $name_string);
            if(count($name_array)!=$child_num){
                $notEqual = true;
                $nomistake = false;
            }
            
        }else{
            $noname = true;
            $nomistake = false;
        }
        ?>
        <?php if($noname == true):?>
            <p>plz enter names</p>
        <?php endif ;?>
        <?php if($notEqual == true):?>
            <p>plz check number of names</p>
        <?php endif ;?>
        <label for="i3">URL of music to be played:</label> <input type="text" name="music_url" id="i3" value = "<?=$_GET["music_url"]?>"> <br>
        <?php 
        $noUrl = false;
        $notRightUrl = false;

        if($_GET["music_url"] != ""){
           $url = $_GET["music_url"];
           if (filter_var($url, FILTER_VALIDATE_URL) === FALSE) {
            $notRightUrl = true;
            $nomistake = false;
        }

        }else{
            $noUrl = true;
            $nomistake = false;
        };
        ?>
        <?php if($noUrl == true):?>
            <p>plz enter url</p>
        <?php endif ;?>
        <?php if($notRightUrl == true):?>
            <p>plz enter correct URL format</p>
        <?php endif ;?>
        
        <label for="i4">Performance type:</label> <input type="text" name="performance_type" id="i4" value = "<?=$_GET["performance_type"]?>"> <br>
        <?php 
        $notype = false;
        $notRightType = false;

        if($_GET["performance_type"] != ""){
            $type = $_GET["performance_type"];
            if($type != "poem" &&$type !="song"){
                $notRightType = true;
                $nomistake = false;
            }
        }else{
            $notype = true;
            $nomistake = false;
        }
        ?>
        <?php if($notype == true):?>
            <p>plz enter type</p>
        <?php endif ;?>
        <?php if($notRightType == true):?>
            <p>plz enter spng or poem</p>
        <?php endif ;?>
        <input type="checkbox" name="ready" id="i5" value="1" <?php if (!empty($_GET['ready'])): ?> checked="checked"<?php endif; ?>><label for="i5">Everyone is ready</label> <br>
        <?php 
        $noReady = false;
        if(isset($_GET["ready"])){
            $noReady = false;
        }else{
            $noReady = true;
            $nomistake = false;
        };
        ?>
        <?php if($noReady  == true):?>
            <p>someone is not ready yet</p>
        <?php endif ;?>
        <button type="submit">Submit</button>
    </form>
    <?php if($nomistake  == true):?>
        <div class="merry">🎄 MERRY CHRISTMAS AND HAPPY NEW YEAR! 🎄</div>
    <?php endif ;?>

    

    <h2>Test cases</h2>
        <a href="index.php?num_children=&children_names=&music_url=&performance_type=">num_children=&children_names=&music_url=&performance_type=</a><br>
        <a href="index.php?num_children=n&children_names=&music_url=&performance_type=">num_children=n&children_names=&music_url=&performance_type=</a><br>
        <a href="index.php?num_children=6.7&children_names=&music_url=&performance_type=">num_children=6.7&children_names=&music_url=&performance_type=</a><br>
        <a href="index.php?num_children=0&children_names=&music_url=&performance_type=">num_children=0&children_names=&music_url=&performance_type=</a><br>
        <a href="index.php?num_children=3&children_names=Adam%2CBarbara&music_url=&performance_type=">num_children=3&children_names=Adam%2CBarbara&music_url=&performance_type=</a><br>
        <a href="index.php?num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=&performance_type=">num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=&performance_type=</a><br>
        <a href="index.php?num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=5c3ezwen&performance_type=">num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=5c3ezwen&performance_type=</a><br>
        <a href="index.php?num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=">num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=</a><br>
        <a href="index.php?num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=good">num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=good</a><br>
        <a href="index.php?num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=song">num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=song</a><br>
        <a href="index.php?num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=song&ready=on">num_children=3&children_names=Adam%2CBarbara%2CChloe&music_url=http%3A%2F%2Ftinyurl.com%2F5c3ezwen&performance_type=song&ready=on</a><br>
</body>
</html>
