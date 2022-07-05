#!/usr/bin/env python
# coding: utf-8

# In[4]:


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


# In[ ]:





# In[6]:


pip install mplsoccer


# In[8]:


from mplsoccer.pitch import Pitch


# In[24]:


data = pd.read_csv("k_means.csv")


# In[25]:


data.head(10)


# In[36]:


df = data[['team', 'type', 'location', 'pass_end_location']]


# In[37]:


df.head()


# In[38]:


df = df[(df['team']=='France') & (df['type']=='Pass')].reset_index()


# In[39]:


df.head()


# In[40]:


# 


# In[41]:


df[['x','y']] = df.location.str.split(expand=True)
df[['endx','endy']] = df.pass_end_location.str.split(expand=True)


# In[42]:


df.head()


# In[43]:


df['x'] = df.loc[:,'x'] = df.x.map(lambda x: x[1:-1]).astype(float)
df['y'] = df.loc[:,'y'] = df.y.map(lambda x: x[0:-1]).astype(float)
df['endx'] = df.loc[:,'endx'] = df.endx.map(lambda x : x[1:-1]).astype(float)
df['endy'] = df.loc[:,'endy'] = df.endy.map(lambda x : x[0:-1]).astype(float)


# In[44]:


df = df.drop(['location','pass_end_location'], axis=1)


# In[45]:


df.head()


# In[47]:


# kmeans clustering
from sklearn.cluster import KMeans

x = np.array(df[['x','y','endx','endy']])
kmeans = KMeans(n_clusters = 5, random_state=100)
kmeans.fit(x)
df['cluster'] = kmeans.predict(x)


# In[48]:


df.head()


# In[49]:


df.cluster.value_counts()


# In[56]:


from mplsoccer.pitch import Pitch
fig, ax = plt.subplots(figsize=(10,10))
pitch = Pitch(pitch_color='grass', line_color='white', stripe=True)

pitch.draw(ax=ax)

for x in range(len(df['cluster'])):
    if df['cluster'][x] == 0:
        pitch.lines(xstart=df['x'][x], ystart=df['y'][x], xend=df['endx'][x], yend=df['endy'][x],
                   color='#74c69d', lw=3, zorder =2, comet=True, ax=ax )
        
    if df['cluster'][x] == 1:
        pitch.lines(xstart=df['x'][x], ystart=df['y'][x], xend=df['endx'][x], yend=df['endy'][x],
                   color='purple', lw=3, zorder =2, comet=True, ax=ax )
        
    if df['cluster'][x] == 2:
        pitch.lines(xstart=df['x'][x], ystart=df['y'][x], xend=df['endx'][x], yend=df['endy'][x],
                   color='yellow', lw=3, zorder =2, comet=True, ax=ax )
        
    if df['cluster'][x] == 3:
        pitch.lines(xstart=df['x'][x], ystart=df['y'][x], xend=df['endx'][x], yend=df['endy'][x],
                   color='blue', lw=3, zorder =2, comet=True, ax=ax )
        
    if df['cluster'][x] == 4:
        pitch.lines(xstart=df['x'][x], ystart=df['y'][x], xend=df['endx'][x], yend=df['endy'][x],
                   color='red', lw=3, zorder =2, comet=True, ax=ax )
    


# In[ ]:




