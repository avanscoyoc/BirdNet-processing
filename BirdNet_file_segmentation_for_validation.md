## Bird Acoustic Data Segmentation

Background: 
We collected acoustic data across 67 sites in the Mojave desert in 2023. Recordings were taken during the peak breeding season (May 20-28th). Acoustic Recordings were collected using Audiomoths deployed at each site for a minimum of 5 days. Audiomoths were programmed to record audio from 8pm to 9am each day to capture night calling birds and the dawn chorus. 4TB of acoustic recordings were collected and run through the BirdNet algorithm to produce a dataframe of species auto-classifications. We must validate the accuracy of these auto-classifications by listening to at least 50 calls segments for each species. 

Objective: 
To avoid scrolling to each timestamp in several thousand audio files across sites and species, here, I segment ~4 TB of bird call audio into 5-second clips and store clips in folders by species name for a quick manual validation.

#### Load Libraries


```python
from pydub import AudioSegment
import os
import pandas as pd
```

After loading packages, I set and check the working directory to the bird audio data.  


```python
os.chdir('/Volumes/ExtremeSSD/')
os.getcwd()
```




    '/Volumes/ExtremeSSD'



#### Segmentation Function

This function loads the data (`table_path`) which contains the BirdNet species assignment (`Common.Name`), original corresponding file name and site (`Begin.File`), and timestamps corresponding to the call clip within each 9-hour file (`Begin.Time..s.`). The function grabs the raw audio file, extracts 5-second clips of audio at the timestamp, and stores each clip with a unique ID in a folder it creates for all clips of that species. 


```python
def segment_wav(input_root_folder, output_root_folder, table_path):
    # Load the table of IDs, species names, start times, and file names from a CSV file
    table = pd.read_csv(table_path)  # Assuming a comma-separated CSV file

    for _, row in table.iterrows():
        subfolder_name = row['site']
        species_code = row['Species.Code']
        species_name = row['Common.Name']
        file_name = row['Begin.File']
        start_time = int(row['Begin.Time..s.']) * 1000  # Convert start time to milliseconds
        segment_id = row['ID']

        # Construct the full path to the input WAV file
        input_file_path = os.path.join(input_root_folder, subfolder_name, file_name)

        # Load the audio file using pydub
        audio = AudioSegment.from_wav(input_file_path)

        # Extract a 5-second segment starting from the specified time
        segment = audio[start_time:start_time + 5000]

        # Construct the output folder path based on the 'species_name' column
        output_folder_path = os.path.join(output_root_folder, species_name)

        # Ensure the output folder exists, create if necessary
        os.makedirs(output_folder_path, exist_ok=True)

        # Construct the output file path using the 'ID' column
        output_file_path = os.path.join(output_folder_path, f"{species_code}_{segment_id}.wav")

        # Export the segment as a new WAV file
        segment.export(output_file_path, format="wav")
```

After defining the function to segment the audio and assign segments to named folders, I set the input and output folders and run the function on the raw data. 


```python
if __name__ == "__main__":
    # Specify the input root folder containing the WAV files
    input_root_folder = "/Volumes/ExtremeSSD/Mojave/birds"

    # Specify the output root folder for the segmented clips
    output_root_folder = "/Volumes/ExtremeSSD/mojave_2016_birds_to_vet/"

    # Specify the path to the CSV table of IDs, species names, start times, and file names
    table_path = "/Volumes/ExtremeSSD/mojave_2016_birds_to_vet.csv"

    # Call the function to perform segmentation
    segment_wav(input_root_folder, output_root_folder, table_path)
```

There you have it! The audio segments can now be quickly validated in a 5-second playlist format by species. This significantly speeds up audio validation to avoid scrolling through several thousands of hours of audio across many species. 
