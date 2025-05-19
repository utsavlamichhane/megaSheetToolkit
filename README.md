## We wrote this script because we cant work in excel if the column number is bigger than 16,384 

Working with **extremely wide** data—each sheet in `input_data.xlsx` has **15-k + columns**—quickly pushes past Excel’s own limit of 16,384 columns (column `XFD`).  That makes any manual workbook merge impossible.  This lightweight R workflow automates the entire process: it **splits** the multi-sheet workbook into individual files, **annotates** each with its sheet name, and then **merges** a user-selected subset into a single, column-aligned CSV—no spreadsheet software required.

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

 .
 ├── input_data.xlsx

 ├── process_excel.R

 └── README.md ← you are here


## Prerequisites

| Software | Version (tested) | Notes |
|----------|------------------|-------|
| R        | ≥ 4.2            | Earlier versions likely work; 4.2+ recommended. |
| Packages | `readxl`, `writexl`, `tibble` | Install with the command below. |

## Quick-start

1. **Clone the repo**
   ```bash
   git clone https://github.com/utsavlamichhane/megaSheetToolkit.git


Install R dependencies (first time only)


```
install.packages(c("readxl", "writexl", "tibble"))

```
