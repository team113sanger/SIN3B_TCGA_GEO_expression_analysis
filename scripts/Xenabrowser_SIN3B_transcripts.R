# This script loads the XenaBrowser GTEX and TCGA datasets for SIN3B transcripts
# Violin Plots of SIN3B expression in TCGA vs GTEX

library(ggplot2)
library(ggpubr)
library(reshape2)
library(munsell)
library(ggsci) # Color palettes inspired by scientific journals
library(here)
library(tidyverse)

# Read table
data <- read_csv(here('data/GTEX_vs_TCGA_SIN3B_transcripts.csv'))

# Retrieve protein coding transcripts
# data.merge <- melt(data,id.vars='Study', measure.vars=c('SIN3B_201','SIN3B_209','SIN3B_202', 'SIN3B_208', 'SIN3B_206'))

data.merge <- data |> pivot_longer(cols = contains("SIN3B"),
           names_to = 'variable', values_to = 'value')
# Violin plots with box plots inside
# Change fill color by Study
# Add boxplot with white fill color
# Assigning the different transcripts to variable column and the frequency values to value column 
my_comparisons <- list(c("GTEX", "TCGA")) 
box <- ggviolin(data.merge, "Study", "value", fill = "Study", add = "boxplot")+
  facet_wrap(~variable, nrow = 1)+
  stat_compare_means(comparisons = my_comparisons, method = "t.test", label.y = 88, label = "p.signif")+
  #scale_fill_lancet() + # Lancet palette  
  ggtitle("Normal Skin vs Cutaneous Melanoma") + 
  ylab("SIN3B protein-coding \ntranscripts (RNA seq) \n Isoform Frequency (%)") + 
  theme(plot.title = element_text(hjust = 0.5))
box

png(here('results/figures/Xenabrowser_GTEX_VS_TCGA_violin_plot_transcripts.png'), width = 800, height = 600)
box
dev.off()