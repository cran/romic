#' @description 'romic' represents high-dimensional data as tables of features,
#'   samples and measurements, and a design list for tracking the meaning of
#'   individual variables. Using this format, filtering, normalization, and
#'   other transformations of a dataset can be carried out in a flexible
#'   manner. 'romic' takes advantage of these transformations to create
#'   interactive shiny apps for exploratory data analysis such as an
#'   interactive heatmap.
#'
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom dplyr %>%
#' @importFrom rlang :=
#' @import ggplot2
#' @import shiny
## usethis namespace: end
NULL

utils::globalVariables(c(
  ".",
  "attribute",
  "attribute_value",
  "collapsed_row_number",
  "eigenvalue",
  "entry_number",
  "feature_label",
  "feature_pk",
  "G0.05",
  "GID",
  "GWEIGHT",
  "iris",
  "msg",
  "n",
  "n_entries",
  "NAME",
  "name",
  "number",
  "ordered_featureId",
  "ordered_featureId_int",
  "ordered_sampleId",
  "orderedId",
  "pc_distance",
  "sample_label",
  "sample_pk",
  "Sepal.Length",
  "Sepal.Width",
  "systematic_name",
  "type",
  "U0.3",
  "valid_tables",
  "variable",
  "x",
  "x_var",
  "y",
  "y_var",
  "YORF"
))
