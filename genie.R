library('VCFparse')
library('VariantAnnotation')
library('VariantAnnotationModules')

#### Function call paths
call_AnnotationModules = "/home/ionadmin/github_app/VariantAnnotationModules/call_AnnotationModules.R"
call_VCFparse = "/home/ionadmin/github_app/VCFparse/call_VCFparse.R"

source("/home/ionadmin/github_app/genie/configs/MainConfig.R")

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
              help="vcf file (path)", metavar="character"),
make_option(c("-o", "--outputs"), type="character", default=NULL,
              help="specify single module or multiple", metavar="character"))

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
vcf = dplyr::filter(vcf, alt == origAlt & ref == origRef | alt == "<CNV>")

# Generate tables
vcf$variant_type = gsub("[^[:alnum:] ]", "", vcf$variant_type)
vcf$protein = gsub("\\[|\\]", "", vcf$protein)
vcf$transcript = gsub("\\[|\\]", "", vcf$transcript)
vcf = dplyr::relocate(vcf, rowid)

## Create output directories
analysis_dir = analysis_output_dir(vcfpath)
print("analysis dir")
print(analysis_dir)
### parsed output
parsed_fp = parsed_filepaths(analysis_dir)
print("parsed fp")
print(parsed_fp)

### annotation output
print("annotation filepaths")
annotation_fp = VariantAnnotationModules::annotation_filepaths(analysis_dir)

module_option = opt$outputs
if(module_option == "parse"){
        source(call_VCFparse)
        print("VCFparse successful")
}
if(module_option == "annotation"){
        source(call_AnnotationModules)
        print("AnnotationModules successful")
}

if(module_option == "parse_annotation"){
        source(call_VCFparse)
        print("VCFparse successful")
        source(call_AnnotationModules)
        print("AnnotationModules successful")
}

#dbDisconnect(con)
#dbDisconnect(CONN)

source("/home/ionadmin/github_app/genie/VariantReport_render.R")


