#!usr/bin/env bash -x

# this script is for the esb/trace server to be updated to head
#
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
drush dis -y islandora_scholar_tombstone
drush dis -y islandora_form_fieldpanel
drush dis -y islandora_binary_object_zip_importer
drush dis -y islandora_binary_object
drush dis -y trace_ext_workflow
drush dis -y islandora_ingest_collections
drush dis -y islandora_nested_collections
drush dis -y islandora_usage_stats_callbacks
drush dis -y islandora_usage_stats
drush dis -y islandora_populator
drush dis -y islandora_xacml_editor
drush dis -y islandora_xacml_api
drush dis -y islandora_xacml_editor
drush dis -y islandora_xmlsitemap
drush dis -y islandora_ocr
drush dis -y islandora_oai
drush dis -y islandora_google_scholar
drush dis -y islandora_scholar_embargo
drush dis -y islandora_solr_config
drush dis -y citation_exporter
drush dis -y doi_importer
drush dis -y endnotexml_importer
drush dis -y pmid_importer
drush dis -y ris_importer
drush dis -y islandora_bibliography
drush dis -y islandora_simple_workflow
drush dis -y islandora_scholar
drush dis -y islandora_solr_views
drush dis -y islandora_solr_metadata
drush dis -y islandora_solr
drush dis -y islandora_solr_config
drush dis -y islandora_checksum_checker
drush dis -y islandora_checksum
drush dis -y islandora_pdfjs
drush dis -y islandora_pdf
drush dis -y islandora_internet_archive_bookreader
drush dis -y islandora_bagit
drush dis -y zip_importer
drush dis -y islandora_importer
drush dis -y islandora_batch_report
drush dis -y islandora_book_batch
drush dis -y islandora_datastream_replace
drush dis -y islandora_batch
drush dis -y islandora_book
drush dis -y islandora_paged_content
drush dis -y islandora_compound_object
drush dis -y islandora_large_image 
drush dis -y islandora_ocr
drush dis -y islandora_openseadragon
#drush dis -y islandora_fits
drush dis -y islandora_oai
drush dis -y islandora_basic_image
drush dis -y islandora_basic_collection
drush dis -y objective_forms
drush dis -y xml_forms
drush dis -y xml_form_api
drush dis -y xml_form_builder
drush dis -y xml_form_elements
drush dis -y islandora
drush dis -y xml_schema_api
drush dis -y php_lib

echo "** updating libraries"

#update libraries
cd sites/all/libraries/


#- tuque

rm -R tuque
git clone https://github.com/Islandora/tuque.git

#  BagItPHP library
rm -R BagItPHP
git clone git://github.com/scholarslab/BagItPHP.git

# citeproc-php library
rm -R citeproc-php
git clone https://github.com/Islandora/citeproc-php.git

# pdfjs library
rm -R pdfjs
git clone https://github.com/mozilla/pdf.js.git
mv ./pdf.js ./pdfjs

# jstree library
#rm -R jstree
#git clone https://github.com/vakata/jstree.git

# JAIL library
rm -R JAIL
git clone https://github.com/sebarmeli/JAIL.git


echo "***** updating modules *****"
#    Update modules

cd $DRUPAL_HOME/sites/all/modules/

#- php_lib
rm -R php_lib
git clone git://github.com/Islandora/php_lib

#- islandora
rm -R islandora
git clone git://github.com/Islandora/islandora

#- objective_forms
rm -R objective_forms
git clone git://github.com/Islandora/objective_forms

#- islandora_solution_pack_collection
rm -R islandora_solution_pack_collection
git clone git://github.com/Islandora/islandora_solution_pack_collection

#- islandora_solution_pack_image
rm -R islandora_solution_pack_image
git clone git://github.com/Islandora/islandora_solution_pack_image

#- islandora_oai
rm -R islandora_oai
git clone git://github.com/Islandora/islandora_oai


#- add the MODS v3.5 mods_to_dc stylesheet
#mv islandora_xml_forms/builder/transforms/mods_to_dc.xsl islandora_xml_forms/builder/transforms/mods_to_dc.xsl.3.4
#cp $UPDATE_EXEC_DIR/transforms/mods_to_dc.xsl islandora_xml_forms/builder/transforms/


#- islandora_populator
rm -R islandora_populator
git clone git://github.com/Islandora/islandora_populator



#- add the MODS v3.5 mods_to_dc_oai stylesheet
#mv islandora_oai/transforms/mods_to_dc_oai.xsl islandora_oai/transforms/mods_to_dc_oai.xsl.3.4
#cp $UPDATE_EXEC_DIR/transforms/mods_to_dc_oai.xsl islandora_oai/transforms/

#- islandora_batch
rm -R islandora_batch
git clone git://github.com/Islandora/islandora_batch

#- add the MODS v3.5 mods_to_dc stylesheet
#mv islandora_batch/transforms/mods_to_dc.xsl islandora_batch/transforms/mods_to_dc.xsl.3.4
#cp $UPDATE_EXEC_DIR/transforms/mods_to_dc.xsl islandora_batch/transforms/

#- islandora_fits
#rm -R islandora_fits
#git clone git://github.com/Islandora/islandora_fits

#- islandora_importer
rm -R islandora_importer
git clone git://github.com/Islandora/islandora_importer

#- add the MODS v3.5 mods_to_dc stylesheet
#mv islandora_importer/xsl/mods_to_dc.xsl islandora_importer/xsl/mods_to_dc.xsl.3.4
#cp $UPDATE_EXEC_DIR/transforms/mods_to_dc.xsl islandora_importer/xsl/

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


#- islandora_xacml_editor
rm -R islandora_xacml_editor
git clone git://github.com/Islandora/islandora_xacml_editor


#- islandora_solution_pack_compound
rm -R islandora_solution_pack_compound
git clone git://github.com/Islandora/islandora_solution_pack_compound


#- islandora_solution_pack_pdf
rm -R islandora_solution_pack_pdf
git clone git://github.com/Islandora/islandora_solution_pack_pdf


#- islandora_solr_search
rm -R islandora_solr_search
git clone git://github.com/Islandora/islandora_solr_search


#- islandora_solr_views
rm -R islandora_solr_views
git clone git://github.com/Islandora/islandora_solr_views

#- islandora_book_batch
rm -R islandora_book_batch
git clone git://github.com/Islandora/islandora_book_batch


#- islandora_pdfjs
rm -R islandora_pdfjs
git clone git://github.com/Islandora/islandora_pdfjs


#- islandora_checksum
rm -R islandora_checksum
git clone git://github.com/Islandora/islandora_checksum

##- islandora_checksum_checker
rm -R islandora_checksum_checker
git clone git://github.com/Islandora/islandora_checksum_checker

#- islandora_pathauto
rm -R islandora_pathauto
git clone git://github.com/Islandora/islandora_pathauto

#- islandora_usage_stats
rm -R islandora_usage_stats
git clone git://github.com/Islandora/islandora_usage_stats

#- islandora_usage_stats_callbacks
rm -R islandora_usage_stats_callbacks
git clone git://github.com/Islandora/islandora_usage_stats_callbacks

### clone UTK Digital Initiatives forks and local modules

#- 

#- islandora_datastream_replace
rm -R islandora_datastream_replace
git clone git://github.com/pc37utn/islandora_datastream_replace

#- islandora_simple_workflow
rm -R islandora_simple_workflow
git clone https://github.com/utkdigitalinitiatives/islandora_simple_workflow.git

#- trace_ext_workflow
rm -R trace_ext_workflow
git clone https://github.com/utkdigitalinitiatives/trace_ext_workflow.git

#- islandora_scholar
rm -R islandora_scholar
git clone https://github.com/utkdigitalinitiatives/islandora_scholar

#- islandora_solr_metadata
rm -R islandora_solr_metadata
git clone https://github.com/utkdigitalinitiatives/islandora_solr_metadata

#- islandora_xml_forms
rm -R islandora_xml_forms
git clone https://github.com/utkdigitalinitiatives/islandora_xml_forms

#- islandora_binary_object
rm -R islandora_binary_object
git clone https://github.com/utkdigitalinitiatives/islandora_binary_object

#- islandora_batch_digital_commons
#   this has some extra baseX installs that go with it,
#  I'm leaving it to be installed by itself when the module is updated
#rm -R islandora_batch_digital_commons
#git clone git://github.com/utkdigitalinitiatives/islandora_batch_digital_commons

#- islandora_scholar_tombstone
rm -R islandora_scholar_tombstone
git clone git://github.com/utkdigitalinitiatives/islandora_scholar_tombstone

#- utk_reflector
rm -R utk_reflector
git clone git://github.com/utkdigitalinitiatives/utk_reflector

# islandora_ingest_collections
rm -R islandora_ingest_collections
git clone https://github.com/utkdigitalinitiatives/islandora_ingest_collections.git

# clone islandora usage stats callbacks needed for displaying view / download count
rm -R islandora_usage_stats_callbacks
git clone https://github.com/Islandora-Labs/islandora_usage_stats_callbacks.git

# clone the Digital initiatives module to create nested collections
git clone https://github.com/utkdigitalinitiatives/islandora_nested_collections.git

# clone Ashok Modi's module to extend XML Form Builder to Work with Field Panels and Field Panes
rm -R islandora_form_fieldpanel
git clone https://github.com/Islandora/islandora_form_fieldpanel


echo "*** re-enabling modules"
#    Enable modules

drush en -y php_lib
drush en -y islandora
drush en -y objective_forms
drush en -y xml_form_api, xml_form_builder, xml_form_elements, xml_schema_api
drush en -y xml_forms
drush en -y islandora_basic_collection
drush en -y islandora_basic_image
#drush en -y islandora_fits
drush en -y islandora_populator
drush en -y islandora_scholar
drush en -y islandora_oai
drush en -y islandora_ocr
drush en -y islandora_openseadragon
drush en -y islandora_large_image
drush en -y islandora_pdf
drush en -y islandora_importer
drush en -y islandora_batch
drush en -y islandora_batch_report
drush en -y islandora_internet_archive_bookreader
drush en -y islandora_paged_content
drush en -y islandora_book
drush en -y islandora_book_batch
drush en -y islandora_compound_object
drush en -y islandora_solr_search
drush en -y islandora_solr_views
drush en -y islandora_solr_config
drush en -y islandora_solr_metadata
drush en -y islandora_pdfjs
drush en -y islandora_pathauto
drush en -y islandora_checksum
drush en -y islandora_checksum_checker
drush en -y islandora_simple_workflow
drush en -y islandora_scholar_embargo
drush en -y islandora_google_scholar
drush en -y citation_exporter
drush en -y doi_importer
drush en -y endnotexml_importer
drush en -y pmid_importer
drush en -y ris_importer
drush en -y islandora_bibliography
drush en -y islandora_xmlsitemap
drush en -y islandora_xacml_api
drush en -y islandora_xacml_editor
drush en -y islandora_populator
drush en -y islandora_usage_stats
drush en -y islandora_usage_stats_callbacks
drush en -y islandora_nested_collections
drush en -y islandora_ingest_collections
drush en -y trace_ext_workflow
drush en -y islandora_binary_object
drush en -y islandora_binary_object_zip_importer
drush en -y islandora_form_fieldpanel
drush en -y islandora_scholar_tombstone

cd $DRUPAL_HOME
# unset maintenance mode to unlock drupal

echo "enable drupal..."
drush vset --exact maintenance_mode 0

