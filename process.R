#####loading necessary libraries
library(readxl)
library(writexl)
library(tibble)   ###provides add_column()

####defining the input excel workbook
input_file <- "input_data.xlsx"

####retrieving all sheet names
sheet_list <- excel_sheets(input_file)

####loop through each sheet, add a new column with sheet name, and save as separate files
for (sheet in sheet_list) {
  df <- read_excel(input_file, sheet = sheet)                    ####read current sheet
  df <- add_column(df, sample_source = sheet, .after = 1)        ####append new column after the first column
  output_name <- paste0(sheet, ".xlsx")                          ####construct output filename
  write_xlsx(df, output_name)                                    ####write modified sheet to new workbook
}

#####prepare list of generated files for merging
file_set <- c("urine.xlsx", "rumenfluid.xlsx", "saliva.xlsx", "plasma.xlsx")

####read all workbooks into a list of data frames
df_list <- lapply(file_set, read_excel)

####generate the master set of all unique column names
all_headers <- unique(unlist(lapply(df_list, colnames)))

####ensure every data frame has every column (fill missing with 0) and order columns consistently
df_filled <- lapply(df_list, function(df) {
  missing <- setdiff(all_headers, colnames(df))
  if (length(missing) > 0) {
    for (col in missing) {
      df[[col]] <- 0
    }
  }
  df <- df[, all_headers, drop = FALSE]
  return(df)
})

####combine all data frames row-wise
merged_df <- do.call(rbind, df_filled)

####save combined output to csv
write.csv(merged_df, "combined_file.csv", row.names = FALSE)
