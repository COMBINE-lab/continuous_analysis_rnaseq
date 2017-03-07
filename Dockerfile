#
# Salmon version of Brett Beaulieu-Jones' original pipeline
#
FROM combinelab/salmon

MAINTAINER "Rob Patro" rob.patro@cs.stonybrook.edu

# Libraries for processing + quantifying RNA-Seq
RUN cd /home/
RUN apt-get install -y wget
RUN wget --output-document sratoolkit.tar.gz http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz
RUN tar -vxzf sratoolkit.tar.gz
RUN export PATH=$PATH:$PWD/sratoolkit.2.8.2-ubuntu64/bin

# Install helpful R libraries
RUN echo 'source("http://bioconductor.org/biocLite.R")' > /tmp/packages.R
RUN Rscript -e 'source("http://bioconductor.org/biocLite.R"); biocLite(c("rhdf5", "biomaRt", "edgeR", "genefilter", "calibrate"));'
RUN echo 'install.packages("devtools")' > /tmp/packages.R
RUN echo 'devtools::install_github("pachterlab/sleuth")' > /tmp/packages.R
RUN echo 'library("sleuth")' > /tmp/packages.R
RUN echo 'install.packages("ggplot2")' > /tmp/packages.R
RUN echo 'library("ggplot2")' > /tmp/packages.R
RUN echo 'install.packages("plyr")' > /tmp/packages.R
RUN echo 'library("plyr")' > /tmp/packages.R
RUN echo 'install.packages("RColorBrewer")' > /tmp/packages.R
RUN echo 'library("RColorBrewer")' > /tmp/packages.R
RUN echo 'install.packages("stringr")' > /tmp/packages.R
RUN echo 'library("stringr")' > /tmp/packages.R
RUN echo 'install.packages("plyr")' > /tmp/packages.R
RUN echo 'library("plyr")' > /tmp/packages.R

RUN Rscript /tmp/packages.R
