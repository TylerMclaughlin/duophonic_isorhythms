source('circular_rhythm_plots.R')

dt = data.table(sectors = 0:31,
                r1 = c(1,0,0,1,0,0,1,0), 
                r2 = c(0,1,1,0,1,1,0,1), 
                i1 = c('a','.','.','b','.','.','c','.'), 
                i2 = c(c('.','a','b','.','c','d','.','a'),
                       c('.','b','c','.','d','a','.','b'),
                       c('.','c','d','.','a','b','.','c'),
                       c('.','d','a','.','b','c','.','d')))
              

c3 <- get_color_dictionary('#FF8800','#0088FF',3)
c4 <- get_color_dictionary('#FF0000','#0000FF',4)

source('circular_rhythm_plots.R')
plot_rhythm(dt, euc_color_dict = euc.color.dict, iso_color_dict1 = c3, iso_color_dict2 = c4)

# figure 1
plot_lrkn(3,5,3,8)

# figure 1
plot_lrkn(3,4,3,8)



plot_lrkn(3,4,3,8)

## complicated!
plot_lrkn(5,4,2,5)

plot_lrkn(3,4,5,7)
