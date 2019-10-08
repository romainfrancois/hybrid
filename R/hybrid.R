
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
  funs <- env(
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


    mean = mean,
    sum = sum,
    var = var,

    "%in%" = function(x, table) {
      hybrid_tree("%in%",
        args = list(x = hybridable(x), table = hybridable(table)),
        class = "hybrid_%in%"
      )
    },

    empty_env()
  )

  quo <- quo_set_env(enquo(expr), funs)

  tryCatch(eval_tidy(quo, data = mask), condition = function(e) NULL)
}
