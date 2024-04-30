test_that("basic functionality works as expected", {
  df <- data.frame(
    plan_br_wt_factor = c(0.2, 0.5),
    plan_br_wt_techshare = c(0.3, 0.6),
    scen_br_wt_factor = c(0.4, 0.7),
    scen_br_wt_techshare = c(0.5, 0.8),
    plan_tech_prod = c(1, 2),
    scen_tech_prod = c(3, 4),
    weight = c(0.6, 0.9)
  )
  weight_col_name <- "weight"
  weight_method_name <- "weight_method"

  output <- calculate_with_weights(df, weight_col_name, weight_method_name)

  expected_new_names <- c(
    "plan_br_dist_alloc_wt",
    "plan_carsten",
    "scen_br_dist_alloc_wt",
    "scen_carsten",
    "plan_alloc_wt_tech_prod",
    "scen_alloc_wt_tech_prod",
    "allocation",
    "allocation_weight"
  )

  expect_true(nrow(output) == nrow(df))
  expect_true(all(expected_new_names %in% names(output)))
  expect_equal(output[["plan_br_dist_alloc_wt"]], df[["plan_br_wt_factor"]] * df[["weight"]])
  expect_equal(output[["plan_carsten"]], df[["plan_br_wt_techshare"]] * df[["weight"]])
  expect_equal(output[["scen_br_dist_alloc_wt"]], df[["scen_br_wt_factor"]] * df[["weight"]])
  expect_equal(output[["scen_carsten"]], df[["scen_br_wt_techshare"]] * df[["weight"]])
  expect_equal(output[["plan_alloc_wt_tech_prod"]], df[["plan_tech_prod"]] * df[["weight"]])
  expect_equal(output[["scen_alloc_wt_tech_prod"]], df[["scen_tech_prod"]] * df[["weight"]])
  expect_equal(output[["allocation"]], rep(weight_method_name, nrow(df)))
  expect_equal(output[["allocation_weight"]], df[["weight"]])
})
