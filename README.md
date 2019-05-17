# islandupdate

## Introduction

  There are many layers to updating Islandora.
  
* The standard drupal core and modules are updated through "drush pm-update". These are the modules registered in the drupal home as offical modules, like colorbox or imagemagick.
* The custom modules for Islandora that are usually kept on github are what this script covers, plus some of the libraries required by those modules.
* There are tools like Tesseract ocr and FITS which could be updated manually but may also come in through an operating
 system package, for instance, we use Red Hat Linux and it has Tesseract as one of the standard packages so it gets updated automatically, but FITS is installed manually so it gets updated when we notice that there is a new version

Local bash script to update islandora installation to HEAD. There are two scripts
 which are customized for different servers.

* does not update everything in drupal, just islandora related modules
* some modules are commented out ( like ones that we are testing )
* does not update any other applications or dependencies, solr, tesseract, etc.

_This may not work correctly with any other system until it is edited._

## Requirements
1. Linux command line bash capabilities
2. Git
3. an installation of Islandora
4. a /home/islandora directory
5. specific paths to the drupal installation

## Usage

1. Clone the repo to your server.
 - cd /home/islandora
 - git clone https://github.com/utkdigitalinitiatives/islandupdate
2. Edit it to fit your local systems and requirements.
3. Run the script as root (sudo -i)

## Process:

1. makes dated backups of current modules and libraries
2. puts drupal into maintenence mode
3. disables modules
4. updates libraries
5. with each module:
  - erase old module
  - download new from git
6. bring in our custom solr configs and xml transforms
7. enable modules
8. cancel the drupal maintenence mode

Note:  the backups are written to a specific directory
 and the erasing of modules does not check to see if it is backed-up, so
careful testing is encouraged.

## Maintainers
1. [Paul Cummins](https://github.com/pc37utn)
2. [Bridger Dyson-Smith](https://github.com/CanOfBees)
## Development

Pull requests are welcome, as are use cases and suggestions.

## License

[GPLv3](http://www.gnu.org/licenses/gpl-3.0.txt)
