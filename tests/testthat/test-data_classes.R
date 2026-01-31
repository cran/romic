library(dplyr)

test_that("Updating triple retains cohesiveness", {
  broken_brauer <- brauer_2008_triple
  broken_brauer$features <- broken_brauer$features %>% mutate(foo = "bar")
  expect_error(check_tomic(broken_brauer), "permutation")

  broken_brauer <- brauer_2008_triple
  broken_brauer$features$name <- factor(broken_brauer$features$name)
  expect_error(check_tomic(broken_brauer), "classes")
})


test_that("Test check_tidy_omic edge cases", {

  testthat::expect_s3_class(simple_tidy, "tidy_omic")

  double_data_tidy <- simple_tidy
  double_data_tidy$data <- rbind(double_data_tidy$data, double_data_tidy$data)

  # duplicated feature, sample, measurement tuples
  expect_snapshot(check_tidy_omic(double_data_tidy, fast_check = FALSE), error = TRUE)

  degenerate_attributes <- three_col_df %>%
    mutate(
      degen_sample_var = rep(1:10, each = 10),
      degen_feature_var = rep(1:10, times = 10)
      )

  # check verbose message
  expect_message(
    create_tidy_omic(
      three_col_df,
      feature_pk = "features",
      sample_pk = "samples"
      ),
    regexp = "1 measurement variables"
  )

  expect_snapshot(
    create_tidy_omic(
      degenerate_attributes %>% select(-degen_sample_var),
      feature_pk = "features",
      sample_pk = "samples",
      feature_var = "degen_feature_var",
      verbose = FALSE
    ),
    error = TRUE)

  expect_snapshot(
    create_tidy_omic(
      degenerate_attributes %>% select(-degen_feature_var),
      feature_pk = "features",
      sample_pk = "samples",
      sample_var = "degen_sample_var",
      verbose = FALSE
    ),
    error = TRUE)

  # inconsistencies between data and design
  simple_tidy_missing_join_1 <- simple_tidy
  simple_tidy_missing_join_1$data <- simple_tidy_missing_join_1$data %>%
    dplyr::select(-features)
  expect_error(
    check_tomic(simple_tidy_missing_join_1),
    regex = "present in the design but not in the data"
  )

  simple_tidy_missing_join_2 <- simple_tidy
  simple_tidy_missing_join_2$data <- simple_tidy_missing_join_2$data %>%
    dplyr::mutate(foo = "bar")
  expect_error(
    check_tomic(simple_tidy_missing_join_2),
    regex = "present in the data but not in the design"
  )
})


test_that("Factor primary keys are preserved when converting from a tidy to a triple", {

  tidy <- create_tidy_omic(
    three_col_df_fct,
    feature_pk = "features",
    sample_pk = "samples",
    verbose = FALSE
    )

  # catch failure case
  expect_snapshot(
    create_tidy_omic(
      three_col_df_fct,
      feature_pk = "features",
      sample_pk = "samples",
      sample_vars = "measurement",
      feature_vars = "measurement",
      verbose = FALSE
      ),
    error = TRUE
    )

  triple_from_tidy <- tomic_to(tidy, "triple_omic")
  triple_from_tidy_check_status <- romic::check_tomic(triple_from_tidy, fast_check = FALSE)
  expect_equal(triple_from_tidy_check_status, 0)

  tidy_with_pcs <- add_pcs(tidy, verbose = FALSE)
  expect_true(sum(stringr::str_detect(colnames(tidy_with_pcs$data), "^PC")) > 1)
})

test_that("Numeric primary keys are preserved when converting from a tidy to a triple", {

  triple_from_tidy <- tomic_to(simple_tidy, "triple_omic")
  triple_from_tidy_check_status <- check_tomic(triple_from_tidy, fast_check = FALSE)
  expect_equal(triple_from_tidy_check_status, 0)

  tidy_with_pcs <- add_pcs(simple_tidy, verbose = FALSE)
  expect_true(sum(stringr::str_detect(colnames(tidy_with_pcs$data), "^PC")) > 1)
})

test_that("Create triple omic", {

  testthat::expect_s3_class(simple_triple, "triple_omic")

  # works without providing features or samples
  triple_omic <- create_triple_omic(
    triple_setup$measurement_df,
    feature_pk = "feature_id",
    sample_pk = "sample_id"
  )

  testthat::expect_s3_class(simple_triple, "triple_omic")

  # works when providing features and samples df

  triple_omic_full <- create_triple_omic(
    triple_setup$measurement_df,
    feature_df = triple_setup$feature_df,
    sample_df = triple_setup$samples_df,
    feature_pk = "feature_id",
    sample_pk = "sample_id"
  )

  testthat::expect_s3_class(simple_triple, "triple_omic")
})

test_that("Test check_triple_omic edge cases", {

  # inconsistent classes of primary and foreign keys
  simple_triple_class_inconsistency <- simple_triple
  simple_triple_class_inconsistency$features$feature_id <-
    factor(simple_triple_class_inconsistency$features$feature_id)

  expect_error(
    check_triple_omic(simple_triple_class_inconsistency),
    "classes differ between the features"
  )


  simple_triple_class_inconsistency_samples <- simple_triple
  simple_triple_class_inconsistency_samples$samples$sample_id <-
    factor(simple_triple_class_inconsistency_samples$samples$sample_id)

  expect_error(
    check_triple_omic(simple_triple_class_inconsistency_samples),
    "classes differ between the samples"
  )

  # degenerate entries
  nonunique_feature_ids <- simple_triple
  nonunique_feature_ids$features <- dplyr::bind_rows(
    nonunique_feature_ids$features,
    nonunique_feature_ids$features
    )

  expect_error(
    check_triple_omic(nonunique_feature_ids, fast_check = FALSE),
    "10 features were present multiple times with"
  )

  nonunique_sample_ids <- simple_triple
  nonunique_sample_ids$samples <- dplyr::bind_rows(
    nonunique_sample_ids$samples,
    nonunique_sample_ids$samples
  )

  expect_error(
    check_triple_omic(nonunique_sample_ids, fast_check = FALSE),
    "5 samples were present multiple times with"
  )

  nonunique_measurements <- simple_triple
  nonunique_measurements$measurements <- dplyr::bind_rows(
    nonunique_measurements$measurements,
    nonunique_measurements$measurements
  )

  expect_error(
    check_triple_omic(nonunique_measurements, fast_check = FALSE),
    "50 measurements were present multiple times with"
  )

})

test_that("Unstructured data preserved using tomic_to", {

  triple_omic <- tomic_to(simple_triple, "triple_omic")
  triple_omic$unstructured$dat <- "test"

  tidy_copy <- triple_to_tidy(triple_omic)
  expect_equal(tidy_copy$unstructured$dat, "test")

  triple_restore <- tidy_to_triple(tidy_copy)
  expect_equal(triple_restore$unstructured$dat, "test")
})


test_that("Read wide data", {
  wide_measurements <- brauer_2008_triple[["measurements"]] %>%
    tidyr::pivot_wider(names_from = sample, values_from = expression)
  wide_df <- brauer_2008_triple[["features"]] %>%
    left_join(wide_measurements, by = "name")
  tidy_omic <- convert_wide_to_tidy_omic(
    wide_df,
    feature_pk = "name",
    feature_vars = c("BP", "MF", "systematic_name"),
    verbose = FALSE
  )
  testthat::expect_s3_class(tidy_omic, "tidy_omic")
})

test_that("Catch corner cases when reading wide data", {
  wide_measurements <- brauer_2008_triple[["measurements"]] %>%
    tidyr::pivot_wider(names_from = sample, values_from = expression)
  wide_df <- brauer_2008_triple[["features"]] %>%
    left_join(wide_measurements, by = "name")

  # reserved name is used
  wide_df_w_reserved <- wide_df %>%
    dplyr::rename(entry_number = name)
  expect_error(
    convert_wide_to_tidy_omic(
      wide_df_w_reserved,
      feature_pk = "entry_number",
      feature_vars = c("BP", "MF", "systematic_name")
    ),
    "Reserved variable names detected"
  )

  # non-unique feature IDs
  wide_df_nonunique_feature_id <- wide_df
  wide_df_nonunique_feature_id$name[1:5] <- wide_df_nonunique_feature_id$name[1]
  expect_snapshot(
    result <- convert_wide_to_tidy_omic(
      wide_df_nonunique_feature_id,
      feature_pk = "name",
      feature_vars = c("BP", "MF", "systematic_name"),
      verbose = FALSE
    )
  )

  # Verify non-unique IDs create correct unique names
  first_name <- wide_df_nonunique_feature_id$name[1]
  unique_names <- result$data %>%
    filter(name == first_name) %>%
    pull(unique_name) %>%
    unique() %>%
    sort()

  expected_names <- paste0(first_name, "-", 1:5)
  expect_equal(unique_names, expected_names)

  # Verify entry_number is preserved in data
  expect_true("entry_number" %in% names(result$data))

  # Verify original feature_pk (name) becomes a feature variable in data
  expect_true("name" %in% names(result$data))

  # Verify the new feature_pk is unique_name
  expect_equal(result$design$feature_pk, "unique_name")

  # Verify name is now listed as a feature variable in design
  expect_true("name" %in% result$design$features$variable)
})

test_that("Mixed types in measurements throw informative error", {
  wide_measurements <- brauer_2008_triple[["measurements"]] %>%
    tidyr::pivot_wider(names_from = sample, values_from = expression)
  wide_df <- brauer_2008_triple[["features"]] %>%
    left_join(wide_measurements, by = "name")

  # Forget to specify feature_vars - should error with helpful message
  expect_error(
    convert_wide_to_tidy_omic(
      wide_df,
      feature_pk = "name"
    ),
    "Measurement columns have mixed types.*Did you forget to specify.*feature_vars"
  )
})

test_that("pivot_longer produces correct structure", {
  wide_measurements <- brauer_2008_triple[["measurements"]] %>%
    tidyr::pivot_wider(names_from = sample, values_from = expression)
  wide_df <- brauer_2008_triple[["features"]] %>%
    left_join(wide_measurements, by = "name")

  result <- convert_wide_to_tidy_omic(
    wide_df,
    feature_pk = "name",
    feature_vars = c("BP", "MF", "systematic_name"),
    verbose = FALSE
  )

  # Verify all samples are present
  n_samples <- ncol(wide_measurements) - 1
  n_features <- nrow(wide_df)

  expect_equal(nrow(result$data), n_samples * n_features)

  # Verify sample column exists and has no NAs
  sample_pk <- result$design$sample_pk
  expect_true(sample_pk %in% names(result$data))
  expect_false(any(is.na(result$data[[sample_pk]])))

  # Verify sample names are preserved
  expected_samples <- setdiff(colnames(wide_measurements), "name")
  actual_samples <- unique(result$data[[sample_pk]])
  expect_setequal(actual_samples, expected_samples)
})

test_that("Custom variable names work correctly", {
  wide_measurements <- brauer_2008_triple[["measurements"]] %>%
    tidyr::pivot_wider(names_from = sample, values_from = expression)
  wide_df <- brauer_2008_triple[["features"]] %>%
    left_join(wide_measurements, by = "name")

  result <- convert_wide_to_tidy_omic(
    wide_df,
    feature_pk = "name",
    feature_vars = c("BP", "MF", "systematic_name"),
    sample_var = "sample_id",
    measurement_var = "intensity",
    verbose = FALSE
  )

  expect_true("sample_id" %in% names(result$data))
  expect_true("intensity" %in% names(result$data))
  expect_false("sample" %in% names(result$data))
  expect_false("abundance" %in% names(result$data))

  # Verify design reflects custom names
  expect_equal(result$design$sample_pk, "sample_id")
  expect_true("intensity" %in% result$design$measurements$variable)
})


test_that("Find primary or foreign keys in tomic table", {

  expect_equal(get_identifying_keys(brauer_2008_triple, "measurements"), c("name", "sample"))
  expect_equal(get_identifying_keys(brauer_2008_triple, "features"), "name")
  expect_equal(get_identifying_keys(brauer_2008_triple, "samples"), "sample")

  # enable
  expect_snapshot(
    get_identifying_keys(brauer_2008_triple, "foo"),
    error = TRUE
  )
})

test_that("Test that get_tomic_table() can retrieve various tables", {

  tidy_df <- get_tomic_table(brauer_2008_triple, "tidy")

  expect_equal(nrow(tidy_df), 18000)
  expect_equal(infer_tomic_table_type(brauer_2008_triple, tidy_df), "measurements")

  samples_df <- get_tomic_table(simple_tidy, "samples")

  expect_equal(dim(samples_df), c(10,1))
  expect_equal(infer_tomic_table_type(simple_tidy, samples_df), "samples")

  expect_snapshot(
    infer_tomic_table_type(simple_tidy, samples_df %>% rename(fake_samples = samples)),
    error = TRUE
  )
})

test_that("reform_tidy_omic() can create a tidy_omic object from its attributes", {
  tidy_data <- romic::brauer_2008_tidy$data
  tomic <- reform_tidy_omic(tidy_data, romic::brauer_2008_tidy$design)

  expect_s3_class(tomic, "tidy_omic")
})

test_that("Catch corner cases when interconverting tomics", {
  # check tomic only works on tidy and triple omics
  expect_snapshot(
    check_tomic(mtcars),
    error = TRUE
  )

  expect_snapshot(
    tomic_to(romic::brauer_2008_tidy, "foo"),
    error = TRUE
  )

  # tomic but not a tidy or triple
  weird_s3_classes_tomic <- romic::brauer_2008_tidy
  class(weird_s3_classes_tomic) <- "tomic"

  expect_error(
    check_tomic(weird_s3_classes_tomic),
    "This is unexpected since the object has the"
  )

})
