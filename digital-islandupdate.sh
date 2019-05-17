#!/usr/bin/env bash

# this script is for the 1st server to be updated to head
# that update is tested before updating the other servers
#
UPDATE_EXEC_DIR=`pwd`
TODAY=$(date +"%y-%m-%d")
LIBBAK="/home/islandora/mod-lib-backups/lib-bak-$TODAY"
MODBAK="/home/islandora/mod-lib-backups/mod-bak-$TODAY"
mkdir $LIBBAK
mkdir $MODBAK

# change to drupal home
cd $DRUPAL_HOME

# do an archive dump?
#drush ard

# set maintenance mode to lock drupal
drush vset --exact maintenance_mode 1

echo "....making backups of modules and libraries..."

cp -a sites/all/modules/* $MODBAK/
cp -a sites/all/libraries/*  $LIBBAK/

echo  "** beginning disabling modules **"

#    Disable modules
# disable solr_views first and enable last because of delay
drush dis -y islandora_solr_views
drush dis -y islandora_batch_derivative_trigger
drush dis -y islandora_datastream_exporter
drush dis -y islandora_datastream_replace
drush dis -y islandora_bagit
drush dis -y islandora_usage_stats
drush dis -y islandora_collection_search
drush dis -y islandora_solr_metadata
drush dis -y islandora_solr
drush dis -y islandora_solr_config
drush dis -y islandora_social_metatags
drush dis -y islandora_premis
#drush dis -y islandora_checksum_checker
drush dis -y islandora_checksum
drush dis -y islandora_bookmark
drush dis -y islandora_videojs
drush dis -y islandora_pdfjs
drush dis -y islandora_newspaper_batch
drush dis -y islandora_newspaper
drush dis -y islandora_binary_object
drush dis -y islandora_audio
drush dis -y islandora_video
drush dis -y islandora_pdf
drush dis -y zip_importer
drush dis -y islandora_importer
drush dis -y islandora_book_batch
drush dis -y islandora_batch
drush dis -y islandora_book
drush dis -y islandora_transcript
drush dis -y islandora_oral_histories
drush dis -y islandora_internet_archive_bookreader
drush dis -y islandora_paged_content
drush dis -y islandora_compound_object
drush dis -y islandora_large_image 
drush dis -y islandora_ocr
drush dis -y islandora_xacml_editor
drush dis -y islandora_xacml_api
drush dis -y islandora_openseadragon
drush dis -y islandora_fits
drush dis -y islandora_oai
drush dis -y islandora_basic_image
drush dis -y islandora_basic_collection
drush dis -y objective_forms
drush dis -y xml_forms
drush dis -y xml_form_api, xml_form_builder, xml_form_elements, xml_schema_api
drush dis -y islandora
drush dis -y xml_schema_api
drush dis -y php_lib

echo "** updating libraries"

#update libraries
cd sites/all/libraries/

#- tuque
rm -R tuque
git clone https://github.com/Islandora/tuque.git

# internet archive bookreader
rm -R bookreader
git clone https://github.com/Islandora/internet_archive_bookreader.git
mv ./internet_archive_bookreader ./bookreader

#  videojs library
rm -R video-js
git clone https://github.com/videojs/video.js.git
mv ./video.js ./video-js

# internet archive bookreader
rm -R bookreader
git clone https://github.com/Islandora/internet_archive_bookreader.git
mv ./internet_archive_boookreader ./bookreader

# pdfjs library
rm -R pdfjs
git clone https://github.com/mozilla/pdf.js.git
mv ./pdf.js ./pdfjs

# jstree library
rm -R jstree
git clone https://github.com/vakata/jstree.git

# JAIL library
rm -R JAIL
git clone https://github.com/sebarmeli/JAIL.git

echo "***** updating modules *****"
#    Update modules

cd $DRUPAL_HOME/sites/all/modules/

# Clone all islandora related modules from modules.txt
cd "$DRUPAL_HOME"/sites/all/modules || exit
while read -r LINE; do
  MOD="${LINE##*/}"
  rm -R "$MOD"
  git clone https://github.com/"$LINE"
done < "$UPDATE_EXEC_DIR"/configs/digital-modules.txt

cd $UPDATE_EXEC_DIR


#- incorporate utk_isl_xml_forms
#- utk_isl_xml_forms are UTK-specific XML Forms, post-processing transforms, and testing data
if [ -d "$UPDATE_EXEC_DIR/utk_isl_xml_forms" ]; then
	rm -R $UPDATE_EXEC_DIR/utk_isl_xml_forms
fi
	git clone git://github.com/utkdigitalinitiatives/utk_isl_xml_forms utk_isl_xml_forms
#- move UTK-specific post-processing transforms
#- this list could grow!
cp $UPDATE_EXEC_DIR/utk_isl_xml_forms/post_process_transforms/roth_post_process.xsl $DRUPAL_HOME/sites/all/modules/islandora_xml_forms/builder/self_transforms/

#- add the MODS v3.5 mods_to_dc stylesheet
mv $DRUPAL_HOME/sites/all/modules/islandora_xml_forms/builder/transforms/mods_to_dc.xsl $DRUPAL_HOME/sites/all/modules/islandora_xml_forms/builder/transforms/mods_to_dc.xsl.3.4
cp $UPDATE_EXEC_DIR/transforms/mods_to_dc.xsl $DRUPAL_HOME/sites/all/modules/islandora_xml_forms/builder/transforms/


#- add the MODS v3.5 mods_to_dc_oai stylesheet
mv $DRUPAL_HOME/sites/all/modules/islandora_oai/transforms/mods_to_dc_oai.xsl $DRUPAL_HOME/sites/all/modules/islandora_oai/transforms/mods_to_dc_oai.xsl.3.4
cp $UPDATE_EXEC_DIR/transforms/mods_to_dc_oai.xsl $DRUPAL_HOME/sites/all/modules/islandora_oai/transforms/


#- add the MODS v3.5 mods_to_dc stylesheet
mv $DRUPAL_HOME/sites/all/modules/islandora_batch/transforms/mods_to_dc.xsl $DRUPAL_HOME/sites/all/modules/islandora_batch/transforms/mods_to_dc.xsl.3.4
cp $UPDATE_EXEC_DIR/transforms/mods_to_dc.xsl $DRUPAL_HOME/sites/all/modules/islandora_batch/transforms/


#- add the MODS v3.5 mods_to_dc stylesheet
mv $DRUPAL_HOME/sites/all/modules/islandora_importer/xsl/mods_to_dc.xsl $DRUPAL_HOME/sites/all/modules/islandora_importer/xsl/mods_to_dc.xsl.3.4
cp $UPDATE_EXEC_DIR/transforms/mods_to_dc.xsl $DRUPAL_HOME/sites/all/modules/islandora_importer/xsl/

cd $DRUPAL_HOME
echo "*** re-enabling modules"
#    Enable modules

drush en -y islandora
drush en -y objective_forms
drush en -y xml_form_api, xml_form_builder, xml_form_elements, xml_schema_api
drush en -y xml_forms
drush en -y islandora_basic_collection
drush en -y islandora_basic_image
drush en -y islandora_fits
drush en -y islandora_oai
drush en -y islandora_ocr
drush en -y islandora_openseadragon
drush en -y islandora_large_image
drush en -y islandora_pdf
drush en -y islandora_batch
drush en -y islandora_importer
drush en -y zip_importer
drush en -y islandora_internet_archive_bookreader
drush en -y islandora_paged_content
drush en -y islandora_book
drush en -y islandora_oral_histories
drush en -y islandora_transcript
drush en -y islandora_book_batch
drush en -y islandora_xacml_api
drush en -y islandora_xacml_editor
drush en -y islandora_compound_object
drush en -y islandora_solr_search
drush en -y islandora_solr_metadata
drush en -y islandora_bookmark
drush en -y islandora_audio
drush en -y islandora_video
drush en -y islandora_videojs
drush en -y islandora_pdfjs
drush en -y islandora_premis
drush en -y islandora_social_metatags
drush en -y islandora_checksum
#drush en -y islandora_checksum_checker
drush en -y islandora_newspaper
drush en -y islandora_collection_search
drush en -y islandora_binary_object
drush en -y islandora_newspaper_batch
drush en -y islandora_batch_derivative_trigger
drush en -y islandora_datastream_exporter
drush en -y islandora_datastream_replace
drush en -y islandora_bagit
drush en -y islandora_usage_stats
drush en -y islandora_solr_views

echo "** updating XML Forms tables **"
if [ -d "$UPDATE_EXEC_DIR/form_tables" ]; then
	echo "Loading xml_forms.sql"
	runuser -l islandora -c 'drush -v sql-cli --root=$DRUPAL_HOME < "$UPDATE_EXEC_DIR"/form_tables/xml_forms.sql'
	echo "Loading xml_form associations"
	runuser -l islandora -c 'drush -v sql-cli --root=$DRUPAL_HOME < "$UPDATE_EXEC_DIR"/form_tables/xml_form_builder_form_associations.sql'
	echo "Clearing the drush cache"
	drush cc all
fi

cd $DRUPAL_HOME
# unset maintenance mode to unlock drupal

echo "enable drupal..."
drush vset --exact maintenance_mode 0


