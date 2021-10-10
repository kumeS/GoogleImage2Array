##' @title bind.array: bind two 4d arrays to one 4d array.
##'
##' @description This function is to bind two arrays to one array
##' along the first dimension,
##' which obtained by the GoogleImage2array function.
##'
##' @param x a list obtained by the GoogleImage2array function.
##' @param y a list obtained by the GoogleImage2array function.
##'
##' @return array
##' @author Satoshi Kume
##'
##' @importFrom EBImage abind
##'
##' @export bind.array
##'
##' @examples \donttest{
##' library(EBImage)
##'
##' # Simple examples
##' query <- "persian cat"
##' CatImg <- GoogleImage2array(query)
##'
##' query <- "Shiba inu"
##' DogImg <- GoogleImage2array(query)
##'
##' #bind arrays
##' Dat <- bind.array(CatImg, DogImg)
##' str(Dat)
##'
##' }
##'

bind.array <- function(x,
                          y){
#x <- CatImg; y <- DogImg

if(!all(names(x) == c("array", "query"))){
 return(message("Warring: not proper value of x"))
}
if(!all(names(y) == c("array", "query"))){
 return(message("Warring: not proper value of y"))
}
if(length(dim(x$array)) != 4){
 return(message("Warring: not proper value of x"))
}
if(length(dim(y$array)) != 4){
 return(message("Warring: not proper value of y"))
}

#set
a1 <- x$array
a2 <- y$array
b1 <- x$query
b2 <- y$query

#Bind
Dat1 <- base::unname(EBImage::abind(a1, a2, along=1))
Dat2 <- c(b1, b2)
Dat <- list(array=Dat1,
            query=Dat2)
#str(Dat)
return(Dat)

}






