hybrid_fun <- function(fun, ...) {
  hybrid_tree(
    class = paste0("hybrid_", fun),
    fun = fun,
    args = list2(...)
  )
}

hybrid_functions <- env(
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

  "%in%" = function(x, table) {
    stopifnot(is_hybridable(x), is_hybridable(table))
    hybrid_fun("%in%", x = x, table = table)
  },

  mean = function(x, ..., na.rm = FALSE) {
    stopifnot(is.logical(na.rm) && dots_n(...) == 0 && is_hybridable(..1))
    hybrid_fun("mean", x = x, na.rm = na.rm)
  },

  sum = function(..., na.rm = FALSE) {
    stopifnot(is.logical(na.rm) && dots_n(...) == 1 && is_hybridable(..1))
    hybrid_fun("sum", x = ..1, na.rm = na.rm)
  },

  var = function(x, ..., na.rm = FALSE) {
    stopifnot(is_hybridable(x), is.logical(na.rm), dots_n(...) == 0L)
    hybrid_fun("var", x = x, na.rm = na.rm)
  },

  sd = function(x, na.rm = FALSE) {
    stopifnot(is_hybridable(x), is.logical(na.rm))
    hybrid_fun("sd", x = x, na.rm = na.rm)
  },

  max = function(..., na.rm = FALSE) {
    stopifnot(is.logical(na.rm) && dots_n(...) == 1 && is_hybridable(..1))
    hybrid_fun("max", x = ..1, na.rm = na.rm)
  },

  min = function(..., na.rm = FALSE) {
    stopifnot(is.logical(na.rm) && dots_n(...) == 1 && is_hybridable(..1))
    hybrid_fun("min", x = ..1, na.rm = na.rm)
  },

  lead = function(x, n = 1L, ...) {
    stopifnot(is_hybridable(x), is_integerish(n), length(n) == 1L, dots_n(...) == 0L)
    hybrid_fun("lead", x = x, n = n)
  },

  lag = function(x, n = 1L, ...) {
    stopifnot(is_hybridable(x), is_integerish(n), length(n) == 1L, dots_n(...) == 0L)
    hybrid_fun("lag", x = x, n = n)
  },

  cume_dist = function(x) {
    stopifnot(is_hybridable(x))
    hybrid_fun("cume_dist", x = x)
  },

  percent_rank = function(x) {
    stopifnot(is_hybridable(x))
    hybrid_fun("percent_rank", x = x)
  },

  min_rank = function(x) {
    stopifnot(is_hybridable(x))
    hybrid_fun("min_rank", x = x)
  },

  dense_rank = function(x) {
    stopifnot(is_hybridable(x))
    hybrid_fun("dense_rank", x = x)
  },

  ntile = function(x = row_number(), n) {
    stopifnot(is_hybridable(x), is_integerish(n))
    hybrid_fun("ntile", x = x, n = n)
  },

  last = function(x, ...) {
    stopifnot(is_hybridable(x), dots_n(...) == 0L)
    hybrid_fun("last", x = x)
  },

  first = function(x, ...) {
    stopifnot(is_hybridable(x), dots_n(...) == 0L)
    hybrid_fun("first", x = x)
  },

  nth = function(x, n, ...) {
    stopifnot(is_hybridable(x), is_integerish(n), dots_n(...) == 0L)
    hybrid_fun("nth", x = x, n = n)
  },

  n_distinct = function(..., na.rm = TRUE) {
    dots <- list(...)
    stopifnot(!all(map_lgl(dots, is_hybridable)), is.logical(na.rm))
    hybrid_fun("n_distinct", !!!dots, na.rm = na.rm)
  },

  row_number = function(...) {
    stopifnot(dots_n(...) == 0L)
    hybrid_fun("row_number")
  },

  group_indices = function(...) {
    stopifnot(dots_n(...) == 0L)
    hybrid_fun("group_indices")
  },

  n = function() {
    hybrid_fun("n")
  },

  empty_env()
)
