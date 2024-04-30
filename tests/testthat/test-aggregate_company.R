test_that("basic functionality works as expected", {
  df <- data.frame(
    scenario_source = "ABC",
    scenario = "ABC",
    allocation = "ABC",
    id = "ABC",
    company_name = "ABC",
    financial_sector = "ABC",
    port_weight = 1,
    allocation_weight = 1,
    plan_br_dist_alloc_wt = 1,
    scen_br_dist_alloc_wt = 1,
    equity_market = "ABC",
    scenario_geography = "ABC",
    year = 2023,
    ald_sector = "ABC",
    technology = "ABC",
    plan_tech_prod = 1:2,
    plan_alloc_wt_tech_prod = 2:3,
    plan_carsten = 1:2,
    plan_emission_factor = 0:1,
    scen_tech_prod = 0:1,
    scen_alloc_wt_tech_prod = 0:1,
    scen_carsten = 0:1,
    scen_emission_factor = 0:1
  )

  output <- aggregate_company(df)

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

  expect_true(all(expected_new_names %in% names(output)))
  # sum plan_tech_prod = 1:2sum(df[["plan_tech_prod"]])
  expect_true(all(output[["plan_sec_prod"]] == sum(df[["plan_tech_prod"]])))
  # sum plan_alloc_wt_tech_prod = 2:3
  expect_true(all(output[["plan_alloc_wt_sec_prod"]] == sum(df[["plan_alloc_wt_tech_prod"]])))
  # sum plan_carsten = 1:2
  expect_true(all(output[["plan_sec_carsten"]] == sum(df[["plan_carsten"]])))
  # weighted mean plan_emission_factor = 0:1 and plan_alloc_wt_tech_prod = 2:3
  expect_true(all(output[["plan_sec_emissions_factor"]] == stats::weighted.mean(df[["plan_emission_factor"]], df[["plan_alloc_wt_tech_prod"]])))
  # sum scen_tech_prod = 0:1
  expect_true(all(output[["scen_sec_prod"]] == sum(df[["scen_tech_prod"]])))
  # sum scen_alloc_wt_tech_prod = 0:1
  expect_true(all(output[["scen_alloc_wt_sec_prod"]] == sum(df[["scen_alloc_wt_tech_prod"]])))
  # sum scen_carsten = 0:1
  expect_true(all(output[["scen_sec_carsten"]] == sum(df[["scen_carsten"]])))
  # weighted mean scen_emission_factor = 0:1 and scen_alloc_wt_tech_prod = 0:1
  expect_true(all(output[["scen_sec_emissions_factor"]] == stats::weighted.mean(df[["scen_emission_factor"]], df[["scen_alloc_wt_tech_prod"]])))
})
