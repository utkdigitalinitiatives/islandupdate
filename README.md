## islandupdate
----
**_This may not work correctly with any other system than our own._**
----
###  Local bash script to update islandora installation to HEAD.

* does not update everything in drupal, just islandora related modules
* does not update all libraries, just ones that are updated more frequently
* some modules are commented out
* does not update any other applications or dependencies, solr, tesseract, etc.

### Process:

1. make dated backups of current modules and libraries
2. Put drupal into maintenence mode
3. disables modules
4. updates libraries
5. with each module:
  - erase old module
  - download new from git
6. enable modules
7. cancel the drupal maintenence mode

Note:  the making backups are writtent o a specific directory
 and the erasing of modules does not check to see if it is backed-up, so
careful testing is encouraged.
