# Authenticate for googledrive/googlesheets4 usage
source("/home/ionadmin/github_app/GDrive_VariantReport/Gauths.R")

## Links for tables on GoogleWorkspace
# Curated variants by MP Data Analysis team
# includes biological (clinvar) and therapeutic (clinical) interpretations
mpvarlink = googledrive::as_id("https://docs.google.com/spreadsheets/d/1B-NfpRNhadl7w1f5UPkRA_XEg4YI3N4pHRxd9yZgZkc/edit?usp=drive_web&ouid=116704210424700639172")

# Curated list of BRAF variant interpretations
braflink = googledrive::as_id("https://docs.google.com/spreadsheets/d/1xQ3FfHV2JLndT7J_yLHGcrb7Uqpc-cjjio9OYXkjz14/edit")

# Curated list of HRR genes
hrrgenes =  googledrive::as_id('https://docs.google.com/spreadsheets/d/11FZz5m34IYmK1-o2UkjFJ7gatXUBr4_F0mhVdGMxQm8/edit#gid=230169235')

cnv_onco = googledrive::as_id("https://urldefense.com/v3/__https://docs.google.com/spreadsheets/d/1dyu-WsczRwqJ57AUkpJieMz1AbpUy3BWOudXYV4a7mw/edit*gid=1301996234__;Iw!!EDSXHx-qqdzzoNk!vqj607tLIu6AKihvhzzY6TcOommZxsfocrg5WLolovwNOhZuvz05-keGKLT5YoNru_rx_JX4tlwXpXEFyc9pEzDru-KJgfgY5nw$")
