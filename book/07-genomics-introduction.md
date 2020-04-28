


# (PART) Applications in Genomics {-} 

# Introduction {#genomic-introduction}

Circular visualization is popular in Genomics and related omics fields. It is
efficient in revealing associations in high dimensional genomic data. In genomic
plots, categories are usually chromosomes and data on x axes are genomic
positions, but it can also be any kind of general genomic categories.

To make is easy for Genomics analysis, **circlize** package particularly
provides functions which focus on genomic plots. These functions are
synonymous to the basic graphic functions but expect special format of input
data:

- `circos.genomicTrack()`: create a new track and add graphics.
- `circos.genomicPoints()`: low-level function, add points.
- `circos.genomicLines()`: low-level function, add lines or segments.
- `circos.genomicRect()`: low-level function, add rectangles.
- `circos.genomicText()`: low-level function, add text.
- `circos.genomicLink()`: add links.

The genomic functions are implemented by basic circlize functions (e.g.
`circos.track()`, `circos.points()`), thus, the use of genomic functions can
be mixed with the basic circlize functions.

## Input data {#input-data}

Genomic data is usually stored as a table where the first three columns
define the genomic regions and following columns are values associated with
the corresponding regions. Each genomic region is composed by three elements:
genomic category (in most case, it is the chromosome), start position on the
genomic category and the end position. Such data structure is known as 
[_BED_](https://genome.ucsc.edu/FAQ/FAQformat#format1)
format and is broadly used in genomic research.

**circlize** provides a simple function `generateRandomBed()` which generates
random genomic data. Positions are uniformly generated from human genome and
the number of regions on chromosomes approximately proportional to the length
of chromosomes. In the function, `nr` and `nc` control the number of rows and
numeric columns that users need. Please note `nr` are not exactly the same as
the number of rows which are returned by the function. `fun` argument is a
self-defined function to generate random values.


```r
set.seed(999)
bed = generateRandomBed()
head(bed)
```

```
##    chr   start     end       value1
## 1 chr1  118750  451929 -0.367702502
## 2 chr1  472114  805024 -0.001764946
## 3 chr1  807013  914103 -0.668379255
## 4 chr1 1058915 1081590  0.390291705
## 5 chr1 1194426 1341960 -1.305901261
## 6 chr1 1670402 2048723  0.340227447
```

```r
bed = generateRandomBed(nr = 200, nc = 4)
nrow(bed)
```

```
## [1] 205
```

```r
bed = generateRandomBed(nc = 2, fun = function(k) sample(letters, k, replace = TRUE))
head(bed)
```

```
##    chr   start     end value1 value2
## 1 chr1  275067  349212      q      e
## 2 chr1  350892  658970      u      f
## 3 chr1  674620  875538      y      r
## 4 chr1 1053255 1115056      p      e
## 5 chr1 1127139 1545066      a      s
## 6 chr1 1864092 1973553      x      u
```

All genomic functions in **circlize** expect input variable as a data frame
which contains genomic data or a list of data frames which contains genomic
data in different conditions.



