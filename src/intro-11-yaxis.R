
op = par(no.readonly = TRUE)

library(circlize)

factors = letters[1:8]
circos.par(points.overflow.warning = FALSE)
circos.par(gap.degree = 8)
circos.initialize(factors = factors, xlim = c(0, 10))
circos.trackPlotRegion(factors = factors, ylim = c(0, 10), track.height = 0.5)
par(cex = 0.8)
for(a in letters[2:4]) {
	circos.yaxis(side = "left", sector.index = a)
}
for(a in letters[5:7]) {
	circos.yaxis(side = "right", sector.index = a)
}
circos.clear()

par(op)
