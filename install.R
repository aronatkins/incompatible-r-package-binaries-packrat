options(repos = list(CRAN = "https://packagemanager.rstudio.com/all/2021-09-01+Y3JhbjoyMDIxLTA4LTMxLDI6NDUyNjIxNTs3Rjc5MTcxQw"))

options(
  download.file.method = "curl",
  download.file.extra = paste("-L -f -w 'curl: HTTP %{http_code} %{url_effective}\n'")
)

install.packages("remotes", type = "source")

# force a lower rcpp.
remotes::install_version("Rcpp", version = "1.0.6", upgrade = "never")
# version before rcpp-1.0.7 requirement
remotes::install_version("httpuv", version = "1.6.2", upgrade = "never")

install.packages("shiny", type = "source")
install.packages("rsconnect", type = "source")

rsconnect::writeManifest()
packrat::snapshot()
