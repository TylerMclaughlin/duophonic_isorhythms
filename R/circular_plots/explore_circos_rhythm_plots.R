library(circlize)
library(data.table)


dt = data.table(sectors = 0:7,
                r1 = c(1,0,0,1,0,0,1,0), r2 = c(0,1,1,0,1,1,0,1), i1 = c('a','-','-','b','-','-','c','-'), i2 = c('-','a','b','-','c','d','-','e'))

euc.color.dict <- data.table(vals = c(0,1), colors = c('white','black'))

cmap_func <- colorRamp(c('#FF0000','#0000FF'))

five_colors <- cmap_func((0:5)/5)

iso.colors <- data.table(vals = c('-','a','b','c','d','e'), colors =  c('white') + five_colors )

rgb(five_colors[,1], five_colors[,2], five_colors[,3], maxColorValue = 255)

hex_ramp_vec <- function(start_color_hex, end_color_hex, n_colors){
  cmap_func <- colorRamp(c(start_color_hex,end_color_hex))
  rgb_matrix <- cmap_func((0:(n_colors - 1))/n_colors)
  
  hex_vec <- rgb(rgb_matrix[,1], rgb_matrix[,2], rgb_matrix[,3], maxColorValue = 255)
  return(hex_vec)
}

hex_ramp_vec('#FF0000','#0000FF',5)

get_color_dictionary <- function(start_color_hex, end_color_hex, n_colors){
  hex_ramp <- hex_ramp_vec(start_color_hex = start_color_hex, end_color_hex = end_color_hex, n_colors = n_colors)
  print(hex_ramp)
  out <- data.table(vals = c('-',letters[1:n_colors]), colors = c('white', hex_ramp) )
  return(out)
}

get_color_dictionary('#FF0000','#0000FF',5)

euc.color.dict$colors[match(dt$r1, euc.color.dict$vals)]

circos.track(ylim = c(0, 1), sectors = sectors,
             bg.col = rep(c("#E41A1C", "#4DAF4A"), 10), bg.border = "#EEEEEE", track.height = 0.05)

dev.off()

circos.clear()

factors = dt$sectors

circos.par("gap.degree" = 0, "cell.padding" = c(0, 0, 0, 0),
           start.degree = 360/40, track.margin = c(0, 0), "clock.wise" = FALSE)

circos.initialize(factors = factors, xlim = c(0, 1))

circos.trackPlotRegion(ylim = c(0, 1), factors = factors, bg.col = "black",
                       track.height = 0.15)
circos.trackText(rep(0.5, 20), rep(0.5, 20),
                 labels = c(13, 4, 18, 1, 20, 5, 12, 9, 14, 11, 8, 16, 7, 19, 3, 17, 2, 15, 10, 6),
                 factors = factors, col = "#EEEEEE", font = 2,
                 facing = "downward")
circos.trackPlotRegion(ylim = c(0, 1), factors = factors,
                       bg.col = rep(c("#E41A1C", "#4DAF4A"), 10), bg.border = "#EEEEEE", 
                       track.height = 0.05)
