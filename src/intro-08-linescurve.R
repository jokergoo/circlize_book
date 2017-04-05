
op = par(no.readonly = TRUE)

par(mfrow = c(1, 2))

par(mar = c(2, 1, 2, 1))
plot(c(0, 1), c(0, 1), ann = FALSE, axes = FALSE, type = "l")
points(seq(0, 1, length = 20), seq(0, 1, length = 20), pch = 16)
box()

par(mar = c(0, 1, 1, 1))
circos.par(points.overflow.warning = FALSE)
circos.par("canvas.ylim" = c(0, 1), gap.degree = 180, start.degree = 0, clock.wise = FALSE)
circos.initialize(letters[1], xlim = c(0, 1))
circos.trackPlotRegion(ylim = c(0, 1), panel.fun = function(x, y) {
	circos.lines(c(0, 1), c(0, 1))
	circos.points(seq(0, 1, length = 20), seq(0, 1, length = 20), pch = 16)
}, track.height = 0.4)
circos.clear()

par(op)
