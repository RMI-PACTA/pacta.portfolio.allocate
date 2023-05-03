aggregate_holdings <- function(portfolio, ...) {
  portfolio %>%
    ungroup() %>%
    group_by(
      .data$company_name,
      .data$credit_parent_ar_company_id,
      .data$id,
      .data$financial_sector,
      .data$current_shares_outstanding_all_classes,
      .data$has_ald_in_fin_sector
    ) %>%
    dplyr::summarise(
      number_holdings = dplyr::n_distinct(.data$holding_id),
      value_usd = sum(.data$value_usd, na.rm = TRUE),
      number_of_shares = sum(.data$number_of_shares, na.rm = TRUE),
      port_weight = sum(.data$port_weight, na.rm = TRUE),
      .groups = "drop"
    ) %>%
    ungroup()
}
