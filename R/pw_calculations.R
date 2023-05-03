#' A short description of the function
#'
#' A longer description of the function
#'
#' @param eq_portfolio A description of the argument
#' @param cb_portfolio A description of the argument
#' @param ... A catch-all for deprecated variables (e.g. `grouping_variables`)
#'
#' @return A description of the return value
#'
#' @export

pw_calculations <- function(eq_portfolio, cb_portfolio, ...) {
  port_all <- data.frame()

  if (data_check(eq_portfolio)) {
    port_all <- bind_rows(port_all, eq_portfolio)
  }

  if (data_check(cb_portfolio)) {
    port_all <- bind_rows(port_all, cb_portfolio)
  }

  if (data_check(port_all)) {
    port_all <- port_all %>%
      select(
        "factset_entity_id",
        "value_usd"
      )

    port_all <- calculate_port_weight(port_all)


    pw <- port_all %>%
      group_by(
        .data$factset_entity_id
      ) %>%
      dplyr::summarise(
        port_weight = sum(.data$port_weight, na.rm = TRUE), .groups = "drop"
      ) %>%
      select("factset_entity_id", "port_weight") %>%
      rename(portfolio_weight = "port_weight")
  } else {
    pw <- data.frame(company_id = "No companies in portfolio", portfolio_weight = "0")
  }

  return(pw)
}
