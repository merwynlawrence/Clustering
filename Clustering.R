#Read the data file
cost_data <- read.csv("costpercompany.csv", header= TRUE)

#Inspect the dataset
names(cost_data) 

# > names(cost_data) 
# [1] "Company"      "surcharges"   "RoR"          "dailycost"    "costwithload" "costofDemand"
# [7] "Sales"        "WearandTear"  "Fcost"  

head(cost_data) 


# head(cost_data) 
# Company surcharges   RoR dailycost costwithload costofDemand Sales WearandTear Fcost
# 1   Yashida       2.70  9.36       222         12.1         12.9 32721        12.3 1.908
# 2 Wisconsin       1.20 11.80       148         59.9          3.5  7287        41.1 0.702
# 3  Virginia       1.07  9.30       174         54.3          5.9 10093        26.6 1.306
# 4    United       1.04  8.60       204         61.0          3.5  6650         0.0 2.116
# 5     Texas       1.16 11.70       104         54.0         -2.1 13507         0.0 0.636
# 6  Southern       1.05 12.60       150         56.7          2.7 10140         0.0 1.108

tail(cost_data) 

# #tail(cost_data) 
# Company surcharges   RoR dailycost costwithload costofDemand Sales WearandTear Fcost
# 24 Commonwealth       1.02 11.20       168         56.0          0.3  6423        34.3 0.700
# 25     Central        1.43 15.40       113         53.0          3.4  9212         0.0 1.058
# 26       CA Gas       1.95  1.86        49        -39.4          6.4 15280        12.3 1.140
# 27           BP       3.90 21.16       370         72.0         16.4 40008        53.4 2.610
# 28      Boston        0.89 10.30       202         57.9          2.2  5088        25.3 1.555
# 29     Arizona        1.06  9.20       151         54.4          1.6  9077         0.0 0.628
# > 


summary(cost_data) 


str(cost_data)



#Check the dimension and number of points of the "cost_data" dataset
nrow(cost_data) 
# 29 rows

ncol(cost_data) 
# 9 columns

dim(cost_data)
# 29 x 9

#cluster package is a powerful tool for cluster analysis

install.packages("cluster") # install "cluster" package 
library(cluster) # activate "cluster" package


pairs(cost_data)

plot(Fcost~ Sales, data = cost_data)
with(cost_data,text(Fcost ~ Sales, labels= Company))     #the following line of code to see the names of the companies


plot(Fcost~ Sales, data = cost_data)
with(cost_data,text(Fcost ~ Sales, labels= Company,pos=4,cex=.6))


# #normalise function
# Normalization of the dataset is among the preprocessing processes in data exploration, 
#in which the attribute data are scaled to fall in a small specified range.
normalise <- function(df)
{
  return(((df- min(df)) /(max(df)-min(df))*(1-0))+0)
}


company<-cost_data[,1]
cost_data_n<-cost_data[,2:9] #remove company column before normalise 
cost_data_n<-as.data.frame(lapply(cost_data_n,normalise)) 
cost_data_n$Company<-company #add company column after normalise


#rearrange the columns in the dataset after normalising 
cost_data_n<-cost_data_n[,c(9,1,2,3,4,5,6,7,8)]

head(cost_data_n)



#calculate the distance matrix using Euclidean Distance.

distance <- dist(cost_data_n,method = "euclidean",)

print(distance, digits=3)


#Visualise the distance matrices using a function called fviz_dist() in factoextra package
library(factoextra)
fviz_dist(distance)

#The colour level is proportional to the value of the dissimilarity between observations
# Red: high similarity (ie: low dissimilarity)
# Blue: low similarity
# 



#inspect the first few observations 
head(cost_data_n)

#Set company names as row names
rownames(cost_data_n)<-cost_data_n$Company

#remove Company column from the dataset
cost_data_n$Company<-NULL


head(cost_data_n)

distance <- dist(cost_data_n,method = "euclidean") 
fviz_dist(distance)


################################################

#####K Means Clustering######

kc<-kmeans(cost_data[,-1],3) #k=3
kc

#The result can be plotted using the clusplot() function
clusplot(cost_data, kc$cluster, color=TRUE, shade=TRUE, lines=0)
