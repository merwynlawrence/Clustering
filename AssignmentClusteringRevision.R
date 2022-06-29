library(cluster)
library(rio)
library(DataExplorer)
library(ggplot2)
library(factoextra)
library(stats)
library(dplyr)
install.packages("ggstatsplot")
library(ggstatsplot)

2ds <-read.csv("Assignment_Clustering.csv", header=T)

dim(ds)
names(ds)
summary(ds)

#Cleaning names
install.packages("janitor")
install.packages("janitor")
install.packages("devtools")
devtools::install_github("sfirke/janitor")

library(janitor)
ds <-ds %>% janitor::clean_names()

summary(ds)


#We observe a lot of NA values in all columns of the dataset
#Removing NA rows

ds<-ds[!is.na(ds$number_of_hospitalization),]
ds<-ds[!is.na(ds$hospitalization_crude_rate_per_10_000),]
ds<-ds[!is.na(ds$hospitalization_age_adjusted_rate_per_10_000),]
ds<-ds[!is.na(ds$number_of_ed_visits),]
ds<-ds[!is.na(ds$ed_visit_crude_rate_per_10_00),]
ds<-ds[!is.na(ds$ed_visit_age_adjusted_rate_per_10_000),]

summary(ds)#Now there are no NA values

view(ds)


#####################################################################
#17012021
#Removing outliers
#5.number_of_ed_visits
boxplot(ds$number_of_ed_visits)

#find the values of the outliers
outlier_values<- boxplot.stats(ds$number_of_ed_visits)$out

#find the upper outliers
upper_outliers<- outlier_values[outlier_values>mean(ds$number_of_ed_visits)]
upper_outliers

#find the lower outliers
lower_outliers<- outlier_values[outlier_values<mean(ds$number_of_ed_visits)]
lower_outliers

#replace the upper and lower outliers with the upper and lower whisker values respectively

ds$number_of_hospitalization[upper_outliers]<-boxplot.stats(ds$number_of_hospitalization)$stats[5]
ds$number_of_hospitalization[lower_indices]<-boxplot.stats(ds$number_of_hospitalization)$stats[1]


#find the indices that correspond to upper and lower outliers
upper_indices<- which(ds$number_of_ed_visits %in% upper_outliers)
lower_indices<- which(ds$number_of_ed_visits %in% lower_outliers)

#replace the upper and lower outliers with the upper and lower whisker values respectively
ds$number_of_ed_visits[upper_indices]<-boxplot.stats(ds$number_of_ed_visits)$stats[5]
ds$number_of_ed_visits[lower_indices]<-boxplot.stats(ds$number_of_ed_visits)$stats[1]


#check if any outiers in boxplot
boxplot(ds$number_of_ed_visits)

#result shows the outliers have been removed. This method is called winsorizing 
#ie Winsorizing replaces outliers with the values of the closest whisker.

summary(ds)

######

#2.number_of_hospitalization
boxplot(ds$number_of_hospitalization)

#find the values of the outliers
outlier_values<- boxplot.stats(ds$number_of_hospitalization)$out

#find the upper outliers
upper_outliers<- outlier_values[outlier_values>mean(ds$number_of_hospitalization)]


#find the lower outliers
lower_outliers<- outlier_values[outlier_values<mean(ds$number_of_hospitalization)]

#find the indices that correspond to upper and lower outliers
upper_indices<- which(ds$number_of_hospitalization %in% upper_outliers)
lower_indices<- which(ds$number_of_hospitalization %in% lower_outliers)

#replace the upper and lower outliers with the upper and lower whisker values respectively
ds$number_of_hospitalization[upper_indices]<-boxplot.stats(ds$number_of_hospitalization)$stats[5]
ds$number_of_hospitalization[lower_indices]<-boxplot.stats(ds$number_of_hospitalization)$stats[1]


boxplot(ds$number_of_hospitalization)

summary(ds)


##########
#3.hospitalization_crude_rate_per_10_000
boxplot(ds$hospitalization_crude_rate_per_10_000)

#find the values of the outliers
outlier_values<- boxplot.stats(ds$hospitalization_crude_rate_per_10_000)$out


#find the upper outliers
upper_outliers<- outlier_values[outlier_values>mean(ds$hospitalization_crude_rate_per_10_000)]


#find the lower outliers
lower_outliers<- outlier_values[outlier_values<mean(ds$hospitalization_crude_rate_per_10_000)]



#find the indices that correspond to upper and lower outliers
upper_indices<- which(ds$hospitalization_crude_rate_per_10_000 %in% upper_outliers)
lower_indices<- which(ds$hospitalization_crude_rate_per_10_000 %in% lower_outliers)


#replace the upper and lower outliers with the upper and lower whisker values respectively
ds$hospitalization_crude_rate_per_10_000[upper_indices]<-boxplot.stats(ds$hospitalization_crude_rate_per_10_000)$stats[5]
ds$hospitalization_crude_rate_per_10_000[lower_indices]<-boxplot.stats(ds$number_of_hospitalization)$stats[1]


boxplot(ds$hospitalization_crude_rate_per_10_000)

summary(ds)

##################

#4.hospitalization_age_adjusted_rate_per_10_000
boxplot(ds$hospitalization_age_adjusted_rate_per_10_000)

#find the values of the outliers
outlier_values<- boxplot.stats(ds$hospitalization_age_adjusted_rate_per_10_000)$out


#find the upper outliers
upper_outliers<- outlier_values[outlier_values>mean(ds$hospitalization_age_adjusted_rate_per_10_000)]


#find the lower outliers
lower_outliers<- outlier_values[outlier_values<mean(ds$hospitalization_age_adjusted_rate_per_10_000)]


#find the indices that correspond to upper and lower outliers
upper_indices<- which(ds$hospitalization_age_adjusted_rate_per_10_000 %in% upper_outliers)
lower_indices<- which(ds$hospitalization_age_adjusted_rate_per_10_000 %in% lower_outliers)

#replace the upper and lower outliers with the upper and lower whisker values respectively
ds$hospitalization_age_adjusted_rate_per_10_000[upper_indices]<-boxplot.stats(ds$hospitalization_age_adjusted_rate_per_10_000)$stats[5]
ds$hospitalization_age_adjusted_rate_per_10_000[lower_indices]<-boxplot.stats(ds$hospitalization_age_adjusted_rate_per_10_000)$stats[1]


boxplot(ds$hospitalization_age_adjusted_rate_per_10_000)

summary(ds)

###
#6.ed_visit_crude_rate_per_10_000
boxplot(ds$ed_visit_crude_rate_per_10_000)

#find the values of the outliers
outlier_values<- boxplot.stats(ds$ed_visit_crude_rate_per_10_000)$out

#find the upper outliers
upper_outliers<- outlier_values[outlier_values>mean(ds$ed_visit_crude_rate_per_10_000)]


#find the lower outliers
lower_outliers<- outlier_values[outlier_values<mean(ds$ed_visit_crude_rate_per_10_000)]


#find the indices that correspond to upper and lower outliers
upper_indices<- which(ds$ed_visit_crude_rate_per_10_000 %in% upper_outliers)
lower_indices<- which(ds$ed_visit_crude_rate_per_10_000 %in% lower_outliers)


#replace the upper and lower outliers with the upper and lower whisker values respectively
ds$ed_visit_crude_rate_per_10_000[upper_indices]<-boxplot.stats(ds$ed_visit_crude_rate_per_10_000)$stats[5]
ds$ed_visit_crude_rate_per_10_000[lower_indices]<-boxplot.stats(ds$ed_visit_crude_rate_per_10_000)$stats[1]


boxplot(ds$ed_visit_crude_rate_per_10_000)

summary(ds)

####
#7.ed_visit_age_adjusted_rate_per_10_000
boxplot(ds$ed_visit_age_adjusted_rate_per_10_000)

#find the values of the outliers
outlier_values<- boxplot.stats(ds$ed_visit_age_adjusted_rate_per_10_000)$out

#find the upper outliers
upper_outliers<- outlier_values[outlier_values>mean(ds$ed_visit_age_adjusted_rate_per_10_000)]


#find the lower outliers
lower_outliers<- outlier_values[outlier_values<mean(ds$ed_visit_age_adjusted_rate_per_10_000)]



#find the indices that correspond to upper and lower outliers
upper_indices<- which(ds$ed_visit_age_adjusted_rate_per_10_000 %in% upper_outliers)
lower_indices<- which(ds$ed_visit_age_adjusted_rate_per_10_000 %in% lower_outliers)

#replace the upper and lower outliers with the upper and lower whisker values respectively
ds$ed_visit_age_adjusted_rate_per_10_000[upper_indices]<-boxplot.stats(ds$ed_visit_age_adjusted_rate_per_10_000)$stats[5]
ds$ed_visit_age_adjusted_rate_per_10_000[lower_indices]<-boxplot.stats(ds$ed_visit_age_adjusted_rate_per_10_000)$stats[1]


boxplot(ds$ed_visit_age_adjusted_rate_per_10_000)

summary(ds)



################

##################
#move town column in new ds
town<-ds[, c(1)]
View(town)




#removing 1st column of the table as it is a categorical data names of town
#cluster analysis is a branch of unsupervised learning hence we need unlabelled data
ds<- ds[, c(-1)]


summary(ds)


########################################
########################################
########################################
scaled_ds <- scale(ds)

view(scaled_ds)

fitK <- kmeans(scaled_ds,3)
fitK
str(fitK)
view(ds)
plot(ds, col = fitK$cluster)


#################################################
#create a scatter plot to compare the variables

pairs(ds)

head(ds)

#relationship between number of hospitalization vs crude rate per 10000
plot(number_of_hospitalization ~ number_of_ed_visits, data= ds)

#relation of towns with each other
with(ds, text(number_of_hospitalization ~ number_of_ed_visits, labels=town))


#remove overlap of names
with(ds, text(number_of_hospitalization ~ number_of_ed_visits, 
              labels=town, pos=4, cex=0.9))


#normalization function df

norm <- function(df)
{
  return(((df-min(df))/(max(df)-min(df))*(1-0))+0)
}

head(ds)

#converting columns to dataframe
ds_n <-as.data.frame(lapply(ds, norm))


ds_n$town <-town

view(ds_n)

#rearranging the columns in dataset

ds_normalized <-ds_n[, c(7, 1,2,3,4,5,6)]
head(ds_normalized)


#eucledean distance
E_dist <-dist(ds_n, method = "euclidean", )


print(E_dist, digits=3)




#vizualizing the distance matrices using fviz function
fviz_dist(E_dist)
#red shows high similarity
#blue shows high dissimilarity

#hopkins statistics
clust_tend <- get_clust_tendency(ds, 30, graph = TRUE) 
clust_tend$hopkins_stat

###kmeans clustering
k <- kmeans(ds[,-1], 3)
k


##plotting the results
clusplot(ds, k$cluster, color= TRUE, shade = TRUE, lines=0)

# Add clusters to the original dataset
ds_n$clusters <- k$cluster




cluster1 <- ds_n[ds_n$clusters == 1, ] 
unique(cluster1$town)

cluster2 <- ds_n[ds_n$clusters == 2, ] 
unique(cluster2$town)

cluster3 <- ds_n[ds_n$clusters == 3, ] 
unique(cluster3$town)

names(ds_n)

ds_n <-  
  # Cluster statistics
  clus_stat <- ds_n %>% group_by(clusters) %>% 
  summarise_all("mean")
clus_stat
