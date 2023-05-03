calculate_ownership_weight <- function(portfolio) {
  portfolio %>%
    mutate(
      ownership_weight =
        .data$number_of_shares / .data$current_shares_outstanding_all_classes
    )
}
