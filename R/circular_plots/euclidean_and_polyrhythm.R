source('circular_rhythm_plots.R')



### E(3,8) and P(3,8)
# Figure 1a

# E(3,8)
tresillo_dt = data.table(sectors = 0:7,
                r1 = c(1,0,0,1,0,0,1,0))
# 3 over 8 polyrhythm
three_dt = data.table(sectors = 0:2,
                      r1 = c('a','b','c'))

euc.color.dict <- data.table(vals = c(0,1), colors = c('white','#282828'))
euc1_color_order <- get_color_order(tresillo_dt$r1, euc.color.dict)

iso.color.dict <- get_color_dictionary('#00FF88','#FF0088',3)
iso.color.order <- get_color_order(three_dt$r1, iso.color.dict)

# plot Euclidean rhythm
circos.clear()
circos.par(#cell.padding = c(0.02, 0, 0.02, 0),#"gap.degree" = n_grid_sectors/20, #"cell.padding" = c(0, 0, 0, 0),
  #start.degree = 180 - 360/n_grid_sectors/2, track.margin = c(0, 0),  "clock.wise" = FALSE)
  start.degree = 90, track.margin = c(0, 0),  "clock.wise" = TRUE)
circos.initialize(factors = tresillo_dt$sectors, xlim = c(0, 1))
circos.track(ylim = c(0, 1), factors = tresillo_dt$sectors, 
                       bg.col = euc1_color_order, 
                       bg.border = 'black',
                       track.height = 0.15 )#0.15*0.75 )
# plot 3 over 8
circos.clear()
par(new = TRUE)
circos.par("canvas.xlim" = c(-1.15, 1.15), "canvas.ylim" = c(-1.15, 1.15),
           start.degree = 90, track.margin = c(0, 0),  "clock.wise" = TRUE)
circos.initialize(factors = three_dt$sectors, xlim = c(0, 1))

circos.track(ylim = c(0.8,1), factors = three_dt$sectors, 
                       bg.col = iso.color.order, 
                       bg.border = 'black',
                       track.height = 0.15)#0.15*0.75 )

dev.off()


### E(5,8) and P(5,8)
# Figure 1b

# 5 over 8 polyrhythm
cinquillo_dt = data.table(sectors = 0:7,
                         r1 = c(1,0,1,1,0,1,1,0))

five_dt = data.table(sectors = 0:4,
                      r1 = c('a','b','c', 'd','e'))

euc.color.dict <- data.table(vals = c(0,1), colors = c('white','#282828'))
euc1_color_order <- get_color_order(cinquillo_dt$r1, euc.color.dict)

iso.color.dict <- get_color_dictionary('#00FF88','#FF0088',5)
iso.color.order <- get_color_order(five_dt$r1, iso.color.dict)

# plot Euclidean rhythm
circos.clear()
circos.par(#cell.padding = c(0.02, 0, 0.02, 0),#"gap.degree" = n_grid_sectors/20, #"cell.padding" = c(0, 0, 0, 0),
  #start.degree = 180 - 360/n_grid_sectors/2, track.margin = c(0, 0),  "clock.wise" = FALSE)
  start.degree = 90, track.margin = c(0, 0),  "clock.wise" = TRUE)
circos.initialize(factors = cinquillo_dt$sectors, xlim = c(0, 1))
circos.track(ylim = c(0, 1), factors = cinquillo_dt$sectors, 
             bg.col = euc1_color_order, 
             bg.border = 'black',
             track.height = 0.15 )#0.15*0.75 )
# plot 5 over 8
circos.clear()
par(new = TRUE)
circos.par("canvas.xlim" = c(-1.15, 1.15), "canvas.ylim" = c(-1.15, 1.15),
           start.degree = 90, track.margin = c(0, 0),  "clock.wise" = TRUE)
circos.initialize(factors = five_dt$sectors, xlim = c(0, 1))

circos.track(ylim = c(0.8,1), factors = five_dt$sectors, 
             bg.col = iso.color.order, 
             bg.border = 'black',
             track.height = 0.15)#0.15*0.75 )

dev.off()

