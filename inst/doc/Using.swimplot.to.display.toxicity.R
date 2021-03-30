## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(swimplot)

## ---- echo = TRUE,fig.align='centre'------------------------------------------
d1 <- data.frame(pat=c('a','b','c','d','e'),end=c(3.26,15.45,14.84,3.51,7.44))

Nausea <- data.frame(pat=c('a','b','c','c','e'),tox="Nausea",grade=as.character(c(1,3,2,2,3)),time=c(2,1,8,10,1.5))
Fever <- data.frame(pat=c('d','e','e','c','c'),tox="Fever",grade=as.character(c(1,2,2,1,2)), time=c(1.5,3,6,2,6.5))
Anemia <- data.frame(pat=c('d','e','e','c','c'),tox="Anemia",grade=as.character(c(1,1,2,1,3)), time=c(1.5,3,5,2,6))


## ---- echo = TRUE,fig.align='centre'------------------------------------------

swimmer_plot(df=d1,id='pat',end='end',col="black",fill='white')+
  swimmer_points(df_points=Nausea,id='pat',time='time',adj.y = 0.3,size=4,name_shape = 'grade',name_col = 'tox',stroke=3)+
  swimmer_points(df_points=Fever,id='pat',time='time',adj.y = 0,size=4,name_shape = 'grade',name_col = 'tox',stroke=3)+
  swimmer_points(df_points=Anemia,id='pat',time='time',adj.y = -0.3,size=4,name_shape = 'grade',name_col = 'tox',stroke=3)+
  ggplot2::scale_shape_manual(values=c("1","2","3")) + ggplot2::guides(shape=FALSE)+
  ggplot2::scale_color_brewer(palette = "Dark2")

## ---- echo = TRUE,fig.align='centre'------------------------------------------

swimmer_plot(df=d1,id='pat',end='end',col="black",fill='white')+
  swimmer_points(df_points=Nausea,id='pat',time='time',adj.y = 0.3,size=4,name_col = 'grade',name_shape = 'tox',stroke=3)+
  swimmer_points(df_points=Fever,id='pat',time='time',adj.y = 0,size=4,name_col = 'grade',name_shape = 'tox',stroke=3)+
  swimmer_points(df_points=Anemia,id='pat',time='time',adj.y = -0.3,size=4,name_col = 'grade',name_shape = 'tox',stroke=3)+ 
  ggplot2::scale_color_manual(name="Grade",values=c("coral2","red3","orangered4"))

## ---- echo = TRUE,fig.align='centre'------------------------------------------
textdf1 <- data.frame(pat=unique(d1$pat),label="Nausea")
textdf2 <- data.frame(pat=unique(d1$pat),label="Fever")
textdf3 <- data.frame(pat=unique(d1$pat),label="Anemia")

swimmer_plot(df=d1,id='pat',end='end',col="black",fill='white')+
  swimmer_points(df_points=Nausea,id='pat',time='time',adj.y = 0.2,size=4,name_col = 'grade',name_shape = 'grade',stroke=3)+
  swimmer_points(df_points=Fever,id='pat',time='time',adj.y = 0,size=4,name_col = 'grade',name_shape = 'grade',stroke=3)+
  swimmer_points(df_points=Anemia,id='pat',time='time',adj.y = -0.2,size=4,name_col = 'grade',name_shape = 'grade',stroke=3)+ 
  ggplot2::scale_color_manual(name="Grade",values=c("coral2","red3","orangered4")) + ggplot2::labs(shape="Grade")+
  swimmer_text(df_text = textdf1,id='pat',label = 'label',adj.x = -2.2,adj.y = 0.2)+
  swimmer_text(df_text = textdf2,id='pat',label = 'label',adj.x = -2.2,adj.y = 0)+
  swimmer_text(df_text = textdf3,id='pat',label = 'label',adj.x = -2.2,adj.y = -0.2)

