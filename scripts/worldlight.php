// Generate an image of the globe with its current illumination by the sun.
<?php
// Get current time.
$datetime = strtotime("now");

// Compute constants.
$time = 1 * 3600 * (-0.1752 * sin(0.033430 * gmdate("z", $datetime) + 0.5474) 
      - 0.1340*sin(0.018234*gmdate("z",$datetime) - 0.1939));
if ($time < 0) {
    $datetime = strtotime("now ".(int)$time." second", $datetime);
} else {
    $datetime = strtotime("+ ".(int)$time." second", $datetime);
}
$alpha = 0.41015237422;
$cosalpha = cos($alpha);
$sinalpha = sin($alpha);
$cosyear = cos($year);
$sinyear = sin($year);

// Compute year and day, normalized to [0, 2*pi).
$day = ((gmdate("H", $datetime) * 60 + gmdate("i", $datetime)) * 60 + gmdate("s", $datetime)) 
       / 43200 * pi();
$year = (gmdate("z", $datetime) - 79.25) / 365 * 2 * pi();

// Compute solar angle.
function angle($l, $b) {
    global $day, $cosalpha, $sinalpha, $cosyear, $sinyear;

    $b = (90 - $b) / 180 * pi();
    $d = $day - $l / 180 * pi();
    $sinb = sin($b);
    $r = array(-1 * cos($d) * $sinb, sin($d) * $sinb, cos($b));

    return $r[0] * ((1 - $cosalpha) * $cosyear * $cosyear + $cosalpha)
           + $r[1] * (1 - $cosalpha) * $cosyear * $sinyear
           - $r[2] * $sinalpha * $sinyear;
}

// Read input images.
$inputfile_day = "../images/globe_day.jpg";
$inputfile_night = "../images/globe_night.jpg";
$image_size = getimagesize($inputfile_day);
$image_day = imagecreatefromjpeg($inputfile_day);
$image_night = imagecreatefromjpeg($inputfile_night);

// Render illuminated globe.
$block_size = 1;
for($i = 0; $i < $image_size[0]; $i = $i + $block_size) {
    for($j = 0; $j < $image_size[1]; $j = $j + $block_size) {
        $x = angle(180 - ($i / $image_size[0] * 360), -90 + ($j / $image_size[1] * 180));
        if ($x < -0.11) {
            ImageCopy($image_day, $image_night, $i, $j, $i, $j, $block_size, $block_size);
        } elseif ($x < 0) {    
            $offset = 13;
            $ptc = (int)(100 - ($x + 0.11) / (0.11) * (100 - $offset)) + $offset;
            if ($ptc > 100) {
                $ptc = 100;
            }
            ImageCopyMerge($image_day, $image_night, $i, $j, $i, $j, $block_size, 
                           $block_size, $ptc);
        }
    }
}

// Save rendered image to file.
//$image_day3 = imagecreatetruecolor(1000, 500);
//imagecopy($image_day3, $image_day, 0, 0, 0, 50, 2000, 1000);
//imagestring($image_day, 2, 5, 1, gmdate("d.m.Y H:i:s ")."UTC", $col);
//imagestring($image_day, 2, 675, 1, "http://hanno-rein.de", $col);
//$font = 'arial.ttf';
//imagettftext($image_day, 20, 0, 600, 100, 1, $font, "asdfasdf");
ImageJPEG($image_day, "./worldlight.jpg", 95);
//ImageJPEG ($image_day3,'',90);
//ImageJPEG ($image_day3, "./worldlight_start.jpg", 90);
?>
