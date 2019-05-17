# !/usr/bin/env bash

#  ***  NEW! *** the digital script should be used for dlwork and porter ****
#    NOT this script!  This is just for legacy info and is temporary
#
# this script is for the 1st server to be updated to head.
# That update is tested before updating the other server(s).
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

#    Disable modulesdrush dis -y islandora_solr_views
# dis solr_views first and enable it last because of delay
drush dis -y islandora_solr_views
drush dis -y islandora_batch_derivative_trigger
drush dis -y islandora_datastream_exporter
drush dis -y islandora_datastream_replace
drush dis -y islandora_bagit
drush dis -y islandora_usage_stats
drush dis -y islandora_scg
drush dis -y islandora_collection_search
drush dis -y islandora_solr_metadata
drush dis -y islandora_solr
drush dis -y islandora_solr_config
drush dis -y islandora_premis
drush dis -y islandora_checksum_checker
drush dis -y islandora_checksum
drush dis -y islandora_bookmark
drush dis -y islandora_videojs
drush dis -y islandora_pdfjs
drush dis -y islandora_newspaper
drush dis -y islandora_binary_object
drush dis -y islandora_audio
drush dis -y islandora_video
drush dis -y islandora_pdf
drush dis -y zip_importer
drush dis -y islandora_importer
drush dis -y islandora_newspaper_batch
drush dis -y islandora_book_batch
drush dis -y islandora_batch
drush dis -y islandora_book
drush dis -y islandora_transcript
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

# internet archive bookreader
rm -R bookreader
git clone https://github.com/Islandora/internet_archive_bookreader.git
mv ./internet_archive_bookreader ./bookreader

#- tuque

rm -R tuque
git clone https://github.com/Islandora/tuque.git

#  videojs library

rm -R video-js
git clone https://github.com/videojs/video.js.git
mv ./video.js ./video-js

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

#- islandora_datastream_exporter
rm -R islandora_datastream_exporter
git clone https://github.com/pc37utn/islandora_datastream_exporter

#- islandora_datastream_replace
rm -R islandora_datastream_replace
git clone https://github.com/utkdigitalinitiatives/islandora_datastream_replace


#- islandora
rm -R islandora
git clone git://github.com/Islandora/islandora

#- ** local **  islandora_solution_pack_collection
rm -R islandora_solution_pack_collection
git clone git://github.com/utkdigitalinitiatives/islandora_solution_pack_collection

#- islandora_solution_pack_image
rm -R islandora_solution_pack_image
git clone git://github.com/Islandora/islandora_solution_pack_image

#- php_lib
rm -R php_lib
git clone git://github.com/Islandora/php_lib

#- objective_forms
rm -R objective_forms
git clone git://github.com/Islandora/objective_forms

#- islandora_xml_forms
rm -R islandora_xml_forms
git clone git://github.com/Islandora/islandora_xml_forms

#- incorporate utk_isl_xml_forms
#- utk_isl_xml_forms are UTK-specific XML Forms, post-processing transforms, and testing data
if [ -d "$UPDATE_EXEC_DIR/utk_isl_xml_forms" ]; then
	rm -R $UPDATE_EXEC_DIR/utk_isl_xml_forms
	git -C $UPDATE_EXEC_DIR clone git://github.com/utkdigitalinitiatives/utk_isl_xml_forms utk_isl_xml_forms
else
	git -C $UPDATE_EXEC_DIR clone git://github.com/utkdigitalinitiatives/utk_isl_xml_forms utk_isl_xml_forms
fi
#- move UTK-specific post-processing transforms
#- this list could grow!
cp $UPDATE_EXEC_DIR/utk_isl_xml_forms/post_processing_transforms/roth_post_process.xsl islandora_xml_forms/builder/self_transforms/

#- add the MODS v3.5 mods_to_dc stylesheet
mv islandora_xml_forms/builder/transforms/mods_to_dc.xsl islandora_xml_forms/builder/transforms/mods_to_dc.xsl.3.4
cp $UPDATE_EXEC_DIR/transforms/mods_to_dc.xsl islandora_xml_forms/builder/transforms/

#- islandora_batch_derivative_trigger
rm -R islandora_batch_derivative_trigger
git clone git://github.com/qadan/islandora_batch_derivative_trigger

#- islandora_oai
rm -R islandora_oai
git clone git://github.com/Islandora/islandora_oai

#- add the MODS v3.5 mods_to_dc_oai stylesheet
mv islandora_oai/transforms/mods_to_dc_oai.xsl islandora_oai/transforms/mods_to_dc_oai.xsl.3.4
cp $UPDATE_EXEC_DIR/transforms/mods_to_dc_oai.xsl islandora_oai/transforms/

#- islandora_batch
rm -R islandora_batch
git clone git://github.com/Islandora/islandora_batch

#- add the MODS v3.5 mods_to_dc stylesheet
mv islandora_batch/transforms/mods_to_dc.xsl islandora_batch/transforms/mods_to_dc.xsl.3.4
cp $UPDATE_EXEC_DIR/transforms/mods_to_dc.xsl islandora_batch/transforms/

#- islandora_fits
rm -R islandora_fits
git clone git://github.com/Islandora/islandora_fits

#- islandora_importer
rm -R islandora_importer
git clone git://github.com/Islandora/islandora_importer

#- add the MODS v3.5 mods_to_dc stylesheet
mv islandora_importer/xsl/mods_to_dc.xsl islandora_importer/xsl/mods_to_dc.xsl.3.4
cp $UPDATE_EXEC_DIR/transforms/mods_to_dc.xsl islandora_importer/xsl/

#- islandora_ocr
rm -R islandora_ocr
git clone git://github.com/Islandora/islandora_ocr

#- islandora_solution_pack_large_image
rm -R islandora_solution_pack_large_image
git clone git://github.com/Islandora/islandora_solution_pack_large_image


#- islandora_openseadragon
rm -R islandora_openseadragon
git clone git://github.com/Islandora/islandora_openseadragon.git

#- islandora_paged_content
rm -R islandora_paged_content
git clone git://github.com/Islandora/islandora_paged_content


#- islandora_internet_archive_bookreader
rm -R islandora_internet_archive_bookreader
git clone git://github.com/Islandora/islandora_internet_archive_bookreader

#- islandora_solution_pack_book
rm -R islandora_solution_pack_book
git clone git://github.com/Islandora/islandora_solution_pack_book

#- islandora_transcript
rm -R islandora_transcript
git clone git://github.com/yorkulibraries/islandora_transcript

#- islandora_xacml_editor
rm -R islandora_xacml_editor
git clone git://github.com/Islandora/islandora_xacml_editor


#- islandora_solution_pack_compound
rm -R islandora_solution_pack_compound
git clone git://github.com/Islandora/islandora_solution_pack_compound


#- islandora_solution_pack_pdf
rm -R islandora_solution_pack_pdf
git clone git://github.com/Islandora/islandora_solution_pack_pdf

#- islandora_solution_pack_audio
rm -R islandora_solution_pack_audio
git clone git://github.com/Islandora/islandora_solution_pack_audio

#- islandora_solution_pack_video
rm -R islandora_solution_pack_video
git clone git://github.com/Islandora/islandora_solution_pack_video

#- islandora_solr_search
rm -R islandora_solr_search
git clone git://github.com/Islandora/islandora_solr_search


#- islandora_solr_metadata
rm -R islandora_solr_metadata
git clone git://github.com/Islandora/islandora_solr_metadata

#- islandora_solr_views
rm -R islandora_solr_views
git clone git://github.com/Islandora/islandora_solr_views

#- islandora_book_batch
rm -R islandora_book_batch
git clone git://github.com/Islandora/islandora_book_batch

#- islandora_bookmark
rm -R islandora_bookmark
git clone git://github.com/Islandora/islandora_bookmark

#- islandora_pdfjs
rm -R islandora_pdfjs
git clone git://github.com/Islandora/islandora_pdfjs

#- islandora_videojs
rm -R islandora_videojs
git clone git://github.com/Islandora/islandora_videojs

#- islandora_premis
rm -R islandora_premis
git clone git://github.com/Islandora/islandora_premis

#- islandora_checksum
rm -R islandora_checksum
git clone git://github.com/Islandora/islandora_checksum

##- islandora_checksum_checker
rm -R islandora_checksum_checker
git clone git://github.com/Islandora/islandora_checksum_checker

#- islandora_solution_pack_newspaper
rm -R islandora_solution_pack_newspaper
git clone git://github.com/Islandora/islandora_solution_pack_newspaper

#- islandora_newspaper_batch
rm -R islandora_newspaper_batch
git clone git://github.com/Islandora/islandora_newspaper_batch

#- discoverygarden islandora collection search
rm -R islandora_collection_search
git clone git://github.com/discoverygarden/islandora_collection_search

#- Islandora-Labs islandora_binary_object
rm -R islandora_binary_object
git clone git://github.com/Islandora-Labs/islandora_binary_object

#- Islandora-mjordan islandora_scg
rm -R islandora_scg
git clone git://github.com/mjordan/islandora_scg

#- Islandora islandora_usage_stats
rm -R islandora_usage_stats
git clone git://github.com/Islandora/islandora_usage_stats

#- Islandora bagit
rm -R islandora_bagit
git clone git://github.com/Islandora/islandora_bagit

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
drush en -y islandora_zip_importer
drush en -y islandora_internet_archive_bookreader
drush en -y islandora_paged_content
drush en -y islandora_book
drush en -y islandora_transcript
drush en -y islandora_book_batch
drush en -y islandora_xacml_api
drush en -y islandora_xacml_editor
drush en -y islandora_compound_object
drush en -y islandora_solr
drush en -y islandora_solr_metadata
drush en -y islandora_bookmark
drush en -y islandora_videojs
drush en -y islandora_pdfjs
drush en -y islandora_premis
drush en -y islandora_checksum
#drush en -y islandora_checksum_checker
drush en -y islandora_newspaper
drush en -y islandora_collection_search
drush en -y islandora_audio
drush en -y islandora_video
drush en -y islandora_binary_object
drush en -y islandora_scg
drush en -y islandora_usage_stats
drush en -y islandora_newspaper_batch
drush en -y islandora_batch_derivative_trigger
drush en -y islandora_datastream_exporter
drush en -y islandora_datastream_replace
drush en -y islandora_bagit
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
