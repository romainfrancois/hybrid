hybrid_vec_arith <- function(op, x, y) {
  hybrid_tree(
    fun = op,
    args = list(x = x, y = y),
    class = c(paste0("hybrid_arith_", op), "hybrid_arith")
  )
}

#' @rdname hybrid
#' @export vec_arith.hybrid
#' @method vec_arith hybrid
#' @export
vec_arith.hybrid <- function(op, x, y, ...) UseMethod("vec_arith.hybrid", y)

#' @export
vec_arith.hybrid.default <- function(op, x, y) {
  hybrid_vec_arith(op, x, y)
}

#' @export
vec_arith.Date.hybrid <- function(op, x, y) {
  hybrid_vec_arith(op, x, y)
}

#' @export
vec_arith.POSIXct.hybrid <- function(op, x, y) {
  hybrid_vec_arith(op, x, y)
}

#' @export
vec_arith.logical.hybrid <- function(op, x, y) {
  hybrid_vec_arith(op, x, y)
}

#' @export
vec_arith.numeric.hybrid <- function(op, x, y) {
  hybrid_vec_arith(op, x, y)
}

#' @export
vec_arith.factor.hybrid <- function(op, x, y) {
  hybrid_vec_arith(op, x, y)
}
