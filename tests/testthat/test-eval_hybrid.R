
test_that("arith operators are recognized", {
  expect_is(eval_hybrid(iris, Sepal.Length + Sepal.Width), "hybrid")
  expect_is(eval_hybrid(iris, Sepal.Length - Sepal.Width), "hybrid")
  expect_is(eval_hybrid(iris, Sepal.Length * Sepal.Width), "hybrid")
  expect_is(eval_hybrid(iris, Sepal.Length / Sepal.Width), "hybrid")
  expect_is(eval_hybrid(iris, Sepal.Length %% Sepal.Width), "hybrid")
  expect_is(eval_hybrid(iris, Sepal.Length %/% Sepal.Width), "hybrid")
  expect_is(eval_hybrid(iris, Sepal.Length ^ Sepal.Width), "hybrid")

  expect_is(eval_hybrid(iris, Sepal.Length + Sepal.Width + Petal.Length), "hybrid")
})

test_that("compare operators are recognized", {
  expect_is(eval_hybrid(iris, Sepal.Length == Sepal.Width), "hybrid")
  expect_is(eval_hybrid(iris, Sepal.Length != Sepal.Width), "hybrid")
  expect_is(eval_hybrid(iris, Sepal.Length > Sepal.Width), "hybrid")
  expect_is(eval_hybrid(iris, Sepal.Length < Sepal.Width), "hybrid")
  expect_is(eval_hybrid(iris, Sepal.Length >= Sepal.Width), "hybrid")
  expect_is(eval_hybrid(iris, Sepal.Length <= Sepal.Width), "hybrid")
})

test_that("not sensible to ast", {
  skip("not sure about that, has to do with how we mask +")
  plus <- function(x, y) {
    x + y
  }

  expect_is(eval_hybrid(iris, plus(Sepal.Length, Sepal.Width)), "hybrid")
  expect_is(eval_hybrid(iris, identity(mean(Sepal.Length))), "hybrid")
})

test_that("ptype correct handling of non hybridable", {
  res <- eval_hybrid(iris, mad(Sepal.Length))
  expect_false(inherits(res, "hybrid"))
  expect_is(res, "numeric")
})


