# Reinitialize the session
rm(list=ls(all=TRUE))

library(utils)
# Go to the working directory
setwd("C:/Users/mdinclaux/Documents/Script/TWB_Robot/Goldengate_combination/")

data <- read.csv("SpaceHex.csv", header = FALSE, sep = ";", dec = ".",stringsAsFactors = FALSE)
t <- ncol(data)

for(type in c("Coord_name","Coord_num")){
if(type == "Coord_num"){
  plate_template = c()
  
  for (i in LETTERS[1:8]) {
    temp <- paste(i, 1:12, sep = "")
    plate_template <- rbind(plate_template, temp)
  }
  
  for(i in seq(1:t)){
    for (d in seq(1:nrow(data))) {
      data[d,i] = plate_template[d,i]
    }
  }
}



tot <- c()
for (i in seq(1:t)) {
 assign(letters[i], as.character(data[,i]))
  tot <- c(tot, as.character(data[,i]))
}

all_combi <- t(combn(tot,2,simplify = TRUE))
colnames(all_combi) <- letters[1:t]
all_combi <- as.data.frame(all_combi)


for (i in seq(1:t)) {
  all_combi <- all_combi[all_combi[,i] %in% eval(parse(text = letters[i])), ]  
}
write.table(all_combi, paste(type,".txt", sep = ""), append = FALSE, sep = ";", dec = ".",
            row.names = FALSE, col.names = TRUE)
browseURL(paste(getwd(),"/",type,".txt", sep = "") )

}