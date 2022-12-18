# Duophonic Isorhythms

Source code and results for "Duophonic isorhythms in complementary interlocking Euclidean rhythms and polyrhythms:  enumeration, periodicity, and live-coding",  a paper on theory of musical rhythms and melodic cycles and live-coding, submtted to ICLC 2023.

![circular_plots](https://github.com/TylerMcLaughlin/duophonic_isorhythms/blob/main/iclc_paper/figures/pngs/figure1.png)

Circular visualizations of 10 examples of musical cycles coded and analyzed in this paper.

# Overview

This project uses Python for four purposes:  enumerating and empirically calculating the period for 11625 distinct two-voice isorhythmic constructs, creating string representations of the isorhythms in complementary interlocking Euclidean rhythms, validating a mathematically derived formula for the period, and generating TidalCycles code templates for playing these four-parameter isorhythms.

The R code is used for exploratory data analysis and visualization.  To generate the circular plots I used ```circlize```, the R package for genomics data visualization.


# Enumeration results

![enumeration_results](https://github.com/TylerMcLaughlin/duophonic_isorhythms/blob/main/iclc_paper/figures/pngs/figure3_enumeration_results.png)

This figure shows how the period of two-voice isorhythms depends on the input parameters, L, R, K, and J.
