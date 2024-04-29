test_that("basic functionality works as expected", {
  portfolio <- data.frame(
    ald_location = "DE",
    year = 2023,
    ald_sector = "Power",
    technology = "NuclearCap",
    financial_sector = "Power",
    allocation = "portfolio_weight",
    allocation_weight = 1,
    ald_production_unit = "MW",
    plan_alloc_wt_tech_prod = 1:2
  )

  output <- aggregate_map_data(portfolio)

  expected_new_names <- c(
    "plan_alloc_wt_sec_prod",
    "equity_market",
    "scenario",
    "scenario_geography"
  )

  expect_true(nrow(output) == 1L)
  expect_true(all(expected_new_names %in% names(output)))
  expect_false(dplyr::is_grouped_df(output))
  expect_equal(output[["plan_alloc_wt_tech_prod"]], sum(portfolio[["plan_alloc_wt_tech_prod"]]))
  expect_equal(output[["plan_alloc_wt_sec_prod"]], sum(portfolio[["plan_alloc_wt_tech_prod"]]))
  expect_equal(output[["equity_market"]], "Global")
  expect_equal(output[["scenario"]], NA)
  expect_equal(output[["scenario_geography"]], NA)
})
