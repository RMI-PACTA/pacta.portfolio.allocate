#' Merge ABCD_scenario data from a database file (RDS or SQLite) with the
#' portfolio data
#'
#' @param portfolio A data frame containing the processed portfolio data
#' @param portfolio_type A single string specifying the type of assets in the
#'   portfolio
#' @param db_dir A single string specifying the path to the directory that
#'   contains the database file
#' @param equity_market_list A character vector of equity markets to be included
#' @param scenario_sources_list A character vector of scenario sources to be
#'   included
#' @param scenario_geographies_list A character vector of senario geographies to
#'   be included
#' @param sector_list A character vector of sectors to be included
#' @param id_col A single string specifying the name of the id column in the
#'   portfolio data
#'
#' @return A data frame contianing the portfolio data with the merged
#'   ABCD_scenario data
#'
#' @export

merge_abcd_from_db <-
  function(portfolio,
           portfolio_type,
           db_dir,
           equity_market_list,
           scenario_sources_list,
           scenario_geographies_list,
           sector_list,
           id_col = "id") {
    if (portfolio_type == "Equity") {
      file_basename <- "equity_abcd_scenario"
    } else if (portfolio_type == "Bonds") {
      file_basename <- "bonds_abcd_scenario"
    } else {
      cli::cli_abort("{.arg portfolio_type} {.val {portfolio_type}} unknown")
    }

    db_filepath <- file.path(db_dir, paste0(file_basename, ".sqlite"))
    if (!file.exists(db_filepath)) {
      db_filepath <- file.path(db_dir, paste0(file_basename, ".rds"))
      if (!file.exists(db_filepath)) {
        cli::cli_abort("ABCD database file {.file {db_filepath}} does not exist")
      }
    }

    if (grepl("[.]sqlite$", db_filepath)) {
      con <- DBI::dbConnect(drv = RSQLite::SQLite(), dbname = db_filepath)
      on.exit(DBI::dbDisconnect(con), add = TRUE)

      dplyr::copy_to(
        dest = con,
        df = portfolio,
        name = "portfolio",
        overwrite = TRUE,
        temporary = TRUE,
        indexes = list(id_col)
      )

      abcd <- dplyr::tbl(con, "abcd_scenario")
      portfolio <- dplyr::tbl(con, "portfolio")
    } else {
      abcd <- readRDS(db_filepath)
    }

    if (portfolio_type == "Equity") {
      abcd <- filter(abcd, .data$equity_market %in% .env$equity_market_list)

      abcd_rows <- dplyr::summarize(abcd, dplyr::n()) %>% dplyr::pull(1L)
      if (abcd_rows < 1L) {
        cli::cli_abort("ABCD data does not contain rows relevant to the specified {.arg equity_market_list} values")
      }
    }

    abcd <-
      abcd %>%
      filter(
        .data$scenario_source %in% .env$scenario_sources_list,
        .data$scenario_geography %in% .env$scenario_geographies_list,
        .data$ald_sector %in% .env$sector_list
      ) %>%
      mutate(mapped_ald = 1)

    left_join(portfolio, abcd, by = dplyr::join_by(!!id_col == "id")) %>%
      dplyr::collect()
  }
