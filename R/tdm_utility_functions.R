#' A helper function to keep track of the scenario(s) relevant for the TDM.
#'
#' @return A character vector, containing the `scenario` value(s) relevant to the TDM.
#'
#' @export

tdm_scenarios <- function() {
  c("IPR FPS 2021")
}

#' A helper function to determine what conditions should be met for the TDM to
#' be generated
#'
#' @param data Like the `data` input to `calculate_tdm`.
#' @param t0 Like the `t0` input to `calculate_tdm`.
#' @param delta_t1 Like the `delta_t1` input to `calculate_tdm`.
#' @param delta_t2 Like the `delta_t2` input to `calculate_tdm`.
#' @param scenarios Like the `scenarios` input to `calculate_tdm`.
#' @param project_code The PACTA project code.
#' @param additional_groups Like the `additional_groups` input to `calculate_tdm`.
#'
#' @return A Boolean, indicating if the TDM should be calculated.
#'
#' @export

tdm_conditions_met <- function(data,
                               t0,
                               delta_t1,
                               delta_t2,
                               scenarios,
                               project_code,
                               additional_groups = NULL) {

  valid_project_code <- project_code == "GENERAL"

  useable_data <- data %>%
    filter(.data$allocation == "portfolio_weight") %>%
    filter(.data$scenario %in% scenarios)

  valid_data_available <- all(
    is.data.frame(useable_data),
    nrow(useable_data) > 0
    )

  tdm_years <- c(t0, t0 + delta_t1, t0 + delta_t2)

  has_useable_data_per_group <- useable_data %>%
    dplyr::summarise(
      has_all_years = all(tdm_years %in% .data$year),
      .by = (union(crucial_tdm_groups(), additional_groups))
      )

  valid_years_available <- all(has_useable_data_per_group$has_all_years)

  return(all(valid_project_code, valid_data_available, valid_years_available))
}

#' A helper function to generate and keep track of all input parameters to the
#' `calculate_tdm` function.
#'
#' @param start_year An integer value, indicating the start year of the PACTA
#' run.
#'
#' @return A named list containing all relevant inputs to `calculate_tdm()`
#'
#' @export

determine_tdm_variables <- function(start_year) {
  list(
    t0 = start_year,
    delta_t1 = 5,
    delta_t2 = 10,
    additional_groups = c("scenario_source", "scenario", "allocation", "equity_market", "scenario_geography"),
    scenarios = tdm_scenarios()
  )
}
