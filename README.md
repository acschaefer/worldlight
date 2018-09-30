# worldlight

This repository contains all files necessary to set up a dynamic desktop background on Raspbian Jessie. 
The desktop background shows an image of the globe and how it is currently illuminated by the sun.

![worldlight_example](/images/worldlight_example.jpg)

To set up the worldlight dynamic desktop background, simply execute the `install.sh` script in the `scripts` folder.
The necessary scripts are installed in `/usr/local/bin/worldlight` and executed every minute as a cronjob.

The credit for the PHP rendering script goes to [Hanno Rein](http://old.hanno-rein.de/software/worldlight.html).
