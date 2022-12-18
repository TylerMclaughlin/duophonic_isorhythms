source('circular_rhythm_plots.R')

dt = data.table(sectors = 0:7,
                r1 = c(1,0,0,1,0,0,1,0), 
                r2 = c(0,1,1,0,1,1,0,1), 
                i1 = c('a','-','-','b','-','-','c','-'), 
                i2 = c('-','a','b','-','c','d','-','e'))

c3 <- get_color_dictionary('#FF8800','#0088FF',3)
c5 <- get_color_dictionary('#FF0000','#0000FF',5)

source('circular_rhythm_plots.R')
plot_rhythm(dt, euc_color_dict = euc.color.dict, iso_color_dict1 = c3, iso_color_dict2 = c5)
