library(data.table)
#library(phonTools)
#library(bioacoustics)
library(tuneR)
library(seewave)
#library(warbleR)
#library(Rraven)
setwd("/home/mark/competitions/zindi-fowl/")

train<-fread("Train.csv")
train[,.(.N,.N/nrow(train)),common_name][order(-N)]
test<-fread("Test.csv")


directory<-"Test"
lf<-list.files(directory,pattern = ".mp3")
for(i in 1:length(lf)){
  fn<-lf[i]
  if(i%%20==1){print(paste(i,Sys.time()))}
  try({
    audio<-readMP3(file.path(directory, fn))
  
    # the frequency of your audio file
    freq <- 44100
    # the length and duration of your audio file
    totlen <- length(audio)
    totsec <- totlen/freq 
    
    # the duration that you want to chop the file into (in seconds)
    seglen <- 5.0
    
    # defining the break points
    breaks <- unique(c(seq(0, totsec, seglen), totsec))
    index <- 1:(length(breaks)-1)
    
    subsamps <- lapply(index, function(i) cutw(audio, f=freq, from=breaks[i], to=breaks[i+1]))
    
    filenames <- paste0("Rsplits_",directory,"/",gsub(".mp3","",fn),"_split",1:(length(breaks)-1),".wav")
    
    # Save the files (length-1 to get only complete subsamples for perfectly even length)
    sapply(1:(pmax(1,length(subsamps)-1)),
           function(x)writeWave(Wave(subsamps[[x]],samp.rate=audio@samp.rate,bit=audio@bit), 
                                filename=filenames[x]))
  })
}

train[1:2]
train_splits<-data.table(fn=list.files("Rsplits_Train/"))
train_splits[,ID:=substr(fn,1,6)]
train_splits<-merge(train_splits,train,"ID")
test[1:2]
sub<-fread("SampleSubmission.csv")
test_splits<-data.table(fn=list.files("Rsplits_Test/"))
test_splits[,ID:=substr(fn,1,6)]
test_splits<-merge(test_splits,sub,"ID")
fwrite(train_splits,"TrainSplits.csv")
fwrite(test_splits,"TestSplits.csv")

trs<-fread("TrainSplits.csv")
tes<-fread("fastai_splits_v1.csv")


tes[11:12]
valID<-"01S9OX"
l<-list()
for(valID in tes[,unique(ID)]){
  q<-tes[ID==valID,3:42,with=F]
  entry<-which(q==max(q))
  col<-ceiling(entry/nrow(q))
  row<-entry%%nrow(q)
  l[[length(l)+1]]<-cbind(ID=valID,q[row][1])
}
submission<-rbindlist(l)
length(tes[,unique(ID)])

last_single<-fread("fastai_f18f.csv")
combined<-rbind(submission[!is.na(Bokmakierie)]
      ,last_single[ID %in% submission[is.na(Bokmakierie),ID]])
fwrite(combined,"splits_max_prob_row.csv",scipen = 9)

