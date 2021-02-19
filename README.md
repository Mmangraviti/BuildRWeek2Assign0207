
<!-- README.md is generated from README.Rmd. Please edit that file -->

# BuildRWeek2Assign0207

<!-- badges: start -->

<!-- badges: end -->

The goal of BuildRWeek2Assign0207 is to read Data is taken from
2013-2015 US National Highway Traffic Safety Administration’s Fatality
Analysis Reporting System,which is a nationwide census providing the
American public yearly data regarding fatal injuries suffered in motor
vehicle traffic crashes.

It is possible to request a summary report or a Map by State wiht
fatalities for a given year

## Installation

You can install the released version of BuildRWeek2Assign0207 from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("BuildRWeek2Assign0207")
```

## Filenames

Three data files are available in this package. They are in the
instfolders accident\_2013.csv.bz2 accident\_2014.csv.bz2
accident\_2015.csv.bz2

## Example-text summary report request

This is a basic example which shows you how to solve a common problem:

``` r
library(BuildRWeek2Assign0207)
fars_summarize_years(c(2013,2014))
#> Warning: `tbl_df()` is deprecated as of dplyr 1.0.0.
#> Please use `tibble::as_tibble()` instead.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_warnings()` to see where this warning was generated.
#> # A tibble: 12 x 3
#>    MONTH `2013` `2014`
#>    <dbl>  <int>  <int>
#>  1     1   2230   2168
#>  2     2   1952   1893
#>  3     3   2356   2245
#>  4     4   2300   2308
#>  5     5   2532   2596
#>  6     6   2692   2583
#>  7     7   2660   2696
#>  8     8   2899   2800
#>  9     9   2741   2618
#> 10    10   2768   2831
#> 11    11   2615   2714
#> 12    12   2457   2604
```

## Example: Map of Fatalities by State for a Given Year

``` r
fars_map_state(1,2015)
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />
