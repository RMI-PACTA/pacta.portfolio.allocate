#' A short description of the function
#'
#' A longer description of the function
#'
#' @param portfolio_type A description of the argument
#' @param analysis_inputs_path Path to directory containing ABCD Data files
#' @param start_year Start year of the analysis
#' @param time_horizon Length of the analysis in years (analysis will run from
#' `start_year` to `start_year + time_horizon`)
#' @param sector_list (character) A vector of PACTA sectors to include in the
#' analysis.
#'
#' @return A description of the return value
#'
#' @export

get_abcd_raw <- function(
  portfolio_type,
  analysis_inputs_path,
  start_year,
  time_horizon,
  sector_list
) {
  filename_eq_raw <- "masterdata_ownership_datastore.rds"
  filename_cb_raw <- "masterdata_debt_datastore.rds"

  if (portfolio_type == "Equity") {
    abcd_raw <- readr::read_rds(file.path(analysis_inputs_path, filename_eq_raw))
  }

  if (portfolio_type == "Bonds") {
    abcd_raw <- readr::read_rds(file.path(analysis_inputs_path, filename_cb_raw))
  }

  abcd_raw <- abcd_raw %>%
    filter(.data$year %in% seq(start_year, start_year + time_horizon)) %>%
    filter(.data$ald_sector %in% sector_list) %>%
    mutate(
      ald_sector = if_else(
        .data$technology == "Coal",
        "Coal",
        .data$ald_sector
      ),
      ald_sector = if_else(
        .data$technology %in% c("Oil", "Gas"),
        "Oil&Gas",
        .data$ald_sector
      ),
      ald_production = if_else(
        .data$technology == "Gas" & grepl("GJ", .data$ald_production_unit),
        .data$ald_production * (1 / 0.0372),
        .data$ald_production
      ),
      ald_production = if_else(
        .data$technology == "Oil" & grepl("GJ", .data$ald_production_unit),
        .data$ald_production * (1 / 6.12),
        .data$ald_production
      ),
      ald_production_unit = if_else(
        .data$technology == "Gas" & grepl("GJ", .data$ald_production_unit),
        "m3 per day",
        .data$ald_production_unit
      ),
      ald_production_unit = if_else(
        .data$technology == "Oil" & grepl("GJ", .data$ald_production_unit),
        "boe per day",
        .data$ald_production_unit
      )
    )

  return(abcd_raw)
}
