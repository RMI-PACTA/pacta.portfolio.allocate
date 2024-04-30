test_that("basic functionality works as expected", {
  df <- data.frame(
    plan_alloc_wt_tech_prod = c(5, 1),
    scen_alloc_wt_tech_prod = c(10, 5),
    technology = c("Oil", "NuclearCap")
  )

  output <- calculate_scenario_alignment(df)

  expected_new_names <- c(
    "trajectory_deviation",
    "trajectory_alignment"
  )

  expect_equal(nrow(output), nrow(df))
  expect_contains(names(output), expected_new_names)
  expect_equal(output[["trajectory_deviation"]], (df[["plan_alloc_wt_tech_prod"]] - df[["scen_alloc_wt_tech_prod"]]) / df[["scen_alloc_wt_tech_prod"]])
  expect_equal(output[["trajectory_alignment"]], output[["trajectory_deviation"]] * c(-1, 1))
})
