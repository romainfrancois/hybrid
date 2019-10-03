hybrid_plus <- function(x, y) {
  UseMethod("hybrid_plus", y)
}
hybrid_plus.default <- function(x, y) {
  attr(x, "ptype") + vec_ptype(y)
}

hybrid_plus.hybrid <- function(x, y) {
  hybrid_tree(
    ptype = attr(x, "ptype") + attr(y, "ptype"),
    fun = "+",
    args = list(x = x, y = y),
    class = c("hybrid_plus")
  )
}

#' @export
`+.hybrid` = function(x, y) {
  if(!inherits(y, "hybrid")) {
    vec_ptype(attr(x, "ptype")) + vec_ptype(y)
  } else {
    hybrid_plus(x, y)
  }
}
