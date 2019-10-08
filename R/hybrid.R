
#' @export
hybrid_leaf <- function(x, name) {
  structure(
    list(),
    class = c("hybrid_leaf", "hybrid"),
    ptype = vec_ptype(x),
    name = name
  )
}

#' @export
hybrid_tree <- function(fun, args, class) {
  structure(
    list(),
    fun = fun,
    args = args,
    class = c(class, "hybrid_tree", "hybrid")
  )
}

is_hybridable <- function(x) {
  inherits(x, "hybrid") || rlang::is_syntactic_literal(x)
}

hybridable <- function(x) {
  stopifnot(is_hybridable(x))
  x
}

#' @export
eval_hybrid <- function(data, expr) {
  mask <- map2(data, names(data), hybrid_leaf)

  quo <- quo_set_env(enquo(expr), hybrid_functions)

  tryCatch(eval_tidy(quo, data = mask), condition = function(e) NULL)
}
