--- 
title: "Circular Visualization in R"
author: "Zuguang Gu"
date: "last revised on 2022-05-10"
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
in the book are generated under version 0.4.15.

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
## R version 4.1.2 (2021-11-01)
## Platform: x86_64-apple-darwin17.0 (64-bit)
## Running under: macOS Big Sur 10.16
## 
## Matrix products: default
## BLAS:   /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRblas.0.dylib
## LAPACK: /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRlapack.dylib
## 
## locale:
## [1] C/UTF-8/C/C/C/C
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] circlize_0.4.15
## 
## loaded via a namespace (and not attached):
##  [1] bookdown_0.24       digest_0.6.29       R6_2.5.1           
##  [4] grid_4.1.2          jsonlite_1.7.2      magrittr_2.0.1     
##  [7] evaluate_0.14       stringi_1.7.6       rlang_0.4.12       
## [10] GlobalOptions_0.1.2 jquerylib_0.1.4     bslib_0.3.1        
## [13] rmarkdown_2.11      tools_4.1.2         stringr_1.4.0      
## [16] xfun_0.29           yaml_2.2.1          fastmap_1.1.0      
## [19] compiler_4.1.2      colorspace_2.0-2    shape_1.4.6        
## [22] htmltools_0.5.2     knitr_1.37          sass_0.4.0
```
