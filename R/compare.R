hybrid_compare <- function(op, x, y) {
  hybrid_tree(
    fun = op,
    args = list(x = x, y = y),
    class = c(paste0("hybrid_arith_compare_", op), "hybrid_compare")
  )
}
