#' @title h_var
#' 
#' @description utility function to make a text grob of desired size
#' 
#' @param text text you want on the grob
#' @param size font size
#' @param gp graphics paramaters.

h_var <- function(text, size, gp=gpar(fontsize=size, fontface = 'bold')) {
  textGrob(
    label=text
   ,just=c('left', 'center')
   ,x=0
   ,gp=gp
  )
}


#' @title grob_justifier
#' 
#' @description a great little function that baptiste wrote up on my SO queston: 
#' http://stackoverflow.com/a/25456672/561698
#' 
#' @param x a grob
#' @param hjust left, center, or right
#' @param vjust top, center, or bottom 

grob_justifier <- function(x, hjust="center", vjust="center"){
  w <- grobWidth(x)
  h <- grobHeight(x)
  xj <- switch(hjust,
               center = 0.5,
               left = 0.5*w,
               right=unit(1,"npc") - 0.5*w)
  yj <- switch(vjust,
               center = 0.5,
               bottom = 0.5*h,
               top=unit(1,"npc") - 0.5*h)
  x$vp <- viewport(x=xj, y=yj)
  arrangeGrob(x)
}
