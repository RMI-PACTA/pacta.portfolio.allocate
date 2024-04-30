test_that("basic functionality works as expected", {
  df <- data.frame(
    plan_alloc_wt_tech_prod = c(5, 1),
    plan_alloc_wt_sec_prod = c(1, 5),
    scen_alloc_wt_tech_prod = c(10, 5),
    scen_alloc_wt_sec_prod = c(5, 10)
  )

  output <- calculate_technology_share(df)

  expected_new_names <- c(
    "plan_tech_share",
    "scen_tech_share"
  )

  expect_equal(nrow(output), nrow(df))
  expect_false(dplyr::is_grouped_df(output))
  expect_contains(names(output), expected_new_names)
  expect_equal(output[["plan_tech_share"]], df[["plan_alloc_wt_tech_prod"]] / df[["plan_alloc_wt_sec_prod"]])
  expect_equal(output[["scen_tech_share"]], df[["scen_alloc_wt_tech_prod"]] / df[["scen_alloc_wt_sec_prod"]])
})
