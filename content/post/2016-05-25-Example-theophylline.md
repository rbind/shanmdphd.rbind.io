---
layout: post
title: "NCA 파라메터 계산하는 예시 for Theophylline"
categories: CPT
comments: true
share: true
tags: [R, PKNCA, NCA, Clinical Pharmacology]
---

PKNCA 패키지를 사용하는 방법이 나와있습니다.

Examples simplify understanding.  Below is an example of how to use the theophylline dataset to generate NCA parameters.

# Load the data 데이타 불러오기.

```r
## 전체 데이타 보기.
knitr::kable(datasets::Theoph)
```

|Subject |   Wt| Dose|  Time|  conc|
|:-------|----:|----:|-----:|-----:|
|1       | 79.6| 4.02|  0.00|  0.74|
|1       | 79.6| 4.02|  0.25|  2.84|
|1       | 79.6| 4.02|  0.57|  6.57|
|1       | 79.6| 4.02|  1.12| 10.50|
|1       | 79.6| 4.02|  2.02|  9.66|
|1       | 79.6| 4.02|  3.82|  8.58|
|1       | 79.6| 4.02|  5.10|  8.36|
|1       | 79.6| 4.02|  7.03|  7.47|
|1       | 79.6| 4.02|  9.05|  6.89|
|1       | 79.6| 4.02| 12.12|  5.94|
|1       | 79.6| 4.02| 24.37|  3.28|
|2       | 72.4| 4.40|  0.00|  0.00|
|2       | 72.4| 4.40|  0.27|  1.72|
|2       | 72.4| 4.40|  0.52|  7.91|
|2       | 72.4| 4.40|  1.00|  8.31|
|2       | 72.4| 4.40|  1.92|  8.33|
|2       | 72.4| 4.40|  3.50|  6.85|
|2       | 72.4| 4.40|  5.02|  6.08|
|2       | 72.4| 4.40|  7.03|  5.40|
|2       | 72.4| 4.40|  9.00|  4.55|
|2       | 72.4| 4.40| 12.00|  3.01|
|2       | 72.4| 4.40| 24.30|  0.90|
|3       | 70.5| 4.53|  0.00|  0.00|
|3       | 70.5| 4.53|  0.27|  4.40|
|3       | 70.5| 4.53|  0.58|  6.90|
|3       | 70.5| 4.53|  1.02|  8.20|
|3       | 70.5| 4.53|  2.02|  7.80|
|3       | 70.5| 4.53|  3.62|  7.50|
|3       | 70.5| 4.53|  5.08|  6.20|
|3       | 70.5| 4.53|  7.07|  5.30|
|3       | 70.5| 4.53|  9.00|  4.90|
|3       | 70.5| 4.53| 12.15|  3.70|
|3       | 70.5| 4.53| 24.17|  1.05|
|4       | 72.7| 4.40|  0.00|  0.00|
|4       | 72.7| 4.40|  0.35|  1.89|
|4       | 72.7| 4.40|  0.60|  4.60|
|4       | 72.7| 4.40|  1.07|  8.60|
|4       | 72.7| 4.40|  2.13|  8.38|
|4       | 72.7| 4.40|  3.50|  7.54|
|4       | 72.7| 4.40|  5.02|  6.88|
|4       | 72.7| 4.40|  7.02|  5.78|
|4       | 72.7| 4.40|  9.02|  5.33|
|4       | 72.7| 4.40| 11.98|  4.19|
|4       | 72.7| 4.40| 24.65|  1.15|
|5       | 54.6| 5.86|  0.00|  0.00|
|5       | 54.6| 5.86|  0.30|  2.02|
|5       | 54.6| 5.86|  0.52|  5.63|
|5       | 54.6| 5.86|  1.00| 11.40|
|5       | 54.6| 5.86|  2.02|  9.33|
|5       | 54.6| 5.86|  3.50|  8.74|
|5       | 54.6| 5.86|  5.02|  7.56|
|5       | 54.6| 5.86|  7.02|  7.09|
|5       | 54.6| 5.86|  9.10|  5.90|
|5       | 54.6| 5.86| 12.00|  4.37|
|5       | 54.6| 5.86| 24.35|  1.57|
|6       | 80.0| 4.00|  0.00|  0.00|
|6       | 80.0| 4.00|  0.27|  1.29|
|6       | 80.0| 4.00|  0.58|  3.08|
|6       | 80.0| 4.00|  1.15|  6.44|
|6       | 80.0| 4.00|  2.03|  6.32|
|6       | 80.0| 4.00|  3.57|  5.53|
|6       | 80.0| 4.00|  5.00|  4.94|
|6       | 80.0| 4.00|  7.00|  4.02|
|6       | 80.0| 4.00|  9.22|  3.46|
|6       | 80.0| 4.00| 12.10|  2.78|
|6       | 80.0| 4.00| 23.85|  0.92|
|7       | 64.6| 4.95|  0.00|  0.15|
|7       | 64.6| 4.95|  0.25|  0.85|
|7       | 64.6| 4.95|  0.50|  2.35|
|7       | 64.6| 4.95|  1.02|  5.02|
|7       | 64.6| 4.95|  2.02|  6.58|
|7       | 64.6| 4.95|  3.48|  7.09|
|7       | 64.6| 4.95|  5.00|  6.66|
|7       | 64.6| 4.95|  6.98|  5.25|
|7       | 64.6| 4.95|  9.00|  4.39|
|7       | 64.6| 4.95| 12.05|  3.53|
|7       | 64.6| 4.95| 24.22|  1.15|
|8       | 70.5| 4.53|  0.00|  0.00|
|8       | 70.5| 4.53|  0.25|  3.05|
|8       | 70.5| 4.53|  0.52|  3.05|
|8       | 70.5| 4.53|  0.98|  7.31|
|8       | 70.5| 4.53|  2.02|  7.56|
|8       | 70.5| 4.53|  3.53|  6.59|
|8       | 70.5| 4.53|  5.05|  5.88|
|8       | 70.5| 4.53|  7.15|  4.73|
|8       | 70.5| 4.53|  9.07|  4.57|
|8       | 70.5| 4.53| 12.10|  3.00|
|8       | 70.5| 4.53| 24.12|  1.25|
|9       | 86.4| 3.10|  0.00|  0.00|
|9       | 86.4| 3.10|  0.30|  7.37|
|9       | 86.4| 3.10|  0.63|  9.03|
|9       | 86.4| 3.10|  1.05|  7.14|
|9       | 86.4| 3.10|  2.02|  6.33|
|9       | 86.4| 3.10|  3.53|  5.66|
|9       | 86.4| 3.10|  5.02|  5.67|
|9       | 86.4| 3.10|  7.17|  4.24|
|9       | 86.4| 3.10|  8.80|  4.11|
|9       | 86.4| 3.10| 11.60|  3.16|
|9       | 86.4| 3.10| 24.43|  1.12|
|10      | 58.2| 5.50|  0.00|  0.24|
|10      | 58.2| 5.50|  0.37|  2.89|
|10      | 58.2| 5.50|  0.77|  5.22|
|10      | 58.2| 5.50|  1.02|  6.41|
|10      | 58.2| 5.50|  2.05|  7.83|
|10      | 58.2| 5.50|  3.55| 10.21|
|10      | 58.2| 5.50|  5.05|  9.18|
|10      | 58.2| 5.50|  7.08|  8.02|
|10      | 58.2| 5.50|  9.38|  7.14|
|10      | 58.2| 5.50| 12.10|  5.68|
|10      | 58.2| 5.50| 23.70|  2.42|
|11      | 65.0| 4.92|  0.00|  0.00|
|11      | 65.0| 4.92|  0.25|  4.86|
|11      | 65.0| 4.92|  0.50|  7.24|
|11      | 65.0| 4.92|  0.98|  8.00|
|11      | 65.0| 4.92|  1.98|  6.81|
|11      | 65.0| 4.92|  3.60|  5.87|
|11      | 65.0| 4.92|  5.02|  5.22|
|11      | 65.0| 4.92|  7.03|  4.45|
|11      | 65.0| 4.92|  9.03|  3.62|
|11      | 65.0| 4.92| 12.12|  2.69|
|11      | 65.0| 4.92| 24.08|  0.86|
|12      | 60.5| 5.30|  0.00|  0.00|
|12      | 60.5| 5.30|  0.25|  1.25|
|12      | 60.5| 5.30|  0.50|  3.96|
|12      | 60.5| 5.30|  1.00|  7.82|
|12      | 60.5| 5.30|  2.00|  9.72|
|12      | 60.5| 5.30|  3.52|  9.75|
|12      | 60.5| 5.30|  5.07|  8.57|
|12      | 60.5| 5.30|  7.07|  6.59|
|12      | 60.5| 5.30|  9.03|  6.11|
|12      | 60.5| 5.30| 12.05|  4.57|
|12      | 60.5| 5.30| 24.15|  1.17|

The columns that we will be interested in for our analysis are conc, Time, and Subject in the concentration data set and Dose, Time, and Subject for the dosing data set.


```r
## By default it is groupedData; convert it to a data frame for use
my.conc <- PKNCAconc(as.data.frame(datasets::Theoph), conc~Time|Subject)

## Dosing data needs to only have one row per dose, so subset for
## that first.
d.dose <- unique(datasets::Theoph[datasets::Theoph$Time == 0,
                                  c("Dose", "Time", "Subject")])
knitr::kable(d.dose,
             caption="Example dosing data extracted from theophylline data set")
```



|    | Dose| Time|Subject |
|:---|----:|----:|:-------|
|1   | 4.02|    0|1       |
|12  | 4.40|    0|2       |
|23  | 4.53|    0|3       |
|34  | 4.40|    0|4       |
|45  | 5.86|    0|5       |
|56  | 4.00|    0|6       |
|67  | 4.95|    0|7       |
|78  | 4.53|    0|8       |
|89  | 3.10|    0|9       |
|100 | 5.50|    0|10      |
|111 | 4.92|    0|11      |
|122 | 5.30|    0|12      |

```r
my.dose <- PKNCAdose(d.dose, Dose~Time|Subject)
```

# Merge the Concentration and Dose

After loading the data, they must be combined to prepare for parameter calculation.  Intervals for calculation will automatically be selected based on the `single.dose.aucs setting` in `PKNCA.options`


```r
my.data.automatic <- PKNCAdata(my.conc, my.dose)
knitr::kable(PKNCA.options("single.dose.aucs"))
```



| start| end|auclast |aucall |aumclast |aumcall |cmax  |cmin  |tmax  |tlast |tfirst |clast.obs |f     |cav   |ctrough |ptr   |tlag  |half.life |r.squared |adj.r.squared |lambda.z |lambda.z.time.first |lambda.z.n.points |clast.pred |span.ratio |aucinf |aumcinf |aucpext |cl    |mrt   |vss   |vd    |thalf.eff |kel   |vz    |
|-----:|---:|:-------|:------|:--------|:-------|:-----|:-----|:-----|:-----|:------|:---------|:-----|:-----|:-------|:-----|:-----|:---------|:---------|:-------------|:--------|:-------------------|:-----------------|:----------|:----------|:------|:-------|:-------|:-----|:-----|:-----|:-----|:---------|:-----|:-----|
|     0|  24|TRUE    |FALSE  |FALSE    |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |FALSE     |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |FALSE  |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |
|     0| Inf|FALSE   |FALSE  |FALSE    |FALSE   |TRUE  |FALSE |TRUE  |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |TRUE      |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |TRUE   |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |

```r
knitr::kable(my.data.automatic$intervals)
```



| start| end|auclast |aucall |aumclast |aumcall |cmax  |cmin  |tmax  |tlast |tfirst |clast.obs |f     |cav   |ctrough |ptr   |tlag  |half.life |r.squared |adj.r.squared |lambda.z |lambda.z.time.first |lambda.z.n.points |clast.pred |span.ratio |aucinf |aumcinf |aucpext |cl    |mrt   |vss   |vd    |thalf.eff |kel   |vz    |Subject |
|-----:|---:|:-------|:------|:--------|:-------|:-----|:-----|:-----|:-----|:------|:---------|:-----|:-----|:-------|:-----|:-----|:---------|:---------|:-------------|:--------|:-------------------|:-----------------|:----------|:----------|:------|:-------|:-------|:-----|:-----|:-----|:-----|:---------|:-----|:-----|:-------|
|     0|  24|TRUE    |FALSE  |FALSE    |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |FALSE     |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |FALSE  |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |1       |
|     0| Inf|FALSE   |FALSE  |FALSE    |FALSE   |TRUE  |FALSE |TRUE  |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |TRUE      |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |TRUE   |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |1       |
|     0|  24|TRUE    |FALSE  |FALSE    |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |FALSE     |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |FALSE  |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |2       |
|     0| Inf|FALSE   |FALSE  |FALSE    |FALSE   |TRUE  |FALSE |TRUE  |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |TRUE      |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |TRUE   |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |2       |
|     0|  24|TRUE    |FALSE  |FALSE    |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |FALSE     |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |FALSE  |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |3       |
|     0| Inf|FALSE   |FALSE  |FALSE    |FALSE   |TRUE  |FALSE |TRUE  |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |TRUE      |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |TRUE   |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |3       |
|     0|  24|TRUE    |FALSE  |FALSE    |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |FALSE     |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |FALSE  |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |4       |
|     0| Inf|FALSE   |FALSE  |FALSE    |FALSE   |TRUE  |FALSE |TRUE  |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |TRUE      |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |TRUE   |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |4       |
|     0|  24|TRUE    |FALSE  |FALSE    |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |FALSE     |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |FALSE  |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |5       |
|     0| Inf|FALSE   |FALSE  |FALSE    |FALSE   |TRUE  |FALSE |TRUE  |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |TRUE      |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |TRUE   |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |5       |
|     0|  24|TRUE    |FALSE  |FALSE    |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |FALSE     |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |FALSE  |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |6       |
|     0| Inf|FALSE   |FALSE  |FALSE    |FALSE   |TRUE  |FALSE |TRUE  |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |TRUE      |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |TRUE   |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |6       |
|     0|  24|TRUE    |FALSE  |FALSE    |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |FALSE     |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |FALSE  |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |7       |
|     0| Inf|FALSE   |FALSE  |FALSE    |FALSE   |TRUE  |FALSE |TRUE  |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |TRUE      |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |TRUE   |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |7       |
|     0|  24|TRUE    |FALSE  |FALSE    |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |FALSE     |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |FALSE  |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |8       |
|     0| Inf|FALSE   |FALSE  |FALSE    |FALSE   |TRUE  |FALSE |TRUE  |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |TRUE      |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |TRUE   |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |8       |
|     0|  24|TRUE    |FALSE  |FALSE    |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |FALSE     |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |FALSE  |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |9       |
|     0| Inf|FALSE   |FALSE  |FALSE    |FALSE   |TRUE  |FALSE |TRUE  |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |TRUE      |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |TRUE   |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |9       |
|     0|  24|TRUE    |FALSE  |FALSE    |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |FALSE     |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |FALSE  |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |10      |
|     0| Inf|FALSE   |FALSE  |FALSE    |FALSE   |TRUE  |FALSE |TRUE  |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |TRUE      |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |TRUE   |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |10      |
|     0|  24|TRUE    |FALSE  |FALSE    |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |FALSE     |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |FALSE  |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |11      |
|     0| Inf|FALSE   |FALSE  |FALSE    |FALSE   |TRUE  |FALSE |TRUE  |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |TRUE      |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |TRUE   |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |11      |
|     0|  24|TRUE    |FALSE  |FALSE    |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |FALSE     |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |FALSE  |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |12      |
|     0| Inf|FALSE   |FALSE  |FALSE    |FALSE   |TRUE  |FALSE |TRUE  |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |TRUE      |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |TRUE   |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |12      |

Intervals for calculation can also be specified manually.  Manual specification requires at least columns for `start` time, `end` time, and the parameters requested.  The manual specification can also include any grouping factors from the concentration data set.  Column order of the intervals is not important.  When intervals are manually specified, they are expanded to the full interval set when added to a PKNCAdata object (in other words, a column is created for each parameter.  Also, PKNCA automatically calculates parameters required for the NCA, so while lambda.z is required for calculating AUC~0-$\infinity$~, you do not have to specify it in the parameters requested.


```r
my.intervals <- data.frame(start=0,
                           end=Inf,
                           cmax=TRUE,
                           tmax=TRUE,
                           aucinf=TRUE,
                           auclast=TRUE)
my.data.manual <- PKNCAdata(my.conc, my.dose,
                            intervals=my.intervals)
knitr::kable(my.data.manual$intervals)
```



| start| end|auclast |aucall |aumclast |aumcall |cmax |cmin  |tmax |tlast |tfirst |clast.obs |f     |cav   |ctrough |ptr   |tlag  |half.life |r.squared |adj.r.squared |lambda.z |lambda.z.time.first |lambda.z.n.points |clast.pred |span.ratio |aucinf |aumcinf |aucpext |cl    |mrt   |vss   |vd    |thalf.eff |kel   |vz    |
|-----:|---:|:-------|:------|:--------|:-------|:----|:-----|:----|:-----|:------|:---------|:-----|:-----|:-------|:-----|:-----|:---------|:---------|:-------------|:--------|:-------------------|:-----------------|:----------|:----------|:------|:-------|:-------|:-----|:-----|:-----|:-----|:---------|:-----|:-----|
|     0| Inf|TRUE    |FALSE  |FALSE    |FALSE   |TRUE |FALSE |TRUE |FALSE |FALSE  |FALSE     |FALSE |FALSE |FALSE   |FALSE |FALSE |FALSE     |FALSE     |FALSE         |FALSE    |FALSE               |FALSE             |FALSE      |FALSE      |TRUE   |FALSE   |FALSE   |FALSE |FALSE |FALSE |FALSE |FALSE     |FALSE |FALSE |

# Compute the parameters

Parameter calculation will automatically split the data by the grouping factor(s), subset by the interval, calculate all required parameters, record all options used for the calculations, and include data provenance to show that the calculation was performed as described.  For all this, just call the `pk.nca` function with your PKNCAdata object.


```r
my.results.automatic <- pk.nca(my.data.automatic)
knitr::kable(head(my.results.automatic$result))
```



| start| end|Subject |PPTESTCD  |    PPORRES|
|-----:|---:|:-------|:---------|----------:|
|     0|  24|1       |auclast   | 92.3654416|
|     0| Inf|1       |cmax      | 10.5000000|
|     0| Inf|1       |tmax      |  1.1200000|
|     0| Inf|1       |tlast     | 24.3700000|
|     0| Inf|1       |lambda.z  |  0.0484570|
|     0| Inf|1       |r.squared |  0.9999997|

```r
summary(my.results.automatic)
```

| start| end|auclast     |cmax        |tmax               |half.life   |aucinf     |
|-----:|---:|:-----------|:-----------|:------------------|:-----------|:----------|
|     0|  24|74.6 [24.3] |.           |.                  |.           |.          |
|     0| Inf|.           |8.65 [17.0] |1.14 [0.630, 3.55] |8.18 [2.12] |115 [28.4] |


```r
my.results.manual <- pk.nca(my.data.manual)
knitr::kable(head(my.results.manual$result))
```



| start| end|Subject |PPTESTCD  |     PPORRES|
|-----:|---:|:-------|:---------|-----------:|
|     0| Inf|1       |auclast   | 147.2347485|
|     0| Inf|1       |cmax      |  10.5000000|
|     0| Inf|1       |tmax      |   1.1200000|
|     0| Inf|1       |tlast     |  24.3700000|
|     0| Inf|1       |lambda.z  |   0.0484570|
|     0| Inf|1       |r.squared |   0.9999997|

```r
summary(my.results.manual)
```

| start| end|auclast     |cmax        |tmax               |aucinf     |
|-----:|---:|:-----------|:-----------|:------------------|:----------|
|     0| Inf|98.7 [22.5] |8.65 [17.0] |1.14 [0.630, 3.55] |115 [28.4] |
