#!/usr/bin/R

################
### OPTPARSE ###
################ library(optparse)

html_dir = analysis_output_dir(vcfpath)
Variant_report_markdown = "/home/ionadmin/github_app/genie/VariantReport_renderN.Rmd"
rmarkdown::render(Variant_report_markdown,
                  params = list(parsed_fp = parsed_fp,
                                annotation_fp = annotation_fp),
                  output_file = paste0(html_dir, '/VariantReport.html'))
