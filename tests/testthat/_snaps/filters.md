# Try all of the filters [plain]

    Code
      .
    Output
      # A tibble: 1 x 1
        BP                        
        <chr>                     
      1 biological process unknown

---

    Code
      filter_tomic(brauer_2008_triple, filter_type = "category", filter_table = "features",
        filter_variable = "bar", filter_value = "biological process unknown")
    Condition
      Error in `filter_tomic()`:
      ! Invalid filter variable
      x `bar` is not a valid variable for the "features" table
      i Valid variables: `name`, `BP`, `MF`, and `systematic_name`

---

    Code
      filter_tomic(brauer_2008_triple, filter_type = "quo", filter_table = "features",
        filter_variable = "bar", filter_value = rlang::quo(BP ==
          "biological process unknown"))
    Message
      ! `filter_variable` was provided when `filter_type` is "quo"; only `filter_value` should be passed. `filter_variable` will be ignored
    Output
      $features
      # A tibble: 110 x 4
         name    BP                         MF                         systematic_name
         <chr>   <chr>                      <chr>                      <chr>          
       1 YOL029C biological process unknown molecular function unknown YOL029C        
       2 YHR036W biological process unknown molecular function unknown YHR036W        
       3 YAL046C biological process unknown molecular function unknown YAL046C        
       4 YHR151C biological process unknown molecular function unknown YHR151C        
       5 YKL027W biological process unknown molecular function unknown YKL027W        
       6 YBR220C biological process unknown molecular function unknown YBR220C        
       7 YLR057W biological process unknown molecular function unknown YLR057W        
       8 YDR239C biological process unknown molecular function unknown YDR239C        
       9 KKQ8    biological process unknown protein kinase activity    YKL168C        
      10 UIP5    biological process unknown molecular function unknown YKR044W        
      # i 100 more rows
      
      $samples
      # A tibble: 36 x 3
         sample nutrient    DR
         <chr>  <chr>    <dbl>
       1 G0.05  G         0.05
       2 G0.1   G         0.1 
       3 G0.15  G         0.15
       4 G0.2   G         0.2 
       5 G0.25  G         0.25
       6 G0.3   G         0.3 
       7 N0.05  N         0.05
       8 N0.1   N         0.1 
       9 N0.15  N         0.15
      10 N0.2   N         0.2 
      # i 26 more rows
      
      $measurements
      # A tibble: 3,960 x 3
         name    sample expression
         <chr>   <chr>       <dbl>
       1 YOL029C G0.05       -0.22
       2 YOL029C G0.1        -0.18
       3 YOL029C G0.15        0.27
       4 YOL029C G0.2         0.18
       5 YOL029C G0.25        0.03
       6 YOL029C G0.3        -0.04
       7 YOL029C N0.05        0.26
       8 YOL029C N0.1         0.15
       9 YOL029C N0.15        0.04
      10 YOL029C N0.2        -0.07
      # i 3,950 more rows
      
      $design
      $design$features
      # A tibble: 4 x 2
        variable        type               
        <chr>           <chr>              
      1 name            feature_primary_key
      2 systematic_name character          
      3 BP              character          
      4 MF              character          
      
      $design$samples
      # A tibble: 3 x 2
        variable type              
        <chr>    <chr>             
      1 sample   sample_primary_key
      2 nutrient character         
      3 DR       numeric           
      
      $design$measurements
      # A tibble: 3 x 2
        variable   type               
        <chr>      <chr>              
      1 name       feature_primary_key
      2 sample     sample_primary_key 
      3 expression numeric            
      
      $design$feature_pk
      [1] "name"
      
      $design$sample_pk
      [1] "sample"
      
      
      attr(,"class")
      [1] "triple_omic" "tomic"       "general"    

# Try all of the filters [ansi]

    Code
      .
    Output
      [90m# A tibble: 1 x 1[39m
        BP                        
        [3m[90m<chr>[39m[23m                     
      [90m1[39m biological process unknown

---

    Code
      filter_tomic(brauer_2008_triple, filter_type = "category", filter_table = "features",
        filter_variable = "bar", filter_value = "biological process unknown")
    Condition
      [1m[33mError[39m in `filter_tomic()`:[22m
      [1m[22m[33m![39m Invalid filter variable
      [31mx[39m `bar` is not a valid variable for the [34m"features"[39m table
      [36mi[39m Valid variables: `name`, `BP`, `MF`, and `systematic_name`

---

    Code
      filter_tomic(brauer_2008_triple, filter_type = "quo", filter_table = "features",
        filter_variable = "bar", filter_value = rlang::quo(BP ==
          "biological process unknown"))
    Message
      [33m![39m `filter_variable` was provided when `filter_type` is [34m[34m"quo"[34m[39m; only `filter_value` should be passed. `filter_variable` will be ignored
    Output
      $features
      [90m# A tibble: 110 x 4[39m
         name    BP                         MF                         systematic_name
         [3m[90m<chr>[39m[23m   [3m[90m<chr>[39m[23m                      [3m[90m<chr>[39m[23m                      [3m[90m<chr>[39m[23m          
      [90m 1[39m YOL029C biological process unknown molecular function unknown YOL029C        
      [90m 2[39m YHR036W biological process unknown molecular function unknown YHR036W        
      [90m 3[39m YAL046C biological process unknown molecular function unknown YAL046C        
      [90m 4[39m YHR151C biological process unknown molecular function unknown YHR151C        
      [90m 5[39m YKL027W biological process unknown molecular function unknown YKL027W        
      [90m 6[39m YBR220C biological process unknown molecular function unknown YBR220C        
      [90m 7[39m YLR057W biological process unknown molecular function unknown YLR057W        
      [90m 8[39m YDR239C biological process unknown molecular function unknown YDR239C        
      [90m 9[39m KKQ8    biological process unknown protein kinase activity    YKL168C        
      [90m10[39m UIP5    biological process unknown molecular function unknown YKR044W        
      [90m# i 100 more rows[39m
      
      $samples
      [90m# A tibble: 36 x 3[39m
         sample nutrient    DR
         [3m[90m<chr>[39m[23m  [3m[90m<chr>[39m[23m    [3m[90m<dbl>[39m[23m
      [90m 1[39m G0.05  G         0.05
      [90m 2[39m G0.1   G         0.1 
      [90m 3[39m G0.15  G         0.15
      [90m 4[39m G0.2   G         0.2 
      [90m 5[39m G0.25  G         0.25
      [90m 6[39m G0.3   G         0.3 
      [90m 7[39m N0.05  N         0.05
      [90m 8[39m N0.1   N         0.1 
      [90m 9[39m N0.15  N         0.15
      [90m10[39m N0.2   N         0.2 
      [90m# i 26 more rows[39m
      
      $measurements
      [90m# A tibble: 3,960 x 3[39m
         name    sample expression
         [3m[90m<chr>[39m[23m   [3m[90m<chr>[39m[23m       [3m[90m<dbl>[39m[23m
      [90m 1[39m YOL029C G0.05       -[31m0[39m[31m.[39m[31m22[39m
      [90m 2[39m YOL029C G0.1        -[31m0[39m[31m.[39m[31m18[39m
      [90m 3[39m YOL029C G0.15        0.27
      [90m 4[39m YOL029C G0.2         0.18
      [90m 5[39m YOL029C G0.25        0.03
      [90m 6[39m YOL029C G0.3        -[31m0[39m[31m.[39m[31m0[39m[31m4[39m
      [90m 7[39m YOL029C N0.05        0.26
      [90m 8[39m YOL029C N0.1         0.15
      [90m 9[39m YOL029C N0.15        0.04
      [90m10[39m YOL029C N0.2        -[31m0[39m[31m.[39m[31m0[39m[31m7[39m
      [90m# i 3,950 more rows[39m
      
      $design
      $design$features
      [90m# A tibble: 4 x 2[39m
        variable        type               
        [3m[90m<chr>[39m[23m           [3m[90m<chr>[39m[23m              
      [90m1[39m name            feature_primary_key
      [90m2[39m systematic_name character          
      [90m3[39m BP              character          
      [90m4[39m MF              character          
      
      $design$samples
      [90m# A tibble: 3 x 2[39m
        variable type              
        [3m[90m<chr>[39m[23m    [3m[90m<chr>[39m[23m             
      [90m1[39m sample   sample_primary_key
      [90m2[39m nutrient character         
      [90m3[39m DR       numeric           
      
      $design$measurements
      [90m# A tibble: 3 x 2[39m
        variable   type               
        [3m[90m<chr>[39m[23m      [3m[90m<chr>[39m[23m              
      [90m1[39m name       feature_primary_key
      [90m2[39m sample     sample_primary_key 
      [90m3[39m expression numeric            
      
      $design$feature_pk
      [1] "name"
      
      $design$sample_pk
      [1] "sample"
      
      
      attr(,"class")
      [1] "triple_omic" "tomic"       "general"    

# Try all of the filters [unicode]

    Code
      .
    Output
      # A tibble: 1 × 1
        BP                        
        <chr>                     
      1 biological process unknown

---

    Code
      filter_tomic(brauer_2008_triple, filter_type = "category", filter_table = "features",
        filter_variable = "bar", filter_value = "biological process unknown")
    Condition
      Error in `filter_tomic()`:
      ! Invalid filter variable
      ✖ `bar` is not a valid variable for the "features" table
      ℹ Valid variables: `name`, `BP`, `MF`, and `systematic_name`

---

    Code
      filter_tomic(brauer_2008_triple, filter_type = "quo", filter_table = "features",
        filter_variable = "bar", filter_value = rlang::quo(BP ==
          "biological process unknown"))
    Message
      ! `filter_variable` was provided when `filter_type` is "quo"; only `filter_value` should be passed. `filter_variable` will be ignored
    Output
      $features
      # A tibble: 110 × 4
         name    BP                         MF                         systematic_name
         <chr>   <chr>                      <chr>                      <chr>          
       1 YOL029C biological process unknown molecular function unknown YOL029C        
       2 YHR036W biological process unknown molecular function unknown YHR036W        
       3 YAL046C biological process unknown molecular function unknown YAL046C        
       4 YHR151C biological process unknown molecular function unknown YHR151C        
       5 YKL027W biological process unknown molecular function unknown YKL027W        
       6 YBR220C biological process unknown molecular function unknown YBR220C        
       7 YLR057W biological process unknown molecular function unknown YLR057W        
       8 YDR239C biological process unknown molecular function unknown YDR239C        
       9 KKQ8    biological process unknown protein kinase activity    YKL168C        
      10 UIP5    biological process unknown molecular function unknown YKR044W        
      # ℹ 100 more rows
      
      $samples
      # A tibble: 36 × 3
         sample nutrient    DR
         <chr>  <chr>    <dbl>
       1 G0.05  G         0.05
       2 G0.1   G         0.1 
       3 G0.15  G         0.15
       4 G0.2   G         0.2 
       5 G0.25  G         0.25
       6 G0.3   G         0.3 
       7 N0.05  N         0.05
       8 N0.1   N         0.1 
       9 N0.15  N         0.15
      10 N0.2   N         0.2 
      # ℹ 26 more rows
      
      $measurements
      # A tibble: 3,960 × 3
         name    sample expression
         <chr>   <chr>       <dbl>
       1 YOL029C G0.05       -0.22
       2 YOL029C G0.1        -0.18
       3 YOL029C G0.15        0.27
       4 YOL029C G0.2         0.18
       5 YOL029C G0.25        0.03
       6 YOL029C G0.3        -0.04
       7 YOL029C N0.05        0.26
       8 YOL029C N0.1         0.15
       9 YOL029C N0.15        0.04
      10 YOL029C N0.2        -0.07
      # ℹ 3,950 more rows
      
      $design
      $design$features
      # A tibble: 4 × 2
        variable        type               
        <chr>           <chr>              
      1 name            feature_primary_key
      2 systematic_name character          
      3 BP              character          
      4 MF              character          
      
      $design$samples
      # A tibble: 3 × 2
        variable type              
        <chr>    <chr>             
      1 sample   sample_primary_key
      2 nutrient character         
      3 DR       numeric           
      
      $design$measurements
      # A tibble: 3 × 2
        variable   type               
        <chr>      <chr>              
      1 name       feature_primary_key
      2 sample     sample_primary_key 
      3 expression numeric            
      
      $design$feature_pk
      [1] "name"
      
      $design$sample_pk
      [1] "sample"
      
      
      attr(,"class")
      [1] "triple_omic" "tomic"       "general"    

# Try all of the filters [fancy]

    Code
      .
    Output
      [90m# A tibble: 1 × 1[39m
        BP                        
        [3m[90m<chr>[39m[23m                     
      [90m1[39m biological process unknown

---

    Code
      filter_tomic(brauer_2008_triple, filter_type = "category", filter_table = "features",
        filter_variable = "bar", filter_value = "biological process unknown")
    Condition
      [1m[33mError[39m in `filter_tomic()`:[22m
      [1m[22m[33m![39m Invalid filter variable
      [31m✖[39m `bar` is not a valid variable for the [34m"features"[39m table
      [36mℹ[39m Valid variables: `name`, `BP`, `MF`, and `systematic_name`

---

    Code
      filter_tomic(brauer_2008_triple, filter_type = "quo", filter_table = "features",
        filter_variable = "bar", filter_value = rlang::quo(BP ==
          "biological process unknown"))
    Message
      [33m![39m `filter_variable` was provided when `filter_type` is [34m[34m"quo"[34m[39m; only `filter_value` should be passed. `filter_variable` will be ignored
    Output
      $features
      [90m# A tibble: 110 × 4[39m
         name    BP                         MF                         systematic_name
         [3m[90m<chr>[39m[23m   [3m[90m<chr>[39m[23m                      [3m[90m<chr>[39m[23m                      [3m[90m<chr>[39m[23m          
      [90m 1[39m YOL029C biological process unknown molecular function unknown YOL029C        
      [90m 2[39m YHR036W biological process unknown molecular function unknown YHR036W        
      [90m 3[39m YAL046C biological process unknown molecular function unknown YAL046C        
      [90m 4[39m YHR151C biological process unknown molecular function unknown YHR151C        
      [90m 5[39m YKL027W biological process unknown molecular function unknown YKL027W        
      [90m 6[39m YBR220C biological process unknown molecular function unknown YBR220C        
      [90m 7[39m YLR057W biological process unknown molecular function unknown YLR057W        
      [90m 8[39m YDR239C biological process unknown molecular function unknown YDR239C        
      [90m 9[39m KKQ8    biological process unknown protein kinase activity    YKL168C        
      [90m10[39m UIP5    biological process unknown molecular function unknown YKR044W        
      [90m# ℹ 100 more rows[39m
      
      $samples
      [90m# A tibble: 36 × 3[39m
         sample nutrient    DR
         [3m[90m<chr>[39m[23m  [3m[90m<chr>[39m[23m    [3m[90m<dbl>[39m[23m
      [90m 1[39m G0.05  G         0.05
      [90m 2[39m G0.1   G         0.1 
      [90m 3[39m G0.15  G         0.15
      [90m 4[39m G0.2   G         0.2 
      [90m 5[39m G0.25  G         0.25
      [90m 6[39m G0.3   G         0.3 
      [90m 7[39m N0.05  N         0.05
      [90m 8[39m N0.1   N         0.1 
      [90m 9[39m N0.15  N         0.15
      [90m10[39m N0.2   N         0.2 
      [90m# ℹ 26 more rows[39m
      
      $measurements
      [90m# A tibble: 3,960 × 3[39m
         name    sample expression
         [3m[90m<chr>[39m[23m   [3m[90m<chr>[39m[23m       [3m[90m<dbl>[39m[23m
      [90m 1[39m YOL029C G0.05       -[31m0[39m[31m.[39m[31m22[39m
      [90m 2[39m YOL029C G0.1        -[31m0[39m[31m.[39m[31m18[39m
      [90m 3[39m YOL029C G0.15        0.27
      [90m 4[39m YOL029C G0.2         0.18
      [90m 5[39m YOL029C G0.25        0.03
      [90m 6[39m YOL029C G0.3        -[31m0[39m[31m.[39m[31m0[39m[31m4[39m
      [90m 7[39m YOL029C N0.05        0.26
      [90m 8[39m YOL029C N0.1         0.15
      [90m 9[39m YOL029C N0.15        0.04
      [90m10[39m YOL029C N0.2        -[31m0[39m[31m.[39m[31m0[39m[31m7[39m
      [90m# ℹ 3,950 more rows[39m
      
      $design
      $design$features
      [90m# A tibble: 4 × 2[39m
        variable        type               
        [3m[90m<chr>[39m[23m           [3m[90m<chr>[39m[23m              
      [90m1[39m name            feature_primary_key
      [90m2[39m systematic_name character          
      [90m3[39m BP              character          
      [90m4[39m MF              character          
      
      $design$samples
      [90m# A tibble: 3 × 2[39m
        variable type              
        [3m[90m<chr>[39m[23m    [3m[90m<chr>[39m[23m             
      [90m1[39m sample   sample_primary_key
      [90m2[39m nutrient character         
      [90m3[39m DR       numeric           
      
      $design$measurements
      [90m# A tibble: 3 × 2[39m
        variable   type               
        [3m[90m<chr>[39m[23m      [3m[90m<chr>[39m[23m              
      [90m1[39m name       feature_primary_key
      [90m2[39m sample     sample_primary_key 
      [90m3[39m expression numeric            
      
      $design$feature_pk
      [1] "name"
      
      $design$sample_pk
      [1] "sample"
      
      
      attr(,"class")
      [1] "triple_omic" "tomic"       "general"    

