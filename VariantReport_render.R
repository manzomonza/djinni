#!/usr/bin/R

################
### OPTPARSE ###
################ library(optparse)
library(VariantAnnotationModules)
library(VCFparse)
html_dir = analysis_output_dir(vcfpath)
vcf_info = as.list(yaml::yaml.load(yaml::read_yaml((parsed_fp$parsed_info))))
sample_ID = vcf_info$IonReporter$AnalysisName
Variant_report_markdown = "/home/ionadmin/github_app/genie/VariantReport_renderN.Rmd"
rmarkdown::render(Variant_report_markdown,
                  params = list(parsed_fp = parsed_fp,
                                annotation_fp = annotation_fp,
                                sample_ID = sample_ID,
				vcf_info = vcf_info),
                  output_file = paste0(html_dir, '/VariantReport.html'))
