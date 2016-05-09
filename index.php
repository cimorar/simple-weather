<?php
require('src/weather.php');

if(isset($_POST['airport'])) {
  $request = new WeatherRequest($_POST['airport']);
  $request->perform();
} else {
print
'<form name="airport" action="index.php"  method="POST">
        Enter the nearest airport code:<br />
        <input type="text" name="airport" id="airport" />
        <input type="submit" name="submit" value="Show Weather" />
</form>';

}