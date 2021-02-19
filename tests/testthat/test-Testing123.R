

test_that("summary 2013 is ok",{
  expect_equal(fars_summarize_years(2013)[2][[1]][1],2230)})

test_that("summary 2014 is ok",{
  expect_equal(fars_summarize_years(2014)[2][[1]][1],2168)})

test_that("summary 2015 is ok",{
  expect_equal(fars_summarize_years(2015)[2][[1]][1],2368)})
