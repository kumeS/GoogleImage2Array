##' @title display.array: display 4d array as a tiled image.
##'
##' @description This function is to create the R array/tensor from
##' 2D image obtained from Google image search.
##'
##' @param x a list obtained by the GoogleImage2array function.
##' @param Save a logical. Whether to save images locally or not.
##' if TRUE, save locally.
##'
##' @return image
##' @author Satoshi Kume
##'
##' @importFrom xml2 read_html
##' @importFrom rvest html_nodes
##' @importFrom rvest html_attr
##' @importFrom EBImage readImage
##' @importFrom EBImage resize
##' @importFrom EBImage Image
##' @import grDevices
##'
##' @export display.array
##'
##' @examples \dontrun{
##' library(EBImage)
##'
##' # Simple examples
##' query <- "persian cat"
##' CatImg <- GoogleImage2array(query)
##'
##' #show images
##' display.array(CatImg)
##'
##' query <- "Shiba inu"
##' DogImg <- GoogleImage2array(query)
##'
##' #show images
##' display.array(DogImg)
##'
##' }
##'

display.array <- function(x,
                          Save=TRUE){

if(!all(names(x) == c("array", "query"))){
 return(message("Warring: not proper value of x"))
}

#set
a <- x$array
b <- x$query

if(!Save){
graphics::par(mfrow=c(4,5), mar=rep(0, 4))
for(n in 1:dim(a)[1]){
  #n <- 1
  plot(t(grDevices::as.raster(a[n,,,], max=max(a[n,,,]))))
}
}else{

grDevices::png(filename=paste0("Image_", b, ".png"),
     width = 500, height = 500)
graphics::par(mfrow=c(4,5), mar=rep(0, 4))
for(n in 1:dim(a)[1]){
  #n <- 1
  plot(t(grDevices::as.raster(a[n,,,], max=max(a[n,,,]))))
}
dev.off()

graphics::par(mfrow=c(4,5), mar=rep(0, 4))
for(n in 1:dim(a)[1]){
  #n <- 1
  plot(t(grDevices::as.raster(a[n,,,], max=max(a[n,,,]))))
}
}
}
