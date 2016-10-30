circularObjs
================

This is a trivial implementation for creation of 'circular' objects such as time of the day, month, etc.

``` r
source('circularObj.R')
```

    ## R.methodsS3 v1.7.1 (2016-02-15) successfully loaded. See ?R.methodsS3 for help.

``` r
monthClass <- circularObj(list(month = month.abb), 'monthClass')

monthClass(list(month = 'Jan')) + 5
```

    ## $month
    ## [1] "Jun"

``` r
monthClass(list(month = 'Jan')) + 12
```

    ## $month
    ## [1] "Jan"

``` r
hourMinute <- circularObj(list(minute = 1:60, hour = 1:12), 'hourMinute')

hourMinute(list(hour = 10, minute = 25))
```

    ## $minute
    ## [1] 25
    ## 
    ## $hour
    ## [1] 10

``` r
hourMinute(list(hour = 10, minute = 25)) + 180
```

    ## $minute
    ## [1] 25
    ## 
    ## $hour
    ## [1] 1

``` r
hourMinute(list(hour = 10, minute = 25)) + (-180)
```

    ## $minute
    ## [1] 25
    ## 
    ## $hour
    ## [1] 7

``` r
hourMinute(list(hour = 10, minute = 25)) - 180
```

    ## $minute
    ## [1] 25
    ## 
    ## $hour
    ## [1] 7

``` r
dayTime <- circularObj(list(second = 1:60, minute = 1:60, hour = 1:24,
                            day = c('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun')),
                       'dayTime')

dayTime(list(day = 'Sun', hour = 10, second = 25, minute = 10)) + 86400
```

    ## $second
    ## [1] 25
    ## 
    ## $minute
    ## [1] 10
    ## 
    ## $hour
    ## [1] 10
    ## 
    ## $day
    ## [1] "Mon"
