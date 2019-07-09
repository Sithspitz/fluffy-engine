########## Heatmap ############
## This will be examining average expression score from CyTOF TIDaL ##


#### SOURCE FUNCTIONS ####

setwd("Heatmap/")

data <- read.csv("case_averages_transposed.csv", header = T)

# Assign First Column as Row Names
rownames(data) <- data$X

# Remove first column
data2 <- as.matrix(subset(data, select = -c(X)))

hr <- hclust(as.dist(1-cor((data2), method = "pearson")), method = "single")
mycl <- cutree(hr, h=max(hr$height/1.12))
clusterRows <- rainbow(length(unique(mycl)))
myClusterSideBar <- clusterRows[mycl]
my_palette <- colorRampPalette(c("blue", "white", "red"))(n = 299)

cairo_pdf("heat4.pdf")
heatmap.2(data2,
          Rowv = as.dendrogram(hr),
          Colv = as.dendrogram(hr),
          dendrogram = "both",
          #dendrogram = "col",
          scale = "row",
          col = my_palette,
          density.info = "none",
          trace = "none",
          ColSideColors = myClusterSideBar,
          key = F,
          labCol = F,
          margins = c(13,12))
dev.off()









hr <- hclust(as.dist(1-cor((data2), method = "pearson")), method = "single")
mycl <- cutree(hr, h=max(hr$height/2))
clusterRows <- rainbow(length(unique(mycl)))
myClusterSideBar <- clusterRows[mycl]
my_palette <- colorRampPalette(c("blue", "white", "red"))(n = 299)

cairo_pdf("heat9.pdf")
heatmap.2(data2,
          Rowv = T,
          Colv = as.dendrogram(hr),
          dendrogram = "both",
          #dendrogram = "col",
          scale = "row",
          col = my_palette,
          density.info = "none",
          trace = "none",
          ColSideColors = myClusterSideBar,
          key = F,
          labCol = F,
          margins = c(13,12))
dev.off()



reorderfun = function(d, w) reorder(d, w),