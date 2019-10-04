#' @rdname hybrid
#' @export vec_arith.hybrid
#' @method vec_arith hybrid
#' @export
vec_arith.hybrid <- function(op, x, y, ...) UseMethod("vec_arith.hybrid", y)

#' @export
vec_arith.hybrid.default <- function(op, x, y) {
  vec_arith(op, attr(x, "ptype"), y)
}

#' @export
vec_arith.hybrid.hybrid <- function(op, x, y) {
  hybrid_tree(
    ptype = vec_arith(op, attr(x, "ptype"), attr(y, "ptype")),
    fun = op,
    args = list(x = x, y = y),
    class = c("hybrid_plus")
  )
}

#' @export
vec_arith.Date.hybrid <- function(op, x, y) {
  vec_arith(op, x, attr(y, "ptype"))
}

#' @export
vec_arith.factor.hybrid <- function(op, x, y) {
  vec_arith(op, x, attr(y, "ptype"))
}
