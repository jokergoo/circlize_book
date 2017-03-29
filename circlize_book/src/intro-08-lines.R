
op = par(no.readonly = TRUE)

library(circlize)
par(mar = c(1, 1, 1, 1), cex = 0.8)
factors = letters[1:9]
circos.par(points.overflow.warning = FALSE)
circos.initialize(factors = factors, xlim = c(0, 10))
circos.trackPlotRegion(factors = factors, ylim = c(0, 10), track.height = 0.5)

circos.lines(sort(runif(10)*10), runif(10)*8, sector.index = "a")
circos.text(5, 9, "type = 'l'", sector.index = "a", facing = "outside")

circos.lines(sort(runif(10)*10), runif(10)*8, sector.index = "b", type = "o")
circos.text(5, 9, "type = 'o'", sector.index = "b", facing = "outside")

circos.lines(sort(runif(10)*10), runif(10)*8, sector.index = "c", type = "h")
circos.text(5, 9, "type = 'h'", sector.index = "c", facing = "outside")

x = sort(runif(10)*10)
y = runif(10)*8
circos.lines(x, y, sector.index = "d", type = "h", baseline = 5, col = ifelse(y > 5, "red", "green"), lwd = 2)
circos.text(5, 9, "type = 'h', baseline = 5\n`col` set as a vector", sector.index = "d", facing = "outside")

circos.lines(sort(runif(10)*10), runif(10)*8, sector.index = "e", type = "s")
circos.text(5, 9, "type = 's'", sector.index = "e", facing = "outside")

circos.lines(sort(runif(10)*10), runif(10)*8, sector.index = "f", area = TRUE)
circos.text(5, 9, "type = 'l', area = TRUE", sector.index = "f")

circos.lines(sort(runif(10)*10), runif(10)*8, sector.index = "g", type = "o", area = TRUE)
circos.text(5, 9, "type = 'o', area = TRUE", sector.index = "g")

circos.lines(sort(runif(10)*10), runif(10)*8, sector.index = "h", type = "s", area = TRUE)
circos.text(5, 9, "type = 's', area = TRUE", sector.index = "h")

circos.lines(sort(runif(10)*10), runif(10)*8, sector.index = "i", area = TRUE, baseline = "top")
circos.text(5, 9, "type = 'l', area = TRUE\nbaseline = 'top'", sector.index = "i")

circos.clear()
par(cex = 1)

par(op)
