# [GoogleImage2Array (0.99.6)](https://kumes.github.io/GoogleImage2Array/)

[![CRAN](https://www.r-pkg.org/badges/version/GoogleImage2Array)](https://cran.r-project.org/web/packages/GoogleImage2Array/index.html)
[![CRAN](https://cranlogs.r-pkg.org/badges/grand-total/GoogleImage2Array)](http://www.datasciencemeta.com/rpackages)

R package for Creating Array Data from 2D Image Thumbnails via Google Image Search

[CRAN/GoogleImage2Array](https://cran.curtin.edu.au/web/packages/GoogleImage2Array/index.html), [GitHub/GoogleImage2Array](https://github.com/kumeS/GoogleImage2Array), [rdrr.io/GoogleImage2Array](https://rdrr.io/cran/GoogleImage2Array/)

# Version

0.99.6: Added a new function, 'display.spiral'.
0.99.6: Modified the 'GoogleImage2array' function.
0.99.5: Fixed to be able to read jpeg and png formats.

# Installation

- install from CRAN (ver.	0.99.2)

```r
install.packages("GoogleImage2Array", repos="http://cran.r-project.org")
```

- install the latest from GitHub

type the code below in the R console window

```r
install.packages("devtools", repos="http://cran.r-project.org")
library(devtools)
devtools::install_github("kumeS/GoogleImage2Array")
```

or install from the source file

```r
git clone https://github.com/kumeS/GoogleImage2Array
R CMD INSTALL GoogleImage2Array
```

# Tutorial

- [How to use the GoogleImage2Array functions](https://kumes.github.io/GoogleImage2Array/vignettes/HowToUse.html)

# Functions

- GoogleImage2array: create array from image thumbnails via the google image search.
- bind.array: bind two 4d arrays to one 4d array.
- display.array: display 4d array as a tiled image.
- display.spiral: display 4d array as a spiral image.


# Simple usage

```r
library(GoogleImage2Array)

#Search by persian cat
query <- "persian cat"
CatImg <- GoogleImage2array(query)

#show info
str(CatImg)
#$ array: num [1:20, 1:64, 1:64, 1:3] 0.0141 0.7029 0.7608 0.111 0.3398 ...
#$ query: chr "persian cat"

#show CatImg
display.array(CatImg)
```

You should have the results of the tiled images as follows.

![Image_persian_cat](inst/images/Image_persian_cat.png)

# License
Copyright (c) 2021 Satoshi Kume 

Released under the [Artistic License 2.0](http://www.perlfoundation.org/artistic_license_2_0).

# Authors
- Satoshi Kume
