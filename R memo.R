# NA
na.string='.'  ##treat all "." as NA
na.rm=TRUE     ## remove na

# SQL connection
library(RODBC)
myconn <- odbcDriverConnect('driver={SQL Server};server=CL-SQL;database=Improve;trusted_connection=true')
tablename <- sqlQuery(myconn, 
                  "SELECT ...")


# Remove specific columns or rows
##1, Remove rows which 'Site' field is "ATLA1", "DETR1", "PITT1"
no_row <- c("ATLA1", "DETR1", "PITT1")
new <- temp[!(temp[,'site'] %in% no_row),]
##2. Remove columns which column names are "cld_err" or "cld_mdl"
no_column <- c("cld_err","cld_mdl")
new <- temp[, !(names(temp) %in% no_column)]

# Color by a variable (in updated factor levels)
# !!! Create a look-up table for colors, mapping flowflag1 to categories (called palette in R)
# (only want to highlight CL and CG, but has flags more than that)
menu = c("CL "= "Clogged", "CG " = 'Clogging', "EP " = 'All 2011-2013', "LF " = 'All 2011-2013', "NM " ='All 2011-2013',"PO "='All 2011-2013',"RF "='All 2011-2013')
CL.test$Sample = menu[as.character(CL.test$flowflag1)]

# Plot and put a group as the TOP LAYER (by using subset...)
library(plyr)

plot = ggplot(data = CL.test) + 
  geom_point(aes(x = chem_mass/1000, y = mf/1000, color = Sample, size = Sample)) + 
  geom_point(aes(x = chem_mass/1000, y = mf/1000, color = Sample, size = Sample), subset = .(Sample == "Clogging")) +
  geom_point(aes(x = chem_mass/1000, y = mf/1000, color = Sample, size = Sample), subset = .(Sample == "Clogged")) +