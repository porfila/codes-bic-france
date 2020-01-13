library(TS)
swift<-read.csv2("codes-bic-france.csv",sep=",")
TS::ROD_saveRDS(swift,"tab_swift")

# Algo de reconnaissance bic 
sh<-read.csv2("EnTeteRexel1.csv")
SWIFT<-ROD_readRDS("tab_swift")
swift<-paste(SWIFT$swift_code,collapse="|")

isswiftcode<-sapply(sh,function(x){
  NROW(grep(swift,x)) > 0.95*NROW(x)
})

isswiftcode<-as.data.frame(isswiftcode)
isswiftcodeCols<-rownames(isswiftcode[isswiftcode==T,,drop=F])

if (sum(isswiftcode[1,]) !=1) {
  isswiftcode<-sapply(sh,function(x){
    c(sum(grepl("^[A-Z]{11}$",x)) == NROW(x),sum(grepl("^[A-Z]{11}$",x)))
  })
}
isswiftcode<-as.data.frame(isswiftcode)

isswiftcode<-isswiftcode[,isswiftcode[1,]==1,drop=F]
isswiftcodeCols<-names(isswiftcode)