Codebook
========
Variable description from http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions and included text files.

Variable Name|Description
-------------|------------
Subject|ID the subject who performed the activity for each window sample (between 1 and 30)
Activity|Activity Name
Domain|Time domain signal or frequency domain signal (Time or Freq)
Instrument|Measuring instrument (Accelerometer or Gyroscope)
Acceleration|Acceleration signal (Body or Gravity)
Variable|Variable (Mean or SD)
Jerk|Jerk signal
Magnitude|Magnitude of the signals calculated using the Euclidean norm
Axis|3-axial signals in the X, Y and Z directions (X, Y, or Z)
Count|Count of data points used to compute `average`
Average|Average of each variable for each activity and each subject

Dataset structure
-----------------
```r
str(tidy_data)
```

```
Classes ‘data.table’ and 'data.frame':	11880 obs. of  11 variables:
 $ Subject         : int  1 1 1 1 1 1 1 1 1 1 ...
 $ Activity        : Factor w/ 6 levels "LAYING","SITTING",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Domain      : Factor w/ 2 levels "Time","Freq": 1 1 1 1 1 1 1 1 1 1 ...
 $ Acceleration: Factor w/ 3 levels NA,"Body","Gravity": 1 1 1 1 1 1 1 1 1 1 ...
 $ Instrument  : Factor w/ 2 levels "Accelerometer",..: 2 2 2 2 2 2 2 2 2 2 ...
 $ Jerk        : Factor w/ 2 levels NA,"Jerk": 1 1 1 1 1 1 1 1 2 2 ...
 $ Magnitude   : Factor w/ 2 levels NA,"Magnitude": 1 1 1 1 1 1 2 2 1 1 ...
 $ Variable    : Factor w/ 2 levels "Mean","SD": 1 1 1 2 2 2 1 2 1 1 ...
 $ Axis        : Factor w/ 4 levels NA,"X","Y","Z": 2 3 4 2 3 4 1 1 2 3 ...
 $ count           : int  50 50 50 50 50 50 50 50 50 50 ...
 $ average         : num  -0.0166 -0.0645 0.1487 -0.8735 -0.9511 ...
 - attr(*, "sorted")= chr  "Subject" "Activity" "Domain" "Acceleration" ...
 - attr(*, ".internal.selfref")=<externalptr>
```


List the key variables in the data table
----------------------------------------

```r
key(tidy_data)
```
```
> key(tidy_data)
[1] "Subject"          "Activity"         "Domain"       "Acceleration" "Instrument"   "Jerk"         "Magnitude"   
[8] "Variable"     "Axis"        
```

Show a few rows of the dataset
------------------------------

```r
head(tidy_data)
```

```
   Subject Activity Domain Acceleration Instrument Jerk Magnitude Variable Axis count     average
1:       1   LAYING       Time               NA      Gyroscope       NA            NA         Mean        X    50 -0.01655309
2:       1   LAYING       Time               NA      Gyroscope       NA            NA         Mean        Y    50 -0.06448612
3:       1   LAYING       Time               NA      Gyroscope       NA            NA         Mean        Z    50  0.14868944
4:       1   LAYING       Time               NA      Gyroscope       NA            NA           SD        X    50 -0.87354387
5:       1   LAYING       Time               NA      Gyroscope       NA            NA           SD        Y    50 -0.95109044
6:       1   LAYING       Time               NA      Gyroscope       NA            NA           SD        Z    50 -0.90828466
```

Summary of variables
--------------------

```r
summary(tidy_data)
```

```
    Subject                   Activity    Domain  Acceleration       Instrument Jerk      Magnitude  Variable Axis 
 Min.   : 1.0   LAYING            :1980   Time:7200   NA     :4680     Accelerometer:7200   NA  :7200   NA       :8640   Mean:5940    NA:3240  
 1st Qu.: 8.0   SITTING           :1980   Freq:4680   Body   :5760     Gyroscope    :4680   Jerk:4680   Magnitude:3240   SD  :5940    X :2880  
 Median :15.5   STANDING          :1980               Gravity:1440                                                                    Y :2880  
 Mean   :15.5   WALKING           :1980                                                                                               Z :2880  
 3rd Qu.:23.0   WALKING_DOWNSTAIRS:1980                                                                                                        
 Max.   :30.0   WALKING_UPSTAIRS  :1980                                                                                                        
     count          average        
 Min.   :36.00   Min.   :-0.99767  
 1st Qu.:49.00   1st Qu.:-0.96205  
 Median :54.50   Median :-0.46989  
 Mean   :57.22   Mean   :-0.48436  
 3rd Qu.:63.25   3rd Qu.:-0.07836  
 Max.   :95.00   Max.   : 0.97451 
