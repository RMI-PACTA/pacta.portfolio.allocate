test_that("basic functionality works as expected", {
  df <- data.frame(
    scenario_source = "WEO2023",
    scenario = "NZE",
    allocation = "portfolio_weight",
    equity_market = "GlobalMarket",
    scenario_geography = "Global",
    year = 2023,
    ald_sector = "Power",
    technology = "NuclearCap",
    plan_tech_prod = c(1, 10),
    plan_alloc_wt_tech_prod = c(1, 10),
    plan_carsten = c(1, 10),
    plan_emission_factor = c(1, 10),
    scen_tech_prod = c(1, 10),
    scen_alloc_wt_tech_prod = c(1, 10),
    scen_carsten = c(1, 10),
    scen_emission_factor = c(1, 10)
  )

  output <- aggregate_portfolio(df)

  expected_new_names <- c(
    "plan_sec_prod",
    "plan_alloc_wt_sec_prod",
    "plan_sec_carsten",
    "plan_sec_emissions_factor",
    "scen_sec_prod",
    "scen_alloc_wt_sec_prod",
    "scen_sec_carsten",
    "scen_sec_emissions_factor"
  )

  expect_true(nrow(output) == 1L)
  expect_true(all(expected_new_names %in% names(output)))
  expect_false(dplyr::is_grouped_df(output))
  expect_equal(output[["plan_sec_prod"]], sum(df[["plan_tech_prod"]]))
  expect_equal(output[["plan_alloc_wt_sec_prod"]], sum(df[["plan_alloc_wt_tech_prod"]]))
  expect_equal(output[["plan_sec_carsten"]], sum(df[["plan_carsten"]]))
  expect_equal(output[["plan_sec_emissions_factor"]], stats::weighted.mean(stats::weighted.mean(df[["plan_emission_factor"]], df[["plan_alloc_wt_tech_prod"]]), sum(df[["plan_alloc_wt_tech_prod"]])))
  expect_equal(output[["scen_sec_prod"]], sum(df[["scen_tech_prod"]]))
  expect_equal(output[["scen_alloc_wt_sec_prod"]], sum(df[["scen_alloc_wt_tech_prod"]]))
  expect_equal(output[["scen_sec_carsten"]], sum(df[["scen_carsten"]]))
  expect_equal(output[["scen_sec_emissions_factor"]], stats::weighted.mean(stats::weighted.mean(df[["scen_emission_factor"]], df[["scen_alloc_wt_tech_prod"]]), sum(df[["scen_alloc_wt_tech_prod"]])))
})
