
op = par(no.readonly = TRUE)

par(mfrow = c(1, 2))
par(mar = c(1, 1, 1, 1))
factors = letters[1:8]
circos.par("track.margin" = c(0.1, 0.1), "clock.wise" = FALSE, "cell.padding" = c(0.05, 3, 0.05, 3),
    xaxis.clock.wise = TRUE)
circos.initialize(factors = factors, xlim = c(0, 10))
circos.trackPlotRegion(factors = factors, ylim = c(0, 10), track.height = 0.4, panel.fun = function(x, y) {
    circos.text(5, 5, get.cell.meta.data("sector.index"), niceFacing = TRUE)
    xlim = get.cell.meta.data("xlim")
    ylim = get.cell.meta.data("ylim")
    circos.lines(xlim, c(0, 0))
    circos.lines(c(9, 10), c(0.5, 0))
    circos.lines(c(9, 10), c(-0.5, 0))
    circos.lines(c(0, 0), xlim)
    circos.lines(c(0.5, 0), c(9, 10))
    circos.lines(c(-0.5, 0), c(9, 10))
})
circos.clear()

text(0, 0, 'circos.par(        \n"xaxis.clock.wise" = TRUE)', cex = 0.7)


par(mar = c(1, 1, 1, 1))
factors = letters[1:8]
circos.par("track.margin" = c(0.1, 0.1), "clock.wise" = FALSE, "cell.padding" = c(0.05, 3, 0.05, 3),
    xaxis.clock.wise = FALSE)
circos.initialize(factors = factors, xlim = c(0, 10))
circos.trackPlotRegion(factors = factors, ylim = c(0, 10), track.height = 0.4, panel.fun = function(x, y) {
    circos.text(5, 5, get.cell.meta.data("sector.index"), niceFacing = TRUE)
    xlim = get.cell.meta.data("xlim")
    ylim = get.cell.meta.data("ylim")
    circos.lines(xlim, c(0, 0))
    circos.lines(c(9, 10), c(0.5, 0))
    circos.lines(c(9, 10), c(-0.5, 0))
    circos.lines(c(0, 0), xlim)
    circos.lines(c(0.5, 0), c(9, 10))
    circos.lines(c(-0.5, 0), c(9, 10))
})
circos.clear()


text(0, 0, 'circos.par(        \n"xaxis.clock.wise" = FALSE)', cex = 0.7)
