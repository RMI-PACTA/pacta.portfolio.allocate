calculate_port_weight <- function(portfolio, ...) {
  portfolio %>%
    ungroup() %>%
    mutate(
      port_total_aum = sum(.data$value_usd, na.rm = TRUE),
      port_weight = .data$value_usd / .data$port_total_aum
    )
}
