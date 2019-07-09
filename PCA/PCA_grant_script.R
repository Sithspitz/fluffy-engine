############# PCA Grant Application ################
## This will be examining average expression score from CyTOF TIDaL ##

#### FOR GGBIPLOT TO WORK NEED TO ROLL BACK TO R 3.5.0 ####

library(utils)
library(tidyverse)
library(tibble)
library(devtools)

install_github("vqv/ggbiplot")
library(ggbiplot)

setwd("PCA/")

data <- read.csv("case_averages.csv", stringsAsFactors = F, header = T)

# Assign First Column as Row Names
rownames(data) <- data$X

# Remove first column
data2 <- subset(data, select = -c(X))

# PCA and Plot
pca_output <- prcomp(data2, center = T, scale. = T)

cairo_pdf("grant_pca_CyTOF_data_with_markers.pdf")
ggbiplot(pca_output, labels = rownames(data2))
dev.off()

cairo_pdf("grant_pca_CyTOF_data.pdf")
ggbiplot(pca_output, labels = rownames(data2), var.axes = F)
dev.off()


