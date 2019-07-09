########## Heatmap ############
## This will be examining average expression score from CyTOF TIDaL ##


#### SOURCE FUNCTIONS ####

setwd("Heatmap/")

data <- read.csv("case_averages_omitted_transposed.csv", header = T)

# Assign First Column as Row Names
rownames(data) <- data$X

# Remove first column
data2 <- as.matrix(subset(data, select = -c(X)))

hr <- hclust(as.dist(1-cor((data2), method = "pearson")), method = "single")
mycl <- cutree(hr, h=max(hr$height/1.12))
clusterRows <- rainbow(length(unique(mycl)))
myClusterSideBar <- clusterRows[mycl]
my_palette <- colorRampPalette(c("blue", "white", "red"))(n = 299)

cairo_pdf("grant_heatmap.pdf")
heatmap.2(data2,
          Rowv = F,
          Colv = as.dendrogram(hr),
          dendrogram = "col",
          #dendrogram = "col",
          scale = "row",
          col = my_palette,
          density.info = "none",
          trace = "none",
          ColSideColors = myClusterSideBar,
          key = F,
          labCol = F,
          margins = c(13,12),
          key.xlab = T)
dev.off()

