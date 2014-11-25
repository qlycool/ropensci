## Start with the rstudio image providing 'base R' as well as RStudio based on Debian testing
FROM rocker/hadleyverse
MAINTAINER Carl Boettiger cboettig@ropensci.org

## Refresh package list and upgrade
RUN apt-get update && apt-get install -y --no-install-recommends \
    gdal-bin \
    libxslt1-dev \
    libgeos-dev \
    libgeos-c1 \
    libgdal1h \
    libgdal1-dev \
    libproj-dev \
    netcdf-bin \
    python-pip 

## Install additional Omegahat dependencies 
RUN rm -rf /tmp/*.rds \
&& install2.r --error --repos http://www.omegahat.org/R \
    Rcompression \
    RHTMLForms \
    ROOXML \
    RWordXML \
    SSOAP \
    Sxslt \
    XMLSchema \
||  installGithub.r \
    omegahat/Rcompression \
    omegahat/RHTMLForms \
    duncantl/ROOXML \
    duncantl/RWordXML \
    omegahat/XMLSchema \
    omegahat/SSOAP/Install \
    omegahat/Sxslt

## Install additional CRAN & Github dependencies
RUN rm -rf /tmp/*.rds \
    installGithub.r \
    DataONEorg/rdataone/dataonelibs \
    ropensci/rdataone/dataone \
    egonw/rrdf/rrdflibs \
    egonw/rrdf/rrdf \
    ramnathv/rcharts \
&&  install2.r --error \
    geiger \ 
    phylobase \
    phytools \
    knitcitations 

RUN install2.r --error --repos http://datacube.wu.ac.at Rcampdf \
&& Rscript -e 'source("http://bioconductor.org/biocLite.R"); biocLite("rhdf5", ask=FALSE); biocLite("BiocInstaller")' \
&& pip install retriever \
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds 


## Install build dependencies (not avaialble for Debian)
#RUN apt-get build-dep -y r-cran-rgeos r-cran-rgdal


## Install the rOpenSci R packages that are currently on CRAN
RUN install2.r --error \
  alm \
  AntWeb \
  aRxiv \
  bold \
  dvn \
  ecoengine \
  ecoretriever \
  paleobioDB \
  rAltmetric \
  rAvis \
  rbhl \
  rbison \
  rdryad \
  rebird \
  rentrez \
  Reol \
  rfigshare \
  rfishbase \
  rfisheries \
  rgbif \
  rinat \
  RNeXML \
  rnoaa \
  rplos \
  RSelenium \
  rsnps \
  rWBclimate \
  solr \
  spocc \
  taxize \
  treebase \
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds

