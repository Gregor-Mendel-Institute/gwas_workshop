#' Manhattan Plot Generator for GWAS Results
#'
#' This function takes in a dataframe containing GWAS results and produces a
#' Manhattan plot visualizing the results.
#'
#' @author Anna Igolkina
#'
#' @param results A dataframe containing GWAS results.
#' @param s.pos The column name in results for the position.
#' @param s.chr The column name in results for the chromosome.
#' @param s.pval The column name in results for the p-value.
#' @param chr.lengths Vector of chromosome lengths, if NULL, they are inferred from the data.
#' @param alpha Alpha value for the plot points.
#' @param s.xlab X-axis label.
#' @param s.ylab Y-axis label, default is "-log10(p-value)".
#' @param s.title Title for the plot.
#' @param col.signif Color for the significance threshold.
#' @param col.chr Vector of colors for even and odd chromosomes.
#' @param padj.method Adjustment method for p-values.
#' @param p.sign.theshold Threshold for significant p-values.
#'
#' @return A ggplot object representing the Manhattan plot.
#'
#' @examples
#' # Assuming df is your dataframe containing GWAS results.
#' ggmanhattan(df, s.pos='POS', s.chr='CHR', s.pval='PVALUE')
ggmanhattan <- function(results,
                        s.pos = 'pos',
                        s.chr = 'chr',
                        s.pval = 'pvalue',
                        chr.lengths = NULL,
                        alpha = 0.5,
                        s.xlab = NULL,
                        s.ylab = "-log10(p-value)",
                        s.title = "Manhattan Plot",
                        col.signif = "#D71313",
                        col.chr = c("#7B8FA1", "#27374D"),
                        padj.method = 'BH',
                        p.sign.theshold = 0.01) {
  
  if (is.null(chr.lengths)) {
    chr.lengths <- tapply(results[, s.pos], results[, s.chr], max)
  }
  
  cum.chr.len <- c(0, cumsum(chr.lengths))
  df <- data.frame(
    pos = results[, s.pos] + cum.chr.len[results[, s.chr]],
    y = results[, s.pval],
    chr.even = results[, s.chr] %% 2
  )
  
  df$adj_pvalue <- p.adjust(df$y, method = padj.method)
  if(sum(df$adj_pvalue <= 0.01) == 0){
    message('No significant markers')
    p.sign.value.log10 = Inf
  } else {
    p.sign.value <- max(df$y[df$adj_pvalue <= p.sign.theshold])
    p.sign.value.log10 <- -log10(p.sign.value)
  }
  
  
  p.man <- ggplot(df, aes(x = pos, y = -log10(y), color = as.factor(chr.even))) +
    geom_point(alpha = alpha) +
    geom_hline(yintercept = p.sign.value.log10, color = col.signif) +
    theme_bw() +
    labs(title = s.title, x = s.xlab, y = s.ylab) +
    scale_color_manual(values = col.chr) +
    theme(legend.position = "none") +
    scale_x_continuous(
      expand = c(0.01, 0.01),
      breaks = (cum.chr.len[-1] + cum.chr.len[-length(cum.chr.len)]) / 2,
      labels = 1:(length(cum.chr.len) - 1)
    ) +
    theme(panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank())
  
  return(p.man)
}


#' QQ plot for p-values using ggplot2
#'
#' This function creates a quantile-quantile (QQ) plot using the `ggplot2` package. It visualizes the distribution of observed p-values against the expected uniform distribution.
#'
#' @author Anna Igolkina
#' 
#' @param results Dataframe containing the p-values.
#' @param s.pval String, column name in the `results` dataframe which contains the p-values. Default is 'pvalue'.
#'
#' @return A ggplot2 object of the QQ plot.
qqplot <- function(results, s.pval = 'pvalue',
                   s.xlab = "expected -log10 pvalues",
                   s.ylab = "observed -log10 pvalues",
                   s.title = NULL){
  expected <- -log10(qunif((rank(results[,s.pval]) - 0.5) / length(results[,s.pval])))
  observed <- -log10(results[,s.pval])
  
  # Create a dataframe for plotting
  df_qq <- data.frame(expected, observed)
  
  # Create QQ plot
  p <- ggplot(df_qq, aes(x=expected, y=observed)) + 
    geom_point() + 
    geom_abline(intercept = 0, slope = 1, color = "#D71313") + 
    xlab(s.xlab) + 
    ylab(s.ylab) + 
    ggtitle(s.title) + 
    theme_bw()
  
  return(p)
}



# Very old version of Manhattan plot made by Daniele's or Pieter's code...
### ### ### ### ### ### ### ### ### ### ### ### 
### plotting -log10 p-value across the genome by chromosome
###
### results = results from notebook 2 (a dataframe with size nsnps x 5)
### (function uses the column headers, so don't change those!)
### chr.lengths = vector of the lengths of each chromosome in bp
### title = stsring with plot title
###
### Usage:
# at.chr.lengths <- c(30427671,19698289,23459830,18585056,26975502) # the lengths of the 5 chromosomes in A. thaliana
# manhattan.plot(results=results.nc, chr.lengths=at.chr.lengths, title="Without K correction")
# manhattan.plot(results=results.maf1, chr.lengths=at.chr.lengths,title="Minor allele frequency cutoff of 1%")
###
### ### ### ### ### ### ### ### ### ### ### ### 
manhattan.plot <- function(results, chr.lengths, title){
  at.chr.lengths <- c(30427671,19698289,23459830,18585056,26975502) # the lengths of the 5 chromosomes in A. thaliana
  # the plot will change colors to denote new chromsomes.  This section lays the groundwork for this
  chr.add <- c(0,cumsum(chr.lengths))[1:5]
  max.bp <- sum(chr.lengths)
  chr.colors <- rep(c("blue", "dodgerblue"),ceiling(length(chr.lengths/2)))
  chr.mids <- chr.add + (chr.lengths/2)
  results.s <- split(results, results$chr)
  
  # make the actual plot 
  # generate an empty plot with the right dimensions
  plot(results$pos,-log10(results$pvalue), xlim=c(0,max.bp), type="n", xlab="Chromosome", ylab="-log10 p-value", xaxt="n", main=title)
  # set up the x axis
  axis(1,at=chr.mids,labels=c(1:5))
  # does plotting by chromosome
  for(up.chr in 1:length(results.s)){
    #print(up.chr)
    up.c <- results.s[[up.chr]]
    up.add <- chr.add[up.chr]
    up.c$pos.plot <- up.c$pos + up.add
    points(up.c$pos.plot, -log10(up.c$pvalue), col=chr.colors[up.chr])
  }
  # adds Bonferroni cutoff
  bon.cutoff = 0.05/nrow(results)
  abline(h=-log10(bon.cutoff), col="red", lty=2)
  
}