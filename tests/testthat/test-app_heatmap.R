test_that("Create heatmap", {

  tomic <- brauer_2008_triple %>%
    filter_tomic(
      filter_type = "category",
      filter_table = "features",
      filter_variable = "BP",
      filter_value = c(
        "protein biosynthesis",
        "rRNA processing", "response to stress"
      )
    )

  grob <- plot_heatmap(
    tomic = tomic,
    value_var = "expression",
    change_threshold = 5,
    cluster_dim = "rows",
    distance_measure = "corr"
  )
  expect_s3_class(grob, "ggplot")

  grob <- plot_heatmap(
    tomic = tomic,
    value_var = "expression",
    change_threshold = 5,
    cluster_dim = "both",
    distance_measure = "dist"
  )
  expect_s3_class(grob, "ggplot")
})
