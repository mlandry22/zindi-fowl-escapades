library(data.table)
setwd("/home/mark/competitions/zindi-fowl/")
a17c<-fread("fastai_A17c.csv")[order(ID)] ## 1.5011
a17f<-fread("fastai_A17f.csv")[order(ID)] ## 1.4364
a17k<-fread("fastai_A17k.csv")[order(ID)] ## 1.5614
a18a<-fread("fastai_A18a.csv")[order(ID)] ## 1.4793
a18b<-fread("fastai_A18b.csv")[order(ID)] ## 1.4845

blend<-data.frame(a17f)

for(ic in 2:ncol(blend)){
  blend[,ic]<-0.2*a17c[,ic,with=FALSE]+
    0.2*a17f[,ic,with=FALSE]+
    0.2*a17k[,ic,with=FALSE]+
    0.2*a18a[,ic,with=FALSE]+
    0.2*a18b[,ic,with=FALSE]
}

a17f[1,1:8,with=F]
blend[1,1:8]

write.csv(blend,"blend_top5_reproducibles.csv",row.names = FALSE)
