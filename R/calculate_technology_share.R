#' A short description of the function
#'
#' A longer description of the function
#'
#' @param df A description of the argument
#'
#' @return A description of the return value
#'
#' @export

calculate_technology_share <- function(df) {
  df %>%
    ungroup() %>%
    mutate(
      plan_tech_share =
        .data$plan_alloc_wt_tech_prod / .data$plan_alloc_wt_sec_prod,
      scen_tech_share =
        .data$scen_alloc_wt_tech_prod / .data$scen_alloc_wt_sec_prod
    )
}
