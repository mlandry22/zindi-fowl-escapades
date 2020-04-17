dir.create(file.path(getwd(),"warbleR_example"))
setwd(file.path(getwd(),"warbleR_example"))

# Check your location
getwd()


data("selection_files")

# Write out Raven example selection tables as physical files
out <- lapply(1:2, function(x) 
  writeLines(selection_files[[x]], con = names(selection_files)[x]))

# Write example sound files out as physical .wav files
data(list = c("Phae.long1", "Phae.long2"))

writeWave(Phae.long1, "Phae.long1.wav")
writeWave(Phae.long2, "Phae.long2.wav")


sels <- imp_raven(all.data = FALSE, freq.cols = FALSE, warbler.format = TRUE)
str(sels)

# Write out the imported selections as a .csv for later use
write.csv(sels, "Raven_sels.csv", row.names = FALSE)

sels <- selection_table(X = sels)
str(sels)
class(sels)

Phae <- querxc(qword = "Phaethornis", download = FALSE) 
str(Phae)

# Query xeno-canto for all Phaethornis longirostris recordings
Phae.lon <- querxc(qword = "Phaethornis longirostris", download = FALSE) 

# Check out the structure of resulting the data frame
str(Phae.lon)










mp32wav(samp.rate = 22.05)
checkwavs() 
wavs <- list.files(pattern = "wav$")
sub<-wavs
wavdur(wavs)
lspec(flist = wavs, ovlp = 10, it = "tiff")
lspec(flist = wavs, flim = c(2, 10), sxrow = 6, rows = 15, ovlp = 10, it = "tiff")

# Make long spectrograms for the xeno-canto sound files
lspec(flim = c(2, 10), ovlp = 10, sxrow = 6, rows = 15, it = "jpeg", flist = wavs)

# Concatenate lspec image files into a single PDF per recording
# lspec images must be jpegs to do this
lspec2pdf(keep.img = FALSE, overwrite = TRUE)

autodetec(
  flist = sub
  , bp = c(1, 10)
  , threshold = 10
  , mindur = 0.05
  , maxdur = 0.5
  , envt="abs"
  , ssmooth = 300
  , ls = TRUE
  , res = 100
  , flim = c(1, 12)
  , wl = 300
  , set = TRUE
  , sxrow = 6
  , rows = 15
  , redo = FALSE)

sub<-wavs[c(1,2,5,6)]
autodetec(flist = sub
          , bp = c(2, 10)
          , threshold = 20
          , mindur = 0.09
          , maxdur = 0.22
          , envt = "abs"
          , ssmooth = 900
          , ls = TRUE
          , res = 100
          , flim= c(1, 12)
          , wl = 300
          , set =TRUE
          , sxrow = 6
          , rows = 15
          , redo = TRUE
          , it = "tiff"
          , img = TRUE
          , smadj = "end")

Phae.ad <- autodetec(
  threshold = 15 #20
  , envt = "abs"
  , bp = c(2, 10)
  , ssmooth = 900
  , mindur = 0.05
  , maxdur = 0.5
  , ls = TRUE
  , res = 100
  , flim = c(1, 12)
  , wl = 300
  , set =TRUE
  , sxrow = 6
  , rows = 15
  , redo = TRUE
  , it = "tiff"
  , img = TRUE
  , smadj = "end"
  , parallel = 20
  , pal = topo.1)

### *************************
snr_file<-"0EFEG5.wav"

snr.autodetec <- autodetec(flist = snr_file
  , bp = c(2, 10)
  , threshold = 20
  , mindur = 0.05
  , maxdur = 0.5
  , envt = "abs"
  , ssmooth = 900
  , ls = TRUE
  , res = 100
  , flim = c(1, 12)
  , wl = 300
  , set =TRUE
  , sxrow = 6
  , rows = 15
  , redo = TRUE
  , it = "tiff"
  , img = TRUE
  , smadj = "end"
  , parallel = 20)

snrspecs(X = snr.autodetec, flim = c(2, 10), snrmar = 0.04, mar = 0.7, it = "jpeg")
snrspecs(X = snr.autodetec, flim = c(2, 10), snrmar = 0.5, mar = 0.7, it = "jpeg")
Phae.snr <- sig2noise(X = snr.autodetec, mar = 0.1)
