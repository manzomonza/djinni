if(file.exists(parsed_fp$parsed_cnv)){
  cnv = readr::read_tsv(parsed_fp$parsed_cnv)
  cnv = dplyr::select(cnv, seqnames, gene, NUMTILES, RAW_CN, contains("perc"))
  cnv = dplyr::rename(cnv, Chr = seqnames)
  DT::datatable(cnv)
}else{
  print("No CNVs")
}
