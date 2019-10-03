
# wrap the data as an hybrid leaf, i.e. a column of a data frame
hybrid_leaf <- function(x) {
  ptype <- vec_ptype(x)
  structure(
    ptype,
    class = c("hybrid_leaf", "hybrid"),
    ptype = ptype
  )
}

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
  eval_tidy(enquo(expr), data = map(data, hybrid_leaf))
}
