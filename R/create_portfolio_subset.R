#' A short description of the function
#'
#' A longer description of the function
#'
#' @param portfolio A description of the argument
#' @param portfolio_type A description of the argument
#' @param ... A catch-all for deprecated variables (e.g. `grouping_variables`)
#'
#' @return A description of the return value
#'
#' @export

create_portfolio_subset <- function(portfolio, portfolio_type, ...) {
  if (portfolio_type %in% unique(portfolio$asset_type)) {
    portfolio_subset <- portfolio %>%
      ungroup() %>%
      filter(.data$asset_type == .env$portfolio_type)

    portfolio_subset <- create_id_columns(portfolio_subset, portfolio_type)

    portfolio_subset <- portfolio_subset %>%
      select(
        all_of(c(
          "holding_id",
          "value_usd",
          "number_of_shares",
          "factset_entity_id",
          "company_name",
          "id",
          "id_name",
          "credit_parent_ar_company_id",
          "country_of_domicile",
          "unit_share_price",
          "current_shares_outstanding_all_classes",
          "financial_sector",
          "has_ald_in_fin_sector",
          "bics_sector"
        ))
      )
  } else {
    write_log(paste0("No ", portfolio_type, " in portfolio"))

    portfolio_subset <- NA
  }



  return(portfolio_subset)
}
