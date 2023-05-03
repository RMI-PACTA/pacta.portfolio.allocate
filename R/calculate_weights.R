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

calculate_weights <- function(portfolio, portfolio_type, ...) {
  port_sub <- portfolio %>%
    select(
      all_of(c(
        "holding_id",
        "id",
        "id_name",
        "company_name",
        "credit_parent_ar_company_id",
        "value_usd",
        "number_of_shares",
        "current_shares_outstanding_all_classes",
        "financial_sector",
        "has_ald_in_fin_sector"
      ))
    ) %>%
    mutate(id = as.character(.data$id))

  port_sub <- calculate_port_weight(port_sub)

  port_sub <- aggregate_holdings(port_sub)


  if (portfolio_type == "Equity") {
    port_sub <- calculate_ownership_weight(port_sub)
  }


  return(port_sub)
}
