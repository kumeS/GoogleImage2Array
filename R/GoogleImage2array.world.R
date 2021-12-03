##' @title GoogleImage2array.world
##'
##' @description This function is to gather images via 10 countries and
##' create the R array/tensor from 2D images obtained.
##'
##' @param Query a character vector to search images
##' @param wh a value of pixels in height and width.
##' @param Col a logical. Whether to handle color or gray images.
##' if TRUE, use color mode.
##' @param verbose Verbosity mode (FALSE: silent, TRUE: progress).
##'
##' @return array
##' @author Satoshi Kume
##'
##' @importFrom xml2 read_html
##' @importFrom rvest html_nodes
##' @importFrom rvest html_attr
##' @importFrom EBImage readImage
##' @importFrom EBImage resize
##' @importFrom EBImage Image
##' @importFrom magrittr %>%
##' @importFrom rTensor as.tensor
##' @importFrom rTensor modeSum
##'
##' @export GoogleImage2array.world
##'
##' @examples \dontrun{
##' library(EBImage)
##'
##' # Simple examples
##' query <- "persian cat"
##' CatImg <- GoogleImage2array.world(query)
##'
##' #show info
##' str(CatImg)
##'
##' }
##'

GoogleImage2array.world <- function(Query,
                                    wh=64,
                                    Col=TRUE,
                                    verbose=FALSE){
#Country
country <- c("en", "ja", "de", "dk", "cz",
             "fr", "gb", "tr", "it", "sg")
Img <- NULL

for(n in 1:length(country)){
if(verbose){message(n, ": ", country[n])}

if(n == 1){
ImgDat <- GoogleImage2array(query,
                              wh=wh,
                              gl=country[n],
                              Col=Col,
                              Save=FALSE,
                              file_path=NULL,
                              Display=FALSE)
}else{
ImgDatN <- GoogleImage2array(query,
                                wh=wh,
                                gl=country[n],
                                Col=Col,
                                Save=FALSE,
                                file_path=NULL,
                                Display=FALSE)
ImgDat <- bind.array(ImgDat, ImgDatN)
}}


#str(ImgDat)
ImgDatArray <- ImgDat$array
#str(ImgDatArray)

ImgT <- rTensor::as.tensor(ImgDatArray)
#str(ImgT)
a <- rTensor::modeSum(ImgT,4,drop=TRUE)
a <- rTensor::modeSum(a,3,drop=TRUE)
a <- rTensor::modeSum(a,2,drop=TRUE)
b <- duplicated(a@data)

#str(a); str(ImgDat)
ImgDat$array <- ImgDat$array[!b,,,]
#str(ImgDat)

#Output
return(ImgDat)

}

