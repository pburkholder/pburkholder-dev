---
layout: post
title: Challenging stop sign photo citation
meta_description: Using FFMPEG to generate timestamped screenshots to challenge a photo violation
author: peter_burkholder
date: '2023-01-16'
categories: tech
---

This week we got a photo violation notice from 
DC Department of Transportation, for an alleged stop
sign violation, for $100. Ugh.

Fortunately, DC now offers video downloads of the alleged
infraction, and it clearly shows the Subaru coming a full
stop for a second or two before making a right turn. Yes,
it would be better if the stop were in front of the
marking, instead of astride it, but the "full stop" is
worth an argument.

Now, I can't really expect an examiner to go and download
the video, so I'll send them screenshots. Thanks to 
[FFMPEG](http://ffmpeg.org/), I can pretty quickly extract
thumbnails with timestamps.

The command:

```
input_file='DC-Xmas-Eve.mp4'
resolution=400x300
frame_rate=15
frames=50
starting_time=00:00:05

ffmpeg -i $input_file -s $resolution -ss $starting_time -frames $frames \
  -vf drawtext="rate=${frame_rate}:fontsize=15:fontfile=/Library/Fonts/DroidSansMono.ttf:\ timecode='00\:00\:00\:00':text='T\:':fontsize=72:fontcolor='white':\ boxcolor=0x000000AA:box=1:x=860-text_w/2:y=960" \
  thumbnail%03d.jpg
```

The framerate is available from VLC with the menu option Window -> Media Information,
for the CLI with `ffprobe -show_entries format=duration file.mp4`

That made way too many images, so I put it in a loop, then made some title slides, and used 
Preview to put them all together. 

Here's the loop:

```
for i in 05 06 07 08; do
   starting_time=00:00:$i
   frames=15
   ffmpeg -i $input_file -s $resolution -ss $starting_time -frames $frames \
     -vf drawtext="rate=${frame_rate}:fontsize=15:fontfile=/Library/Fonts/DroidSansMono.ttf:\ timecode='00\:00\:00\:00':text='T\:':fontsize=72:fontcolor='white':\ boxcolor=0x000000AA:box=1:x=860-text_w/2:y=960" \
     $i-thumbnail%03d.jpg
done
```

## End result

![Print out with coffee cup](/assets/img/xmas-eve-print.jpg)


## References

I didn't figure this out myself. Props to
https://stackoverflow.com/questions/3169916/can-ffmpeg-burn-in-time-code