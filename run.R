if (system.file(package = "packrat") == "") {
  # Using CRAN to obtain packrat, which lets us then restore the
  # project (using a different repository).
  cat("installing packrat.\n")
  install.packages("packrat", repos = "https://cran.rstudio.com/")
} else {
  cat("packrat is available.\n")
}

sourceRepo <- "https://packagemanager.rstudio.com/all/2021-09-01+Y3JhbjoyMDIxLTA4LTMxLDI6NDUyNjIxNTs3Rjc5MTcxQw"
binaryRepo <- "https://packagemanager.rstudio.com/all/__linux__/bionic/2021-09-01+Y3JhbjoyMDIxLTA4LTMxLDI6NDUyNjIxNTs3Rjc5MTcxQw"

# NOTE: packrat.lock repos is wrong.
incomingRepos <- packrat::get_lockfile_metadata()$repos

if (Sys.info()["sysname"] == "Linux") {
  cat("Using the binary repository.\n")
  outgoingRepos <- list(CRAN = binaryRepo)
  
  userAgentString <- shQuote(paste(
    "RStudio R (", version$major, ".", version$minor, " ", paste(
      version$platform, version$arch, version$os
    ), ")",
    sep = ""))
  
  cat(paste("Using user agent string:", userAgentString, "\n"))

  options(
    download.file.method = "curl",
    download.file.extra = paste("-L -f -w 'curl: HTTP %{http_code} %{url_effective}\n'", "-A", userAgentString)
  )
  
} else {
  cat("Using the source repository.\n")
  outgoingRepos <- list(CRAN = sourceRepo)
  
  options(
    download.file.method = "curl",
    download.file.extra = paste("-L -f -w 'curl: HTTP %{http_code} %{url_effective}\n'")
  )
}
packrat::set_lockfile_metadata(repos = outgoingRepos)

# My source is not helpful for others! Maybe use a temporary directory?
# If we do not remove the src directory, we will magically re-use previously downloaded packages.
cat("removing packrat/src\n")
unlink("packrat/src", recursive = TRUE)

packrat::restore()
svr <- httpuv::startServer("127.0.0.1", 5000, list(call = function(req) list(status = 200)))
httpuv::stopServer(svr)
cat("All OK!\n")
# httpuv::runServer("127.0.0.1", 5000, list(call = function(req) list(status = 200)))