#:# libraries
library(digest)
library(OpenML)
library(mlr)

#:# config
set.seed(1)

#:# data
data <- getOMLDataSet(data.id = 161L)
df <- data$data
head(df)

#:# preprocessing
head(df)

#:# model
classif_task = makeClassifTask(id = "task", data = df, target = "class")
classif_lrn = makeLearner("classif.gbm", predict.type = "prob")

#:# hash 
#:# 966276d98912899965b895ec20646175
hash <- digest(list(classif_task, classif_lrn))
hash

#:# audit
cv <- makeResampleDesc("CV", iters = 5)
r <- resample(classif_lrn, classif_task, cv, measures = list(acc, auc, tnr, tpr, ppv, f1))
measure <- r$aggr
measure

#:# session info
sink(paste0("sessionInfo.txt"))
sessionInfo()
sink()
