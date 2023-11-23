# 7-segment toki pona

## Goals
1. displayable on a 7-segment display
2. one syllable per character
3. writable by hand
4. reduce ambiguity in both writing and on a display
5. easy to remember
6. minimize strokes per character
7. include as much punctuation as possible for 7-segment displays

---
## a quick note
The summaries are presented at the top as a matter of convenience. I highly recommend reading the explanations that follow in order to understand how the system is put together. Rote memorization would require knowing 69 symbols while understanding the system only really requires 14 (+2 for the flipped variants).

---
## summary table
This table contains all viable variants of toki pona syllables

vowel | . | k | t | p | j | l | w | n | m | s
---   |---|---|---|---|---|---|---|---|---|---
. | | | | | | | | ![n](./sitelen/n.png) |
a |![a](./sitelen/a.png) | ![ka](./sitelen/ka.png) | ![ta](./sitelen/ta.png) | ![pa](./sitelen/pa.png) | ![ja](./sitelen/ja.png) | ![la](./sitelen/la.png) | ![wa](./sitelen/wa.png) | ![na](./sitelen/na.png) | ![ma](./sitelen/ma.png) | ![sa](./sitelen/sa.png)
e (wan) |![e-wan](./sitelen/e-wan.png) | ![ke-wan](./sitelen/ke-wan.png) | ![te-wan](./sitelen/te-wan.png) | ![pe-wan](./sitelen/pe-wan.png) | ![je-wan](./sitelen/je-wan.png) | ![le-wan](./sitelen/le-wan.png) | ![we-wan](./sitelen/we-wan.png) | ![ne-wan](./sitelen/ne-wan.png) | ![me-wan](./sitelen/me-wan.png) | ![se-wan](./sitelen/se-wan.png)
e (tu) |![e-tu](./sitelen/e-tu.png) | ![ke-tu](./sitelen/ke-tu.png) | ![te-tu](./sitelen/te-tu.png) | ![pe-tu](./sitelen/pe-tu.png) | ![je-tu](./sitelen/je-tu.png) | ![le-tu](./sitelen/le-tu.png) | ![we-tu](./sitelen/we-tu.png) | ![ne-tu](./sitelen/ne-tu.png) | ![me-tu](./sitelen/me-tu.png) | ![se-tu](./sitelen/se-tu.png)
i (wan) |![i-wan](./sitelen/i-wan.png) | ![ki-wan](./sitelen/ki-wan.png) | ![ti](./sitelen/ti.png) | ![pi-wan](./sitelen/pi-wan.png) | ![ji-wan](./sitelen/ji-wan.png) | ![li-wan](./sitelen/li-wan.png) | ![wi-wan](./sitelen/wi-wan.png) | ![ni-wan](./sitelen/ni-wan.png) | ![mi-wan](./sitelen/mi-wan.png) | ![si-wan](./sitelen/si-wan.png)
i (tu) |![i-tu](./sitelen/i-tu.png) | ![ki-tu](./sitelen/ki-tu.png) | | | ![ji-tu](./sitelen/ji-tu.png) | ![li-tu](./sitelen/li-tu.png) | ![wi-tu](./sitelen/wi-tu.png) | ![ni-tu](./sitelen/ni-tu.png) | ![mi-tu](./sitelen/mi-tu.png) | ![si-tu](./sitelen/si-tu.png)
o |![o](./sitelen/o.png) | ![ko](./sitelen/ko.png) | ![to](./sitelen/to.png) | ![po](./sitelen/po.png) | ![jo](./sitelen/jo.png) | ![lo](./sitelen/lo.png) | ![wo](./sitelen/wo.png) | ![no](./sitelen/no.png) | ![mo](./sitelen/mo.png) | ![so](./sitelen/so.png)
u |![u](./sitelen/u.png) | ![ku](./sitelen/ku.png) | ![tu](./sitelen/tu.png) | ![pu](./sitelen/pu.png) | ![ju](./sitelen/ju.png) | ![lu](./sitelen/lu.png) | ![wu](./sitelen/wu.png) | ![nu](./sitelen/nu.png) | ![mu](./sitelen/mu.png) | ![su](./sitelen/su.png)

## Concept
The upper four segments on the display are used for the consonant and the lower three are used for the vowel in each syllable. The shapes of each are intentionally selected in an attempt to be unambiguous when written by hand or shown on a 7-segment display. I have included some handwriting examples below to help visualize what it looks like in that context.

Each syllable is to be written from top to bottom. The consonant is on the top and the vowel is on the bottom. This style of writing might flow better if written top-down rather than left-right, however I think either would be acceptable

## Vowels
![Vowel Segments](./sitelen/faded/u.png)

The vowels take up the lower three bars of the seven segment display. This offers 2^3 potential variants of which the blank one is already taken by the `space` character. The remaining seven are _all_ used by the five vowels.

a | e | i | o | u
---|---|---|---|---
![Vowel a wan](./sitelen/faded/a.png) | ![Vowel e wan](./sitelen/faded/e-wan.png) ![Vowel e tu](./sitelen/faded/e-tu.png) | ![Vowel i wan](./sitelen/faded/i-wan.png) ![Vowel i tu](./sitelen/faded/i-tu.png) | ![Vowel o wan](./sitelen/faded/o.png) | ![Vowel u wan](./sitelen/faded/u.png)

![handwritten vowels](sitelen/handwritten-vowels.jpg)

I tried to make them similar to the vowels in romanized languages, but it is somewhat minimal and abstract so you will have to bear with me. I provide as much justification as I can with each.

### a
![Vowel a](./sitelen/faded/a.png)

Imagine the two side-bars of a capitalized "A". In _most_ of the consonants (e.g. "sa"), the center segment is active which helps with visualizing an "A" on the bottom

### e
![Vowel e wan](./sitelen/faded/e-wan.png)
![Vowel e tu](./sitelen/faded/e-tu.png)

Similar to "A", this benefits greatly from having a consonant. Sometimes it looks like a lowercase "e". This can be mirrored in order to reduce the number of strokes required to write the letter, especially in handwriting. Either is acceptable.

### i
![Vowel i wan](./sitelen/faded/i-wan.png)
![Vowel i tu](./sitelen/faded/i-tu.png)

Look it's a little "i"! It also can be mirrored like "e".

### o
![Vowel o](./sitelen/faded/o.png)

This one never really looks like an "O" unfortunately. I remember it because "o" is very _open_ and this representation is the only vowel that is fully separated from all consonants.

### u
![Vowel u](./sitelen/faded/u.png)

This one is likely the easiest to visualize. Although it has the opposite problem of "e" and "a" in that adding consonants can make it appear like an "o". It takes a little bit of focus at first to see beyond that, but I tried to make the combinations in a way that makes it flow smoothly once you are used to it.

## Consonants
sounds made in the back of the mouth are in the left column.

 back |mid |front
 ---|---|---
 k | t | p
 j | l | w
 . | n | m
 . | s | .

 back |mid |front
 ---|---|---
![Consonant k](./sitelen/faded/k.png) | ![Consonant t](./sitelen/faded/t.png) | ![Consonant p](./sitelen/faded/p.png)
![Consonant j](./sitelen/faded/j.png) | ![Consonant l](./sitelen/faded/l.png) | ![Consonant w](./sitelen/faded/w.png)
. | ![Consonant n](./sitelen/faded/n.png) | ![Consonant m](./sitelen/faded/m.png)
. | ![Consonant s](./sitelen/faded/s.png) | .

![handwritten consonants](sitelen/handwritten-consonants.jpg)

### k-t-p
k | t | p
---|---|---
![Consonant k](./sitelen/faded/k.png) | ![Consonant t](./sitelen/faded/t.png) | ![Consonant p](./sitelen/faded/p.png)

- k looks like a "c" in the roman alphabet which can often make a "k" sound
- t looks like a "T" with the right half removed
- p looks like a "P" with the lower half of the lobe removed

### j-l-w
j | l | w
---|---|---
![Consonant j](./sitelen/faded/j.png) | ![Consonant l](./sitelen/faded/l.png) | ![Consonant w](./sitelen/faded/w.png)

- j looks pretty much like a j without the dot
- l looks like an "L"
- w (double-u) looks like a single "u". (i.e. it's half of a "W")

### n-m
n | m
---|---
![Consonant n](./sitelen/faded/n.png) | ![Consonant m](./sitelen/faded/m.png)

both of these characters block airflow and feel somewhat closed because all of the outer segments are filled. 
- n looks like the kanji for "ni" (2) in japanese: 二
- m looks like half of an "m" (it would have been cool to use this for n, but this shape wouldn't work because n and na would become ambiguous in handwriting)

### s
![Consonant s](./sitelen/faded/s.png)

s is kinda its own thing in toki pona as a fricative consonant. I originally wanted to use this shape for a different consonant, but in the end s seemed the most appropriate to me. It's easy to remember because square starts with s.

## Avoiding Ambiguities
I wound up making about 4 iterations of this where I thought I had a great solution but wound up 


## handwritten summary table
almost all of these symbols can be written in 1 or 2 strokes (I am defining a stroke as having to lift your writing implement off the paper). There are only 2 symbols that require 3 strokes: wa, and no.

This table does not include all potential variants within this system, it is just what felt the most natural to me while writing since I feel like that is what would be preferred in general for a writing system.

![handwritten summary table](./sitelen/handwritten-full.png)

## punctuation
period: ![period](sitelen/faded/period.png)

quote: ![quote](sitelen/faded/quote.png)

question: ![question](sitelen/faded/question.png)

---
## Inspiration

- https://github.com/abalidoth/sitelen_palisa
- 7-segment images generated using GeoGachingToolbox.com under CC-by-nc-nd 3.0: https://www.geocachingtoolbox.com/index.php?lang=en&page=segmentDisplay