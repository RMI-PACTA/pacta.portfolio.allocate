#' A short description of the function
#'
#' A longer description of the function
#'
#' @param portfolio A description of the argument
#'
#' @return A description of the return value
#'
#' @export

ownership_allocation <- function(portfolio) {
  # Only for equity portfolios
  port_abcd_own <- calculate_with_weights(portfolio, "ownership_weight", "ownership_weight")

  port_abcd_own %>%
    mutate(
      plan_carsten = NA,
      scen_carsten = NA
    )
}
