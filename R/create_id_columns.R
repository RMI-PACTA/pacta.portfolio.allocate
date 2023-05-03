create_id_columns <- function(portfolio, portfolio_type) {
  if (portfolio_type == "Equity") {
    portfolio <- portfolio %>%
      rename(id = "ar_company_id") %>%
      mutate(
        id_name = "ar_company_id",
        id = as.character(.data$id)
      )
  }
  if (portfolio_type == "Bonds") {
    portfolio <- portfolio %>%
      rename(id = "ar_company_id") %>%
      mutate(
        id_name = "ar_company_id",
        id = as.character(.data$id)
      )
  }

  return(portfolio)
}
