# worldlight

This repository contains all files necessary to set up a dynamic desktop background on Debian and its derivates. 
The desktop background shows an image of the globe and how it is currently illuminated by the sun.

![worldlight_example](/images/worldlight_example.jpg)

To set up the worldlight desktop background, simply execute the `install.sh` script in the `scripts` folder.

If you want to manually generate a worldlight image, run the script `worldlight.php` in the `scripts` folder:
```console
php scripts/worldlight.php
```
The output is written to `images/worldlight`.

The credit for the rendering of the globe goes to [Hanno Rein](http://old.hanno-rein.de/software/worldlight.html), who wrote the original PHP script.
