library(ggplot2)
library(data.table)
library(ggridges)

dt <- fread('results.csv')

table(dt$is_trivial)
#nontrivial    trivial 
#6960       4665 

dt[,LR_sum := L + R]
dt[,LR_string := paste0(L,R)]
dt[, LR_mean := LR_sum/2]

dt[is_trivial == 'nontrivial']

ggplot(dt) + geom_line(aes(x = LR_sum, y = euclidean_cycle_length))

ggplot(dt[is_trivial == 'nontrivial']) + geom_line(aes(x = LR_sum, y = euclidean_cycle_length))

ggplot(dt[is_trivial == 'nontrivial']) + geom_boxplot(aes(x = factor(LR_sum), y = euclidean_cycle_length))

ggplot(dt[is_trivial == 'trivial']) + geom_boxplot(aes(x = factor(LR_sum), y = euclidean_cycle_length))

ggplot(dt[is_trivial == 'nontrivial']) + geom_boxplot(aes(x = factor(N), y = euclidean_cycle_length))

ggplot(dt[is_trivial == 'nontrivial'], aes(x = factor(N), y = euclidean_cycle_length)) + stat_density_ridges(aes(y = euclidean_cycle_length))

ggplot(dt[is_trivial == 'nontrivial']) + geom_histogram(aes(x = euclidean_cycle_length)) + facet_grid(factor(N) ~ .)

ggplot(dt[is_trivial == 'nontrivial'][euclidean_cycle_length < 64]) + geom_histogram(aes(x = euclidean_cycle_length)) + facet_grid(factor(N) ~ .)

# in paper?
ggplot(dt[is_trivial == 'nontrivial'][euclidean_cycle_length < 64][N <= 16]) + geom_histogram(aes(x = euclidean_cycle_length, fill = factor(N) )) + facet_grid(factor(N) ~ .) + scale_fill_viridis_d() + theme_bw() + theme(legend.position = 'none')

# num cycles instead of cycle length
ggplot(dt[is_trivial == 'nontrivial'][cycle_length < 64][N <= 16]) + geom_histogram(aes(x = num_cycles, fill = factor(N) )) + facet_grid(factor(N) ~ .) + scale_fill_viridis_d() + theme_bw() + theme(legend.position = 'none')


# bar plot
# Candidate for Figure 2
ggplot(dt[is_trivial == 'nontrivial'][N <= 19]) + geom_bar(aes(x = factor(num_cycles), fill = factor(N) )) + facet_wrap(factor(N) ~ .) + scale_fill_viridis_d() + theme_bw() + theme(legend.position = 'none') 

ggplot(dt) + geom_bar(aes(x = factor(num_cycles), fill = factor(L) )) + facet_wrap(factor(N) ~ .) + scale_fill_viridis_d() + theme_bw() # + theme(legend.position = 'none') 

ggplot(dt) + geom_tile(aes(x = factor(num_cycles), fill = factor(L) )) + facet_wrap(factor(N) ~ .) + scale_fill_viridis_d() + theme_bw() # + theme(legend.position = 'none') 

## HEATMAP
ggplot(dt) + geom_tile(aes(x = factor(K), y = factor(J), fill = factor(num_cycles) )) + facet_wrap(factor(L) ~ factor(R) ) + scale_fill_viridis_d() + theme_bw() # + theme(legend.position = 'none') 

# FIGURE 2
ggplot(dt[K <= 8][K > 1][J <= 8]) + geom_tile(aes(x = factor(L), y = factor(R), fill = factor(num_cycles) )) + facet_grid(factor(K) ~ factor(J) ) + coord_equal() +  scale_fill_viridis_d() + theme_bw() # + theme(legend.position = 'none') 
ggsave('iclc_paper/figures/figure2.pdf', width = 9, height = 6, dpi = 300)

ggplot(dt[K <= 16][K > 9][J <= 16][J > 9]) + geom_tile(aes(x = factor(L), y = factor(R), fill = factor(num_cycles) )) + facet_grid(factor(K) ~ factor(J) ) + coord_equal() +  scale_fill_viridis_d() + theme_bw() # + theme(legend.position = 'none') 
ggsave('iclc_paper/figures/figure3_extra.pdf', width = 9, height = 6, dpi = 300)

ggplot(dt[K <= 16][K > 9][J <= 23][J > 16]) + geom_tile(aes(x = factor(L), y = factor(R), fill = factor(num_cycles) )) + facet_grid(factor(K) ~ factor(J) ) + coord_equal() +  scale_fill_viridis_d() + theme_bw() # + theme(legend.position = 'none') 

# dpeendence on K
ggplot(dt) + geom_boxplot(aes(x = factor(K), y = num_cycles, fill = factor(K) )) + scale_fill_viridis_d() + theme_bw() # + theme(legend.position = 'none') 

# dpeendence on K*J
dt[,KJ_prod := K*J]
### OOOOH in papeer?
ggplot(dt) + geom_boxplot(aes(x = factor(KJ_prod), y = num_cycles, fill = factor(KJ_prod) )) + scale_fill_viridis_d() + theme_bw()  + theme(legend.position = 'none') 

ggplot(dt) + geom_boxplot(aes(x = factor(K), y = num_cycles, fill = factor(K) )) + scale_fill_viridis_d() + theme_bw()  + theme(legend.position = 'none') 
ggsave('iclc_paper/figures/')

### OOOOH in papeer?
ggplot(dt) + geom_boxplot(aes(x = factor(LR_prod), y = num_cycles, fill = factor(LR_prod) )) + scale_fill_viridis_d() + theme_bw()  + theme(legend.position = 'none') 

ggplot(dt[J == 5]) + geom_line(aes(x = K, y = num_cycles, color = L ))  + theme_bw()  


ggplot(dt) + geom_bar(aes(x = factor(num_cycles)), stat = 'count')  + theme_bw() + theme(legend.position = 'none')

ggplot(dt) + geom_histogram(aes(x = euclidean_cycle_length))  + theme_bw() + theme(legend.position = 'none')

ggplot(dt[is_trivial == 'nontrivial'][cycle_length < 64][N <= 8]) + geom_histogram(aes(x = cycle_length, fill = factor(N) )) + scale_fill_viridis_d() + theme_bw() + theme(legend.position = 'none')

ggplot(dt[is_trivial == 'nontrivial'][cycle_length < 64][N <= 16]) + geom_histogram(aes(x = cycle_length, fill = factor(N) )) + scale_fill_viridis_d() + theme_bw() + theme(legend.position = 'none')

ggplot(dt[is_trivial == 'nontrivial'][cycle_length < 128][N <= 16]) + geom_histogram(aes(x = cycle_length, fill = factor(N) )) + scale_fill_viridis_d() + theme_bw() + theme(legend.position = 'none')
ggplot(dt[is_trivial == 'nontrivial'][cycle_length < 128][N <= 32]) + geom_histogram(aes(x = cycle_length, fill = factor(N) ), bins = 100) + scale_fill_viridis_d() + theme_bw() + theme(legend.position = 'none')

ggplot(dt[is_trivial == 'nontrivial'][G <= 32]) + geom_histogram(aes(x = cycle_length, fill = factor(G) ), bins = 100) + scale_fill_viridis_d() + theme_bw() + theme(legend.position = 'none')

ggplot(dt[is_trivial == 'nontrivial'][G <= 16]) + geom_histogram(aes(x = cycle_length, fill = factor(G) ), bins = 100) + scale_fill_viridis_d() + theme_bw() + theme(legend.position = 'none')

dev.off()


ggplot(dt[is_trivial == 'nontrivial'][G <= 16]) + geom_point(aes(x = cycle_length, y = L, color = factor(G) )) + theme_bw() + theme(legend.position = 'none')

ggplot(dt[is_trivial == 'nontrivial'][G <= 16]) + geom_histogram(aes(x = cycle_length, fill = LR_string  )) + theme_bw() + facet_grid(L~R)

ggplot(dt[is_trivial == 'nontrivial'][G <= 32]) + geom_histogram(aes(x = cycle_length, fill = LR_string  )) + theme_bw() + facet_grid(L~R)

#^^
ggplot(dt[is_trivial == 'nontrivial'][N <= 32]) + geom_histogram(aes(x = log10(cycle_length), fill = LR_string  )) + scale_fill_viridis_d() + theme_bw() + facet_grid(L~R)

ggplot(dt[is_trivial == 'nontrivial'][G <= 32]) + geom_histogram(aes(x = log10(cycle_length), fill = LR_string  )) +  theme_bw() + facet_grid(L~R)

#:)
ggplot(dt[is_trivial == 'nontrivial']) + geom_histogram(aes(x = cycle_length), bins = 60) + theme_bw()

ggplot(dt[is_trivial == 'nontrivial']) + geom_histogram(aes(x = num_cycles), bins = 60) + theme_bw()

ggplot(dt[is_trivial == 'nontrivial']) + geom_histogram(aes(x = cycle_length, fill = factor(K)), bins = 60)
# ooh
ggplot(dt[is_trivial == 'nontrivial']) + geom_histogram(aes(x = cycle_length, fill = factor(N)), bins = 60) + theme_bw()
ggplot(dt[is_trivial == 'nontrivial']) + geom_histogram(aes(x = num_cycles, fill = factor(N)), bins = 60) + theme_bw()

dt[,lrog_prod := L*R*N*K]
dt[,normalized_length := lrog_prod]

## How does num_cycles length depend on L, R, K, and G??

results_dt[,.(L,R,K,N, num_cycles)][L == 2][R == 3][40:60]


# :)
ggplot(dt) + geom_point(aes(x = lrog_prod, y = cycle_length))



ggplot(dt) + geom_point(aes(x = lrog_prod, y = cycle_length, color = factor(G))) + scale_color_viridis_d(begin = 0.99, end = 0.01)

ggplot(dt) + geom_hex(aes(x = lrog_prod, y = cycle_length))

ggplot(dt[is_trivial == 'nontrivial']) + geom_histogram(aes(x = cycle_length, fill = factor(G)), bins = 60) + theme_bw()

# find the simplest rhythms
dt[order(cycle_length)][is_trivial == 'nontrivial']
dt[order(cycle_length)][is_trivial == 'nontrivial'][G == 8]
dt[order(cycle_length)][is_trivial == 'nontrivial'][L == 2] [R == 2][G == 16]
dt[order(cycle_length)][is_trivial == 'nontrivial'][L == 3] [R == 4][G == 16]
dt[order(cycle_length)][is_trivial == 'nontrivial'][G == 16]
dt[order(cycle_length)][is_trivial == 'nontrivial'][G == 16][L == 5][R == 4]

# max cycle length
dt[,polyrhythmic_cycle_length := (K + J)*num_cycles]

max(dt$polyrhythmic_cycle_length)
max(dt$euclidean_cycle_length)

dt[,LRKJ_sum := L + R + K + J]

dt[euclidean_cycle_length == 640][,.(L,R,K,J,num_cycles,LRKJ_sum)]

ggplot(dt) + geom_boxplot(aes(x = factor(N), y = euclidean_cycle_length))

# colored histogram fig 5
dt[,LR_prod := L*R]

ggplot(dt) + geom_histogram(aes(x = euclidean_cycle_length, fill = factor(LR_prod) ), bins = 50)  + theme_bw() #+ theme(legend.title = 'none')




dt_lr30 = fread('results_LR_30.csv')

dt_lr200 = fread('results_LR_200_nmax3.csv')
ggplot(dt_lr200[K == 1][N == 2]) + geom_tile(aes(x = factor(L), y = factor(R), fill = factor(num_cycles) )) + facet_grid(factor(K) ~ factor(J) ) + coord_equal() +  scale_fill_viridis_d() + theme_bw()  + theme(legend.position = 'none') 

# reference
#ggplot(dt[K <= 8][K > 1][J <= 8]) + geom_tile(aes(x = factor(L), y = factor(R), fill = factor(num_cycles) )) + facet_grid(factor(K) ~ factor(J) ) + coord_equal() +  scale_fill_viridis_d() + theme_bw() # + theme(legend.position = 'none') 

ggplot(dt_lr30[K == 3][J == 3]) + geom_tile(aes(x = factor(L), y = factor(R), fill = factor(num_cycles) )) + facet_grid(factor(K) ~ factor(J) ) + coord_equal() +  scale_fill_viridis_d() + theme_bw()  + theme(legend.position = 'none') 


ggplot(dt_lr30[K == 3][J == 7]) + geom_tile(aes(x = factor(L), y = factor(R), fill = factor(num_cycles) )) + facet_grid(factor(K) ~ factor(J) ) + coord_equal() +  scale_fill_grey() + theme_bw()  + theme(legend.position = 'none') 

ggplot(dt_lr30[K == 13][J == 12]) + geom_tile(aes(x = factor(L), y = factor(R), fill = factor(num_cycles) )) + facet_grid(factor(K) ~ factor(J) ) + coord_equal() +  scale_fill_grey() + theme_bw()  + theme(legend.position = 'none') 

ggplot(dt_lr30[K == 11][J == 12]) + geom_tile(aes(x = factor(L), y = factor(R), fill = factor(num_cycles) )) + facet_grid(factor(K) ~ factor(J) ) + coord_equal() +  scale_fill_grey() + theme_bw()  + theme(legend.position = 'none') 

