
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
  bottom <- env("+" = function(e1, e2) vec_arith("+", e1, e2), top)

  eval_tidy(
    enquo(expr),
    data = new_data_mask(bottom, top)
  )
}
