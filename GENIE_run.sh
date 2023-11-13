#!/usr/bin/sh
R_genie="/home/ionadmin/github_app/genie/genie.R"

input_file=$1

Rscript "$R_genie" -o "parse_annotation" -f "$input_file"
