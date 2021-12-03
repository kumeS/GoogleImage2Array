##################################################
library(GoogleImage2Array)
##################################################
query <- "persian cat"
CatImg <- GoogleImage2array(query, wh=256)
str(CatImg)
display.array(CatImg)

#画像アレイを取り出す
Img <- CatImg$array

#パラメータ設定
k <- 64
m <- dim(Img)[2]/k
m1 <- c(1:m)*k - k + 1
m2 <- c(1:m)*k

#横方向の設定
w1 <- rep(m1, times = m)
w2 <- rep(m2, times = m)
#縦方向の設定
h1 <- rep(m1, each = length(m1))
h2 <- rep(m2, each = length(m2))
#ピクセス数
p0 <- length(m1)*length(m2)

#画像をCropして、ベクトルに変換して重ねていく。
ImgDatCrop <- NULL
for(l in 1:dim(Img)[1]){
  for(n in 1:c(m*m)){
    #l <- 1; n <- 1
    Crop01 <- unlist(Img[l,c(h1[n]:h2[n]),c(w1[n]:w2[n]),1])
    Crop02 <- unlist(Img[l,c(h1[n]:h2[n]),c(w1[n]:w2[n]),2])
    Crop03 <- unlist(Img[l,c(h1[n]:h2[n]),c(w1[n]:w2[n]),3])
    ImgDatCrop <- rbind(ImgDatCrop, c(Crop01, Crop02, Crop03))
  }
}

#詳細
dim(ImgDatCrop)

#Q-mode PCA: 相関行列
pca <- prcomp(ImgDatCrop, scale = TRUE)
str(pca)

#固有値(Standard deviation)、寄与率(Proportion of Variance)、累積寄与率(Cumulative Proportion)の表示
round(summary(pca)$importance, 2)[,1:10]

#主成分分析の主成分(固有ベクトル)の表示（一部）
round(pca$rotation, 3)[c(1:5),c(1:10)]

#主成分得点（一部）
round(pca$x, 3)[c(1:5),c(1:10)]

#Cumulative Proportion (累積寄与率)の計算
vars <- apply(pca$x, 2, var)
result <- cumsum(vars / sum(vars))

par(mfcol = c(1,1), mgp=c(2.5, 1, 0), mai = c(0.75, 0.75, 0.2, 0.2))
plot(result, type="b", pch=4, col="skyblue",
     xlab="Principal Component", ylim=c(0,1),
     ylab="Cumulative proportion of variance explained",
     cex=0.5, cex.lab=0.9)
abline(h=0.8, col="red", lwd=0.5); abline(v=sum(result < 0.8)+1, col="blue", lty=2, lwd=0.5)

##################################################
library(EBImage); options(EBImage.display = "raster")
library(animation)
##################################################

#主成分数
Num <- 75
k <- 64
m1 <- 4; m2 <- 5
p0 <- m1*m2

#アニメーション作成
animation::saveGIF({
  for(m in 1:Num){
    #m <- 1

    #主成分の絞り込み
    pcaP <- pca
    pcaP$x[,-c(1:m)] <- 0

    #相関行列PCAの逆計算
    pca01 <- t(t(pcaP$x %*% t(pcaP$rotation)) * pcaP$scale + pcaP$center)

    #図示
    par(mfrow = c(m1, m2), family="HiraKakuProN-W3",
        omi=c(0.1, 0.1, 0.5, 0.1), mai = c(0.025, 0.025, 0.025, 0.025))
    for(n in 1:20){
      #n <- 1
      a <- NULL
      for(i in 1:16){
        a[[i]] <- EBImage::Image(array(pca01[16*(n-1)+i,], dim=c(k, k, 3)),
                                 colormode = "Color")
      }
      EBImage::display(combine(a[c(1,5,9,13,
                                   2,6,10,14,
                                   3,7,11,15,
                                   4,8,12,16)]),
                       nx=4, all=TRUE, spacing = 0.01, margin = 5)
      if(n == 1){
        mtext(side = 3, line=1, outer=T, text = paste0("PC", m, "までを使って生成。"), cex=1.25)
      }
    }
  }
},  movie.name = paste0("Img_PCA.gif"), interval = 0.4, dpi=100,
nmax = length(Num), ani.width = 500, ani.height=500, ani.type="png")


