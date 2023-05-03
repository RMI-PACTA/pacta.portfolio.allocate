#' A short description of the function
#'
#' A longer description of the function
#'
#' @param df A description of the argument
#'
#' @return A description of the return value
#'
#' @export

aggregate_portfolio <- function(df) {
  ### Note: in the code below I have to add the "AllComp" ending for the variables I used in the weighted mean calc
  ### due to a quirk in the way that dplyr and weighted.meann work together.
  ### when I sum, I have to create a different output column name then the input column I am summing,
  ### or else weighted.mean will get confused if I try to  use that input column name as my weighting
  ### variable.  Hence... plan_alloc_wt_tech_prod_all_comp=sum(plan_alloc_wt_tech_prod, na.rm=TRUE)
  ### I jsut temporarily rename these to do the agregation and then change the names back.
  if (data_check(df)) {
    df <- df %>%
      select(
        all_of(c(
          "scenario_source",
          "scenario",
          "allocation",
          "equity_market",
          "scenario_geography",
          "year",
          "ald_sector",
          "technology",
          "plan_tech_prod",
          "plan_alloc_wt_tech_prod",
          "plan_carsten",
          "plan_emission_factor",
          "scen_tech_prod",
          "scen_alloc_wt_tech_prod",
          "scen_carsten",
          "scen_emission_factor"
        ))
      ) %>%
      mutate(
        plan_emission_factor = ifelse(
          is.na(.data$plan_emission_factor),
          0,
          .data$plan_emission_factor
        ),
        scen_emission_factor = ifelse(
          is.na(.data$scen_emission_factor),
          0,
          .data$scen_emission_factor
        )
      ) %>%
      group_by(
        .data$scenario_source,
        .data$scenario,
        .data$allocation,
        .data$equity_market,
        .data$scenario_geography,
        .data$year,
        .data$ald_sector,
        .data$technology
      ) %>%
      dplyr::summarise(
        plan_tech_prod = sum(
          .data$plan_tech_prod,
          na.rm = TRUE
        ),
        plan_alloc_wt_tech_prod_all_comp = sum(
          .data$plan_alloc_wt_tech_prod,
          na.rm = TRUE
        ),
        plan_carsten = sum(
          .data$plan_carsten,
          na.rm = TRUE
        ),
        plan_emission_factor_all_comp = stats::weighted.mean(
          .data$plan_emission_factor,
          .data$plan_alloc_wt_tech_prod,
          na.rm = TRUE
        ),
        scen_tech_prod = sum(.data$scen_tech_prod, na.rm = TRUE),
        scen_alloc_wt_tech_prod_all_comp = sum(
          .data$scen_alloc_wt_tech_prod,
          na.rm = TRUE
        ),
        scen_carsten = sum(.data$scen_carsten, na.rm = TRUE),
        scen_emission_factor_all_comp = stats::weighted.mean(
          .data$scen_emission_factor,
          .data$scen_alloc_wt_tech_prod,
          na.rm = TRUE
        ),
        .groups = "drop_last"
      ) %>%
      mutate( # get sector totals
        plan_sec_prod = sum(.data$plan_tech_prod, na.rm = TRUE),
        plan_alloc_wt_sec_prod = sum(
          .data$plan_alloc_wt_tech_prod_all_comp,
          na.rm = TRUE
        ),
        plan_sec_carsten = sum(
          .data$plan_carsten,
          na.rm = TRUE
        ),
        plan_sec_emissions_factor = stats::weighted.mean(
          .data$plan_emission_factor_all_comp,
          .data$plan_alloc_wt_tech_prod_all_comp,
          na.rm = TRUE
        ),
        scen_sec_prod = sum(.data$scen_tech_prod, na.rm = TRUE),
        scen_alloc_wt_sec_prod = sum(
          .data$scen_alloc_wt_tech_prod_all_comp,
          na.rm = TRUE
        ),
        scen_sec_carsten = ifelse(
          all(is.na(.data$scen_carsten)),
          NA,
          sum(.data$scen_carsten, na.rm = TRUE)
        ), ### this is a random case where if all SCen.carsten are NA, it will total to zero, when I want it to be NA
        scen_sec_emissions_factor = stats::weighted.mean(
          .data$scen_emission_factor_all_comp,
          .data$scen_alloc_wt_tech_prod_all_comp,
          na.rm = TRUE
        )
      ) %>%
      ungroup()

    names(df) <- gsub("\\_all_comp", "", names(df))
  }
  return(df)
}
