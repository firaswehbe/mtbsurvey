# Script to run the Survey Report (Report-001)
rm(list = ls())

# Set the variables you need
# Get all fields and all events so no need to set myfields and myevents
myfields = NULL
myevents = NULL

# Call REDCap function
source('util001_simpleRCdataload.R')

# Remove incomplete records
mydata<- mydata[mydata$survey_complete==2,]

# Post processing, make factors, make POSIX dates, etc...
# If these are common consider making them part of the redcap load script

mydata$gen_insttypeasfactor <- makeColAsRCFactor('gen_insttype') # Institution Type - factor
mydata$b2asfactor <- factor(mydata$b2,levels = c(0,1),ordered = TRUE,labels = c("No","Yes")) # Use NGS - 1,0 => factor
mydata$submitter_roleasfactor <- makeColAsRCFactor('submitter_role') # Submitter Role - factor
# mydata$dobasPOSIXct <- makeColAsPOSIXct('dob') # Data of Birth - POSIXct
# mydata$yobasinteger <- as.integer(strftime(mydata$dobasPOSIXct,format = '%Y')) # Year of Birth - integer

# Images - Mostly sourced from their own file. The final images are in 'output/' and they
# get sourced into the Rmd file as external image not a plot R chunk
# source('fig001_cumulative.R')
# source('fig002_yobhistogram.R')

# Make a RMarkDown report. If you are just tweaking the report template, you can just source
# the last line below to avoid pulling the data from REDCap every time.
library(knitr)
rmarkdown::render('report001_globalreport.Rmd', output_dir = 'output', run_pandoc = TRUE)
