## source file
library("VCFparse")
library("VariantAnnotationModules")
library("NGSannotation")
library("tools")

suppressPackageStartupMessages({
  library("janitor")
  library("tidyverse")
  library("RCurl")
  library("R.utils")
  library("data.table")
  library("curl")
  library("GenomicRanges")
  library("Biostrings")
  library("writexl")
})

CLINVAR_SUMMARY_FILEPATH = "/home/ionadmin/ngs_variant_annotation/variantAnnotation/clinvar/variant_summary.txt.gz"

######################################### Tumor Suppressor Gene list #####################################
#TSG_LENGTHS <- readRDS("/home/ionadmin/ngs_variant_annotation/variantAnnotation/TumorSuppressorGenes/OncoKB_TSG_maxLength.RDS")
TSG_LENGTHS <- readRDS("/mnt/NGS_Diagnostik/Variant_databases/variantAnnotation/TumorSuppressorGenes/OncoKB_TSG_maxLength.RDS")

#################################################  NCBI Clinvar Variant summary table Download #################################################

## Works if most recent clinvar is in following ftp directory:
# https://ftp.ncbi.nlm.nih.gov/pub/clinvar/tab_delimited/

################################################# Read in Clinvar table

CLINVAR <- data.table::fread(CLINVAR_SUMMARY_FILEPATH) %>%
  dplyr::filter(Assembly == "GRCh37") %>%
  janitor::clean_names()

print("CLINVAR: loaded")


##### COSMIC VARIANT SQLITE database
library(DBI)
library(RSQLite)


COSMIC_SQL <- '/home/ionadmin/ngs_variant_annotation/variantAnnotation/cosmic/cut_CosmicVariant.sdb'
SQLITE <- DBI::dbDriver("SQLite")
CONN <- dbConnect(SQLITE, COSMIC_SQL,
                  encoding = "ISO-8859-1")
COSMIC <- dplyr::tbl(CONN, "cosmic_var")

#### CANCER HOTSPOTS
CANCER_HOTSPOTS <- '/home/ionadmin/ngs_variant_annotation/variantAnnotation/cancerHotspots/hotspots_v2.xls'
CANCERHOTSPOTS = readxl::read_xls(CANCER_HOTSPOTS)


#### gnomAD filtering
gnomadpath = "/mnt/NGS_Diagnostik/Variant_databases/gnomAD_DB/gnomad_all_sites_2020.sdb"
gnomadpath = "/mnt/NGS_Diagnostik/Variant_databases/gnomAD_DB/gnomad_v2_exomes.sdb"
con =  dbConnect(SQLite(), gnomadpath)
#GNOMAD = dplyr::tbl(con, "GNOMAD_sites")
GNOMAD = dplyr::tbl(con, "gnomad_v2_exomes")




