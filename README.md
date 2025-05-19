Working with **extremely wide** data—each sheet in `input_data.xlsx` has **15-k + columns**—quickly pushes past Excel’s own limit of 16,384 columns (column `XFD`).  That makes any manual copy-and-paste or workbook merge impossible.  This lightweight R workflow automates the entire process: it **splits** the multi-sheet workbook into individual files, **annotates** each with its sheet name, and then **merges** a user-selected subset into a single, column-aligned CSV—no spreadsheet software required.

# Excel Sheet Processor

## Overview
This repository contains:

1. **`input_data.xlsx`** – an Excel workbook with several ultra-wide sheets (≥150 000 columns).  
2. **`process.R`** – an R script that  
   * adds a `sample_source` column to every sheet (filled with the sheet’s name),  
   * exports each sheet to its own `.xlsx` file, and  
   * merges a user-defined subset of those files into a single CSV (`combined_file.csv`), padding any missing columns with `0`.

Because the merge happens in R data frames—which have no practical column limit for this size—you can safely combine sheets that Excel itself cannot open in a single view.

## Repository Structure
