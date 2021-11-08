##' @title display.spiral: display 4d array as a spiral image.
##'
##' @description This function is to create a spiral imagethe
##' from R array/tensor obtained from Google image search.
##'
##' @param x a list obtained by the GoogleImage2array function.
##' @param Save a logical. Whether to save images locally or not.
##' if TRUE, save locally.
##' @param SaveFormat a character of format; png or pdf.
##' @param file_path a character. a directory to save the image file.
##'
##' @return image
##' @author Satoshi Kume
##'
##' @importFrom EBImage readImage
##' @importFrom EBImage writeImage
##' @importFrom EBImage resize
##' @importFrom EBImage Image
##' @importFrom graphics par
##' @import grDevices
##' @importFrom spiralize spiral_initialize
##' @importFrom spiralize spiral_track
##' @importFrom spiralize spiral_raster
##'
##' @export display.spiral
##'
##' @examples \donttest{
##' library(EBImage)
##'
##' # Simple examples
##' query <- "persian cat"
##' CatImg <- GoogleImage2array(query)
##'
##' #show images
##' display.spiral(CatImg)
##'
##' }
##'

display.spiral <- function(x,
                          Save=FALSE,
                          SaveFormat="png",
                          file_path=NULL){

if(!all(names(x) == c("array", "query"))){
 return(message("Warring: not proper value of x"))
}

#set
a <- x$array
b <- gsub(" ", "_", x$query)

oldpar <- graphics::par(no.readonly = TRUE)    # code line i
on.exit(graphics::par(oldpar))            # code line i + 1

Spi <- function(a=a, b=b){
spiralize::spiral_initialize(start = 0, end = 360*3 + 180,
                             polar_lines_gp = gpar(col = "white",lty = 3))
spiralize::spiral_track(height = 0.95)
for(m in seq_len(dim(a)[1])){
  #m <- 1
  spiralize::spiral_raster(0.05*m - 0.025, 0.5,
              paste0(tempD, "/", b, "_", formatC(m, flag = "0", width = 3), ".png"),
              width = 0.05, height = 1, facing = "curved_inside")
}
}

tempD <- tempdir()
for(n in seq_len(dim(a)[1])){
  #n <- 1
  a1 <- EBImage::Image(a[n,,,], colormode="Color")
  #str(a1)
  a2 <- EBImage::resize(a1, w=64)
  EBImage::writeImage(a2,
                      files = paste0(tempD, "/", b, "_", formatC(n, flag = "0", width = 3), ".png"),
                      type = "png")
}
#dir(tempD)

if(!Save){
message("Please wait for some minutes")
Spi(a=a, b=b)

}else{
message("Please wait for some minutes")
if(is.null(file_path)){
  path <- paste0(tempdir(), "/")
}else{
  path <- paste0(sub("/$", "", file_path), "/")
}
if(SaveFormat == "png"){
grDevices::png(
  filename=paste0(path, "Image_", gsub(" ", "_", b), ".png"),
  width = 500, height = 500)
}
if(SaveFormat == "pdf"){
grDevices::pdf(
  filename=paste0(path, "Image_", gsub(" ", "_", b), ".pdf"),
  width = 7, height = 7)
}
Spi(a=a, b=b)
dev.off()
}
}

