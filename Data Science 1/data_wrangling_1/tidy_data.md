tidy data
================
Yuki Joyama
2023-09-26

## PULSE data

``` r
pulse_df =
  haven::read_sas("data/public_pulse_data.sas7bdat") |> 
  janitor::clean_names() |> 
  pivot_longer(
    bdi_score_bl:bdi_score_12m,
    names_to = "visit",
    values_to = "bdi_score",
    names_prefix = "bdi_score_"
  ) |> 
  mutate(
    visit = replace(visit, visit == "bl", "00m")
  )

litters_df =
  read_csv("data/FAS_litters.csv") |> 
  janitor::clean_names() |> 
  select(litter_number, gd0_weight, gd18_weight) |> 
  pivot_longer(
    gd0_weight:gd18_weight,
    names_to = "gd",
    values_to = "weight"
  ) |> 
  mutate(
    gd = case_match(
      gd,
      "gd0_weight" ~ 0,
      "gd18_weight" ~ 18
    )
  )
```

    ## Rows: 49 Columns: 8
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (2): Group, Litter Number
    ## dbl (6): GD0 weight, GD18 weight, GD of Birth, Pups born alive, Pups dead @ ...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
litters_df
```

    ## # A tibble: 98 × 3
    ##    litter_number    gd weight
    ##    <chr>         <dbl>  <dbl>
    ##  1 #85               0   19.7
    ##  2 #85              18   34.7
    ##  3 #1/2/95/2         0   27  
    ##  4 #1/2/95/2        18   42  
    ##  5 #5/5/3/83/3-3     0   26  
    ##  6 #5/5/3/83/3-3    18   41.4
    ##  7 #5/4/2/95/2       0   28.5
    ##  8 #5/4/2/95/2      18   44.1
    ##  9 #4/2/95/3-3       0   NA  
    ## 10 #4/2/95/3-3      18   NA  
    ## # ℹ 88 more rows
