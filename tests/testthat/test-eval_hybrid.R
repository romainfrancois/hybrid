
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

