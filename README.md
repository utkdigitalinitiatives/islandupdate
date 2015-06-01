# islandupdate
----
This may not work correctly with any other system than our own.
----
###  Local bash script to update islandora installation to HEAD.
* does not update everything in drupal, just islandora related modules
* does not update all libraries, just ones that are updated more frequently
* some modules are commented out
* does not update any other applications or dependencies, solr, tesseract, etc.

### Process:
* make dated backups of current modules and libraries
* Put drupal into maintenence mode
* disables modules
* updates libraries
* with each module:
** erase old module
** download new from git
* enable modules
* cancel the drupal maintenence mode

Note:  the making backups are writtent o a specific directory
 and the erasing of modules does not check to see if it is backed-up, so
careful testing is encouraged.
