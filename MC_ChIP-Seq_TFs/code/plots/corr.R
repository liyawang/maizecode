panel.cor <- function(x, y, digits=2, cex.cor)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  test <- cor.test(x,y)
  Signif <- ifelse(round(test$p.value,3)<0.001,"p<0.001",paste("p=",round(test$p.value,3)))  
  text(0.5, 0.4, paste("r=",txt),cex=2)
  text(.5, .6, Signif,cex=2)
}

panel.smooth<-function (x, y, col = "blue", bg = NA, pch = 18, 
                        cex = 1, col.smooth = "orange", col.reg="red",span = 2/3, iter = 3, ...) 
{
  points(x, y, pch = pch, col = col, bg = bg, cex = cex)
  ok <- is.finite(x) & is.finite(y)
  # if (any(ok)) 
    # lines(stats::lowess(x[ok], y[ok], f = span, iter = iter), col = col.smooth, ...)# lowess line
    # abline(stats::lm(x[ok]~y[ok]),col= "orange") # regression line
    # abline(stats::lm(y[ok]~x[ok]),col="green", lwd=1.2) # regression line
     
}


panel.hist <- function(x, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  # hist(x)
  # h <- hist(x, plot = FALSE)
  # breaks <- h$breaks; nB <- length(breaks)
  # y <- h$counts; y <- y/max(y)
  # rect(breaks[-nB], 0, breaks[-1], y, col="cyan",...)
}


setwd("/Users/xwang/Desktop/CSHL_Ware/chip_seq/Maizecode/062819/window_count")

CT_RA1_Input_rep1<-read.table("CT_RA1_Input_rep1_count.txt", sep="\t")
CT_RA1_Input_rep2<-read.table("CT_RA1_Input_rep2_count.txt", sep="\t")
RA1_Input_rep1<-read.table("RA1_Input_rep1_count.txt", sep="\t")
RA1_Input_rep2<-read.table("RA1_Input_rep2_count.txt", sep="\t")
CT_RA1_GFP_rep1<-read.table("CT_RA1_GFP_rep1_count.txt", sep="\t")
CT_RA1_GFP_rep2<-read.table("CT_RA1_GFP_rep2_count.txt", sep="\t")
RA1_GFP_rep1<-read.table("RA1_GFP_rep1_count.txt", sep="\t")
RA1_GFP_rep2<-read.table("RA1_GFP_rep2_count.txt", sep="\t")
CT_WUS1_Input_rep1<-read.table("CT_WUS1_Input_rep1_count.txt", sep="\t")
CT_WUS1_Input_rep2<-read.table("CT_WUS1_Input_rep2_count.txt", sep="\t")
WUS1_Input_rep1<-read.table("WUS1_Input_rep1_count.txt", sep="\t")
WUS1_Input_rep2<-read.table("WUS1_Input_rep2_count.txt", sep="\t")
CT_WUS1_RFP_rep1<-read.table("CT_WUS1_RFP_rep1_count.txt", sep="\t")
CT_WUS1_RFP_rep2<-read.table("CT_WUS1_RFP_rep2_count.txt", sep="\t")
WUS1_RFP_rep1<-read.table("WUS1_RFP_rep1_count.txt", sep="\t")
WUS1_RFP_rep2<-read.table("WUS1_RFP_rep2_count.txt", sep="\t")
CT_ZFHD_Input_rep1<-read.table("CT_ZFHD_Input_rep1_count.txt", sep="\t")
CT_ZFHD_Input_rep2<-read.table("CT_ZFHD_Input_rep2_count.txt", sep="\t")
ZFHD_Input_rep1<-read.table("ZFHD_Input_rep1_count.txt", sep="\t")
ZFHD_Input_rep2<-read.table("ZFHD_Input_rep2_count.txt", sep="\t")
CT_ZFHD_RFP_rep1<-read.table("CT_ZFHD_RFP_rep1_count.txt", sep="\t")
CT_ZFHD_RFP_rep2<-read.table("CT_ZFHD_RFP_rep2_count.txt", sep="\t")
ZFHD_RFP_rep1<-read.table("ZFHD_RFP_rep1_count.txt", sep="\t")
ZFHD_RFP_rep2<-read.table("ZFHD_RFP_rep2_count.txt", sep="\t")


TF<-cbind(CT_RA1_Input_rep1, CT_RA1_Input_rep2, RA1_Input_rep1, RA1_Input_rep2, CT_RA1_GFP_rep1, CT_RA1_GFP_rep2, RA1_GFP_rep1,RA1_GFP_rep2, CT_WUS1_Input_rep1, CT_WUS1_Input_rep2, WUS1_Input_rep1, WUS1_Input_rep2,CT_WUS1_RFP_rep1, CT_WUS1_RFP_rep2,WUS1_RFP_rep1, WUS1_RFP_rep2,CT_ZFHD_Input_rep1, CT_ZFHD_Input_rep2,ZFHD_Input_rep1, ZFHD_Input_rep2, CT_ZFHD_RFP_rep1,CT_ZFHD_RFP_rep2,ZFHD_RFP_rep1,ZFHD_RFP_rep2)

colnames(TF)=c("CT_RA1_Input_rep1", "CT_RA1_Input_rep2","RA1_Input_rep1","RA1_Input_rep2","CT_RA1_GFP_rep1","CT_RA1_GFP_rep2","RA1_GFP_rep1","RA1_GFP_rep2","CT_WUS1_Input_rep1","CT_WUS1_Input_rep2","WUS1_Input_rep1","WUS1_Input_rep2","CT_WUS1_RFP_rep1","CT_WUS1_RFP_rep2","WUS1_RFP_rep1","WUS1_RFP_rep2","CT_ZFHD_Input_rep1","CT_ZFHD_Input_rep2","ZFHD_Input_rep1","ZFHD_Input_rep2","CT_ZFHD_RFP_rep1","CT_ZFHD_RFP_rep2","ZFHD_RFP_rep1","ZFHD_RFP_rep2")

LS<-colSums(TF)

TF_Nor_LS<-cbind(CT_RA1_Input_rep1/LS[1], CT_RA1_Input_rep2/LS[2],RA1_Input_rep1/LS[3], RA1_Input_rep2/LS[4],CT_RA1_GFP_rep1/LS[5],CT_RA1_GFP_rep2/LS[6],RA1_GFP_rep1/LS[7], RA1_GFP_rep2/LS[8],CT_WUS1_Input_rep1/LS[9],CT_WUS1_Input_rep2/LS[10],WUS1_Input_rep1/LS[11],WUS1_Input_rep2/LS[12],CT_WUS1_RFP_rep1/LS[13],CT_WUS1_RFP_rep2/LS[14],WUS1_RFP_rep1/LS[15],WUS1_RFP_rep2/LS[16],CT_ZFHD_Input_rep1/LS[17],CT_ZFHD_Input_rep2/LS[18],ZFHD_Input_rep1/LS[19], ZFHD_Input_rep2/LS[20],CT_ZFHD_RFP_rep1/LS[21],CT_ZFHD_RFP_rep2/LS[22],ZFHD_RFP_rep1/LS[23],ZFHD_RFP_rep2/LS[24])

colnames(TF_Nor_LS)=c("CT_RA1_Input_rep1", "CT_RA1_Input_rep2","RA1_Input_rep1","RA1_Input_rep2","CT_RA1_GFP_rep1","CT_RA1_GFP_rep2","RA1_GFP_rep1","RA1_GFP_rep2","CT_WUS1_Input_rep1","CT_WUS1_Input_rep2","WUS1_Input_rep1","WUS1_Input_rep2","CT_WUS1_RFP_rep1","CT_WUS1_RFP_rep2","WUS1_RFP_rep1","WUS1_RFP_rep2","CT_ZFHD_Input_rep1","CT_ZFHD_Input_rep2","ZFHD_Input_rep1","ZFHD_Input_rep2","CT_ZFHD_RFP_rep1","CT_ZFHD_RFP_rep2","ZFHD_RFP_rep1","ZFHD_RFP_rep2")


test=head(TF_Nor_LS, n=100)

pairs(TF_Nor_LS[,c(1,2,5,6)],lower.panel=panel.smooth, upper.panel=panel.cor,diag.panel=panel.hist, labels=c(expression(italic("CT_RA1_Input_rep1")), expression(italic("CT_RA1_Input_rep1"))),label.pos=0.5)



bitmap("CT_RA1_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(1,2,5,6)]*100000,lower.panel=panel.smooth, upper.panel=panel.cor,diag.panel=panel.hist, labels=c("CT_RA1_Input_rep1", "CT_RA1_Input_rep1", "CT_RA1_GFP-IP_rep1","CT_RA1_GFP-IP_rep1"),label.pos=0.5,font.labels=3)
dev.off()

upper.panel<-function(x, y,...){
  points(x,y)
  r <- round(cor(x, y), digits=2)
  txt <- paste0("R = ", r)
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  text(0.5, 0.9, txt,col="red",...)
}

panel.lm<-
function (x, y, col = par("col"), bg = NA, pch = par("pch"),
cex = 1, col.lm = "red", lwd=par("lwd"), ...)
{
points(x, y, pch = pch, col = col, bg = bg, cex = cex)
ok <- is.finite(x) & is.finite(y)
if (any(ok))
    abline(lm(y~x,subset=ok), col = col.lm, ...)
}

plot(head(TF_Nor_LS[,c(1,2)])*100000)


bitmap("CT_RA1_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(1,2,5,6)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,250), ylim = c(0,250),labels=c("CT_RA1_Input_rep1", "CT_RA1_Input_rep2", "CT_RA1_GFP-IP_rep1","CT_RA1_GFP-IP_rep2"),label.pos=0.5)
dev.off()


bitmap("CT_RA1_Inp_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(1,2)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,250), ylim = c(0,250),labels=c("CT_RA1_Input_rep1", "CT_RA1_Input_rep2"),label.pos=0.5)
dev.off()


bitmap("CT_RA1_IP_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(5,6)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,250), ylim = c(0,250),labels=c("CT_RA1_GFP-IP_rep1","CT_RA1_GFP-IP_rep2"),label.pos=0.5)
dev.off()


pairs(test[,c(1,2,5,6)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,500), ylim = c(0,500),labels=c("CT_RA1_Input_rep1", "CT_RA1_Input_rep1", "CT_RA1_GFP-IP_rep1","CT_RA1_GFP-IP_rep1"),label.pos=0.5)


bitmap("RA1_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(3,4,7,8)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,400), ylim = c(0,400),labels=c("RA1_Input_rep1", "RA1_Input_rep2", "RA1_GFP-IP_rep1","RA1_GFP-IP_rep2"),label.pos=0.5)
dev.off()

bitmap("RA1_Inp_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(3,4)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,400), ylim = c(0,400),labels=c("RA1_Input_rep1", "RA1_Input_rep2"),label.pos=0.5)
dev.off()

bitmap("RA1_IP_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(7,8)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,400), ylim = c(0,400),labels=c("RA1_GFP-IP_rep1","RA1_GFP-IP_rep2"),label.pos=0.5)
dev.off()


bitmap("CT_WUS1_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(9,10,13,14)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,250), ylim = c(0,250),labels=c("CT_WUS1_Input_rep1", "CT_WUS1_Input_rep2", "CT_WUS1_RFP-IP_rep1","CT_WUS1_RFP-IP_rep2"),label.pos=0.5)
dev.off()


bitmap("CT_WUS1_Inp_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(9,10)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,250), ylim = c(0,250),labels=c("CT_WUS1_Input_rep1", "CT_WUS1_Input_rep2"),label.pos=0.5)
dev.off()

bitmap("CT_WUS1_IP_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(13,14)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,250), ylim = c(0,250),labels=c("CT_WUS1_RFP-IP_rep1","CT_WUS1_RFP-IP_rep2"),label.pos=0.5)
dev.off()

bitmap("WUS1_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(11,12,15,16)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,250), ylim = c(0,250),labels=c("WUS1_Input_rep1", "WUS1_Input_rep2", "WUS1_RFP-IP_rep1","WUS1_RFP-IP_rep2"),label.pos=0.5)
dev.off()

bitmap("WUS1_Inp_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(11,12)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,250), ylim = c(0,250),labels=c("WUS1_Input_rep1", "WUS1_Input_rep2"),label.pos=0.5)
dev.off()

bitmap("WUS1_IP_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(15,16)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,250), ylim = c(0,250),labels=c("WUS1_RFP-IP_rep1","WUS1_RFP-IP_rep2"),label.pos=0.5)
dev.off()

bitmap("CT_ZFHD_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(17,18,21,22)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,250), ylim = c(0,250),labels=c("CT_ZFHD_Input_rep1", "CT_ZFHD_Input_rep2", "CT_ZFHD_RFP-IP_rep1","CT_ZFHD_RFP-IP_rep2"),label.pos=0.5)
dev.off()

bitmap("CT_ZFHD_Inp_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(17,18)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,250), ylim = c(0,250),labels=c("CT_ZFHD_Input_rep1", "CT_ZFHD_Input_rep2"),label.pos=0.5)
dev.off()

bitmap("CT_ZFHD_IP_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(21,22)]*100000,lower.panel= NULL, upper.panel = upper.panel,xlim=c(0,250), ylim = c(0,250),labels=c("CT_ZFHD_RFP-IP_rep1","CT_ZFHD_RFP-IP_rep2"),label.pos=0.5)
dev.off()

bitmap("ZFHD_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(19,20,23,24)]*100000,lower.panel= NULL, upper.panel = upper.panel,labels=c("ZFHD_Input_rep1", "ZFHD_Input_rep2", "ZFHD_RFP-IP_rep1","ZFHD_RFP-IP_rep2"),label.pos=0.5)
dev.off()

bitmap("ZFHD_Inp_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(19,20)]*100000,lower.panel= NULL, upper.panel = upper.panel,labels=c("ZFHD_Input_rep1", "ZFHD_Input_rep2"),label.pos=0.5)
dev.off()

bitmap("ZFHD_IP_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(23,24)]*100000,lower.panel= NULL, upper.panel = upper.panel,labels=c("ZFHD_RFP-IP_rep1","ZFHD_RFP-IP_rep2"),label.pos=0.5)
dev.off()

# ZFHD_8_smps
bitmap("ZFHD_8smps_R.jpg", res=300, type="jpeg", height = 13, width=13)
pairs(TF_Nor_LS[,c(17,18,21,22,19,20,23,24)]*100000,lower.panel= NULL, upper.panel = upper.panel,labels=c("CT_ZFHD_Input_rep1", "CT_ZFHD_Input_rep2", "CT_ZFHD_RFP-IP_rep1","CT_ZFHD_RFP-IP_rep2", "ZFHD_Input_rep1", "ZFHD_Input_rep2", "ZFHD_RFP-IP_rep1","ZFHD_RFP-IP_rep2"),label.pos=0.5,cex.labels=0.5)
dev.off()

#######
#barplot for number of reads
rdPairs<-read.table("/Users/xwang/Desktop/CSHL_Ware/chip_seq/Maizecode/062819/align_stats/rdPairs.txt", sep="\t",header=TRUE)

attach(rdPairs)




t=t(as.matrix(rdPairs[,c(2,5)]))
colnames(t)<-Smp_name

setwd("/Users/xwang/Desktop/CSHL_Ware/chip_seq/Maizecode/062819/align_stats/")

bitmap("raw_trimmed_rdPairs3.jpg", res=300, type="jpeg", height = 13, width=20)
x<-barplot(t,beside=TRUE,ylim=c(0,3e+07),ylab="Read Pairs", xaxt="n",yaxt="n")
lab=colnames(t)
tlab=seq(2,3*ncol(t),by=3)
axis(1, at=tlab, labels=FALSE)
axis(2, at=seq(0,30000000,5000000), labels=expression(0.0, 0.5%*%10^6, 1.0%*%10^7, 1.5%*%10^7, 2.0%*%10^7,2.5%*%10^7, 3.0%*%10^7),cex.axis=0.6,font=2)

text(x=tlab, y=par("usr")[3],labels=lab, srt=45, adj=c(1.1,1.5),xpd=TRUE,cex = 0.6,font=2)

# text(x=tlab, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]), labels=lab, srt=45, adj=1, xpd=TRUE,cex = 0.6)

# text(x=tlab, y=par()$usr[3]-0.1*(par()$usr[4]-par()$usr[3]),labels=lab, srt=30, adj=1,xpd=TRUE,cex = 0.6)

# text(x=tlab, y=par("usr")[3],labels=lab, srt=30, adj=c(1.1,1.1),xpd=TRUE,cex = 0.8)

text(tlab+0.5, Trimmed_Rds_Pairs-1300000,labels=as.character(Trimmed_Per),las=1,cex=0.7,col="red",srt=90,font=2) 
legend('topright',legend=c('Raw_Rd_Pairs','Kept_Rds_Pairs'),fill=gray.colors(2),  bty = "n")
dev.off()

lab=colnames(t)
tlab=seq(1.5,2*ncol(t),by=2)

bitmap("raw_rdPairs3.jpg", res=300, type="jpeg", height = 13, width=18)
x<-barplot(t[1,],ylim=c(0,3e+07),ylab="Read Pairs", xaxt="n",yaxt="n",main="Distribution_Raw_read_Pairs",space=1)

axis(1, at=tlab, labels=FALSE)
axis(2, at=seq(0,30000000,5000000), labels=expression(0.0, 0.5%*%10^7, 1.0%*%10^7, 1.5%*%10^7, 2.0%*%10^7,2.5%*%10^7, 3.0%*%10^7),cex.axis=0.6,font=2)
text(x=tlab, y=par("usr")[3],labels=lab, srt=45, adj=c(1.1,1.5),xpd=TRUE,cex = 0.6,font=2)
text(tlab, Rd_Pairs-1100000,labels=as.character(Library_Per),las=1,cex=0.8,col="red",srt=90,font=2) 
dev.off()



bitmap("trimmed_rdPairs2.jpg", res=300, type="jpeg", height = 13, width=18)
x<-barplot(t[2,],ylim=c(0,3e+07),ylab="Read Pairs", xaxt="n",yaxt="n",main="Trimmed_read_Pairs",space=1)

axis(1, at=tlab, labels=FALSE)
axis(2, at=seq(0,30000000,5000000), labels=expression(0.0, 0.5%*%10^7, 1.0%*%10^7, 1.5%*%10^7, 2.0%*%10^7,2.5%*%10^7, 3.0%*%10^7),cex.axis=0.6,font.axis=2)
text(x=tlab, y=par("usr")[3],labels=lab, srt=45, adj=c(1.1,1.5),xpd=TRUE,cex = 0.6,font=2)
text(tlab, Trimmed_Rds_Pairs+1000000,labels=as.character(Trimmed_Per),las=1,cex=0.6,col="red",srt=90,font=2) 
dev.off()


alignStat<-read.table("/Users/xwang/Desktop/CSHL_Ware/chip_seq/Maizecode/062819/align_stats/align.txt", sep="\t",header=TRUE)

attach(alignStat)


t2=t(as.matrix(alignStat[,c(3,4)]))
colnames(t2)<-Smp_name
bitmap("mapped_per2.jpg", res=300, type="jpeg", height = 10, width=15)
x<-barplot(t2,beside=TRUE,ylim=c(0,1),ylab="Mapped Percentage", xaxt="n",yaxt="n")
lab=colnames(t2)
tlab=seq(2,3*ncol(t),by=3)
axis(1, at=tlab, labels=FALSE)
axis(2, at=seq(0,1,.2), labels=paste(100*seq(0,1,by=.2), "%"),cex.axis=0.8,font.axis=2,las=2)

text(x=tlab, y=par("usr")[3],labels=lab, srt=45, adj=c(1.1,1.5),xpd=TRUE,cex = 0.6,font=2)
text(tlab+0.5, STAR-0.04,labels=paste(STAR*100,"%",sep=""),las=1,cex=0.8,col="red",srt=90,font=2) 
text(tlab-0.5, BWA-0.04,labels=paste(BWA*100, "%",sep=""),las=1,cex=0.8,col="maroon1",srt=90,font=2) 

legend('topright',legend=c('BWA','STAR'),fill=gray.colors(2),  bty = "n")
dev.off()


setwd("/Users/xwang/Desktop/CSHL_Ware/chip_seq/Maizecode/062819/align_stats/")
alignStat2<-read.table("/Users/xwang/Desktop/CSHL_Ware/chip_seq/Maizecode/062819/align_stats/align2.txt", sep="\t",header=TRUE)

attach(alignStat2)
t3=t(as.matrix(alignStat2[,c(3,5)]))
colnames(t3)<-Smp_name

bitmap("mapped_All_Uniq_per.jpg", res=300, type="jpeg", height = 10, width=18)
par(xpd = T, mar = par()$mar + c(0,0,5,0))
# par(mar = c(5, 5, 11, 2))
# par(mar=c(par('mar')[1:3], 0)) # optional, removes extraneous right inner margin space
# par(mar = c(5, 4, 4, 2) + 0.1)
x<-barplot(t3,beside=TRUE,ylim=c(0,1),ylab="Mapped Percentage", xaxt="n",yaxt="n",main="Mapping Percentage")
lab=colnames(t3)
tlab=seq(2,3*ncol(t3),by=3)
axis(1, at=tlab, labels=FALSE)
axis(2, at=seq(0,1,.2), labels=paste(100*seq(0,1,by=.2), "%"),cex.axis=0.8,font.axis=2,las=2)

text(x=tlab-0.5, y=par("usr")[3],labels=lab, srt=45, adj=c(1.1,1.5),xpd=TRUE,cex = 0.6,font=2)
text(tlab-0.5,BWA_Mapping-0.06,labels=paste(BWA_Mapping*100,"%",sep=""),las=1,cex=0.8,col="red",srt=90,font=2) 
text(tlab+0.5, BWA_Uniq_Per-0.06,labels=paste(BWA_Uniq_Per*100, "%",sep=""),las=1,cex=0.8,col="maroon1",srt=90,font=2) 
# legend(par('usr')[2], par('usr')[4],legend=c('All-alignment','Unique-alignment'),fill=gray.colors(2),  bty = "n")

# legend('topright',inset=c(-2,0),legend=c('All-alignment','Unique-alignment'),fill=gray.colors(2),  bty = "n")

legend(55,1.1,legend=c('All-alignment','Unique-alignment'),fill=gray.colors(2),  bty = "n")
par(mar=c(5, 4, 4, 2) + 0.1)

dev.off()

