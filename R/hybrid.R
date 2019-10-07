
#' @export
hybrid_leaf <- function(x) {
  ptype <- vec_ptype(x)
  structure(
    ptype,
    class = c("hybrid_leaf", "hybrid"),
    ptype = ptype
  )
}

#' @export
hybrid_tree <- function(ptype, fun, args, class) {
  structure(
    ptype,
    fun = fun,
    args = args,
    class = c(class, "hybrid_tree", "hybrid"),
    ptype = ptype
  )
}

#' @export
eval_hybrid <- function(data, expr) {
  top <- env(!!!map(data, hybrid_leaf))
  bottom <- env(
    # arith
    "+"   = function(e1, e2) vec_arith("+", e1, e2),
    "-"   = function(e1, e2) vec_arith("-", e1, e2),
    "*"   = function(e1, e2) vec_arith("*", e1, e2),
    "/"   = function(e1, e2) vec_arith("/", e1, e2),
    "^"   = function(e1, e2) vec_arith("^", e1, e2),
    "%%"  = function(e1, e2) vec_arith("%%", e1, e2),
    "%/%" = function(e1, e2) vec_arith("%/%", e1, e2),
    "&"   = function(e1, e2) vec_arith("&", e1, e2),
    "|"   = function(e1, e2) vec_arith("|", e1, e2),
    "!"   = function(x) vec_arith("!", x, MISSING()),

    # compare
    "==" = function(x, y) hybrid_compare("==", x, y),
    "<=" = function(x, y) hybrid_compare("<=", x, y),
    ">=" = function(x, y) hybrid_compare(">=", x, y),
    "!=" = function(x, y) hybrid_compare("!=", x, y),
    "<"  = function(x, y) hybrid_compare("<" , x, y),
    ">"  = function(x, y) hybrid_compare(">" , x, y),

    top
  )

  eval_tidy(
    enquo(expr),
    data = new_data_mask(bottom, top)
  )
}

#' @export
hybrid_ptype <- function(x) {
  UseMethod("hybrid_ptype")
}

#' @export
hybrid_ptype.default <- function(x) {
  vec_ptype(x)
}

#' @export
hybrid_ptype.hybrid <- function(x) {
  attr(x, "ptype")
}
