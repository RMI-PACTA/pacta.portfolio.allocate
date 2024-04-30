test_that("basic functionality works as expected", {
  portfolio <- data.frame(
    number_of_shares = 1:2,
    current_shares_outstanding_all_classes = 3:4
  )

  output <- calculate_ownership_weight(portfolio)

  expected_new_names <- "ownership_weight"

  expect_equal(nrow(output), nrow(portfolio))
  expect_contains(names(output), expected_new_names)
  expect_equal(output[["ownership_weight"]], portfolio[["number_of_shares"]] / portfolio[["current_shares_outstanding_all_classes"]])
})
