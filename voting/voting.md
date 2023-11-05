---
title: Voting Systems
---

The goal of this is to create a generalized voting system definition with the intent to eventually make a tool to run polls/elections easily.

# Ballot Definition

```python
self.uid = uuid.uuid4()
self.options = \[BallotOption]
self.status = vresult.OK

# planned timestamps
self.voteOpen = 0
self.voteClose = 0

# actual timestamps
self.voteOpened = 0
self.voteClosed = 0

#TODO: should round be included here? we have the data elsewhere but might be nice to ensure consistency

# Max/Min scores available to choose for each option.
# Both cannot be 0
self.maxScore = 1 # >= 0
self.minScore = 0 # <= 0

# How many options can be picked?
self.mustChoose = 0 # Can be larger to force write ins
self.canChoose = 1 # >= mustChoose

# Top/bot x scores must be unique
self.topUniqueScores = 0
self.botUniqueScores = 0

# Write in
self.canWriteIn = 0 # number of allowed write-ins

# Points pool
self.pointsPool = 0 # 0 = don't use points pool
self.mustAllocate = 0
self.canAllocate = 1
self.writeInPoints = False # True if write-ins pull from points pool
```

# Election Definition

I originally tried to take a similar approach as the ballot definition and apply it to the overall poll/election description, however I think it is a much harder solution space to "close". Perhaps it is better to be able to define a series of steps for how to evaluate the election result.

# Analysis

TODO: maybe also compare to normal distribution, etc.? Other types of statistical analysis?

## Risk-limiting Audits

# Security and Anonymity

Users should be able to preserve as much anonymity as possible. Cascade permissions upwards to that no more than $n$ people are within a certain category at the end? I have a lot more thoughts here that I need to put down

# Other Thoughts

- Is there anything here that can be usefully compared to gambling theory or game theory in general?
- It would be really cool to have an automated comparison tool that analyzes the options in your election and tells you about which fairness criteria it fails/passes. This would help a lot with education about voting systems and why choosing the right one is important.
    - Also highlighting if votes can be wasted or not counted in general
 
# Imported Notes

*   How to define voting methodologies?
    *   Number of points available for allocation
    *   Max points per option
    *   Point values can/cannot repeat
    *   Is overall abstaining allowed?
    *   Is skipping options allowed? (Requires more points available than options.)
*   Definition
    *   Ballot
        *   A. Options (O)
            *   Just the list of available options/candidates/choices
            *   Number of options = len(O)
        *   B. Highest option score (s)
            *   Any integer value >= 1
        *   C. Top u ranks must be unique
            *   Allows to force all to be unique
            *   Allows to force only top (preferred option) while still having lower acceptable choices selected
            *   u <= min( s, len(O) )
        *   D. Must rank >= n options and <= m options
            *   Skip none, skip all, force voter to vote for more than one, etc.
        *   E. (Write in responses? How many? Affect on points pool (write in points can only be used for write in values, in some cases may still subtract from overall pool)? )
        *   F. Total points pool (Must use all points? Must use x points?)
            *   Max
            *   Min
    *   Evaluation
        *   Number of winners
        *   Select options?
        *   Or select steps?
    *   A. Options
    *   B. Highest possible score
    *   C. Must scores be unique?
    *   D. Must all options be scored?
    *   E. Is abstaining allowed?
    *   F. Total points pool
        *   If E, Minimum = 0
        *   If !E & !D, Minimum = 1
        *   If !E & D, Minimum = 1 + 2 + .. + Len(A)
        *   If !C, Max = Len(A) \* B
        *   If C, Max = B + (B-1) + .. + (B - (len(A) - 1))
    *   (Allow write in responses?)
        *   How many?
        *   Is there a viable variant where you pick a single favorite and then several other acceptable choices? Maybe just only allow one top score but lower scores are okay to duplicate? What if duplicate allowance is defined as the top n ranks? So 0 allows duplicates anywhere. 1 only allows 1 choice in top column. Etc
        *   Does it affect point pool?
*   Scoring
    *   Score calculation
        *   Sum
        *   Highest
        *
    *   Runoff behavior
        *   Make it like a step/scripting system? Define operations and then order
        *   Calculate score
        *   Distribute extra scores
        *   Eliminate options

 