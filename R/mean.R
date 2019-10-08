hybrid_fun <- function(fun, ...) {
  hybrid_tree(
    class = paste0("hybrid_", fun),
    fun = fun,
    args = list(...)
  )
}

#' @export
mean.hybrid <- function(x, ...) {
  hybrid_fun("mean", x = x, ...)
}

#' @export
sum.hybrid <- function(..., na.rm = FALSE) {
  hybrid_fun("sum", ..., na.rm = na.rm)
}

var <- function(x, ..., na.rm = FALSE) {
  stopifnot(is_hybridable(x), is.logical(na.rm), dots_n(...) == 0L)
  hybrid_tree(fun = "var", class = "hybrid_var", args = list(x = x, na.rm = na.rm))
}
