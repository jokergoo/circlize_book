

# Graphics {#graphics}

In this chapter, we will introduce low-level functions that add graphics to
the circle. Usages of most of these functions are similar as normal graphic
functions (e.g. `points()`, `lines()`). Combination use of these functions can
generate very complex circular plots.

All low-level functions accept `sector.index` and `track.index` arguments
which indicate which cell the graphics are added in. By default the graphics
are added in the "current" sector and "current" track, so it is recommended to
use them directly inside `panel.fun` function. However, they can also be used
in other places with explicitly specifying sector and track index. Following
code shows an example of using `ciros.points()`.


```r
circos.track(..., panel.fun = function(x, y) {
    circos.points(x, y)
})
circos.points(x, y, sector.index, track.index)
```

In this chapter, we will also discuss how to customize links and how to highlight
regions in the circle.

## Points {#points}

Adding points by `circos.points()` is similar as `points()` function. Possible
usage is:


```r
circos.points(x, y)
circos.points(x, y, sector.index, track.index)
circos.points(x, y, pch, col, cex)
```

There is a companion function `circos.trackPoints()` which adds points to all
sectors in a same track simultaneously. The input of `circos.trackPoints()`
must contain a vector of categorical factors, a vector of x values and a
vector of y values. X values and y values are split by the categorical
variable and corresponding subset of x and y values are internally sent to
`circos.points()`. `circos.trackPoints()` adds points to the "current" track
by default which is the most recently created track. Other tracks can also be
selected by explictly setting `track.index` argument.


```r
circos.track(...)
circos.trackPoints(fa, x, y)
```

`circos.trackPoints()` is simply implemented by `circos.points()` with a `for`
loop. However, it is more recommended to directly use `circos.points()` and
`panel.fun` which provides great more flexibility. Actually following code is
identical to above code.


```r
circos.track(fa, x, y, panel.fun = function(x, y) {
	circos.points(x, y)
})
```

Other low-level functions also have their companion `circos.track*()`
function. The usage is same as `circos.trackPoints()` and they will not be
further discussed in following sections.

## Lines {#lines}

Adding lines by `circos.lines()` is similar as `lines()` function. One
additional feature is that the areas under or above the lines can be filled by
specifing `area` argument to `TRUE`. Position of the baseline can be set to a
pre-defined string of `bottom` or `top`, or a numeric value which is the
position on y-axis. When `area` is set to `TRUE`, `col` controls the filled
color and `border` controls the color for the borders.

`baseline` argument is also workable when `lty` is set to `"h"`. Note when `lty`
is set to `"h"`, graphic parameters such as `col` can be set as a vector with
same length as `x`. Figure \@ref(fig:circlize-lines) illustrates supported `lty`
settings and `area`/`baseline` settings.

<div class="figure" style="text-align: center">
<img src="03-graphics_files/figure-epub3/circlize-lines-1.svg" alt="Line styles and areas supported in `circos.lines()`"  />
<p class="caption">(\#fig:circlize-lines)Line styles and areas supported in `circos.lines()`</p>
</div>

Straight lines are transformed to curves when mapping to the circular layout
(Figure \@ref(fig:circlize-linecurve)). Normally, curves are approximated by a
series of segments of straight lines. With more and shorter segments, there is
better approximation, but with larger size if the figures are generated into
e.g. PDF files, especially for huge dataset. Default length of segments in
**circlize** is a balance between the quality and size of the figure. You can
set the length of the unit segment by `unit.circle.segments` option in
`circos.par()`. The length of the segment is calculated as the length of the
unit circle (2$\pi$) divided by `unit.circle.segments`. In some scenarios,
actually you don't need to segment the lines such as radical lines, then you can
set `straight` argument to `TRUE` to get rid of unnecessary segmentations.

<div class="figure" style="text-align: center">
<img src="03-graphics_files/figure-epub3/circlize-linecurve-1.svg" alt="Transformation of straight lines into curves in the circle."  />
<p class="caption">(\#fig:circlize-linecurve)Transformation of straight lines into curves in the circle.</p>
</div>

Possible usage for `circos.lines()` is:


```r
circos.lines(x, y)
circos.lines(x, y, sector.index, track.index)
circos.lines(x, y, col, lwd, lty, type, straight)
circos.lines(x, y, col, area, baseline, border)
```

## Segments {#segments}

Line segments can be added by `circos.segments()` function. The usage is similar
as `segments()`. Radical segments can be added by setting `straight` to `TRUE`.



```r
circos.segments(x0, y0, x1, y1)
circos.segments(x0, y0, x1, y1, straight)
```

## Text {#text}

Adding text by `circos.text()` is similar as `text()` function. Text is added on
the plot for human reading, thus, when putting the text on the circle, the
facing of text is very important. `circos.text()` supports seven facing options
which are `inside`, `outside`, `clockwise`, `reverse.clockwise`, `downward`,
`bending.inside` and `bending.outside`. Please note for `bending.inside` and
`bending.outside`, currently, single line text is only supported. If you want to
put bended text into two lines, you need to split text into two lines and add
each line by `circos.text()` separately. The different facings are illustrated
in figure \@ref(fig:circlize-text).

<div class="figure" style="text-align: center">
<img src="03-graphics_files/figure-epub3/circlize-text-1.svg" alt="Text facings."  />
<p class="caption">(\#fig:circlize-text)Text facings.</p>
</div>

Possible usage for `circos.text()` is:


```r
circos.text(x, y, labels)
circos.text(x, y, labels, sector.index, track.index)
circos.text(x, y, labels, facing, niceFacing, adj, cex, col, font)
```

If, e.g., `facing` is set to `inside`, text which is on the bottom half of the
circle is still facing to the top and hard to read. To make text more easy to
read and not to hurt readers' neck too much, `circos.text()` provides
`niceFacing` option which automatically adjust text facing according to their
positions in the circle. `niceFacing` only works for `facing` value of
`inside`, `outside`, `clockwise`, `reverse.clockwise`, `bending.inside` and
`bending.outside`.

When `niceFacing` is on, `adj` is also adjusted according to the corresponding
facings. Figure \@ref(fig:circlize-text-easy) illustrates text positions under
different settings of `adj` and `facing`. The red dots are the positions of the texts.

<div class="figure" style="text-align: center">
<img src="03-graphics_files/figure-epub3/circlize-text-easy-1.svg" alt="Human easy text facing."  />
<p class="caption">(\#fig:circlize-text-easy)Human easy text facing.</p>
</div>

`adj` is internally passed to `text()`, thus, it actually adjusts text
positions either horizontally or vertically (in the canvas coordinate). If the
direction of the offset is circular, the offset value can be set as degrees
that the position of the text is adjusted by wrapping the offset by
`degree()`.


```r
circos.text(x, y, labels, adj = c(0, degree(5)), facing = "clockwise")
```

As `circos.text()` is applied in the data coordiante, offset can be directly
added to `x` or/and `y` as a value measured in the data coordinate. An absolute
offset can be set by using `ux()` (in x direction) and `uy()` (in y
direction).


```r
circos.text(x + ux(2, "mm"), y + uy(2, "mm"), labels)
```

## Rectangles and polygons {#rectangles}

Theoretically, circular rectangles and polygons are all polygons. If you imagine
the plotting region in a cell as Cartesian coordinate, then `circos.rect()`
draws rectangles. In the circle, the up and bottom edge become two arcs. Note this
function can be vectorized.


```r
circos.rect(xleft, ybottom, xright, ytop)
circos.rect(xleft, ybottom, xright, ytop, sector.index, track.index)
circos.rect(xleft, ybottom, xright, ytop, col, border, lty, lwd)
```

`circos.polygon()` draws a polygon through a series of points in a cell.
Please note the first data point must overlap to the last data point.


```r
circos.polygon(x, y)
circos.polygon(x, y, col, border, lty, lwd)
```

In Figure \@ref(fig:circlize-errorline), the area of standard deviation of the
smoothed line is drawn by `circos.polygon()`. Source code can be found in the
**Examples** section of the `circos.polygon()` help page.

<div class="figure" style="text-align: center">
<img src="03-graphics_files/figure-epub3/circlize-errorline-1.svg" alt="Area of standard deviation of the smoothed line."  />
<p class="caption">(\#fig:circlize-errorline)Area of standard deviation of the smoothed line.</p>
</div>

## Axes {#axes}

Mostly, we only draw x-axes on the circle. `circos.axis()` or `circos.xaxis()`
privides options to customize x-axes which are on the circular direction. It
supports basic functionalities as `axis()` such as defining the breaks and
corresponding labels. Besides that, the function also supports to put x-axes to
a specified position on y direction, to position the x-axes facing the center of
the circle or outside of the circle, and to customize the axes ticks. The `at`
and `labels` arguments can be set to a long vector that the parts which exceed
the maximal value in the corresponding cell are removed automatically. The
facing of labels text can be optimized by `labels.niceFacing` (by default it is
`TRUE`).

Figure \@ref(fig:circlize-xaxis) illustrates different settings of x-axes. The
explanations are as follows:

- a: Major ticks are calculated automatically, other settings are defaults.
- b: Ticks are pointing to inside of the circle, facing of tick labels is set to
  `outside`.
- c: Position of x-axis is `bottom` in the cell.
- d: Ticks are pointing to the inside of the circle, facing of tick labels is
  set to `reverse.clockwise`.
- e: manually set major ticks and also set the position of x-axis.
- f: replace numeric labels to characters, with no minor ticks.
- g: No ticks for both major and minor, facing of tick labels is set to
  `reverse.clockwise`.
- h: Number of minor ticks between two major ticks is set to 2. Length of ticks
  is longer. Facing of tick labels is set to `clockwise`.

<div class="figure" style="text-align: center">
<img src="03-graphics_files/figure-epub3/circlize-xaxis-1.svg" alt="X-axes"  />
<p class="caption">(\#fig:circlize-xaxis)X-axes</p>
</div>

As you may notice in the above figure, when the first and last axis labels
exceed data ranges on x-axis in the corresponding cell, their positions are
automatically adjusted to be shifted inwards in the cell.

Possible usage of `circos.axis()` is as follows. Note `h` can be `bottom`, `top`
or a numeric value.


```r
circos.axis(h)
circos.axis(h, sector.index, track.index)
circos.axis(h, major.at, labels, major.tick, direction)
circos.axis(h, major.at, labels, major.tick, labels.font, labels.cex,
            labels.facing, labels.niceFacing)
circos.axis(h, major.at, labels, major.tick, minor.ticks,
            major.tick.length, lwd)
```

Y-axis is also supported by `circos.yaxis()`. The usage is similar as
`circos.axis()` One thing that needs to be note is users need to manually adjust
`gap.degree` in `circos.par()` to make sure there are enough spaces for y-axes.
(Figure \@ref(fig:circlize-yaxis))


```r
circos.yaxis(side)
circos.yaxis(at, labels, sector.index, track.index)
```

<div class="figure" style="text-align: center">
<img src="03-graphics_files/figure-epub3/circlize-yaxis-1.svg" alt="Y-axes"  />
<p class="caption">(\#fig:circlize-yaxis)Y-axes</p>
</div>

## Raster image {#raster-image}

`circos.raster()` is used to add a raster image at a certain position in the circle with
proper rotation. The first input variable should be a `raster` object or an object that
can be converted by `as.raster()`. Facing of the image is controlled by `facing` and `niceFacing`
arguments which are similar as in `circos.text()`. When value of `facing` is one of 
`inside`, `outside`, `reverse.clockwise`, `clockwise` and `downward`, the size of raster image
should have absolute values which should be specified in the form of `number-unit` such as `20mm`,
`1.2cm` or `0.5inche`. If only one of `width` and `height` is specified, the other one is 
automatically calculated by using the aspect ratio of the original image. Following example shows
five types of facings of the raster image (figure \@ref(fig:raster-normal).




















































