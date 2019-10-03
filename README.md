
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hybrid

<!-- badges: start -->

<!-- badges: end -->

The goal of hybrid is to …

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("romainfrancois/hybrid")
```

## Motivation

`eval_hybrid()` (temporary name) evaluates an expression with
`eval_tidy()` with a data mask made of hybrid leaves. An hybrid leaf is
essentially the `ptype` of a column marked with the `"hybrid"` class.

Giving leaves the hybrid class makes it possible to dispatch based on
that class, so `mean.hybrid` and `+.hybrid` (currently for this POC)
when passed hybrid trees (leaves included) make hybrid trees.

``` r
library(hybrid)

eval_hybrid(iris, mean(Sepal.Length))
#> numeric(0)
#> attr(,"fun")
#> [1] "mean"
#> attr(,"args")
#> attr(,"args")$x
#> numeric(0)
#> attr(,"class")
#> [1] "hybrid_leaf" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
#> 
#> attr(,"class")
#> [1] "hybrid_mean" "hybrid_tree" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
```

For functions that don’t define hybrid methods, the computation is
however as quick as possible yet still maintaining some type stability
because the ptype is used in place of the real column.

``` r
eval_hybrid(iris, median(Sepal.Length))
#> [1] NA
```

The idea is that standard R evaluation and dispatch takes place and if
we end up with an hybrid object, then perhaps the c++ code can handle
it, otherwise fall back.

``` r
# these return an hybrid object because +() and mean() can handle hybrid
eval_hybrid(iris, mean(Sepal.Length))
#> numeric(0)
#> attr(,"fun")
#> [1] "mean"
#> attr(,"args")
#> attr(,"args")$x
#> numeric(0)
#> attr(,"class")
#> [1] "hybrid_leaf" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
#> 
#> attr(,"class")
#> [1] "hybrid_mean" "hybrid_tree" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
eval_hybrid(iris, Sepal.Length + Sepal.Width)
#> numeric(0)
#> attr(,"fun")
#> [1] "+"
#> attr(,"args")
#> attr(,"args")$x
#> numeric(0)
#> attr(,"class")
#> [1] "hybrid_leaf" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
#> 
#> attr(,"args")$y
#> numeric(0)
#> attr(,"class")
#> [1] "hybrid_leaf" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
#> 
#> attr(,"class")
#> [1] "hybrid_plus" "hybrid_tree" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
eval_hybrid(iris, Sepal.Length + Sepal.Width + Petal.Length)
#> numeric(0)
#> attr(,"fun")
#> [1] "+"
#> attr(,"args")
#> attr(,"args")$x
#> numeric(0)
#> attr(,"fun")
#> [1] "+"
#> attr(,"args")
#> attr(,"args")$x
#> numeric(0)
#> attr(,"class")
#> [1] "hybrid_leaf" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
#> 
#> attr(,"args")$y
#> numeric(0)
#> attr(,"class")
#> [1] "hybrid_leaf" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
#> 
#> attr(,"class")
#> [1] "hybrid_plus" "hybrid_tree" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
#> 
#> attr(,"args")$y
#> numeric(0)
#> attr(,"class")
#> [1] "hybrid_leaf" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
#> 
#> attr(,"class")
#> [1] "hybrid_plus" "hybrid_tree" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
eval_hybrid(iris, mean(Sepal.Length + Sepal.Width))
#> numeric(0)
#> attr(,"fun")
#> [1] "mean"
#> attr(,"args")
#> attr(,"args")$x
#> numeric(0)
#> attr(,"fun")
#> [1] "+"
#> attr(,"args")
#> attr(,"args")$x
#> numeric(0)
#> attr(,"class")
#> [1] "hybrid_leaf" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
#> 
#> attr(,"args")$y
#> numeric(0)
#> attr(,"class")
#> [1] "hybrid_leaf" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
#> 
#> attr(,"class")
#> [1] "hybrid_plus" "hybrid_tree" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
#> 
#> attr(,"class")
#> [1] "hybrid_mean" "hybrid_tree" "hybrid"     
#> attr(,"ptype")
#> numeric(0)

# not sensible to the call ast, as is evaluation based
plus <- function(x, y) {
  x + y
}

eval_hybrid(iris, identity(mean(Sepal.Length)))
#> numeric(0)
#> attr(,"fun")
#> [1] "mean"
#> attr(,"args")
#> attr(,"args")$x
#> numeric(0)
#> attr(,"class")
#> [1] "hybrid_leaf" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
#> 
#> attr(,"class")
#> [1] "hybrid_mean" "hybrid_tree" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
eval_hybrid(iris, plus(Sepal.Length, Sepal.Width))
#> numeric(0)
#> attr(,"fun")
#> [1] "+"
#> attr(,"args")
#> attr(,"args")$x
#> numeric(0)
#> attr(,"class")
#> [1] "hybrid_leaf" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
#> 
#> attr(,"args")$y
#> numeric(0)
#> attr(,"class")
#> [1] "hybrid_leaf" "hybrid"     
#> attr(,"ptype")
#> numeric(0)
#> 
#> attr(,"class")
#> [1] "hybrid_plus" "hybrid_tree" "hybrid"     
#> attr(,"ptype")
#> numeric(0)

# No max() hybrid function so we get something not hybrid
eval_hybrid(iris, mad(Sepal.Length))
#> [1] NA

# + does not handle the pattern `hybrid + not-hybrid`
eval_hybrid(iris, mean(Sepal.Length) + 1)
#> numeric(0)
```
