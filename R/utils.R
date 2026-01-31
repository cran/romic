#' Format Names for Plotting
#'
#' Wrap long names over multiple lines so that they will look better on plots.
#'
#' @param chars a character vector (or a variable that can be converted to one)
#' @inheritParams stringr::str_wrap
#' @param truncate_at max character length
#'
#' @return a reformatted character vector of the same length as the input.
#'
#' @examples
#' chars <- "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer
#'   ac arcu semper erat porttitor egestas. Etiam sagittis, sapien at mattis."
#'
#' format_names_for_plotting(chars)
#' @export
format_names_for_plotting <- function(chars, width = 40, truncate_at = 80) {
  as.character(chars) %>%
    stringr::str_trunc(width = truncate_at, side = "right") %>%
    stringr::str_wrap(
      width = width,
      exdent = 2
    )
}

coerce_to_classes <- function(obj, reference_obj) {
  reference_obj_class <- class(reference_obj)[1]

  if (any(reference_obj_class %in% "glue")) {
    out <- glue::as_glue(obj)
  } else if (any(reference_obj_class %in% c("factor", "ordered"))) {
    out <- do.call(
      reference_obj_class,
      list(
        x = obj,
        levels = levels(reference_obj)
      )
    )
  } else if (reference_obj_class == "character") {
    out <- as.character(obj)
  } else if (reference_obj_class == "numeric") {
    out <- as.numeric(obj)
  } else if (reference_obj_class == "integer") {
    out <- as.integer(obj)
  } else if (reference_obj_class == "logical") {
    out <- as.logical(obj)
  } else {
    cli::cli_abort(c(
      "Unsupported class conversion",
      "x" = "Converting to {.cls {reference_obj_class}} is not implemented",
      "i" = "Supported classes: {.cls glue}, {.cls factor}, {.cls ordered}, {.cls character}, {.cls numeric}, {.cls integer}, {.cls logical}"
    ))
  }

  if (all(!is.na(reference_obj)) && any(is.na(out))) {
    n_na <- sum(is.na(out))
    cli::cli_abort(c(
      "Unexpected NA values introduced",
      "x" = "{n_na} value{?s} {?was/were} converted to NA during coercion",
      "i" = "Zero NAs are expected based on the reference object"
    ))
  }

  return(out)
}

#' Var Partial Match
#'
#' Partial string matching of a provided variable to the variables available
#' in a table
#'
#' @param x a variable name or regex match to a variable name
#' @param df a data.frame or tibble
#'
#' @return a single variable from df
var_partial_match <- function(x, df) {
  checkmate::assertString(x)
  checkmate::assertDataFrame(df)

  valid_vars <- colnames(df)

  # character match
  if (x %in% valid_vars) {
    return(x)
  }

  # treat x as a regular expression
  var_match <- valid_vars[stringr::str_detect(valid_vars, x)]

  if (length(var_match) == 1) {
    return(var_match)
  } else if (length(var_match) == 0) {
    cli::cli_abort(c(
      "No matching variable found",
      "x" = "{.val {x}} did not match any variables",
      "i" = "Valid variables: {.var {valid_vars}}",
      "i" = "You can also specify a variable with a unique substring or regular expression"
    ))
  } else {
    n_matches <- length(var_match)
    cli::cli_abort(c(
      "Ambiguous variable match",
      "x" = "{.val {x}} matched {n_matches} variables: {.var {var_match}}",
      "i" = "This function treats the provided variable as a regular expression",
      "i" = "Please provide a more specific variable name or regular expression that matches only one variable"
    ))
  }
}
