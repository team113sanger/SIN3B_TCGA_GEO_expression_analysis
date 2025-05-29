# This script loads the XenaBrowser GTEX and TCGA datasets
# Violin plots of SIN3B expression in TCGA vs GTEX
# PS: if installing of packages fails, run the line: options("install.lock"=FALSE)

library(ggplot2)
library(ggpubr)
library(munsell)
library(ggsci) # Color palettes inspired by scientific journals

setwd("~/Paper SIN3B/Figures")

# Read table
data <- read.table('GSE46517__39705_at_subset.csv',sep = ',', header = TRUE, row.names = ) 

# Violin plots with box plots inside
# Change fill color by Group
# Add boxplot with white fill color
# Color from Lancet palette
my_comparisons <- list(c("Nevus", "Primary Melanoma"), c("Nevus", "Metastatic Melanoma"), c("Primary Melanoma", "Metastatic Melanoma")) 

box <- ggviolin(data, x = "Group", y = "SIN3B_Expression", fill = "Group", add = "boxplot")+
  stat_compare_means(comparisons = my_comparisons, method = "t.test", label.y = c(8.5, 9.0, 9.5), label = "p.signif")+
  scale_x_discrete(limits = c("Nevus", "Primary Melanoma", "Metastatic Melanoma")) +
  scale_fill_discrete(limits = c("Nevus", "Primary Melanoma", "Metastatic Melanoma"))
  scale_fill_lancet() #Lancet palette
box

# Labeling x and y axis
box <- box + ggtitle("GSE46517") + xlab("Tissue Type") + 
  ylab("Standardized SIN3B expression \n log2(count)")
box

# Title to the center
box <- box + theme(plot.title = element_text(hjust = 0.5))
box

# Scale y axis
box <- box + scale_y_continuous(limits = c(5,10))
box