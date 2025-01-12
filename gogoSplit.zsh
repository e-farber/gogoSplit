#!/bin/zsh
set -e

# Duration of individual segments in seconds.
# Modify this to adjust the duration of the produced files.
segmentDuration=$((60 * 90))

# Function to round up a floating-point number.
roundUp () { x=$1; echo ${$((x + 1))%.*}}

# Check if file exists.
file=$1
if ! [[ -f "$file" ]]; then
  echo ⚡ "File not found:" "$file"
  exit 1
fi

# Name of output directory and files.
output=${file%.*}
# Duration of individual segments in hours (for printing).
segmentHours=$((segmentDuration/3600.))
    # Strip '.' if there are no decimal digits.
if [[ "${segmentHours:0-1}" == "." ]]; then segmentHours=${segmentHours%.*}; fi
# Duration of input file in seconds.
duration=$(ffprobe -i "$file" -show_entries format=duration -v quiet -of csv="p=0")
# Amount of expected output files.
amount=$(roundUp $(( $duration / $segmentDuration )) )
# Specifies zero padding for output files.
format="0${#amount}d"

echo "Splitting:" "$file"
echo "Output:   " "$amount" "segments of" "$segmentHours"'h'
echo "Directory:" "$output"

# Split the file into segments using ffmpeg.
mkdir "$output"
mv "$file" "$output"
cd "$output"
ffmpeg -hide_banner -loglevel error  \
    -i "$file" -f segment -segment_time $segmentDuration \
    -segment_start_number 1 -c copy "$output"%"$format".mp3
mv "$file" ..

echo -e "\nSuccessful."
exit 0

