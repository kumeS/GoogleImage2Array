# GoogleImage2Array
R package for Creating array data from 2D image thumbnails via Google Image Search

Installation
======
```r
git clone https://github.com/kumeS/GoogleImage2Array
R CMD INSTALL GoogleImage2Array
```

or type the code below in the R console window

```r
install.packages("devtools", repos="http://cran.r-project.org")
library(devtools)
devtools::install_github("kumeS/GoogleImage2Array")
```

Usage 
======
```r
#Search by persian cat
query <- "persian cat"
CatImg <- GoogleImage2array(query)

#show info
str(CatImg)

#show CatImg
display.array(CatImg)
```

# License
Copyright (c) 2021 Satoshi Kume 

Released under the [Artistic License 2.0](http://www.perlfoundation.org/artistic_license_2_0).

# Authors
- Satoshi Kume
