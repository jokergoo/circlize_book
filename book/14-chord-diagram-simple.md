

# (PART) Visualize Relations {-} 

# The `chordDiagram()` function

One unique feature of circular layout is the circular visualization of
relations between objects by links. See examples in
http://circos.ca/intro/tabular_visualization/. Such type of plot is called
[Chord diagram](http://en.wikipedia.org/wiki/Chord_diagram). In **circlize**,
it is easy to plot Chord diagram in a straightforward or in a highly customized way.

There are two data formats that represent relations, either adjacency matrix
or adjacency list. In adjacency matrix, value in $i^{th}$ row and $j^{th}$
column represents the relation from object in the $i^{th}$ row and the object
in the $j^{th}$ column where the absolute value measures the strength of the
relation. In adjacency list, relations are represented as a three-column data
frame in which relations come from the first column and to the second column,
and the third column represents the strength of the relation.

Following code shows an example of an adjacency matrix.


```r
mat = matrix(1:9, 3)
rownames(mat) = letters[1:3]
colnames(mat) = LETTERS[1:3]
mat
```

```
##   A B C
## a 1 4 7
## b 2 5 8
## c 3 6 9
```

And the code in below is an example of an adjacency list.


```r
df = data.frame(from = letters[1:3], to = LETTERS[1:3], value = 1:3)
df
```

```
##   from to value
## 1    a  A     1
## 2    b  B     2
## 3    c  C     3
```

Actually, it is not difficult to convert between these two formats. There are
also R packages and functions do the conversion such as in **reshape2**
package, `melt()` converts a matrix to a data frame and `dcast()` converts the
data frame back to the matrix.

Chord diagram shows the information of the relation from several levels. 1.
the links are straightforward to show the relations between objects; 2. width
of links are proportional to the strength of the relation which is more
illustrative than other graphic mappings; 3. colors of links can be another
graphic mapping for relations; 4. width of sectors represents total
strength for an object which connects to other objects or is connected from other
objects. You can find an interesting example of using Chord diagram to visualize
leagues system of players clubs by their national team from https://gjabel.wordpress.com/2014/06/05/world-cup-players-representation-by-league-system/ and the adapted code is at
https://jokergoo.github.io/circlize_examples/example/wc2014.html.

In **circlize** package, there is a `chordDiagram()` function that supports
both adjacency matrix and adjacency list. For different formats of input, the
corresponding format of graphic parameters will be different either. E.g. when
the input is a matrix, since information of the links in the Chord diagram is
stored in the matrix, corresponding graphics for the links sometimes should
also be specified as a matrix, while if the input is a data frame, the graphic
parameters for links only need to be specified as an additional column to the
data frame. Using the matrix is very straightforward and makes goodlooking
plots, while using the data frame provides more flexibility for controlling
the Chord diagram. Thus, in this chapter, we will show usage for both
adjacency matrix and list.

Since the usage for the two types of inputs are highly similar, in this chapter,
we mainly show figures generated from the matrix, but still show the code which uses
adjacency list.

## Basic usage of making Chord diagram

First let's generate a random matrix and the corresponding adjacency list.


```r
set.seed(999)
mat = matrix(sample(18, 18), 3, 6) 
rownames(mat) = paste0("S", 1:3)
colnames(mat) = paste0("E", 1:6)
mat
```

```
##    E1 E2 E3 E4 E5 E6
## S1  4 14 13 17  5  2
## S2  7  1  6  8 12 15
## S3  9 10  3 16 11 18
```

```r
df = data.frame(from = rep(rownames(mat), times = ncol(mat)),
    to = rep(colnames(mat), each = nrow(mat)),
    value = as.vector(mat),
    stringsAsFactors = FALSE)
df
```

```
##    from to value
## 1    S1 E1     4
## 2    S2 E1     7
## 3    S3 E1     9
## 4    S1 E2    14
## 5    S2 E2     1
## 6    S3 E2    10
## 7    S1 E3    13
## 8    S2 E3     6
## 9    S3 E3     3
## 10   S1 E4    17
## 11   S2 E4     8
## 12   S3 E4    16
## 13   S1 E5     5
## 14   S2 E5    12
## 15   S3 E5    11
## 16   S1 E6     2
## 17   S2 E6    15
## 18   S3 E6    18
```

The simplest usage is just calling `chordDiagram()` with 
`mat` (Figure \@ref(fig:chord-diagram-basic)).


```r
chordDiagram(mat)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-basic-1.png" alt="Basic usages of `chordDiagram()`." width="672" />
<p class="caption">(\#fig:chord-diagram-basic)Basic usages of `chordDiagram()`.</p>
</div>

```r
circos.clear()
```

or call with `df`:


```r
chordDiagram(df)
circos.clear()
```

The default Chord Diagram consists of a track of labels, a track of grids (or
you can call it lines, rectangles) with axes, and links. Sectors which correspond to rows in
the matrix locate at the bottom half of the circle. The order of sectors is
the order of `union(rownames(mat), colnames(mat))` or `union(df[[1]],
df[[2]])` if input is a data frame. The order of sectors can be controlled by
`order` argument (Figure \@ref(fig:chord-diagram-basic-order), left). Of course, the
length of `order` vector should be same as the number of sectors.

In following code, `S1`, `S2` and `S3` should better be put together since
they belong to a same group, which is same for `E*` sectors. Of course, you
can give a order which mix `S*` and `E*` (Figure
\@ref(fig:chord-diagram-basic-order), right), but it is not recommended
because it is bad for reading the plot. You can find more information of
setting grouped Chord diagrams (two or more groups) in Section
\@ref(multiple-group-chord-diagram).


```r
par(mfrow = c(1, 2))
chordDiagram(mat, order = c("S2", "S1", "S3", "E4", "E1", "E5", "E2", "E6", "E3"))
circos.clear()

chordDiagram(mat, order = c("S2", "S1", "E4", "E1", "S3", "E5", "E2", "E6", "E3"))
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-basic-order-1.png" alt="Adjust sector orders in Chord diagram. Left: sectors are still grouped after reordering; right: sectors are not grouped." width="768" />
<p class="caption">(\#fig:chord-diagram-basic-order)Adjust sector orders in Chord diagram. Left: sectors are still grouped after reordering; right: sectors are not grouped.</p>
</div>

```r
circos.clear()
```



Under default settings, the grid colors which represent sectors are randomly
generated, and the link colors are same as grid colors which correspond to
rows (or the first column if the input is an adjacency list) but with 50% transparency.

## Adjust by `circos.par()`

Since Chord Diagram is implemented by basic circlize functions, like normal circular plot,
the layout can be customized by `circos.par()`.

The gaps between sectors can be set by `circos.par(gap.after = ...)` (Figure \@ref(fig:chord-diagram-basic-gap-after)). 
It is useful when you want to distinguish sectors between rows and columns. 
Please note since you change default graphical settings, you need to 
use `circos.clear()` in the end of the plot to reset it.


```r
circos.par(gap.after = c(rep(5, nrow(mat)-1), 15, rep(5, ncol(mat)-1), 15))
chordDiagram(mat)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-basic-gap-after-1.png" alt="Set gaps in Chord diagram." width="672" />
<p class="caption">(\#fig:chord-diagram-basic-gap-after)Set gaps in Chord diagram.</p>
</div>

```r
circos.clear()
```

If the input is a data frame:


```r
circos.par(gap.after = c(rep(5, length(unique(df[[1]]))-1), 15, 
                         rep(5, length(unique(df[[2]]))-1), 15))
chordDiagram(df)
circos.clear()
```

As explained in Section \@ref(graphic-parameters), `gap.after` can also specified
as a named vector:


```r
circos.par(gap.after = c("S1" = 5, "S2" = 5, "S3" = 15, "E1" = 5, "E2" = 5,
	                     "E3" = 5, "E4" = 5, "E5" = 5, "E6" = 15))
chordDiagram(mat)
circos.clear()
```

To make it simpler, users can directly set `big.gap` in `chordDiagram()`
(Figure \@ref(fig:chord-diagram-basic-big-gap)). The value of `big.gap`
corresponds to the gap between row sectors and column sectors (or first-column
sectors and second-column sectors in the input is a data frame). Internally a
proper `gap.after` is assigned to `circos.par()`. Note it will only work when
there is no overlap between row sectors and column sectors, or in other words,
rows and columns in the matrix, or the first column and the second column 
in the data frame represent two different groups. 


```r
chordDiagram(mat, big.gap = 30)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-basic-big-gap-1.png" alt="Directly set big.gap in chordDiagram()." width="672" />
<p class="caption">(\#fig:chord-diagram-basic-big-gap)Directly set big.gap in chordDiagram().</p>
</div>

```r
circos.clear()
```

`small.gap` argument controls the gap between sectors corresponding to either
matrix rows or columns. The default value is 1 degree and normally you don't
need to set it. `big.gap` and `small.gap` can also be set in the scenarios
where number of groups is larger than two, see Section
\@ref(multiple-group-chord-diagram) for more details.

Similar to a normal circular plot, the first sector (which is the first row in
the adjacency matrix or the first row in the adjacency list) starts from right
center of the circle and sectors are arranged clock-wisely. The start degree
for the first sector can be set by `circos.par(start.degree = ...)` and the
direction can be set by `circos.par(clock.wise = ...)` (Figure
\@ref(fig:chord-diagram-basic-start-degree)).

In Figure \@ref(fig:chord-diagram-basic-start-degree) (left), setting
`circos.par(clock.wise = FALSE)` makes the link so twisted. Actually making
the direction reverse clock wise can also be done by setting a reversed order
of all sectors (Figure \@ref(fig:chord-diagram-basic-start-degree), right). As
we can see, the links in the left plot are very twisted, while it still looks
fine in the right plot. The reason is `chordDiagram()` automatically optimizes
the positions of links according to the arrangement of sectors.


```r
par(mfrow = c(1, 2))
circos.par(start.degree = 85, clock.wise = FALSE)
chordDiagram(mat)
circos.clear()

circos.par(start.degree = 85)
chordDiagram(mat, order = c(rev(colnames(mat)), rev(rownames(mat))))
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-basic-start-degree-1.png" alt="Change position and orientation of Chord diagram." width="768" />
<p class="caption">(\#fig:chord-diagram-basic-start-degree)Change position and orientation of Chord diagram.</p>
</div>

```r
circos.clear()
```

## Colors {#chord-diagram-colors}

### Set grid colors

Grids have different colors to represent different sectors. Generally, sectors
are divided into two groups. One contains sectors defined in rows of the
matrix or the first column in the data frame, and the other contains sectors
defined in columns of the matrix or the second column in the data frame. Thus,
links connect objects in the two groups. By default, link colors are same as
the color for the corresponding sectors in the first group.

Changing colors of grids may change the colors of links as well. Colors for
grids can be set through `grid.col` argument. Values of `grid.col` better be a
named vector of which names correspond to sector names. If it is has no name
index, the order of `grid.col` is assumed to have the same order as sectors 
(Figure \@ref(fig:chord-diagram-grid-color)). If you want to colors to be the same
as the sectors from the matrix columns or the second column in the data frame, 
simply transpose the matrix (Figure \@ref(fig:chord-diagram-grid-color) right).


```r
grid.col = c(S1 = "red", S2 = "green", S3 = "blue",
    E1 = "grey", E2 = "grey", E3 = "grey", E4 = "grey", E5 = "grey", E6 = "grey")
chordDiagram(mat, grid.col = grid.col)
chordDiagram(t(mat), grid.col = grid.col)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-grid-color-1.png" alt="Set grid colors in Chord diagram." width="768" />
<p class="caption">(\#fig:chord-diagram-grid-color)Set grid colors in Chord diagram.</p>
</div>

### Set link colors {#chord-diagram-link-color}

Transparency of link colors can be set by `transparency` argument (Figure \@ref(fig:chord-diagram-color-transparency)). 
The value should between 0 to 1 in which 0 means no transparency and 1 means full transparency.
Default transparency is 0.5.


```r
chordDiagram(mat, grid.col = grid.col, transparency = 0)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-color-transparency-1.png" alt="Transparency for links in Chord diagram." width="672" />
<p class="caption">(\#fig:chord-diagram-color-transparency)Transparency for links in Chord diagram.</p>
</div>

For adjacecy matrix, colors for links can be customized by providing a matrix
of colors. In the following example, we use `rand_color()` to generate a
random color matrix. Note since `col_mat` already contains transparency,
`transparency` will be ignored if it is set (Figure \@ref(fig:chord-diagram-color-mat)).


```r
col_mat = rand_color(length(mat), transparency = 0.5)
dim(col_mat) = dim(mat)  # to make sure it is a matrix
chordDiagram(mat, grid.col = grid.col, col = col_mat)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-color-mat-1.png" alt="Set a color matrix for links in Chord diagram." width="672" />
<p class="caption">(\#fig:chord-diagram-color-mat)Set a color matrix for links in Chord diagram.</p>
</div>

While for ajacency list, colors for links can be customized as a vector.


```r
col = rand_color(nrow(df))
chordDiagram(df, grid.col = grid.col, col = col)
```

When the strength of the relation (e.g. correlations) represents as continuous values,
`col` can also be specified as a self-defined color mapping function. `chordDiagram()`
accepts a color mapping generated by `colorRamp2()` (Figure \@ref(fig:chord-diagram-color-fun)). 


```r
col_fun = colorRamp2(range(mat), c("#FFEEEE", "#FF0000"), transparency = 0.5)
chordDiagram(mat, grid.col = grid.col, col = col_fun)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-color-fun-1.png" alt="Set a color mapping function for links in Chord diagram." width="672" />
<p class="caption">(\#fig:chord-diagram-color-fun)Set a color mapping function for links in Chord diagram.</p>
</div>

The color mapping function also works for adjacency list, but it will be
applied to the third column in the data frame, so you need to make sure the
third column has the proper values.


```r
chordDiagram(df, grid.col = grid.col, col = col_fun)
# or
chordDiagram(df, grid.col = grid.col, col = col_fun(df[, 3]))
```

When the input is a matrix, sometimes you don't need to generate the whole
color matrix. You can just provide colors which correspond to rows or columns
so that links from a same row/column will have the same color (Figure \@ref(fig:chord-diagram-color-row-col)). 
Here note values of colors can be set as numbers,
color names or hex code, same as in the base R graphics.


```r
chordDiagram(mat, grid.col = grid.col, row.col = 1:3)
chordDiagram(mat, grid.col = grid.col, column.col = 1:6)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-color-row-col-1.png" alt="Set link colors same as row sectors or column sectors in Chord diagram." width="768" />
<p class="caption">(\#fig:chord-diagram-color-row-col)Set link colors same as row sectors or column sectors in Chord diagram.</p>
</div>

`row.col` and `column.col` is specifically designed for matrix. There is no
similar settings for ajacency list.

To emphasize again, transparency of links can be included in `col`, `row.col`
or `column.col`, if transparency is already set there, `transparency` argument
will be ignored.

In Section \@ref(highlight-links), we will introduce how to highlight subset
of links by only assigning colors to them.

## Link border {#chord-diagram-link-border}

`link.lwd`, `link.lty` and `link.border` control the line width, the line
style and the color of the link border. All these three parameters can be set
either a single scalar or a matrix if the input is adjacency matrix.

If it is set as a single scalar, it means all links share the same style (Figure \@ref(fig:chord-diagram-style-scalar)).


```r
chordDiagram(mat, grid.col = grid.col, link.lwd = 2, link.lty = 2, link.border = "red")
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-style-scalar-1.png" alt="Line style for Chord diagram." width="672" />
<p class="caption">(\#fig:chord-diagram-style-scalar)Line style for Chord diagram.</p>
</div>

If it is set as a matrix, it should have same dimension as `mat`
(Figure \@ref(fig:chord-diagram-style-fullmat)). 


```r
lwd_mat = matrix(1, nrow = nrow(mat), ncol = ncol(mat))
lwd_mat[mat > 12] = 2
border_mat = matrix(NA, nrow = nrow(mat), ncol = ncol(mat))
border_mat[mat > 12] = "red"
chordDiagram(mat, grid.col = grid.col, link.lwd = lwd_mat, link.border = border_mat)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-style-fullmat-1.png" alt="Set line style as a matrix." width="672" />
<p class="caption">(\#fig:chord-diagram-style-fullmat)Set line style as a matrix.</p>
</div>

The matrix is not necessary to have same dimensions as in `mat`. It can also
be a sub matrix (Figure \@ref(fig:chord-diagram-style-submatrix)). For rows or
columns of which the corresponding values are not specified in the matrix,
default values are filled in. It must have row names and column names so that
the settings can be mapped to the correct links.


```r
border_mat2 = matrix("black", nrow = 1, ncol = ncol(mat))
rownames(border_mat2) = rownames(mat)[2]
colnames(border_mat2) = colnames(mat)
chordDiagram(mat, grid.col = grid.col, link.lwd = 2, link.border = border_mat2)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-style-submatrix-1.png" alt="Set line style as a sub matrix." width="672" />
<p class="caption">(\#fig:chord-diagram-style-submatrix)Set line style as a sub matrix.</p>
</div>

To be more convenient, graphic parameters can be set as a three-column data
frame in which the first two columns correspond to row names and column names
in the matrix, and the third column corresponds to the graphic parameters
(Figure \@ref(fig:chord-diagram-style-dataframe)).


```r
lty_df = data.frame(c("S1", "S2", "S3"), c("E5", "E6", "E4"), c(1, 2, 3))
lwd_df = data.frame(c("S1", "S2", "S3"), c("E5", "E6", "E4"), c(2, 2, 2))
border_df = data.frame(c("S1", "S2", "S3"), c("E5", "E6", "E4"), c(1, 1, 1))
chordDiagram(mat, grid.col = grid.col, link.lty = lty_df, link.lwd = lwd_df,
    link.border = border_df)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-style-dataframe-1.png" alt="Set line style as a data frame." width="672" />
<p class="caption">(\#fig:chord-diagram-style-dataframe)Set line style as a data frame.</p>
</div>

It is much easier if the input is a data frame, you only need to set graphic settings
as a vecotr.


```r
chordDiagram(df, grid.col = grid.col, link.lty = sample(1:3, nrow(df), replace = TRUE),
    link.lwd = runif(nrow(df))*2, link.border = sample(0:1, nrow(df), replace = TRUE))
```

## Highlight links

Sometimes we want to highlight some links to emphasize the importance of such relations.
Highlighting by different border styles are introduced in Section \@ref(chord-diagram-link-border) 
and here we focus on highlighting by colors.

There are two ways to highlight links, one is to set different transparency to different links
and the other is to only draw links that needs to be highlighted. Based on this rule and 
ways to assign colors to links (introduced in Section \@ref(chord-diagram-link-color)), we can
highlight links which come from a same sector by assigning colors with different transparency
by `row.col` argument (Figure \@ref(fig:chord-diagram-highlight-row)).


```r
chordDiagram(mat, grid.col = grid.col, row.col = c("#FF000080", "#00FF0010", "#0000FF10"))
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-highlight-row-1.png" alt="Highlight links by transparency." width="672" />
<p class="caption">(\#fig:chord-diagram-highlight-row)Highlight links by transparency.</p>
</div>

We can also highlight links with values larger than a cutoff. 
There are at least three ways to do it. First, construct a color matrix and set links
with small values to full transparency.

Since link colors can be specified as a matrix, we can set the transparency of
those links to a high value or even set to full transparency (Figure \@ref(fig:chord-diagram-highlight-mat)). 
In following example, links with value less than 12 is set to `#00000000`.


```r
col_mat[mat < 12] = "#00000000"
chordDiagram(mat, grid.col = grid.col, col = col_mat) 
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-highlight-mat-1.png" alt="Highlight links by color matrix." width="672" />
<p class="caption">(\#fig:chord-diagram-highlight-mat)Highlight links by color matrix.</p>
</div>

Following code demonstrates using a color mapping function to map values to different transparency.
Note this is also workable for adjacency list.


```r
col_fun = function(x) ifelse(x < 12, "#00000000", "#FF000080")
chordDiagram(mat, grid.col = grid.col, col = col_fun)
```

For both color matrix and color mapping function, actually all links are all
drawn and the reason why you cannot see some of them is they are assigned with
full transparency. If a three-column data frame is used to assign colors to
links of interest, links which are not defined in `col_df` are not drawn (Figure \@ref(fig:chord-diagram-highlight-df)).


```r
col_df = data.frame(c("S1", "S2", "S3"), c("E5", "E6", "E4"), 
    c("#FF000080", "#00FF0080", "#0000FF80"))
chordDiagram(mat, grid.col = grid.col, col = col_df)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-highlight-df-1.png" alt="Highlight links by data frame." width="672" />
<p class="caption">(\#fig:chord-diagram-highlight-df)Highlight links by data frame.</p>
</div>

Highlighting links is relatively simple for adjacency list that you only need
to construct a vector of colors according to what links you want to highlight.


```r
col = rand_color(nrow(df))
col[df[[3]] < 10] = "#00000000"
chordDiagram(df, grid.col = grid.col, col = col)
```

Some figure formats do not support transparency such as GIF format. Here the
other argument `link.visible` is recently introduced to **circlize** package
which may provide a simple way to control the visibility of links. The value can
be set as an logical matrix for adjacency matrix or a logical vector for
adjacency list (Figure \@ref(fig:chord-diagram-link-visible)).


```r
col = rand_color(nrow(df))
chordDiagram(df, grid.col = grid.col, link.visible = df[[3]] >= 10)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-link-visible-1.png" alt="Highlight links by setting `link.visible`." width="672" />
<p class="caption">(\#fig:chord-diagram-link-visible)Highlight links by setting `link.visible`.</p>
</div>

## Orders of links

Orders of links on every sector are adjusted automatically to make them look
nice. But sometimes sorting links according to the width on the sector is
useful for detecting potential features. `link.sort` and `link.decreasing` can
be set to control the order of positioning links on sectors 
(Figure \@ref(fig:chord-diagram-link-order1)).


```r
chordDiagram(mat, grid.col = grid.col, link.sort = TRUE, link.decreasing = TRUE)
title("link.sort = TRUE, link.decreasing = TRUE", cex = 0.6)
chordDiagram(mat, grid.col = grid.col, link.sort = TRUE, link.decreasing = FALSE)
title("link.sort = TRUE, link.decreasing = FALSE", cex = 0.6)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-link-order1-1.png" alt="Order of positioning links on sectors." width="768" />
<p class="caption">(\#fig:chord-diagram-link-order1)Order of positioning links on sectors.</p>
</div>

## z-index of adding links

The default order of adding links to the plot is based on their order in the
matrix or in the data frame. Normally, transparency should be set to the link
colors so that they will not overlap to each other. In most cases, this looks
fine, but sometimes, it improves the visualization to put wide links more
forward and to put small links more backward in the plot. This can be set by
`link.zindex` argument which defines the order of adding links one above the other. Larger value
means the corresponding link is added later (Figure \@ref(fig:chord-diagram-link-order2)).


```r
chordDiagram(mat, grid.col = grid.col, transparency = 0)
chordDiagram(mat, grid.col = grid.col, transparency = 0, link.zindex = rank(mat))
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-link-order2-1.png" alt="z-index of adding links." width="768" />
<p class="caption">(\#fig:chord-diagram-link-order2)z-index of adding links.</p>
</div>

Similar code if the input is a data frame.


```r
chordDiagram(df, grid.col = grid.col, transparency = 0, link.zindex = rank(df[[3]]))
```

## Self-links

How to set self links dependends on whether the information needs to be duplicated. 
The `self.link` argument can be set to `1` or `2` for the two different scenarios. 
Check the difference in Figure \@ref(fig:chord-diagram-self-link) (the black link on sector `a`).


```r
df2 = data.frame(start = c("a", "b", "c", "a"), end = c("a", "a", "b", "c"))
chordDiagram(df2, grid.col = 1:3, self.link = 1)
title("self.link = 1")
chordDiagram(df2, grid.col = 1:3, self.link = 2)
title("self.link = 2")
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-self-link-1.png" alt="Self-links in Chord diagram." width="768" />
<p class="caption">(\#fig:chord-diagram-self-link)Self-links in Chord diagram.</p>
</div>

## Symmetric matrix

When the matrix is symmetric, by setting `symmetric = TRUE`, only lower
triangular matrix without the diagonal will be used (Figure \@ref(fig:chord-diagram-symmetric)).


```r
mat3 = matrix(rnorm(25), 5)
colnames(mat3) = letters[1:5]
cor_mat = cor(mat3)
col_fun = colorRamp2(c(-1, 0, 1), c("green", "white", "red"))
chordDiagram(cor_mat, grid.col = 1:5, symmetric = TRUE, col = col_fun)
title("symmetric = TRUE")
chordDiagram(cor_mat, grid.col = 1:5, col = col_fun)
title("symmetric = FALSE")
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-symmetric-1.png" alt="Symmetric matrix for Chord diagram." width="768" />
<p class="caption">(\#fig:chord-diagram-symmetric)Symmetric matrix for Chord diagram.</p>
</div>

## Directional relations

In some cases, when the input is a matrix, rows and columns represent
directions, or when the input is a data frame, the first column and second
column represent directions. Argument `directional` is used to illustrate such
direction on the plot. `directional` with value `1` means the direction is
from rows to columns (or from the first column to the second column for the
adjacency list) while `-1` means the direction is from columns to rows (or from
the second column to the first column for the adjacency list). A value of `2` means
bi-directional.

By default, the two ends of links have unequal height (Figure
\@ref(fig:chord-diagram-directional-simple)) to represent the directions.
The position of starting end of the link is shorter than the other end to give
users the feeling that the link is moving out. If this is not what your
correct feeling, you can set `diffHeight` to a negative value.



```r
par(mfrow = c(1, 3))
chordDiagram(mat, grid.col = grid.col, directional = 1)
chordDiagram(mat, grid.col = grid.col, directional = 1, diffHeight = mm_h(5))
chordDiagram(mat, grid.col = grid.col, directional = -1)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-directional-simple-1.png" alt="Represent directions by different height of link ends." width="768" />
<p class="caption">(\#fig:chord-diagram-directional-simple)Represent directions by different height of link ends.</p>
</div>

Row names and column names in `mat` can also overlap. In this case, showing
direction of the link is important to distinguish them 
(Figure \@ref(fig:chord-diagram-directional-overlap)).


```r
mat2 = matrix(sample(100, 35), nrow = 5)
rownames(mat2) = letters[1:5]
colnames(mat2) = letters[1:7]
mat2
```

```
##    a  b  c  d  e  f  g
## a 60 14 33 27 70  2 45
## b 89 84 87  9 78 49 40
## c 26  7 42 74 36 76  4
## d 51 82 85 16 73 59 31
## e 30 90 23 38 68 11 35
```


```r
chordDiagram(mat2, grid.col = 1:7, directional = 1, row.col = 1:5)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-directional-overlap-1.png" alt="Chord diagram where row names and column names overlap." width="672" />
<p class="caption">(\#fig:chord-diagram-directional-overlap)Chord diagram where row names and column names overlap.</p>
</div>

If you do not need self-link for which two ends of a link are in a same sector, 
just set corresponding values to 0 in the matrix (Figure \@ref(fig:chord-diagram-directional-non-selfloop)).


```r
mat3 = mat2
for(cn in intersect(rownames(mat3), colnames(mat3))) {
    mat3[cn, cn] = 0
}
mat3
```

```
##    a  b  c  d  e  f  g
## a  0 14 33 27 70  2 45
## b 89  0 87  9 78 49 40
## c 26  7  0 74 36 76  4
## d 51 82 85  0 73 59 31
## e 30 90 23 38  0 11 35
```


```r
chordDiagram(mat3, grid.col = 1:7, directional = 1, row.col = 1:5)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-directional-non-selfloop-1.png" alt="Directional Chord diagram without self links." width="672" />
<p class="caption">(\#fig:chord-diagram-directional-non-selfloop)Directional Chord diagram without self links.</p>
</div>

Links can have arrows to represent directions (Figure \@ref(fig:chord-diagram-directional-arrow)). 
When `direction.type` is set to `arrows`, Arrows are added at
the center of links. Similar as other graphics parameters for links, the
parameters for drawing arrows such as arrow color and line type can either be
a scalar, a matrix, or a three-column data frame.

If `link.arr.col` is set as a data frame, only links specified in the data frame
will have arrows. Pleast note this is the only way to draw arrows to subset of links.


```r
arr.col = data.frame(c("S1", "S2", "S3"), c("E5", "E6", "E4"), 
    c("black", "black", "black"))
chordDiagram(mat, grid.col = grid.col, directional = 1, direction.type = "arrows",
    link.arr.col = arr.col, link.arr.length = 0.2)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-directional-arrow-1.png" alt="Use arrows to represent directions in Chord diagram." width="672" />
<p class="caption">(\#fig:chord-diagram-directional-arrow)Use arrows to represent directions in Chord diagram.</p>
</div>

If combining both `arrows` and `diffHeight`, it will give you better visualization 
(Figure \@ref(fig:chord-diagram-directional-arrow2)).


```r
arr.col = data.frame(c("S1", "S2", "S3"), c("E5", "E6", "E4"), 
    c("black", "black", "black"))
chordDiagram(mat, grid.col = grid.col, directional = 1, 
    direction.type = c("diffHeight", "arrows"),
    link.arr.col = arr.col, link.arr.length = 0.2)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-directional-arrow2-1.png" alt="Use both arrows and link height to represent directions in Chord diagram." width="672" />
<p class="caption">(\#fig:chord-diagram-directional-arrow2)Use both arrows and link height to represent directions in Chord diagram.</p>
</div>

There is another arrow type: `big.arrow` which is efficient to visualize
arrows when there are too many links (Figure \@ref(fig:chord-diagram-directional-arrow3)).


```r
matx = matrix(rnorm(64), 8)
chordDiagram(matx, directional = 1, direction.type = c("diffHeight", "arrows"),
    link.arr.type = "big.arrow")
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-directional-arrow3-1.png" alt="Use big arrows to represent directions in Chord diagram." width="672" />
<p class="caption">(\#fig:chord-diagram-directional-arrow3)Use big arrows to represent directions in Chord diagram.</p>
</div>

If `diffHeight` is set to a negative value, the start ends are longer than
the other ends (Figure \@ref(fig:chord-diagram-directional-arrow4)).


```r
chordDiagram(matx, directional = 1, direction.type = c("diffHeight", "arrows"),
    link.arr.type = "big.arrow", diffHeight = -mm_h(2))
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-directional-arrow4-1.png" alt="Use big arrows to represent directions in Chord diagram." width="672" />
<p class="caption">(\#fig:chord-diagram-directional-arrow4)Use big arrows to represent directions in Chord diagram.</p>
</div>

It is almost the same to visualize directional Chord diagram form a adjacency list.


```r
chordDiagram(df, directional = 1)
```

As shown in the previous Figures, there are bars on the source sector side
that show the proportion of target sectors (actually it is not necessarily to
be that, the bars are put on the side where the links are shorter and
`diffHeight` with a positive value). The bars can be removed by setting
`link.target.prop = FALSE`. The height of the bars is controlled by
`target.prop.height` argument.


```r
par(mfrow = c(1, 2))
chordDiagram(mat, grid.col = grid.col, directional = 1, 
	link.target.prop = FALSE)
chordDiagram(mat, grid.col = grid.col, directional = 1, 
	diffHeight = mm_h(10), target.prop.height = mm_h(8))
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-link-target-prop-1.png" alt="Control argument link.target.prop and target.prop.height." width="768" />
<p class="caption">(\#fig:chord-diagram-link-target-prop)Control argument link.target.prop and target.prop.height.</p>
</div>

## Scaling

The link on Chord diagram represents the "absolute value" of the relations. Sometimes
for a certain sector, we might want to see relatively, how much of it goes to other
sectors. In this case, `scale` argument can be set to `TRUE` so that on each sector, the 
value represents the fraction of the interaction going to one other sector (Figure \@ref(fig:chord-diagram-scale)). 


```r
set.seed(999)
mat = matrix(sample(18, 18), 3, 6) 
rownames(mat) = paste0("S", 1:3)
colnames(mat) = paste0("E", 1:6)

grid.col = c(S1 = "red", S2 = "green", S3 = "blue",
    E1 = "grey", E2 = "grey", E3 = "grey", E4 = "grey", E5 = "grey", E6 = "grey")
par(mfrow = c(1, 2))
chordDiagram(mat, grid.col = grid.col)
title("Default")
chordDiagram(mat, grid.col = grid.col, scale = TRUE)
title("scale = TRUE")
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-scale-1.png" alt="Scaling on sectors." width="768" />
<p class="caption">(\#fig:chord-diagram-scale)Scaling on sectors.</p>
</div>

After scaling, all sectors have the same size and the data range of each sector 
are all `c(0, 1)`.


## Reduce

If a sector in Chord Diagram is too small, it will be removed from the
original matrix, since basically it can be ignored visually from the plot. In
the following matrix, the second row and third column contain tiny values.


```r
mat = matrix(rnorm(36), 6, 6)
rownames(mat) = paste0("R", 1:6)
colnames(mat) = paste0("C", 1:6)
mat[2, ] = 1e-10
mat[, 3] = 1e-10
```

In the Chord Diagram, categories corresponding to the second row and the third column will
be removed (`R2` and `C3` are removed).


```r
chordDiagram(mat)
circos.info()
```

```
## All your sectors:
##  [1] "R1" "R3" "R4" "R5" "R6" "C1" "C2" "C4" "C5" "C6"
## 
## All your tracks:
## [1] 1 2
## 
## Your current sector.index is C6
## Your current track.index is 2
```

The `reduce` argument controls the size of sectors to be removed. The value is
a percent of the size of a sector to the total size of all sectors.

You can also explictly remove sectors by assigning corresponding values to 0.


```r
mat[2, ] = 0
mat[, 3] = 0
```

All parameters for sectors such as colors or gaps between sectors are also automatically
reduced accordingly by the function.


## Input as a data frame

As mentioned before, both matrix and data frame can be used to represent relations
between two sets of features. In previous examples, we mainly demonstrate the use
of `chordDiagram()` with matrix as input. Also we show the code with data frame as
input for each functionality. Here we will go through these functionality again 
with data frames and we also show some unique features which is only usable for 
data frames.

When the input is a data frame, number of rows in the data frame corresponds to
the number of links on the Chord diagram. Many arguments can be set as a vector
which have the same length as the number of rows of the input data frame. They are:

- `transparency`
- `col`. Note, `col` can also be a color mapping function generated from `colorRamp2()`.
- `link.border`
- `link.lwd`
- `link.lty`
- `link.arr.length`
- `link.arr.width`
- `link.arr.type`
- `link.arr.lwd`
- `link.arr.lty`
- `link.arr.col`
- `link.visible`
- `link.zindex`

Since all of them are already demonstrated in previous sections, we won't show them again here.

The following two sections list unique features only from data frames.

### Multiple links between two sectors

If the input is a matrix, there can only be one link from sector A to B, but
for the data frame, there can be mulitple links for a same pair of sectors. In
following example, each pair of sectors have two links, one for positive value
and the other for negative value.


```r
df = expand.grid(letters[1:3], LETTERS[1:4])
df1 = df
df1$value = sample(10, nrow(df), replace = TRUE)
df2 = df
df2$value = -sample(10, nrow(df), replace = TRUE)
df = rbind(df1, df2)
grid.col = structure(1:7, names = c(letters[1:3], LETTERS[1:4]))
chordDiagram(df, col = ifelse(df$value > 0, "red", "green"), grid.col = grid.col)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-multiple-link-1.png" alt="Multiple links for a same pair of sectors." width="672" />
<p class="caption">(\#fig:chord-diagram-multiple-link)Multiple links for a same pair of sectors.</p>
</div>

This functionality is useful when you want to visualize Figure
\@ref(fig:chord-diagram-multiple-link) as two Chord diagrams, one for positive
values and one for negative values, but still correspond the size of sector to
the sum of both positive and negative values.


```r
par(mfrow = c(1, 2))
chordDiagram(df, col = "red", link.visible = df$value > 0, grid.col = grid.col)
title("Positive links")
chordDiagram(df, col = "green", link.visible = df$value < 0, grid.col = grid.col)
title("Negative links")
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-multiple-link-split-1.png" alt="Split positive links and negative links." width="768" />
<p class="caption">(\#fig:chord-diagram-multiple-link-split)Split positive links and negative links.</p>
</div>

### Unequal width of the link ends

Almost all of the Chord diagrams shown in this chapter (except Figure
\@ref(fig:chord-diagram-scale)), the width of the two ends of a link is always the
same. This means same amount of information comes from one sector and goes to
the other sector. However, for some cases, this is not always true. For example,
when do scaling on sectors, the link actually has unequal width of the two ends (Figure
\@ref(fig:chord-diagram-scale) right). 

Since the two ends have different width, now the data frame needs two numeric columns
which correspond to the two ends of the links. Check following example:


```r
df = expand.grid(letters[1:3], LETTERS[1:4])
df$value = 1
df$value2 = 3  # the names of the two columns do not matter
par(mfrow = c(1, 2))
chordDiagram(df[, 1:3], grid.col = grid.col)
title("one column of values")
chordDiagram(df[, 1:4], grid.col = grid.col)  # note we use two value-columns here
title("two columns of values")
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/chord-diagram-unequal-end-width-1.png" alt="Unequal width of the link ends." width="768" />
<p class="caption">(\#fig:chord-diagram-unequal-end-width)Unequal width of the link ends.</p>
</div>

<!--
## More precise control on link positions

In previous section, we introduced the arguments `link.sort` and `link.decreasing` that
controls the ordering of links positioned on the circle. When the input is a data frame,
the control on the positions of links can be more precies. Let's regenerate the data frame
that was used in previous examples:


```r
set.seed(999)
mat = matrix(sample(18, 18), 3, 6) 
rownames(mat) = paste0("S", 1:3)
colnames(mat) = paste0("E", 1:6)
df = data.frame(from = rep(rownames(mat), times = ncol(mat)),
    to = rep(colnames(mat), each = nrow(mat)),
    value = as.vector(mat),
    stringsAsFactors = FALSE)
```

Let's make an animation of how the links are added sequantially:


```r
nr = nrow(df)
for(i in seq_len(nr)) {
	visible = rep(TRUE, nr)
	visible[seq(i, nr)[-1]] = FALSE
	chordDiagram(df, grid.col = grid.col, link.visible = visible)
}
```

<img src="14-chord-diagram-simple_files/figure-html/unnamed-chunk-21-.gif" width="672" style="display: block; margin: auto;" />

I created a second data frame which is the same as `df` but with
rows randomly permuted.


```r
df2 = df[sample(nr, nr), ]
```

By default, the links are automatically arranged. To manually control
the positions of links, the `link.auto` should be set to `FALSE`. Figure
\@ref(fig:ink-auto) compares the aotumatic arrangement of links.


```r
par(mfrow = c(1, 2))
chordDiagram(df2, grid.col = grid.col)
circos.clear()

chordDiagram(df2, grid.col = grid.col, link.auto = FALSE)
```

<div class="figure" style="text-align: center">
<img src="14-chord-diagram-simple_files/figure-html/link-auto-1.png" alt="Automatical arrangement of links." width="768" />
<p class="caption">(\#fig:link-auto)Automatical arrangement of links.</p>
</div>

```r
circos.clear()
```
-->

