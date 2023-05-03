#' A short description of the function
#'
#' A longer description of the function
#'
#' @param portfolio A description of the argument
#'
#' @return A description of the return value
#'
#' @export

aggregate_map_data <- function(portfolio) {
  portfolio <-
    portfolio %>%
    ungroup() %>%
    group_by(
      .data$ald_location,
      .data$year,
      .data$ald_sector,
      .data$technology,
      .data$financial_sector,
      .data$allocation,
      .data$allocation_weight,
      .data$ald_production_unit
    ) %>%
    dplyr::summarise(
      plan_alloc_wt_tech_prod = sum(
        .data$plan_alloc_wt_tech_prod,
        na.rm = TRUE
      ),
      .groups = "drop_last"
    ) %>%
    mutate(plan_alloc_wt_sec_prod = sum(.data$plan_alloc_wt_tech_prod)) %>%
    ungroup()

  if (data_check(portfolio)) {
    portfolio$equity_market <- "Global"
    portfolio$scenario <- NA # this is current plans only
    portfolio$scenario_geography <- NA
  }

  portfolio
}
