#!/usr/bin/env python
# coding: utf-8

# # K Means Clustering

# In[2]:


import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.cluster import KMeans


# In[3]:


# loading data from csv to pd dataframe (Mall_Customers.csv downloaded from Kaggle)

customer_data = pd.read_csv("Mall_Customers.csv")


# In[4]:


# inspect the data
customer_data.head(5)


# In[5]:


#finding the no of rows and dloumns
customer_data.shape


# In[6]:


customer_data.info()


# In[7]:


# inspecting missing values
customer_data.isnull().sum()


# In[48]:


#the above output shows nomissing values


# In[8]:


x = customer_data.iloc[:,[2,4]].values


# In[129]:


#scaling
#from sklearn.preprocessing import StandardScaler

#scalar = StandardScaler()
#x = scalar.fit_transform(x.reshape(1,-1))


# In[9]:


print(x)


# # Finding the value of k using Elbow Method

# In[10]:


# finding the (value of k )number of clusters  using WSS method

wcss = []

for i in range(1,11):
    kmeans = KMeans(n_clusters=i, init='k-means++', random_state=42)
    kmeans.fit(x)
    wcss.append(kmeans.inertia_)


# In[13]:


#inspecting wcss
wcss


# In[12]:


# plotting the wcss graph

sns.set()
plt.plot(range(1,11), wcss)
plt.title("The Elbow Method Graph")
plt.xlabel("Number of CLuster")
plt.ylabel("WCSS")
plt.show()


# In[134]:


# the graph shows that the optimum number of custers is 5


# # K Means 

# In[14]:


kmeans = KMeans(n_clusters = 5, init =  'k-means++', random_state=0)


# In[15]:


Y =  kmeans.fit_predict(x)


# In[16]:


#append the dataframe with the cluster column
customer_data['cluster'] = Y


# In[17]:


customer_data.head(10)


# In[18]:


customer_data['cluster'].value_counts()


# # Visualization

# In[19]:


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


# # Creating Multiple Clusters

# In[23]:


for k in range (1,6):
    kmeans = KMeans(n_clusters = k)
    kmeans.fit(customer_data[['Age','Spending Score (1-100)']])
    customer_data[f'KMeans_{k}'] =kmeans.labels_


# In[24]:


customer_data


# In[28]:


fig, axs =plt.subplots(nrows=1, ncols=5, figsize=(20,5))

for i, ax in enumerate(fig.axes, start=1):
    ax.scatter(x=customer_data['Age'], y= customer_data['Spending Score (1-100)'], c=customer_data[f'KMeans_{i}'])
    ax.set_ylim(0,100)
    ax.set_xlim(0,80)
    ax.set_title(f'N Clusters: {i}''')


# In[ ]:




