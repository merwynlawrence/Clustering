#!/usr/bin/env python
# coding: utf-8

# In[42]:


import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.cluster import KMeans


# In[43]:


# loading data from csv to pd dataframe (Mall_Customers.csv downloaded from Kaggle)

customer_data = pd.read_csv("Mall_Customers.csv")


# In[44]:


# inspect the data
customer_data.head(5)


# In[45]:


#finding the no of rows and dloumns
customer_data.shape


# In[46]:


customer_data.info()


# In[47]:


# inspecting missing values
customer_data.isnull().sum()


# In[48]:


#the above output shows nomissing values


# In[94]:


x = customer_data.iloc[:,[3,4]].values


# In[95]:


# finding the (value of k )number of clusters  using WSS method

wcss = []

for i in range(1,11):
    kmeans = KMeans(n_clusters=i, init='k-means++', random_state=42)
    kmeans.fit(x)
    wcss.append(kmeans.inertia_)


# In[96]:


wcss


# In[97]:


# plotting the wcss graph

sns.set()
plt.plot(range(1,11), wcss)
plt.title("The Elbow Method Graph")
plt.xlabel("Number of CLuster")
plt.ylabel("WCSS")
plt.show()


# In[98]:


# the graph shows that the optimum number of custers is 5


# In[99]:


kmeans = KMeans(n_clusters = 5, init =  'k-means++', random_state=0)


# In[ ]:





# In[100]:


Y =  kmeans.fit_predict(x)


# In[101]:


#append the dataframe with the cluster column
customer_data['cluster'] = Y


# In[102]:


customer_data.head(10)


# In[103]:


#Visualizing the CLusters

plt.figure(figsize=(10,10))
plt.scatter(x[Y==0,0], x[Y==0,1], s= 50, c='green')
plt.scatter(x[Y==1,0], x[Y==1,1], s= 50, c='yellow')
plt.scatter(x[Y==2,0], x[Y==2,1], s= 50, c='blue')
plt.scatter(x[Y==3,0], x[Y==3,1], s= 50, c='red')
plt.scatter(x[Y==4,0], x[Y==4,1], s= 50, c='black')

# Plotting the centroids
plt.scatter(kmeans.cluster_centers_[:,0], kmeans.cluster_centers_[:,1], s= 100, c='magenta')

#title
plt.title("Customer Groups")
plt.xlabel("Annual Income")
plt.ylabel("Spending Score")
plt.show()


# In[ ]:




