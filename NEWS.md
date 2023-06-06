# pacta.portfolio.allocate 0.0.2

* loses `tdm_scenarios()` and `determine_tdm_variables()` in favour of defining 
  these parameters explicitly in `workflow.transition.monitor` 
  (#3). 

* `tdm_conditions_met` gains arguments `data`, `t0`, `delta_t1`, `delta_t2`, `scenarios` and `additional groups`. The function now has more expanded and comprehensive validation (#17). 

* adds new functions `get_entity_info()` and `left_join_entity_info()` to facilitate reading and merging in entity info from an on-disk SQLite database if available

* modifies the `merge_abcd_from_db()` function so that it can read and merge the ABCD_scenario data from an on-disk SQLite database if available

* adds new `merge_abcd_from_db()` as a drop-in replacement for the pattern `ald_scen_eq <- get_ald_scen("Equity"); port_eq_old <- merge_in_ald(port_eq, ald_scen_eq); rm(ald_scen_eq)`.

* depends on {dplyr} >= 1.1.0 for the new per-operation grouping with `.by`/`by` (see `?dplyr_by`), and for new `dplyr::join_by()` function.

* lose the exported function `data_includes_tdm_scenarios()`.

* `determine_tdm_variables` now sets `delta_t2 = 10` (used to be `9`).

* `quit_if_no_pacta_relevant_data()` now also generates a PDF with the error message in place of the executive summary (#212).

* `quit_if_no_pacta_relevant_data()` now fails on Bonds with no ALD in fin_sector (#194).

# pacta.portfolio.allocate 0.0.1

* Added a `NEWS.md` file to track changes to the package. This package is a hard-fork of [pacta.portfolio.analysis](https://github.com/RMI-PACTA/pacta.portfolio.analysis/commit/3cbc3c1f528e8ec34fbcdd37aa98a6aae330a16d) at commmit `3cbc3c1`.
