# gogoSplit
zsh script that splits an mp3 into segments using ffmpeg. The output files are formatted in a nice way.

## Usage
### Example:

`gogoSplit.zsh myAudioFile.mp3`

### Output
This will create a directory called `myAudioFile` which will contain files `myAudioFile<index>.mp3`. The original mp3 is preserved.

### Adjustment 
By default, the mp3 file is split into segments of 90 minutes. This can be adjusted by changing the `segmentDuration` variable.


## Future
For audio files that feature chapter metadata, the script could split them into chapters instead of segments of equal length.

Chapter metadata can be detected using ffprobe. In case no such data is present, the file could still be split into segments like it does currently.
