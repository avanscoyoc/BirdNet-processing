## Extract Survey Length Metadata from Bird Audio files

Background:
Often acoustic surveys will include thousands of hours of audio files across many sites. Usually bird survey recording devices are programed to be synched to start and stop on pre-determined dates. However, due to issues with data recorders, such as battery issues, or unpredictable weather events, rain, damage, or human tampering, the actual survey start and end times might be different between sites. 

Goal: This code snippet loops through your audio file directory and extracts the earliest file start date and latest file end date to generate a dataframe of suvey start/end times by site. This dataframe can then be used to accounting for suvey problems or differences in survey effort in occupancy models for birds. 

#### Load libraries and set initial parameters


```python
import pandas as pd 
import os
import glob 
import datetime
```

Ensure you are in the correct working directory for accessing your files. 


```python
#check current directory
os.getcwd()
```




    '/Users/amy'



Load the directory with bird files and initiated a site name list, start date list, and end date list for storing the values from each file's metadata. 


```python
#set up directories and lists
all_folders = os.listdir('/Volumes/ExtremeSSD/Mojave/Birds')
site = []
start = []
end = []
```

#### Date extraction

In order to assess the exact of the acoustic survey at each site, loop through each .wav file in each site folder, get the earliest file creation date and the latest file end date. Ignore any folders with different file types and report those sites as NA (several audio files were made using older SM3 recording devices which we will ignore for this analysis). Append each site's survey start and survey end dates to a single dataframe


```python
#for each site's acoustic survey files, identify the first start time and last end time
for folder in all_folders:
    v1 = os.path.basename(folder) #get siteID
    site.append(v1) #append siteID
    folder_path = '/Volumes/ExtremeSSD/Mojave/Birds/' + folder #get folder path
    file_type = '/*.WAV' #use .wav files 
    files = glob.glob(folder_path + file_type) #choose only .wav files in each folder
    if len(files) == 0: #if there are no files, as with SM3s leave as NA and move on
        v2 = 'SM3'
        v3 = 'NA'
        start.append(v2)
        end.append(v3)
    else:
        #otherwise get the first file creation datetime
        v2 = datetime.datetime.fromtimestamp(os.stat(min(files, key=os.path.getctime)).st_birthtime)
        #and the last file modified (aka end) datetime
        v3 = datetime.datetime.fromtimestamp(os.stat(max(files, key=os.path.getmtime)).st_mtime)
        start.append(v2) #append min date
        end.append(v3) #append max date

#put in dataframe
d = pd.DataFrame() 
d['site_id'] = site
d['survey_start'] = start
d['survey_end'] = end

#write to csv
d.to_csv("/Users/amy/Desktop/bird_survey_datetime.csv", index=False) #save to .csv file
```

Done! You've created a file of exact survey start and end times by site. 
