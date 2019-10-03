hybrid_mean <- function(x, ..., .data) {
  UseMethod("hybrid_mean")
}

hybrid_mean.default <- function(x, ..., .data) {
  mean(x, ...)
}

hybrid_mean.numeric <- function(x, ..., .data) {
  hybrid_tree(
    # structure the result as a numeric() so that
    # other functions that are unaware of hybrid can operate on this object
    ptype = numeric(),

    # but remember some information for
    class = "hybrid_mean",
    fun = "mean",
    args = list(x = .data, ...)
  )
}

#' @export
mean.hybrid <- function(x, ...) {
  hybrid_mean(attr(x, "ptype"), ..., .data = x)
}
