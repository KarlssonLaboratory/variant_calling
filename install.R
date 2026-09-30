#!/usr/bin/env Rscript

#---- CRAN packages -----------------------------------------------------------

pkgs_CRAN <- c(
  "data.table",
  "tidyverse"
  "patchwork",
  "vcfR",
  "clinfun",
  "R.utils"
)

install.packages(
  pkgs_CRAN,
  repos = getOption("repos"),
  Ncpus = parallel::detectCores()
)

cat(" > All packages installed successfully.\n")