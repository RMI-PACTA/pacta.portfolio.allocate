test_that("passes TRUE, if at least one group of data contains all TDM years", {
  t0 <- 2021
  delta_t1 <- 5
  delta_t2 <- 9
  scenarios <- "IPR FPS 2021"

  input_data <- fake_tdm_data(
    ald_sector = c("power", "power", "power", "steel"),
    year = c(t0, t0 + delta_t1, t0 + delta_t2, t0)
  )

  out <- tdm_conditions_met(
    input_data,
    t0,
    delta_t1,
    delta_t2,
    scenarios,
    project_code = "XXX"
    )

  expect_equal(out, TRUE)
})
