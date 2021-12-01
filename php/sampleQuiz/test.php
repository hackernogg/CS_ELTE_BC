<?php 
    $data = [
    [
        "race" => "Zerg",
        "unitName"=>"Zergling",
        "avgAttack"=>5,
        "avgHealth"=>5,
        "unitType"=>"Ground",
        "attack"=>["Ground"]
    ],
    [
        "race" => "Terran",
        "unitName"=>"Marrine",
        "avgAttack"=>5,
        "avgHealth"=>5,
        "unitType"=>"Ground",
        "attack"=>["Ground","Fly"]
    ],
    [
        "race" => "Protoss",
        "unitName"=>"Zealot",
        "avgAttack"=>6,
        "avgHealth"=>6,
        "unitType"=>"Ground",
        "attack"=>["Ground"]
    ],
    [
        "race" => "Zerg",
        "unitName"=>"Hydralisk",
        "avgAttack"=>6,
        "avgHealth"=>6,
        "unitType"=>"Ground",
        "attack"=>["Ground","Fly"]
    ],
    [
        "race" => "Terran",
        "unitName"=>"Battlecruiser",
        "avgAttack"=>8,
        "avgHealth"=>8,
        "unitType"=>"Fly",
        "attack"=>["Ground","Fly"]
    ],
    [
        "race" => "Protoss",
        "unitName"=>"Reaver",
        "avgAttack"=>8,
        "avgHealth"=>8,
        "unitType"=>"Ground",
        "attack"=>["Ground"]
    ]
    ];
    $highestAttack = $data[0]["avgAttack"];

    foreach($data as $player){
        if($player["avgAttack"] > $highestAttack){
            $highestAttack = $player["avgAttack"];
        }
        
    }
    $highestHealth = 0;
    foreach($data as $player){
        if($player["race"] == "Terran"){
            if($player["avgHealth"]>$highestHealth){
                $highestHealth = $player["avgHealth"];
            }
        }
        
    }
    var_dump($_POST);
    if($_POST){
        echo "got post";
    }


?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>test</title>
</head>
<body>
    <h1>2 highestAttack.</h1>
    <p><?=$highestAttack ?></p>
    <h1>3 highestHealth.</h1>
    <p><?=$highestHealth ?></p>
    <h1>4&5 table.</h1>
    <form method="post">
        <p>plz, put text in to both field, or just let both of them be empty</p>
        <h3>avalible Race type: Zerg,Terran,Protoss</h3>
        <h2>Race type<input name="raceType"></h2>
        <h3>avalible Attack type: Ground, Fly</h3>
        <h2>Attack type<input name="attackType"></h2>
        <input type="submit" name="table" value="show table">
    </form>
    <?php if($_POST && $_POST["raceType"]==""&&$_POST["attackType"]=="") :?>
        <table>
        <?php foreach($data as $player) :?>
            <tr>
                <td><?=$player["race"]?></td>
                <td><?=$player["unitName"]?></td>
                <td><?=$player["avgAttack"]?></td>
                <td><?=$player["avgHealth"]?></td>
                <td><?=$player["unitType"]?></td>
                <?php foreach($player["attack"] as $attack) :?>
                    <td><?=$attack?></td>
                <?php endforeach;?>


            </tr>
        <?php endforeach;?>
        </table>
    <?php endif ;?>
    <?php if($_POST && $_POST["raceType"]!=""&&$_POST["attackType"]!="") :?>
        <table>
        <?php foreach($data as $player) :?>
            <?php if($_POST["raceType"]==$player["race"]&&in_array($_POST["attackType"],$player["attack"])) :?>
            <tr>
                <td><?=$player["race"]?></td>
                <td><?=$player["unitName"]?></td>
                <td><?=$player["avgAttack"]?></td>
                <td><?=$player["avgHealth"]?></td>
                <td><?=$player["unitType"]?></td>
                <?php foreach($player["attack"] as $attack) :?>
                    <td><?=$attack?></td>
                <?php endforeach;?>

            <?php endif ;?>
            </tr>
        <?php endforeach;?>
        </table>
    <?php endif ;?>
</body>
</html>
