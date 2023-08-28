#!/usr/bin/R

################
### OPTPARSE ###
################ library(optparse)

snv = readr::read_tsv(parsed_fp$parsed_snv)
##
snv = "./testfiles/Y537_B2023.6661_OcaV3_output/parsed_output/parsed_snv.tsv"
snv = readr::read_tsv(snv)
snv = VariantAnnotationModules::amino_acid_code_3_to_1(snv)

clinvar_hits = readr::read_tsv('./testfiles/Y537_B2023.6661_OcaV3_output/annotation_output/annotation_clinvar.tsv')

#html_dir = analysis_output_dir(vcfpath)
Variant_report_markdown = "/home/ionadmin/github_app/genie/VariantReport_renderN.Rmd"
rmarkdown::render(Variant_report_markdown,
                  params = list(snv = snv),
                  output_file = paste0(html_dir, '/VariantReport.html'))
