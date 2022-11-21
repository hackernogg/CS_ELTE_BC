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
  <h1>Ideas for <?= $member['name'] ?></h1>
  <a href="index.php">Back to main page</a>
  <form action="" method="post">
    <fieldset>
      <legend>New idea</legend>
      Idea: <input type="text" name="idea" required> <br>
      <button name="function-add" type="submit">Add new idea</button>
    </fieldset>
  </form>
  <ul>
    <li class="ok">
      idea OK  
    </li>
    <li class="new">
      idea NEW
      <form action="" method="post">
        <input type="hidden" name="idea-id" value="idea1-id">
        <button type="submit" name="function-ok">Got it!</button>
        <button type="submit" name="function-discard">Discard it!</button>
      </form>
    </li>
    <li class="discarded">
      idea DISCARDED
    </li>
  </ul>
</body>
</html>