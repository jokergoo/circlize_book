


# Advanced usage of `chordDiagram()`

The default style of `chordDiagram()` is somehow enough for most visualization
tasks, still you can have more configurations on the plot.

The usage is same for both ajacency matrix and ajacency list, so we only
demonstrate with the matrix.

## Organization of tracks

By default, `chordDiagram()` creates two tracks, one track for labels and one
track for grids with axes.


```r
chordDiagram(mat)
circos.info()
```

```
## All your sectors:
## [1] "S1" "S2" "S3" "E1" "E2" "E3" "E4" "E5" "E6"
## 
## All your tracks:
## [1] 1 2
## 
## Your current sector.index is E6
## Your current track.index is 2
```

These two tracks can be controlled by `annotationTrack` argument. Available
values for this argument are `grid`, `name` and `axis`. The height of
annotation tracks can be set by `annotationTrackHeight` which is the
percentage to the radius of unit circle and can be set by `uh()` function with
an absolute unit. Axes are only added if `grid` is set in `annotationTrack` 
(Figure \@ref(fig:chord-diagram-default-track)).


```r
chordDiagram(mat, grid.col = grid.col, annotationTrack = "grid")
chordDiagram(mat, grid.col = grid.col, annotationTrack = c("name", "grid"),
    annotationTrackHeight = c(0.03, 0.01))
chordDiagram(mat, grid.col = grid.col, annotationTrack = NULL)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-advanced-usage_files/figure-html/chord-diagram-default-track-1.svg" alt="Track organization in `chordDiagram()`." width="768" />
<p class="caption">(\#fig:chord-diagram-default-track)Track organization in `chordDiagram()`.</p>
</div>

Several empty tracks can be allocated before Chord diagram is drawn. Then self-defined graphics can
be added to these empty tracks afterwards. The number of pre-allocated tracks can be set 
through `preAllocateTracks`.


```r
chordDiagram(mat, preAllocateTracks = 2)
circos.info()
```

```
## All your sectors:
## [1] "S1" "S2" "S3" "E1" "E2" "E3" "E4" "E5" "E6"
## 
## All your tracks:
## [1] 1 2 3 4
## 
## Your current sector.index is E6
## Your current track.index is 4
```

The default settings for pre-allocated tracks are:


```r
list(ylim = c(0, 1),
     track.height = circos.par("track.height"),
     bg.col = NA,
     bg.border = NA,
     bg.lty = par("lty"),
     bg.lwd = par("lwd"))
```

The default settings for pre-allocated tracks can be overwritten by specifying `preAllocateTracks`
as a list.


```r
chordDiagram(mat, annotationTrack = NULL,
    preAllocateTracks = list(track.height = 0.3))
```

If more than one tracks need to be pre-allocated, just specify `preAllocateTracks`
as a list which contains settings for each track:


```r
chordDiagram(mat, annotationTrack = NULL,
    preAllocateTracks = list(list(track.height = 0.1),
                             list(bg.border = "black")))
```

By default `chordDiagram()` provides poor supports for customization of sector
labels and axes, but with `preAllocateTracks` it is rather easy to customize
them. Such customization will be introduced in next section.

## Customize sector labels

In `chordDiagram()`, there is no argument to control the style of sector
labels, but this can be done by first pre-allocating an empty track and
customizing the labels in it later. In the following example, one track is
firstly allocated and a Chord diagram is added without label track and axes.
Later, the first track is updated with adding labels with clockwise facings
(Figure \@ref(fig:chord-diagram-labels-show)).


```r
chordDiagram(mat, grid.col = grid.col, annotationTrack = "grid", 
    preAllocateTracks = list(track.height = max(strwidth(unlist(dimnames(mat))))))
# we go back to the first track and customize sector labels
circos.track(track.index = 1, panel.fun = function(x, y) {
    circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
        facing = "clockwise", niceFacing = TRUE, adj = c(0, 0.5))
}, bg.border = NA) # here set bg.border to NA is important
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-advanced-usage_files/figure-html/chord-diagram-labels-show-1.svg" alt="Change label directions." width="384" />
<p class="caption">(\#fig:chord-diagram-labels-show)Change label directions.</p>
</div>

In the following example, the labels are put on the grids (Figure \@ref(fig:chord-diagram-labels-inside)). 
Please note `circos.text()` and
`get.cell.meta.data()` can be used outside `panel.fun` if the sector index and
track index are specified explicitly.


```r
chordDiagram(mat, grid.col = grid.col, 
    annotationTrack = c("grid", "axis"), annotationTrackHeight = uh(5, "mm"))
for(si in get.all.sector.index()) {
    xlim = get.cell.meta.data("xlim", sector.index = si, track.index = 1)
    ylim = get.cell.meta.data("ylim", sector.index = si, track.index = 1)
    circos.text(mean(xlim), mean(ylim), si, sector.index = si, track.index = 1, 
        facing = "bending.inside", niceFacing = TRUE, col = "white")
}
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-advanced-usage_files/figure-html/chord-diagram-labels-inside-1.svg" alt="Put sector labels to the grid." width="384" />
<p class="caption">(\#fig:chord-diagram-labels-inside)Put sector labels to the grid.</p>
</div>

For the last example in this section, if the width of the sector is less than
20 degree, the labels are added in the radical direction (Figure \@ref(fig:chord-diagram-labels-multile-style)).


```r
set.seed(123)
mat2 = matrix(rnorm(100), 10)
chordDiagram(mat2, annotationTrack = "grid", 
    preAllocateTracks = list(track.height = max(strwidth(unlist(dimnames(mat))))))
circos.track(track.index = 1, panel.fun = function(x, y) {
    xlim = get.cell.meta.data("xlim")
    xplot = get.cell.meta.data("xplot")
    ylim = get.cell.meta.data("ylim")
    sector.name = get.cell.meta.data("sector.index")

    if(abs(xplot[2] - xplot[1]) < 20) {
        circos.text(mean(xlim), ylim[1], sector.name, facing = "clockwise",
            niceFacing = TRUE, adj = c(0, 0.5), col = "red")
    } else {
        circos.text(mean(xlim), ylim[1], sector.name, facing = "inside", 
            niceFacing = TRUE, adj = c(0.5, 0), col= "blue")
    }
}, bg.border = NA)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-advanced-usage_files/figure-html/chord-diagram-labels-multile-style-1.svg" alt="Adjust label direction according to the width of sectors." width="384" />
<p class="caption">(\#fig:chord-diagram-labels-multile-style)Adjust label direction according to the width of sectors.</p>
</div>

When you set direction of sector labels as radical (`clockwise` or
`reverse.clockwise`), if the labels are too long and exceed your figure
region, you can either decrease the size of the font or set `canvas.xlim` and
`canvas.ylim` parameters in `circos.par()` to wider intervals.

## Customize sector axes

Axes are helpful to correspond to the absolute values of links. By default
`chordDiagram()` adds axes on the grid track. But it is easy to customize one
with self-defined code.

In following example code, we draw another type of axes which show relative
percent on sectors. We first pre-allocate an empty track by
`preAllocateTracks` and come back to this track to add axes later.

You may see we add the first axes to the top of second track. You can also
put them to the bottom of the first track.


```r
# similar as the previous example, but we only plot the grid track
chordDiagram(mat, grid.col = grid.col, annotationTrack = "grid", 
    preAllocateTracks = list(track.height = uh(5, "mm")))
for(si in get.all.sector.index()) {
    circos.axis(h = "top", labels.cex = 0.3, sector.index = si, track.index = 2)
}
```

Now we go back to the first track to add the second type of axes and sector names.
In `panel.fun`, if the sector is less than 30 degree, the break for the axis is set to 0.5
(Figure \@ref(fig:chord-diagram-axes)).



```r
# the second axis as well as the sector labels are added in this track
circos.track(track.index = 1, panel.fun = function(x, y) {
    xlim = get.cell.meta.data("xlim")
    ylim = get.cell.meta.data("ylim")
    sector.name = get.cell.meta.data("sector.index")
    xplot = get.cell.meta.data("xplot")
    
    circos.lines(xlim, c(mean(ylim), mean(ylim)), lty = 3) # dotted line
    by = ifelse(abs(xplot[2] - xplot[1]) > 30, 0.2, 0.5)
    for(p in seq(by, 1, by = by)) {
        circos.text(p*(xlim[2] - xlim[1]) + xlim[1], mean(ylim) + 0.1, 
            paste0(p*100, "%"), cex = 0.3, adj = c(0.5, 0), niceFacing = TRUE)
    }
    
    circos.text(mean(xlim), 1, sector.name, niceFacing = TRUE, adj = c(0.5, 0))
}, bg.border = NA)
circos.clear()
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-advanced-usage_files/figure-html/chord-diagram-axes-1.svg" alt="Customize sector axes for Chord diagram." width="576" />
<p class="caption">(\#fig:chord-diagram-axes)Customize sector axes for Chord diagram.</p>
</div>

## Put horizontally or vertically symmetric

In Chord diagram, when there are two groups (which correspond to rows and columns
if the input is an adjacency matrix), it is always visually beautiful to rotate the diagram
to be symmetric on horizontal direction or vertical direction. See following example:


```r
par(mfrow = c(1, 2))
circos.par(start.degree = 0)
chordDiagram(mat, grid.col = grid.col, big.gap = 20)
abline(h = 0, lty = 2, col = "#00000080")
circos.clear()

circos.par(start.degree = 90)
chordDiagram(mat, grid.col = grid.col, big.gap = 20)
abline(v = 0, lty = 2, col = "#00000080")
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-advanced-usage_files/figure-html/chord-diagram-sym-1.svg" alt="Rotate Chord diagram." width="768" />
<p class="caption">(\#fig:chord-diagram-sym)Rotate Chord diagram.</p>
</div>

```r
circos.clear()
```

## Compare two Chord diagrams

Normally, in Chord diagram, values in `mat` are normalized to the summation of
the absolute values in the matrix, which means the width for links only
represents relative values. Then, when comparing two Chord diagrams, it is
necessary that unit width of links in the two plots should be represented in a
same scale. This problem can be solved by adding larger gaps to the Chord
diagram which has smaller matrix.

First we make the "big" Chord diagram.


```r
mat1 = matrix(sample(20, 25, replace = TRUE), 5)
chordDiagram(mat1, directional = 1, grid.col = rep(1:5, 2), transparency = 0.5,
    big.gap = 10, small.gap = 1) # 10 and 1 are default values for the two arguments
```

The second matrix only has half the values in `mat1`.


```r
mat2 = mat1 / 2
```

`calc_gap()` can be used to calculate the gap for the second Chord diagram
to make the scale of the two Chord diagram the same.


```r
gap = calc_gap(mat1, mat2, big.gap = 10, small.gap = 1)
chordDiagram(mat2, directional = 1, grid.col = rep(1:5, 2), transparency = 0.5,
    big.gap = gap, small.gap = 1)
```

Now the scale of the two Chord diagrams (Figure \@ref(fig:chord-diagram-compare)) are the 
same if you compare the scale of axes in the two diagrams.

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-advanced-usage_files/figure-html/chord-diagram-compare-1.svg" alt="Compare two Chord Diagrams in a same scale." width="768" />
<p class="caption">(\#fig:chord-diagram-compare)Compare two Chord Diagrams in a same scale.</p>
</div>

To correctly use the functionality of `calc_gap()`, the two Chord diagram should
have same value for `small.gap` and there should be no overlap between the two
sets of the sectors.

## Multiple-group Chord diagram

Generally `chordDiagram()` function visualizes relations between two groups
(i.e. from rows to columns if the input is an adjacency matrix or from column
1 to column 2 if the input is an adjacency list), however, for
`chordDiagram()`, it actually doesn't need any grouping information. The
visual effect of grouping is just enhanced by setting different gap degrees.
In this case, it is easy to make a Chord diagram with more than two groups.

First let's generate three matrix which contain pairwise relations from three groups:


```r
options(digits = 2)
mat1 = matrix(rnorm(25), nrow = 5)
rownames(mat1) = paste0("A", 1:5)
colnames(mat1) = paste0("B", 1:5)

mat2 = matrix(rnorm(25), nrow = 5)
rownames(mat2) = paste0("A", 1:5)
colnames(mat2) = paste0("C", 1:5)

mat3 = matrix(rnorm(25), nrow = 5)
rownames(mat3) = paste0("B", 1:5)
colnames(mat3) = paste0("C", 1:5)
```

Since `chordDiagram()` only accepts one single matrix, here the three
matrix are merged into one big matrix.


```r
mat = matrix(0, nrow = 10, ncol = 10)
rownames(mat) = c(rownames(mat2), rownames(mat3))
colnames(mat) = c(colnames(mat1), colnames(mat2))
mat[rownames(mat1), colnames(mat1)] = mat1
mat[rownames(mat2), colnames(mat2)] = mat2
mat[rownames(mat3), colnames(mat3)] = mat3
mat
```

```
##       B1    B2     B3     B4    B5     C1     C2    C3    C4    C5
## A1  0.98  3.24  0.517  2.128  0.44 -0.866  0.754 -0.90 -0.61  0.54
## A2 -0.37 -0.42  0.369 -0.741 -0.46 -0.236 -0.499 -1.31 -1.19 -0.41
## A3  1.05  0.30 -0.215 -1.096 -1.06 -0.197  0.214  2.00  2.20 -0.48
## A4 -1.05  0.64  0.065  0.038  1.26  1.110 -0.325  0.60  1.31 -0.79
## A5 -1.26 -0.48 -0.034  0.310 -0.35  0.085  0.095 -1.25 -0.27 -0.59
## B1  0.00  0.00  0.000  0.000  0.00  1.651 -0.516 -1.24  0.71  0.88
## B2  0.00  0.00  0.000  0.000  0.00 -0.054 -0.993 -1.28 -0.36 -1.02
## B3  0.00  0.00  0.000  0.000  0.00  0.119  1.676 -0.57  0.06  1.96
## B4  0.00  0.00  0.000  0.000  0.00  0.244 -0.441  0.62 -0.70 -0.09
## B5  0.00  0.00  0.000  0.000  0.00  1.232 -0.723  1.11 -0.72  0.21
```

When making the chord diagram, we set larger gaps between groups to identify different groups.
Here we manually adjust `gap.after` in `circos.par()`.

Also we add an additional track in which we add lines to enhance the visual effect of different groups.


```r
library(circlize)
circos.par(gap.after = rep(c(rep(1, 4), 8), 3))
```

```
## Warning: 'gap.degree' can only be modified before `circos.initialize`, or maybe
## you forgot to call `circos.clear` in your last plot.
```

```r
chordDiagram(mat, annotationTrack = c("grid", "axis"),
    preAllocateTracks = list(
        track.height = uh(4, "mm"),
        track.margin = c(uh(4, "mm"), 0)
))
circos.track(track.index = 2, panel.fun = function(x, y) {
    sector.index = get.cell.meta.data("sector.index")
    xlim = get.cell.meta.data("xlim")
    ylim = get.cell.meta.data("ylim")
    circos.text(mean(xlim), mean(ylim), sector.index, cex = 0.6, niceFacing = TRUE)
}, bg.border = NA)

highlight.sector(rownames(mat1), track.index = 1, col = "red", 
    text = "A", cex = 0.8, text.col = "white", niceFacing = TRUE)
highlight.sector(colnames(mat1), track.index = 1, col = "green", 
    text = "B", cex = 0.8, text.col = "white", niceFacing = TRUE)
highlight.sector(colnames(mat2), track.index = 1, col = "blue", 
    text = "C", cex = 0.8, text.col = "white", niceFacing = TRUE)
```

<img src="14-chord-diagram-advanced-usage_files/figure-html/unnamed-chunk-10-1.svg" width="384" style="display: block; margin: auto;" />

```r
circos.clear()
```

If row names and column names in the big matrix are not grouped, the sector order
can be manually adjusted by `order` argument.


```r
chordDiagram(mat, order = c(paset0("A", 1:5), paset0("B", 1:5), paset0("C", 1:5)))
```

It is similar way to construct a multiple-group Chord diagram with data frame as input.


```r
library(reshape2)
df2 = do.call("rbind", list(melt(mat1), melt(mat2), melt(mat3)))
chordDiagram(df2, order = c(paste0("A", 1:5), paste0("B", 1:5), paste0("C", 1:5)))
```
