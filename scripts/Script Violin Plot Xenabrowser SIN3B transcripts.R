# This script loads the XenaBrowser GTEX and TCGA datasets for SIN3B transcripts
# Violin Plots of SIN3B expression in TCGA vs GTEX

library(ggplot2)
library(ggpubr)
library(reshape2)
library(munsell)
library(ggsci) # Color palettes inspired by scientific journals

setwd("~/Paper SIN3B/Figures")

# Read table
data <- read.table('GTEX_vs_TCGA_SIN3B_transcripts.csv',sep = ';', header = TRUE, row.names = ) 

# Retrieve protein coding transcripts
data.merge <- melt(data,id.vars='Study', measure.vars=c('SIN3B_201','SIN3B_209','SIN3B_202', 'SIN3B_208', 'SIN3B_206'))

# Violin plots with box plots inside
# Change fill color by Study
# Add boxplot with white fill color
# Assigning the different transcripts to variable column and the frequency values to value column 
my_comparisons <- list(c("GTEX", "TCGA")) 
box <- ggviolin(data.merge, "Study", "value", fill = "Study", add = "boxplot")+
  facet_wrap(~variable, nrow = 1)+
  stat_compare_means(comparisons = my_comparisons, method = "t.test", label.y = 88, label = "p.signif")+
  scale_fill_lancet() # Lancet palette
box

# Labeling x and y axis
box <- box + ggtitle("Normal Skin vs Cutaneous Melanoma") + 
  ylab("SIN3B protein-coding \ntranscripts (RNA seq) \n Isoform Frequency (%)")
box
# Title to the center
box <- box + theme(plot.title = element_text(hjust = 0.5))
box
