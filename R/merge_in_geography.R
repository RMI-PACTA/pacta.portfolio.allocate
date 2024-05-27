#' A short description of the function
#'
#' A longer description of the function
#'
#' @param portfolio A description of the argument
#' @param ald_raw A description of the argument
#'
#' @return A description of the return value
#'
#' @export

merge_in_geography <- function(
  portfolio,
  ald_raw,
  sector_list
) {
  company_all <- portfolio %>%
    distinct(
      .data$allocation,
      .data$allocation_weight,
      .data$id,
      .data$financial_sector
    )


  company_all <- company_all %>%
    filter(.data$financial_sector %in% .env$sector_list),
  sector_list

  ### join with MASTER to get country production
  company_all_data <- left_join(
    company_all,
    distinct(
      ald_raw,
      .data$id,
      .data$country_of_domicile,
      .data$ald_location,
      .data$year,
      .data$ald_sector,
      .data$technology,
      .data$ald_production,
      .data$ald_production_unit
    ),
    by = c("id" = "id", "financial_sector" = "ald_sector")
  ) %>%
    mutate(ald_sector = .data$financial_sector)

  ### complete rows of technology within a sector - we need to have a row for each tech to get a real tech share
  # dont' calculate tech share
  # specific_tech_list <- unique(company_all_data$technology)
  # specific_sector_list <- unique(company_all_data$ald_sector)
  #
  # company_all_data <- company_all_data %>% ungroup() %>%
  #   group_by(allocation, id, financial_sector, allocation, allocation_weight, ald_location,
  #            year, ald_sector) %>%
  #   complete(ald_sector = specific_sector_list,
  #           technology = specific_tech_list,
  #            fill = list(ald_production = 0))
  #
  # company_all_data <- removeInvalidSectorTechCombos(company_all_data)

  company_all_data$plan_alloc_wt_tech_prod <- company_all_data$ald_production * company_all_data$allocation_weight


  return(company_all_data)
}
