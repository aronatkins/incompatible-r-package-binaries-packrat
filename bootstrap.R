options(repos = list(CRAN = "https://packagemanager.rstudio.com/all/2021-09-01+Y3JhbjoyMDIxLTA4LTMxLDI6NDUyNjIxNTs3Rjc5MTcxQw"))

install.packages("packrat")
packrat::init(infer.dependencies = FALSE)
  # restart = FALSE,
  # infer.dependencies = FALSE)
