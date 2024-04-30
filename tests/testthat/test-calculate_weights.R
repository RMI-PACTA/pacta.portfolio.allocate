test_that("basic functionality works as expected", {
  portfolio <- data.frame(
    holding_id = c(1, 2),
    id = c(124, 456),
    id_name = "ai_company_id",
    company_name = c("ABC", "DEF"),
    credit_parent_ar_company_id = c(789, 987),
    value_usd = c(2, 10),
    number_of_shares = c(1, 5),
    current_shares_outstanding_all_classes = c(100, 500),
    financial_sector = "Power",
    has_ald_in_fin_sector = TRUE
  )
  portfolio_type <- "Equity"

  output <- calculate_weights(portfolio, portfolio_type)

  expected_new_names <- c(
    "number_holdings",
    "port_weight",
    "ownership_weight"
  )

  expect_equal(nrow(output), nrow(portfolio))
  expect_false(dplyr::is_grouped_df(output))
  expect_contains(names(output), expected_new_names)
  expect_type(output[["id"]], "character")
  expect_equal(output[["number_holdings"]], c(1L, 1L))
  expect_equal(output[["port_weight"]], portfolio[["value_usd"]] / sum(portfolio[["value_usd"]]))
  expect_equal(output[["ownership_weight"]], portfolio[["number_of_shares"]] / portfolio[["current_shares_outstanding_all_classes"]])
})
