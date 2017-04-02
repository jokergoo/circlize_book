
op = par(no.readonly = TRUE)

library(circlize)
par(mfrow = c(1, 2))
circos.par("start.degree" = 90, "gap.degree" = 0)
factors = letters[1:4]
circos.initialize(factors = factors, xlim = c(0, 1))
df = data.frame(factors = rep("a", 100),
	            x = runif(100),
	            y = runif(100))
circos.track(ylim = range(df$y))
circos.track(df$factors, x = df$x, y = df$y, track.index = 1,
	panel.fun = function(x, y) {
	circos.points(x, y, pch = 16, cex = 0.5)
})
circos.track(ylim = range(df$y))
circos.track(df$factors, x = df$x, y = df$y, track.index = 2,
	panel.fun = function(x, y) {
	circos.lines(1:100/100, y)
})
circos.clear()

rect(0, 0, 1, 1)
text(0, 0, 0, adj = c(0.5, 1))
text(1, 0, 1, adj = c(0.5, 1))
text(0, 1, 1, adj = c(0.5, 0))


# circos.par("canvas.xlim" = c(0, 1), "canvas.ylim" = c(0, 1), 
# 	"start.degree" = 90, "gap.degree" = 0)
par(mar = c(1, 1, 1, 1))
circos.par("canvas.xlim" = c(0, 1), "canvas.ylim" = c(0, 1),
	"start.degree" = 90, "gap.after" = 270)
factors = "a"
circos.initialize(factors = factors, xlim = c(0, 1))
circos.track(df$factors, x = df$x, y = df$y, 
	panel.fun = function(x, y) {
	circos.points(x, y, pch = 16, cex = 0.5)
})
circos.track(df$factors, x = df$x, y = df$y, 
	panel.fun = function(x, y) {
	circos.lines(1:100/100, y)
})
circos.clear()
box()
par(xpd = NA)
text(0, 0, 0, adj = c(0.5, 1))
text(1, 0, 1, adj = c(0.5, 1))
text(0, 1, 1, adj = c(0.5, 0))

par(op)
