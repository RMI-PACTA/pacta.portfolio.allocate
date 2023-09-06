#' A short description of the function
#'
#' A longer description of the function
#'
#' @param portfolio_type A description of the argument
#'
#' @return A description of the return value
#'
#' @export

get_abcd_raw <- function(portfolio_type) {
  filename_eq_raw <- "masterdata_ownership_datastore.rds"
  filename_cb_raw <- "masterdata_debt_datastore.rds"

  if (portfolio_type == "Equity") {
    abcd_raw <- readr::read_rds(file.path(.GlobalEnv$analysis_inputs_path, filename_eq_raw))
  }

  if (portfolio_type == "Bonds") {
    abcd_raw <- readr::read_rds(file.path(.GlobalEnv$analysis_inputs_path, filename_cb_raw))
  }

  abcd_raw <- abcd_raw %>%
    filter(.data$year %in% seq(.GlobalEnv$start_year, .GlobalEnv$start_year + .GlobalEnv$time_horizon)) %>%
    filter(.data$ald_sector %in% .GlobalEnv$sector_list) %>%
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
