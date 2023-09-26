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

## LotR

Import LotR words data

``` r
fellowship_df =
  readxl::read_excel("data/LotR_Words.xlsx", range = "B3:D6") |> 
  mutate(movie = "fellowship")

two_towers_df =
  readxl::read_excel("data/LotR_Words.xlsx", range = "F3:H6") |> 
  mutate(movie = "two towers")

return_of_the_king_df =
  readxl::read_excel("data/LotR_Words.xlsx", range = "J3:L6") |> 
  mutate(movie = "return of the king")

lotr_df = 
  bind_rows(fellowship_df, two_towers_df, return_of_the_king_df) |>
  janitor::clean_names() |> 
  pivot_longer(
    male:female,
    names_to = "gender",
    values_to = "word"
  ) |> 
  relocate(movie)

lotr_df
```

    ## # A tibble: 18 × 4
    ##    movie              race   gender  word
    ##    <chr>              <chr>  <chr>  <dbl>
    ##  1 fellowship         Elf    male     971
    ##  2 fellowship         Elf    female  1229
    ##  3 fellowship         Hobbit male    3644
    ##  4 fellowship         Hobbit female    14
    ##  5 fellowship         Man    male    1995
    ##  6 fellowship         Man    female     0
    ##  7 two towers         Elf    male     513
    ##  8 two towers         Elf    female   331
    ##  9 two towers         Hobbit male    2463
    ## 10 two towers         Hobbit female     0
    ## 11 two towers         Man    male    3589
    ## 12 two towers         Man    female   401
    ## 13 return of the king Elf    male     510
    ## 14 return of the king Elf    female   183
    ## 15 return of the king Hobbit male    2673
    ## 16 return of the king Hobbit female     2
    ## 17 return of the king Man    male    2459
    ## 18 return of the king Man    female   268

## Revisit FAS

``` r
litters_df =
  read_csv("data/FAS_litters.csv") |> 
  janitor::clean_names() |> 
  mutate(wt_gain = gd18_weight - gd0_weight) |> 
  select(litter_number, group, wt_gain) |> 
  separate(group, into = c("dose", "day_of_tx"), sep = 3)
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

    ## # A tibble: 49 × 4
    ##    litter_number   dose  day_of_tx wt_gain
    ##    <chr>           <chr> <chr>       <dbl>
    ##  1 #85             Con   7            15  
    ##  2 #1/2/95/2       Con   7            15  
    ##  3 #5/5/3/83/3-3   Con   7            15.4
    ##  4 #5/4/2/95/2     Con   7            15.6
    ##  5 #4/2/95/3-3     Con   7            NA  
    ##  6 #2/2/95/3-2     Con   7            NA  
    ##  7 #1/5/3/83/3-3/2 Con   7            NA  
    ##  8 #3/83/3-3       Con   8            NA  
    ##  9 #2/95/3         Con   8            NA  
    ## 10 #3/5/2/2/95     Con   8            NA  
    ## # ℹ 39 more rows

``` r
pups_df =
  read_csv("data/FAS_pups.csv") |> 
  janitor::clean_names() |> 
  mutate(
    sex = case_match(
      sex,
      1 ~ "male",
      2 ~ "female"
    )
  )
```

    ## Rows: 313 Columns: 6
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): Litter Number
    ## dbl (5): Sex, PD ears, PD eyes, PD pivot, PD walk
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
pups_df
```

    ## # A tibble: 313 × 6
    ##    litter_number sex   pd_ears pd_eyes pd_pivot pd_walk
    ##    <chr>         <chr>   <dbl>   <dbl>    <dbl>   <dbl>
    ##  1 #85           male        4      13        7      11
    ##  2 #85           male        4      13        7      12
    ##  3 #1/2/95/2     male        5      13        7       9
    ##  4 #1/2/95/2     male        5      13        8      10
    ##  5 #5/5/3/83/3-3 male        5      13        8      10
    ##  6 #5/5/3/83/3-3 male        5      14        6       9
    ##  7 #5/4/2/95/2   male       NA      14        5       9
    ##  8 #4/2/95/3-3   male        4      13        6       8
    ##  9 #4/2/95/3-3   male        4      13        7       9
    ## 10 #2/2/95/3-2   male        4      NA        8      10
    ## # ℹ 303 more rows

``` r
fas_df = 
  left_join(pups_df, litters_df, by = "litter_number")

fas_df
```

    ## # A tibble: 313 × 9
    ##    litter_number sex   pd_ears pd_eyes pd_pivot pd_walk dose  day_of_tx wt_gain
    ##    <chr>         <chr>   <dbl>   <dbl>    <dbl>   <dbl> <chr> <chr>       <dbl>
    ##  1 #85           male        4      13        7      11 Con   7            15  
    ##  2 #85           male        4      13        7      12 Con   7            15  
    ##  3 #1/2/95/2     male        5      13        7       9 Con   7            15  
    ##  4 #1/2/95/2     male        5      13        8      10 Con   7            15  
    ##  5 #5/5/3/83/3-3 male        5      13        8      10 Con   7            15.4
    ##  6 #5/5/3/83/3-3 male        5      14        6       9 Con   7            15.4
    ##  7 #5/4/2/95/2   male       NA      14        5       9 Con   7            15.6
    ##  8 #4/2/95/3-3   male        4      13        6       8 Con   7            NA  
    ##  9 #4/2/95/3-3   male        4      13        7       9 Con   7            NA  
    ## 10 #2/2/95/3-2   male        4      NA        8      10 Con   7            NA  
    ## # ℹ 303 more rows
