## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(swimplot)
library(ggplot2)

## ---- echo = TRUE,fig.align='centre'------------------------------------------
knitr::kable(head(ClinicalTrial.Arm,10))
knitr::kable(head(ClinicalTrial.AE,10))
knitr::kable(head(ClinicalTrial.Response,10))

## ---- echo = TRUE,fig.align='centre'------------------------------------------
swimmer_plot(df=ClinicalTrial.Arm,id='id',end='End_trt',fill='lightblue',width=.85)

## ---- echo = TRUE,fig.align='centre'------------------------------------------
arm_plot <- swimmer_plot(df=ClinicalTrial.Arm,id='id',end='End_trt',name_fill='Arm',
                         id_order='Arm',col="black",alpha=0.75,width=.8)

arm_plot

## ---- echo = TRUE,fig.align='centre'------------------------------------------
swim_plot_stratify <-swimmer_plot(df=ClinicalTrial.Arm,id='id',end='End_trt',name_fill='Arm',
col="black",alpha=0.75,width=.8,base_size = 14,stratify= c('Age','Sex'))

swim_plot_stratify

## ---- echo = TRUE,fig.align='centre'------------------------------------------
AE_plot <- arm_plot + swimmer_points(df_points=
 ClinicalTrial.AE,id='id',time='time',name_shape =
 'event',size=2.5,fill='white',col='black')
AE_plot

## ---- echo = TRUE,fig.align='centre'------------------------------------------
arm_plot + swimmer_points(df_points=
 ClinicalTrial.AE,id='id',time='time',name_shape =
 'event',size=2.5,fill='white',name_col = 'Related')


## ---- echo = TRUE,fig.align='centre'------------------------------------------
Response_plot <- arm_plot +
swimmer_lines(df_lines=ClinicalTrial.Response,id='id',start =
'Response_start',end='Response_end',name_col='Response',size=1)

Response_plot

## ---- echo = TRUE,fig.align='centre'------------------------------------------
Response_plot_with_points <- Response_plot+
swimmer_points_from_lines(df_lines=ClinicalTrial.Response,id='id',start =
'Response_start',end = 'Response_end', cont =
'Continued_response',name_col='Response',size=2)

Response_plot_with_points

## ---- echo = TRUE,fig.align='centre'------------------------------------------
AE_plot+
swimmer_arrows(df_arrows=ClinicalTrial.Arm,id='id',arrow_start='End_trt',
cont = 'Continued_treatment',name_col='Arm',type =
 "open",cex=1)

## ---- echo = TRUE,fig.align='centre'------------------------------------------
AE_plot <- AE_plot+
swimmer_arrows(df_arrows=ClinicalTrial.Arm,id='id',arrow_start='End_trt',
cont = 'Continued_treatment',name_col='Arm',show.legend = FALSE,type =
 "open",cex=1) + scale_color_discrete(drop=FALSE)

AE_plot

## ---- echo = TRUE,fig.align='centre'------------------------------------------
Response_plot_with_points <- Response_plot_with_points+
 swimmer_arrows(df_arrows=ClinicalTrial.Response,id='id',arrow_start='Response_end',
 cont = 'Continued_response',name_col='Response',show.legend = FALSE,type =
 "open",cex=1)

Response_plot_with_points

## ----col1 , echo=T,warnings=FALSE,message=FALSE-------------------------------
AE_plot <-  AE_plot +
  scale_fill_manual(name="Treatment",values=c("Arm A" = "#e41a1c", "Arm B"="#377eb8","Off Treatment"='#4daf4a'))+
  scale_color_manual(name="Treatment",values=c("Arm A"="#e41a1c", "Arm B" ="#377eb8","Off Treatment"='#4daf4a')) +
  scale_shape_manual(name="Adverse event",values=c(AE=21,SAE=24,Death=17),breaks=c('AE','SAE','Death'))

AE_plot

## ----col2 , echo=T,warnings=F,warnings=FALSE,warnings=FALSE,message=FALSE-----
Response_plot_with_points <- Response_plot_with_points +
  scale_fill_manual(name="Treatment",values=c("Arm A" ="#e41a1c", "Arm B"="#377eb8","Off Treatment"='#4daf4a'))+
  scale_color_manual(name="Response",values=c("grey20","grey80"))+
  scale_shape_manual(name='',values=c(17,15),breaks=c('Response_start','Response_end'),
                     labels=c('Response start','Response end'))

Response_plot_with_points

## ----legend2 , echo=T,warnings=F,message=F,warning=FALSE----------------------

Response_plot_with_points <- Response_plot_with_points+guides(fill = guide_legend(override.aes = list(shape = NA)))
Response_plot_with_points


## ----legend3 ,echo=T, eval=T,warnings=F,message=F,warning=FALSE---------------

Response_plot_with_points <- Response_plot_with_points+
  annotate("text", x=3.5, y=20.45, label="Continued response",size=3.25)+
  annotate("text",x=2.5, y=20.25, label=sprintf('\u2192'),size=8.25)+
  coord_flip(clip = 'off', ylim = c(0, 17))
Response_plot_with_points


## ----axis2 , echo=T,warnings=FALSE,messgages=FALSE----------------------------

Response_plot_with_points +  scale_y_continuous(name = "Time since enrollment (months)",breaks = seq(0,18,by=3))


## ----Legend with multiple , echo=T,warnings=FALSE,messgages=FALSE-------------

#Overriding legends to have colours for the events and no points in the lines
p1 <- arm_plot + swimmer_points(df_points=ClinicalTrial.AE,id='id',time='time',name_shape =
                                       'event',size=2.5,col='black',name_fill = 'event') +
  scale_shape_manual(values=c(21,22,23),breaks=c('AE','SAE','Death'))
  

p1 +scale_fill_manual(name="Treatment",values=c("AE"='grey90',"SAE" ="grey40","Death" =1,"Arm A"="#e41a1c", "Arm B" ="#377eb8","Off Treatment"="#4daf4a"))

## ----Legend with multiple2 , echo=T,warnings=FALSE,messgages=FALSE------------
#First step is to correct the fill legend 

p2 <- p1 + scale_fill_manual(name="Treatment",values=c("AE"='grey90',"SAE" ="grey40","Death" =1,"Arm A"="#e41a1c", "Arm B" ="#377eb8","Off Treatment"="#4daf4a"),breaks = c("Arm A","Arm B","Off Treatment"))
p2
##Then use guides to add the colours to the 

#Setting the colours of the filled points to match the AE type 
p2 + guides(shape = guide_legend(override.aes = list(fill=c('grey90','grey40',1))),fill = guide_legend(override.aes = list(shape = NA))) 


## ---- echo=T,warnings=FALSE,messgages=FALSE-----------------------------------

Gap_data <- data.frame(patient_ID=c('ID:3','ID:1','ID:1','ID:1','ID:2',
                                    'ID:2','ID:2','ID:3','ID:3'),
                       start=c(10,1,2,7,2,10,14,5,0),
                       end=c(20,2,4,10,7,14,22,7,3),
                       treatment=c("A","B","C","A","A","C","A","B","C"))

knitr::kable(Gap_data)


## ---- echo=T,warnings=FALSE,messgages=FALSE-----------------------------------

swimmer_plot(df=Gap_data,id='patient_ID',name_fill="treatment",col=1,
id_order = c('ID:1','ID:2','ID:3')) +theme_bw()

## ---- echo=T,warnings=FALSE,messgages=FALSE-----------------------------------

Gap_data <- rbind(Gap_data,data.frame(patient_ID='ID:2',start=22,end=26,treatment=NA))
knitr::kable(Gap_data)

## ---- echo=T,warnings=FALSE,messgages=FALSE-----------------------------------
swimmer_plot(df=Gap_data,id='patient_ID',name_fill="treatment",col=1,
id_order = c('ID:1','ID:2','ID:3')) +
ggplot2::theme_bw()+ggplot2::scale_fill_manual(name="Treatment",
 values=c("A"="#e41a1c", "B"="#377eb8","C"="#4daf4a",na.value=NA),breaks=c("A","B","C"))+
  ggplot2::scale_y_continuous(breaks=c(0:26))

## ---- echo=T,warnings=FALSE,messgages=FALSE-----------------------------------

wide_example <- structure(list(ID = c("ID:001", "ID:002", "ID:003"), Date.begin.Treatment = structure(c(14307, 
14126, 15312), class = "Date"), AE = structure(c(16133, 14491, 
NA), class = "Date"), SAE = structure(c(16316, NA, 16042), class = "Date"), 
    Death.date = structure(c(16499, NA, 17869), class = "Date"), 
    Response1 = c("SD", "SD", NA), Response1.Start = structure(c(14745, 
    14345, NA), class = "Date"), Response1.End = structure(c(15111, 
    14418, NA), class = "Date"), Response2 = c("CR", "PR", NA
    ), Response2.Start = structure(c(15768, 14674, NA), class = "Date"), 
    Response2.End = structure(c(16133, 14856, NA), class = "Date"), 
    Response3 = c(NA, "CR", NA), Response3.Start = structure(c(NA, 
    14856, NA), class = "Date"), Response3.End = structure(c(NA, 
    15587, NA), class = "Date"), Last.follow.up = structure(c(16499, 
    17048, 17869), class = "Date")), class = "data.frame", row.names = c(NA, 
-3L))

## ---- echo=F,warnings=FALSE,messgages=FALSE, fig.width = 8, fig.height = 4.5----
knitr::kable(wide_example)

## ---- echo=TRUE,warnings=FALSE,messgages=FALSE, fig.width = 8, fig.height = 4.5----
date_cols <- c("Date.begin.Treatment","AE","SAE",'Death.date','Response1.Start', 'Response1.End','Response2.Start', 'Response2.End',
               'Response3.Start' ,'Response3.End' ,'Last.follow.up') # Getting the columns with dates
wide_example[date_cols] <- lapply(wide_example[date_cols], as.numeric) # Converting to numbers 
wide_example[date_cols] <- round((wide_example[date_cols]-wide_example$Date.begin.Treatment)/365.25,1) #Calcuating the time in years since the start of treatment
knitr::kable(wide_example)

## ----echo=T,warnings=FALSE,messgages=FALSE------------------------------------
plot <- swimmer_plot(df=wide_example,id='ID',end='Last.follow.up',col='black',fill='grey')
plot

## ----echo=T,warning=FALSE,messgage=FALSE, fig.width = 8, fig.height = 4.5-----
library(tidyr)
data_time_points <- wide_example[,c('ID','AE','SAE','Death.date')]
points_long <- gather_(data=data_time_points,"point", "time", 
                       gather_cols=c('AE','SAE','Death.date'),na.rm=T)
knitr::kable(points_long,align='c',row.names = F)

## ----echo=T,warning=FALSE,messgage=FALSE, fig.width = 8, fig.height = 4.5-----
plot+ swimmer_points(df=points_long,id='ID',name_shape = 'point',size=8)

## ----warning=FALSE,messgage=FALSE,echo=T, fig.width = 8, fig.height = 4.5-----
long_start <- gather_(data=wide_example[,c('ID','Response1.Start','Response2.Start','Response3.Start')],
                      "response_number", "start_time", gather_cols=c('Response1.Start','Response2.Start',
                                                                'Response3.Start'),na.rm=T)

long_start$response_number <- substring(long_start$response_number,1,9) # Will be used to match to the end and types

## ----warning=FALSE,messgage=FALSE,echo=FALSE, fig.width = 8, fig.height = 4.5----
knitr::kable(long_start,align='c',row.names = F)

## ----fig.height=4.5,echo=TRUE, fig.width=8, message=FALSE, warning=FALSE------
long_end <- gather_(data=wide_example[,c('ID','Response1.End','Response2.End','Response3.End')],
                    "response_number", "end_time", gather_cols=c('Response1.End','Response2.End',
                                                            'Response3.End'),na.rm=T)
long_end$response_number <- substring(long_end$response_number,1,9)

long_response <- gather_(data=wide_example[,c('ID','Response1','Response2','Response3')],
                         "response_number", "Response", gather_cols=c('Response1','Response2','Response3'),
                         na.rm=T)

long_response_full <- Reduce(function(...) merge(..., all=TRUE,by=c('ID','response_number')), 
                            list(long_start, long_end, long_response))

## ----fig.height=4.5,echo=F, fig.width=8, message=FALSE, warning=FALSE---------
knitr::kable(long_response_full,align='c',row.names = F)

## ----echo=TRUE,warnings=FALSE,messgages=FALSE, fig.width = 8, fig.height = 4.5----
plot+ 
  swimmer_points(df=points_long,id='ID',name_shape = 'point',size=8)+
  swimmer_lines(df_lines = long_response_full,id='ID',start = 'start_time',end='end_time',
                name_col='Response',size=25)

