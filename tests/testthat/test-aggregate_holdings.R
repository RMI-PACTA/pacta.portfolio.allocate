test_that("basic functionality works as expected", {
  portfolio <- data.frame(
    holding_id = 1:2,
    value_usd = c(1, 10),
    number_of_shares = c(1, 10),
    port_weight = c(1/11, 10/11),
    company_name = "ABC",
    credit_parent_ar_company_id = "ABC123",
    id = "DEF456",
    financial_sector = "Power",
    current_shares_outstanding_all_classes = 1e9,
    has_ald_in_fin_sector = TRUE
  )

  output <- aggregate_holdings(portfolio)

  expected_new_names <- c(
    "number_holdings",
    "value_usd",
    "number_of_shares",
    "port_weight"
  )

  expect_true(nrow(output) == 1L)
  expect_true(all(expected_new_names %in% names(output)))
  expect_false(dplyr::is_grouped_df(output))
  expect_equal(output[["number_holdings"]], 2L)
  expect_equal(output[["value_usd"]], sum(portfolio[["value_usd"]]))
  expect_equal(output[["number_of_shares"]], sum(portfolio[["number_of_shares"]]))
  expect_equal(output[["port_weight"]], sum(portfolio[["port_weight"]]))
})
