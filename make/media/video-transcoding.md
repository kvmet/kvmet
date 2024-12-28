---
layout: default
title: Video Transcoding
---

# Video Transcoding

My general goal for video transcoding is  
to archive my personal media. I do not  
aim for a lossless conversion but I  
choose what level of conversion to do  
based on how much of the original that I
want to preserve.

- [Descriptors](#descriptors)
- [Presets](#presets)
- [Audio](#audio)
- [Subtitles](#subtitles)

## Descriptors

### Codec

I've chosen to use AV1 for my encoding  
because it has an increasing amount of  
support and I expect it to be readily  
available in the future since it is open
source.

- `AV1` - SVT-AV1-PSY

### Resolution

These resolutions are based on 16:9. I  
generally choose to crop black bars so  
the final resolution and aspect ratio  
may be different than listed below.

- `SD` - Under 720p
- `HD` - 720p & 900p
- `2K` - FHD (1080p)
- `4K` - UHD 4K (2160p)
- `5K` - UHD 5K (2880p)
- `8K` - UHD 8K (4320p)
- `16K` - UHD 16K (8640p)

### Media Type

- `Grainy` - Media with film grain
- `Anime` - 2D Animation
- `CG` - 3D Animation
- `Live` - Live-action

### Levels

- `Insane`
    - Imperceptible flaws
- `Standard`
    - No flaws during playback
- `Economy`
    - Optimized for encode size & time

## Presets

### AV1 2K Grainy Anime Insane

For 1080p 2D animation with film grain.

#### Options

```
--rc 0 --crf 12 --progress 3 --tune 3  
--preset 4 --variance-boost-strength 3
--variance-octile 2 --film-grain 6 
--frame-luma-bias 80 --chroma-qm-min 0
```

#### Performance 

- Speed: ~0.6x (i7 15th gen)
- Size: ~0.75x (vs h.264 lossless)

#### Notes

- CRF 12
    - Seems a little high but the dynamic<br/>settings will boost when needed.
- Preset 4
    - Good balance between encode speed<br/>and quality.
- Tune 3
    - Perceptive SSIM tune
- Variance Boost 3
- Variance Octile 2/8
    - Quite aggressive. Will result in<br/>a lot of false positives but<br/>reduces chance of artifacts.
- Film Grain 6
    - Adjust this to match source.


#### Notes

### AV1 HD Anime Standard

### AV1 HD Anime Economy

## Audio

## Subtitles
