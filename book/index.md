
--- 
title: "Circular Visualization in R"
author: "Zuguang Gu"
date: "last revised on 2020-04-28"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib]
biblio-style: apalike
link-citations: yes
github-repo: jokergoo/circlize_book
cover-image: images/circlize_cover.jpg
url: 'https\://bookdown.org/jokergoo/circlize-book/book'
description: "This book provides a comprehensive overview of implementing circular visualization in R by cirlize package, espeically focusing on visualizaing high dimentional genomic data and revealing complex relationships by Chord diagram."
---

# About {-}

This is the documentation of the
[**circlize**](https://cran.r-project.org/package=circlize) package. Examples
in the book are generated under version 0.4.9.

If you use **circlize** in your publications, I am appreciated if you can cite:

Gu, Z. (2014) circlize implements and enhances circular visualization in R.
Bioinformatics. DOI:
[10.1093/bioinformatics/btu393](https://doi.org/10.1093/bioinformatics/btu393)

<img src="images/circlize_cover.jpg" style="width:500px;border:2px solid black;" />

Session info:


```r
sessionInfo()
```

```
## R version 3.6.0 (2019-04-26)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: CentOS Linux 7 (Core)
## 
## Matrix products: default
## BLAS:   /usr/lib64/libblas.so.3.4.2
## LAPACK: /usr/lib64/liblapack.so.3.4.2
## 
## locale:
##  [1] LC_CTYPE=en_GB.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_GB.UTF-8        LC_COLLATE=en_GB.UTF-8    
##  [5] LC_MONETARY=en_GB.UTF-8    LC_MESSAGES=en_GB.UTF-8   
##  [7] LC_PAPER=en_GB.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_GB.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] circlize_0.4.9
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.4          bookdown_0.17       digest_0.6.25      
##  [4] grid_3.6.0          magrittr_1.5        evaluate_0.14      
##  [7] rlang_0.4.5         stringi_1.4.6       GlobalOptions_0.1.1
## [10] rmarkdown_1.18      tools_3.6.0         stringr_1.4.0      
## [13] xfun_0.13           yaml_2.2.1          compiler_3.6.0     
## [16] colorspace_1.4-1    shape_1.4.4         htmltools_0.4.0    
## [19] knitr_1.28
```
