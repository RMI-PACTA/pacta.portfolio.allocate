test_that("basic functionality works as expected", {
  portfolio <- data.frame(
    value_usd = 1:2
  )

  output <- calculate_port_weight(portfolio)

  expected_new_names <- c(
    "port_total_aum",
    "port_weight"
  )

  expect_equal(nrow(output), nrow(portfolio))
  expect_false(dplyr::is_grouped_df(output))
  expect_contains(names(output), expected_new_names)
  expect_true(all(output[["port_total_aum"]] == sum(portfolio[["value_usd"]])))
  expect_equal(output[["port_weight"]], portfolio[["value_usd"]] / sum(portfolio[["value_usd"]]))
})
