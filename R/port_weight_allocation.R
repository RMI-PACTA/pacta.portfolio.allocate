#' A short description of the function
#'
#' A longer description of the function
#'
#' @param port_abcd A description of the argument
#'
#' @return A description of the return value
#'
#' @export

port_weight_allocation <- function(port_abcd) {
  port_abcd_pw <-
    port_abcd %>%
    filter(
      .data$has_ald_in_fin_sector == TRUE,
      .data$financial_sector == .data$ald_sector
    )

  if (data_check(port_abcd_pw)) {
    port_abcd_pw <-
      calculate_with_weights(
        port_abcd_pw,
        "port_weight",
        "portfolio_weight"
      )
  }

  port_abcd_pw
}
