## romic 1.3.3

### Minor Improvements and Fixes

- Docstring cleanup and wrapping imputation function in dontrun since `impute` may not be installed from Bioconductor.

## romic 1.3.2

### Minor Improvements and Fixes

- upgraded defunction mutate_ call #7
- upgraded mutate_at, mutate_if, select_if, etc to use mutate/select and across
- improved warnings and errors by switching to `cli`

## romic 1.3.1

### Minor Improvements and Fixes

- updated pkgdown site deployment and link urls.

## romic 1.3.0

### Major changes

- Removed plotly dependency due to plotly package retirement from CRAN #1
- Removed interactive plotting functions [`plot_heatmap`]

### New Features

- Switched new primary repo to github.com/shackett/romic. github.com/calico/romic is now read-only
- added `calculate_sample_mahalanobis_distances` to calculate the Mahalanobis distance of samples from the PC centroid Calico/#85
- added `tomi` matrix export with `tomic_to_matrix`. Calico/#78

### Minor Improvements and Fixes

- Added `invert` arguments to `filter_tomic` Calico/#89
- Allow for transposing axes when creating heatmaps. Calico/#81

## romic 1.1.3

### New Features

- `get_tomic_table()` makes it easy to pull individual tables out of tomic objects. Calico/#55

### Minor Improvements and Fixes

- Bug fix in `add_pcs()` Calico/#52
- added option to not display percent variance explained on PCs to `add_pcs()` Calico/#53
- Added passing of axis and colorbar labels in `plot_heatmap()` Calico/#60
- Updated romic-package alias so package documentation properly displays with `?romic` Calico/#63
- Renamed tests and greatly expanded test coverage. Calico/#64

## romic 1.1.1

### New Features

- `plot_bivariate()` supports setting size, alpha, and shape. Calico/#48
- `add_pc_loadings()` changed to `add_pcs()` for accuracy. Added fraction of variability explained by PCs to `add_pcs()`. Calico/#32
- `plot_univariate()` and `plot_bivariate()` supporting providing a partial string match to a variable name. This helps to generate consistent plots even if names might change (like PC1 (10%)). Calico/#44
- tidy_omics and triple_omics can now include a list with unstructured data. This puts the convention more in line with an H5AD file. #43. This is currently only used to return the fraction of variance explained by each PC as part of `add_pcs()`. Calico/#42

### Minor Improvements and Fixes

- `plot_heatmap()` rowlabels are suppressed when there are too many features rather than setting size to zero. Calico/#45
- `plot_heatmap()` supports ordered objects. Calico/#37
- ` coerce_to_classes()` added support for glue objects. Calico/#35
- Added additional checks to retain the class of primary keys and tests of coversions. Calico/#33
