library(circlize)
library(data.table)

# load up pre-computed results table
results_dt <- fread('../results.csv')

# Euclidean rhythms 'x..x..x.' are represented as 10010010
euc_color_dict <- data.table(vals = c(0,1), colors = c('white','#282828'))



hex_ramp_vec <- function(start_color_hex, end_color_hex, n_colors, plus_one = FALSE){
  cmap_func <- colorRamp(c(start_color_hex,end_color_hex))
  if(plus_one){
  rgb_matrix <- cmap_func((0:(n_colors - 1))/(n_colors - 1))
  }else{
    rgb_matrix <- cmap_func((0:(n_colors - 1))/n_colors )
    
  }
  hex_vec <- rgb(rgb_matrix[,1], rgb_matrix[,2], rgb_matrix[,3], maxColorValue = 255)
  return(hex_vec)
}

get_color_dictionary <- function(start_color_hex, end_color_hex, n_colors, plus_one = FALSE){
  hex_ramp <- hex_ramp_vec(start_color_hex = start_color_hex, end_color_hex = end_color_hex, n_colors = n_colors, plus_one = plus_one )
  print(hex_ramp)
  out <- data.table(vals = c('.',letters[1:n_colors]), colors = c('white', hex_ramp) )
  return(out)
}

get_color_order <- function(column, color.dict){
  color.dict$colors[match(column, color.dict$vals)]
}

plot_dicier <- function(dt, euc_color_dict, iso_color_dict1, iso_color_dict2 , plot_isorhythm = TRUE, duophonic = TRUE){
  circos.clear()
  n_grid_sectors = length(dt$sectors)
  circos.par(#cell.padding = c(0.02, 0, 0.02, 0),#"gap.degree" = n_grid_sectors/20, #"cell.padding" = c(0, 0, 0, 0),
             #start.degree = 180 - 360/n_grid_sectors/2, track.margin = c(0, 0),  "clock.wise" = FALSE)
             start.degree = 90, track.margin = c(0, 0),  "clock.wise" = TRUE)
  
  circos.initialize(factors = dt$sectors, xlim = c(0, 1))
  
  euc1_color_order <- get_color_order(dt$r1, euc_color_dict)
  euc2_color_order <- get_color_order(dt$r2, euc_color_dict)
  print(euc1_color_order)
  print(euc2_color_order)
  if(plot_isorhythm){
      iso1_color_order <- get_color_order(dt$i1, iso_color_dict1)
      if(duophonic){
          iso2_color_order <- get_color_order(dt$i2, iso_color_dict2)
      }
      print(iso1_color_order)
  }
  # euclidean 1
  circos.trackPlotRegion(ylim = c(0, 1), factors = factors, 
                         bg.col = euc1_color_order, 
                         bg.border = 'black',
                         track.height = 0.15*0.75 )
  #circos.text(-1, 1, factors, col = 'green', track.index = 1)#, sector.index = "a", track.index = 1)
  if(duophonic){
  # euclidean 2
  circos.trackPlotRegion(ylim = c(0, 1), factors = factors, 
                         bg.col = euc2_color_order,
                         bg.border = 'black',
                         track.height = 0.15*0.85)
  }
  if(plot_isorhythm){
      # isorhythm 1
      circos.trackPlotRegion(ylim = c(0, 1), factors = factors,
                         bg.col = iso1_color_order, #bg.border = "#EEEEEE", 
                         track.height = 0.15*0.90)
      if(duophonic){
      # isorhythm 2
      circos.trackPlotRegion(ylim = c(0, 1), factors = factors,
                         bg.col = iso2_color_order, #bg.border = "#EEEEEE", 
                         track.height = 0.15)
      }
  }
}

string_to_vec <- function(string){
  unlist(strsplit(string, ""))
}

plot_dicier_lrkn <- function(l,r,k,n, plot_isorhythm = TRUE, duophonic = TRUE){
  rhythm <- results_dt[L == l][R == r][K == k][N == n]
  rhythm_length = rhythm$cycle_length - 1
  plot_dt <- data.table(sectors = 0:rhythm_length,
                        r1 = string_to_vec(rhythm$euclidean_string),
                        r2 = string_to_vec(rhythm$inv_euclidean_string),
                        i1 = string_to_vec(rhythm$isorhythm_string_l),
                        i2 = string_to_vec(rhythm$isorhythm_string_r))
  cl <- get_color_dictionary('#FF8800','#0088FF',l)
  cr <- get_color_dictionary('#FF0000','#0000FF',r)

  plot_dicier(plot_dt, euc_color_dict = euc.color.dict, iso_color_dict1 = cl, 
              iso_color_dict2 = cr, plot_isorhythm = plot_isorhythm,
              duophonic = duophonic)
}


plot_dip <- function(k_plot_dt, j_plot_dt, k_dict, j_dict,
                     iso_color_dict1, iso_color_dict2 , plot_isorhythm = TRUE,
                     duophonic = TRUE){
  circos.clear()
  k_grid_sectors = length(k_plot_dt$sectors)
  j_grid_sectors = length(j_plot_dt$sectors)
 
  k_color_order <- get_color_order(k_plot_dt$r1, k_dict)
  j_color_order <- get_color_order(j_plot_dt$r1, j_dict)
  print('k_color_order')
  print(k_color_order)
  print('j_color_order')
  print(j_color_order)
  if(plot_isorhythm){
    print('iso1_color_order')
    iso1_color_order <- get_color_order(k_plot_dt$i1, iso_color_dict1)
    print(iso1_color_order)
    if(duophonic){
      print('iso2_color_order')
      iso2_color_order <- get_color_order(j_plot_dt$i1, iso_color_dict2)
      print(iso1_color_order)
    }
  }
  
  # k polyrhythm
  circos.par(#cell.padding = c(0.02, 0, 0.02, 0),#"gap.degree" = n_grid_sectors/20, #"cell.padding" = c(0, 0, 0, 0),
    #start.degree = 180 - 360/n_grid_sectors/2, track.margin = c(0, 0),  "clock.wise" = FALSE)
    start.degree = 90, track.margin = c(0, 0),  "clock.wise" = TRUE)
  
  circos.initialize(factors = k_plot_dt$sectors, xlim = c(0, 1))
  
  circos.trackPlotRegion(ylim = c(0, 1), factors = factors, 
                         bg.col = k_color_order, 
                         bg.border = 'black',
                         track.height = 0.15*0.75 )
  #circos.text(-1, 1, factors, col = 'green', track.index = 1)#, sector.index = "a", track.index = 1)
  if(duophonic){
    # polyrhythm j
    print('polyj')
    circos.clear()
    par(new = TRUE)
    circos.par("canvas.xlim" = c(-1 - (0.15*0.75), 1 + (0.15*0.75)), 
               "canvas.ylim" = c(-1 - (0.15*0.75), 1 + (0.15*0.75)),
               start.degree = 90, track.margin = c(0, 0),  "clock.wise" = TRUE)
    circos.initialize(factors = j_plot_dt$sectors, xlim = c(0, 1))
    circos.trackPlotRegion(ylim = c(0, 1), factors = factors, 
                           bg.col = j_color_order,
                           bg.border = 'black',
                           track.height = 0.15*0.85)
  }
  if(plot_isorhythm){
    # isorhythm 1
    print('isok')
    circos.clear()
    par(new = TRUE)
    circos.par("canvas.xlim" = c(-1 - (0.15*2), 1  + (0.15*2)), 
               "canvas.ylim" = c(-1  - (0.15*2), 1  + (0.15*2)),
               start.degree = 90, track.margin = c(0, 0),  "clock.wise" = TRUE)
    
    circos.initialize(factors = k_plot_dt$sectors, xlim = c(0, 1))
               
    circos.trackPlotRegion(ylim = c(0, 1), factors = factors,
                           bg.col = iso1_color_order, #bg.border = "#EEEEEE", 
                           track.height = 0.15*0.90)
    if(duophonic){
      # isorhythm 2
      print('isoj')
      circos.clear()
      par(new = TRUE)
      circos.par("canvas.xlim" = c(-1 - (0.15*3) , 1 + (0.15*3)), 
                 "canvas.ylim" = c(-1 - ( 0.15*3), 1 +  ( 0.15*3)),
                 start.degree = 90, track.margin = c(0, 0),  "clock.wise" = TRUE)
      
      circos.initialize(factors = j_plot_dt$sectors, xlim = c(0, 1))
                 
      circos.trackPlotRegion(ylim = c(0, 1), factors = factors,
                             bg.col = iso2_color_order, #bg.border = "#EEEEEE", 
                             track.height = 0.15)
    }
  }
}


plot_dip_lrkn <- function(l,r,k,j, plot_isorhythm = TRUE, duophonic = TRUE){
  rhythm <- results_dt[L == l][R == r][K == k][N == (k + j)]
  k_rhythm_length = rhythm$num_cycles*k 
  print(k_rhythm_length)
  k_plot_dt <- data.table(sectors = 0:(k_rhythm_length - 1),
                        r1 = rep(letters[0:k], rhythm$num_cycles ),
                        i1 = letters[0:l])
  print(k_plot_dt)
  j_rhythm_length = rhythm$num_cycles*j 
  print(j_rhythm_length)
  j_plot_dt <- data.table(sectors = 0:(j_rhythm_length - 1),
                        r1 = rep(letters[0:j], rhythm$num_cycles ),
                        i1 = letters[0:r])
  print(j_plot_dt)
  #ck <- get_color_dictionary('#00FF88','#FF0088',k) 
  #cj <- get_color_dictionary('#00FFFF','#FF00FF',j)
  ck <- get_color_dictionary('#000000','#FFFFFF',k, plus_one = TRUE)
  cj <- get_color_dictionary('#000000','#FFFFFF',j, plus_one = TRUE)
  cl <- get_color_dictionary('#FF8800','#0088FF',l)
  cr <- get_color_dictionary('#FF0000','#0000FF',r)
  plot_dip(k_plot_dt, j_plot_dt, k_dict = ck, j_dict = cj,
           iso_color_dict1 = cl,  iso_color_dict2 = cr, 
           plot_isorhythm = plot_isorhythm, duophonic = duophonic)
}


