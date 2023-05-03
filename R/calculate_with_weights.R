calculate_with_weights <- function(df, weight_col_name, weight_method_name) {
  df %>%
    mutate(
      plan_br_dist_alloc_wt   = .data$plan_br_wt_factor * .data[[weight_col_name]],
      plan_carsten            = .data$plan_br_wt_techshare * .data[[weight_col_name]],
      scen_br_dist_alloc_wt   = .data$scen_br_wt_factor * .data[[weight_col_name]],
      scen_carsten            = .data$scen_br_wt_techshare * .data[[weight_col_name]],
      plan_alloc_wt_tech_prod = .data$plan_tech_prod * .data[[weight_col_name]],
      scen_alloc_wt_tech_prod = .data$scen_tech_prod * .data[[weight_col_name]],
      allocation              = .env$weight_method_name,
      allocation_weight       = .data[[weight_col_name]]
    )
}
