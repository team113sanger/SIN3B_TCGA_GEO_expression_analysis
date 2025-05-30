# This script loads the XenaBrowser GTEX and TCGA datasets
# Violin plots of SIN3B expression in TCGA vs GTEX
# PS: if installing of packages fails, run the line: options("install.lock"=FALSE)

library(ggplot2)
library(ggpubr)
library(munsell)
library(ggsci) # Color palettes inspired by scientific journals
library(here) 

# setwd("~/Paper SIN3B/Figures")

# Read table
data <- read.table(here('data/GSE8401__39705_at.csv'),sep = ',', header = TRUE)

# Violin plots with box plots inside
# Change fill color by Group
# Add boxplot with white fill color
# Color from Lancet palette
my_comparisons <- list(c("Primary Melanoma", "Metastatic Melanoma")) 

box <- ggviolin(data, x = "Group", y = "SIN3B_Expression", fill = "Group", add = "boxplot")+
  stat_compare_means(comparisons = my_comparisons, method = "t.test", label.y = 8, label = "p.signif")+
  scale_x_discrete(limits = c("Primary Melanoma", "Metastatic Melanoma")) +
  scale_fill_discrete(limits = c("Primary Melanoma", "Metastatic Melanoma")) +
#   scale_fill_lancet() + #Lancet palette 
  ggtitle("GSE8401") + 
  xlab("Tissue Type") +  # Labeling x and y axis
  ylab("Standardized SIN3B expression \n log2(count)") +
  theme(plot.title = element_text(hjust = 0.5)) + # Title to the center 
  scale_y_continuous(limits = c(4,9)) # Scale y axis
box

png(here('results/figures/GSE8401_violin_plot.png'), width = 800, height = 600)
box
dev.off()