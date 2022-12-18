source('circular_rhythm_plots.R')

### complementary interlocking Euclidean rhythm, no isorhythms

# CIER example 1
# Figure 1c
plot_dicier_lrkn(3,5,3,8, plot_isorhythm = FALSE)

# CIER example 2
# Figure 1d
plot_dicier_lrkn(4,1,4,11, plot_isorhythm = FALSE)

### single euclidean rhythm with an isorhythm

# Figure 1e
plot_dicier_lrkn(5,3,5,8, duophonic = FALSE)

# Figure 1f
plot_dicier_lrkn(3,3,5,8, duophonic = FALSE)

### DICIER examples

# Figure 1g
plot_dicier_lrkn(3,5,3,8)

# Figure 1h
plot_dicier_lrkn(3,4,3,8)


### DIP examples

# Figure 1i
plot_dip_lrkn(4,4,3,4)

# Figure 1j
plot_dip_lrkn(4,3,3,4)



