  
library('VCFparse')
library('VariantAnnotation')
library('VariantAnnotationModules')



analysis_name = aggregate_META_information(vcf_comment_section(vcfpath))
  analysis_name = analysis_name$IonReporter$AnalysisName
  analysis_name = stringr::str_remove(analysis_name, pattern=" ")
