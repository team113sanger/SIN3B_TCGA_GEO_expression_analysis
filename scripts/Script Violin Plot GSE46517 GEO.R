# This script loads the XenaBrowser GTEX and TCGA datasets
# Violin plots of SIN3B expression in TCGA vs GTEX
# PS: if installing of packages fails, run the line: options("install.lock"=FALSE)

library(ggplot2)
library(ggpubr)
library(munsell)
library(here)
library(ggsci) # Color palettes inspired by scientific journals


# Read table
data <- read.table(here('data/GSE46517__39705_at_subset.csv'),sep = ',', header = TRUE)

# Violin plots with box plots inside
# Change fill color by Group
# Add boxplot with white fill color
# Color from Lancet palette
my_comparisons <- list(c("Nevus", "Primary Melanoma"), c("Nevus", "Metastatic Melanoma"), c("Primary Melanoma", "Metastatic Melanoma")) 

box <- ggviolin(data, x = "Group", y = "SIN3B_Expression", fill = "Group", add = "boxplot")+
  stat_compare_means(comparisons = my_comparisons, method = "t.test", label.y = c(8.5, 9.0, 9.5), label = "p.signif")+
  scale_x_discrete(limits = c("Nevus", "Primary Melanoma", "Metastatic Melanoma")) +
  scale_fill_discrete(limits = c("Nevus", "Primary Melanoma", "Metastatic Melanoma"))
  scale_fill_lancet() + #Lancet palette
  ggtitle("GSE46517") + 
  xlab("Tissue Type") + 
  ylab("Standardized SIN3B expression \n log2(count)") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_y_continuous(limits = c(5,10))
box


png(here('results/figures/GSE46517_violin_plot.png'), width = 800, height = 600)
box
dev.off()