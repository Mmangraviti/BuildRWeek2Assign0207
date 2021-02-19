library(testthat)
library(BuildRWeek2Assign0207)

test_check("BuildRWeek2Assign0207")

test_that("summary 2013 is ok",{
  expect_equal(fars_summarize_years(2013)[2][[1]][1],2230)})
