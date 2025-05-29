# This script loads the XenaBrowser GTEX and TCGA datasets
# Violin plots of SIN3B expression in TCGA vs GTEX
# PS: if installing of packages fails, run the line: options("install.lock"=FALSE)

library(ggplot2)
library(ggpubr)
library(munsell)
library(ggsci) # Color palettes inspired by scientific journals
library(here)
library(readr)

# Read table
data <- read_csv(here('data/GTEX_vs_TCGA_SIN3B.csv'))

# Violin plots with box plots inside
# Change fill color by Study
# Add boxplot with white fill color
# Color from Cosmic palette
my_comparisons <- list(c("GTEX", "TCGA")) 
box <- ggviolin(data, x = "Study", y = "SIN3B_expression", fill = "Study", add = "boxplot")+
  stat_compare_means(comparisons = my_comparisons, method = "t.test", label.y = 14, label = "p.signif")+
  scale_fill_lancet() + # Lancet palette 
  ggtitle("Normal Skin vs Cutaneous Melanoma") + 
  xlab("Study") + 
  ylab("SIN3B expression (RNA seq) \n RSEM count DESEq2 standardized \n log2(count +1)") + 
  theme(plot.title = element_text(hjust = 0.5))
box



png(here('results/figures/Xenabrowser_GTEX_VS_TCGA_violin_plot.png'), width = 800, height = 600)
box
dev.off()