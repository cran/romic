# Test check_tidy_omic edge cases

    Code
      check_tidy_omic(double_data_tidy, fast_check = FALSE)
    Condition
      Error in `check_tidy_omic()`:
      ! Duplicate measurements detected
      x 100 measurements were present multiple times with the same feature and sample primary keys
      i Examples:
        feature = 1 ; sample = 1, feature = 1 ; sample = 2, feature = 1 ; sample = 3, feature = 1 ; sample = 4, feature = 1 ; sample = 5, feature = 1 ; sample = 6, feature = 1 ; sample = 7, feature = 1 ; sample = 8, feature = 1 ; sample = 9, and feature = 1 ; sample = 10

---

    Code
      create_tidy_omic(degenerate_attributes %>% select(-degen_sample_var),
      feature_pk = "features", sample_pk = "samples", feature_var = "degen_feature_var",
      verbose = FALSE)
    Condition
      Error:
      ! Failed to parse glue component
      Caused by error in `parse()`:
      ! <text>:1:6: unexpected '{'
      1: .var {
               ^

---

    Code
      create_tidy_omic(degenerate_attributes %>% select(-degen_feature_var),
      feature_pk = "features", sample_pk = "samples", sample_var = "degen_sample_var",
      verbose = FALSE)
    Condition
      Error in `check_tidy_omic()`:
      ! Invalid sample attributes detected
      x "degen_sample_var" was duplicated for 10 samples
      i These variables should not be sample attributes

# Factor primary keys are preserved when converting from a tidy to a triple

    Code
      create_tidy_omic(three_col_df_fct, feature_pk = "features", sample_pk = "samples",
        sample_vars = "measurement", feature_vars = "measurement", verbose = FALSE)
    Condition
      Error in `create_tidy_omic()`:
      ! measurement were assigned to multiple classes of variables each variable should only belong to one class

# Catch corner cases when reading wide data

    Code
      result <- convert_wide_to_tidy_omic(wide_df_nonunique_feature_id, feature_pk = "name",
        feature_vars = c("BP", "MF", "systematic_name"), verbose = FALSE)
    Condition
      Warning:
      Non-unique feature identifiers detected
      ! 4 rows did not contain a unique `name`
      i Adding extra variables `unique_name` and `entry_number` to distinguish them

# Find primary or foreign keys in tomic table

    Code
      get_identifying_keys(brauer_2008_triple, "foo")
    Condition
      Error in `get_identifying_keys()`:
      ! Assertion on 'table' failed: Must be element of set {'features','samples','measurements'}, but is 'foo'.

# Test that get_tomic_table() can retrieve various tables

    Code
      infer_tomic_table_type(simple_tidy, samples_df %>% rename(fake_samples = samples))
    Condition
      Error in `infer_tomic_table_type()`:
      ! Cannot determine table type
      x Based on the primary keys, `tomic_table` doesn't appear to be features, samples, or measurements
      i Table must contain either `features`, `samples`, or both

# Catch corner cases when interconverting tomics

    Code
      check_tomic(mtcars)
    Condition
      Error in `check_tomic()`:
      ! Assertion on 'tomic' failed: Must inherit from class 'tomic', but has class 'data.frame'.

---

    Code
      tomic_to(romic::brauer_2008_tidy, "foo")
    Condition
      Error in `tomic_to()`:
      ! Assertion on 'to_class' failed: Must be element of set {'tidy_omic','triple_omic'}, but is 'foo'.

