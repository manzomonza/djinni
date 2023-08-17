library('VCFparse')
library('VariantAnnotation')
library('VariantAnnotationModules')

#### Function call paths
call_AnnotationModules = "/home/ionadmin/github_app/VariantAnnotationModules/call_AnnotationModules.R"
call_VCFparse = "/home/ionadmin/github_app/VCFparse/call_VCFparse.R"



analysis_output_dir = function(vcfpath){
  vcf_meta = VCFparse::aggregate_META_information(vcf_comment_section(vcfpath))
  vcf_dir = dirname(vcfpath)
  analysis_name = vcf_meta$IonReporter$AnalysisName
  analysis_name = stringr::str_remove(analysis_name, pattern=" ")
  analysis_dir = paste0(analysis_name, "_output")
  analysis_dir = paste0(vcf_dir, "/", analysis_dir)
  if(!dir.exists(analysis_dir)){
    dir.create(analysis_dir)
  }
  return(analysis_dir)
}

################################################# OPTPARSE
library(optparse)

option_list = list(
  make_option(c("-f", "--file"), type="character", default=NULL,
              help="vcf file (path)", metavar="character"))

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser)

print(opt$file)

#################################################/ OPTPARSE
vcfpath = opt$file

## Read in file
vcf = VCFparse::readVCF(vcfpath)
# Parse FUNC
if(nrow(vcf) > 0){
  vcf = combine_orig_with_FUNC_extracts(vcf)
}
## remove double columns
vcf =  dplyr::select(vcf, -contains(".1"))
vcf =  dplyr::select(vcf, -FUNC)

# Generate tables
vcf$variant_type = gsub("[^[:alnum:] ]", "", vcf$variant_type)
vcf$protein = gsub("\\[|\\]", "", vcf$protein)
vcf$transcript = gsub("\\[|\\]", "", vcf$transcript)
vcf = dplyr::relocate(vcf, rowid)

## Create output directories
analysis_dir = analysis_output_dir(vcfpath)

### parsed output
parsed_fp = parsed_filepaths(analysis_dir)

### annotation output
annotation_fp = annotation_filepaths(analysis_dir)

source(call_VCFparse)
source(call_AnnotationModules)


