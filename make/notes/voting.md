---
layout: modern
title: Voting
---

# Voting Systems

## Motivation

Friends and I have a group where we watch movies.
We often have issues choosing what to watch so we were discussing
ways that we could optimize the problem. Eventually we landed on
the idea of using some kind of polling or voting system to achieve this,
however we didn't really like the existing options because we wanted
to be able to do more complex voting methodologies than just
majority vote.

After a couple hours of research I learned a lot more about
voting methodologies in general and then wondered if there was a reasonable
way to generalize the problem.

## Ballots

This ballot definition is reasonably comprehensive for complex ballots,
but doesn't really cover Pairwise/Condorcet voting without making a bunch of
copies. Could maybe be an option at the poll level though?

```ruby
class BallotOption
  id: UUID
  name: String
  description: String | Null
  # TODO: define mutual exclusion between options? (Skip for now. Can add later)
end

enum BallotStatus
  DRAFT
  PUBLISHED
  OPEN
  CLOSED
  CANCELLED
end

class BallotDefinition
  id: UUID
  name: String
  description: String | Null
  options: BallotOption[]
  # some version stuff and poll relational info

  status: BallotStatus

  planned_open_time: Timestamp | Null
  planned_close_time: Timestamp | Null

  open_time: Timestamp | Null
  close_time: Timestamp | Null

  # Maximum and minimum scores available for each option
  # maximum_score != minimum_score
  maximum_score: Integer = 1 # >= 0
  minimum_score: Integer = 0 # <=0

  # How many options can be picked?
  # must_choose can be bigger than length(options) to force write-ins
  must_choose: Integer = 0
  can_choose: Integer = 1 # >= must_choose
  can_write_in: Integer = 1 # Number of allowed write-ins

  # Number of scores that must be unique at top/bottom
  top_unique_scores: Integer = 0
  bottom_unique_scores: Integer = 0
  # TODO: maybe should be like # per score? (that would be very high ballot complexity)

  # Points pool
  points_pool: Integer = 0 # 0 = don't use points pool
  must_allocate: Integer = 0
  can_allocate: Integer = 1
  write_in_points: Boolean = False # True if write-ins pull from points pool

  # vote_cost = (count(votes_for_option) * points_multiplier) ^ points_power
  # i.e. 1x^1 = linear; 2x^1 = doubling; 1x^2 = quadratic
  points_multiplier: Integer = 1 # >= 1
  points_power: Integer = 1 # >= 1
end

#TODO: still missing a way to encode round? (could be handled by poll or a relational table)
```


# Election Definition

should support multiple ballots so that ballots can be grouped together

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


---
messy long-form notes again. several months have passed:

# Voting Systems

First-Past-The-Post (FPTP):
- Each voter selects one candidate.
- The candidate with the most votes wins.
- Mathematically simple: Count votes, highest number wins.
- Criticism: Can lead to "wasted" votes, doesn't require a majority to win (just a plurality).

Two-Round System (TRS):
- If no candidate wins a majority in the first round, a second round is held with the top two candidates.
- Mathematically, still simple counting, but with a possible second phase if no majority is reached initially.

Instant-Runoff Voting (IRV) / Ranked-Choice Voting (RCV):
- Voters rank candidates in order of preference.
- If no candidate has a majority, the candidate with the fewest votes is eliminated, and those votes are redistributed to the next-ranked candidate on each ballot.
- Repeat until a candidate has a majority.
- Mathematically more complex, involves counting, redistribution of votes, and potential multiple rounds of calculation.

Single Transferable Vote (STV):
- A form of RCV used for multi-seat elections.
- Voters rank candidates as in IRV.
- Candidates who reach a certain quota are elected, and excess votes are transferred based on voter preferences.
- Any remaining seats are filled by eliminating the lowest-ranked candidates and transferring votes until all seats are filled.
- Math involves calculating quotas and multiple redistributions based on preferences and surplus votes.

Approval Voting:
- Voters can vote for as many candidates as they approve of.
- The candidate with the most votes wins.
- Mathematically straightforward: tally all approvals, highest count wins.
- Allows for greater expression of voter preference.

Score Voting (Range Voting):
- Voters score each candidate on a scale (e.g., 0 to 5).
- All scores are totaled for each candidate.
- Candidate with the highest total score wins.
- Math involves simple addition but with a higher data set per voter.

Condorcet Method:
- Voters rank candidates.
- The winner would be the candidate who would win a one-on-one election against every other candidate.
- Mathematically, it involves pairwise comparisons among all candidates, which can be complex and computationally intensive.

Borda Count:
- Voters rank candidates.
- Points are assigned to each rank (e.g., 1 point for last place, 2 points for second-last, etc.).
- Points are totaled for each candidate.
- The candidate with the most points wins.
- Math involves allocating points based on rank and summing them up.

- First-Past-The-Post (FPTP)
- Two-Round System (TRS)
- Instant-Runoff Voting (IRV) / Ranked-Choice Voting (RCV)
- Single Transferable Vote (STV)
- Approval Voting
- Score Voting (Range Voting)
- Condorcet Method
- Borda Count
- Cumulative Voting
- Bucklin Voting
- Coombs' Method
- Baldwin Method
- Nanson's Method
- Dodgson's Method
- Kemeny-Young Method
- Minimax Condorcet
- Schulze Method
- Copeland's Method
- Ranked Pairs (Tideman)
- STAR Voting (Score Then Automatic Runoff)
- Majority Judgment
- Single Non-Transferable Vote (SNTV)
- Mixed-Member Proportional Representation (MMP)
- Party-list Proportional Representation
- Alternative Vote Plus (AV+)
- Open List and Closed List Proportional Representation
- Sequential Proportional Approval Voting (SPAV)
- Jefferson Method (D'Hondt method)
- Webster Method (Sainte-Laguë method)
- Hamilton Method (Largest Remainder Method)
- Huntington-Hill Method

# Voting criteria / evaluations

Majority Criterion: Does the system elect the candidate who has a majority of first-preference votes?

Condorcet Criterion: Does the system always elect the Condorcet winner, if one exists (a candidate who would beat each of the other candidates in a head-to-head contest)?

Monotonicity: Will voting a candidate higher in one's preference never hurt that candidate or help a lower-ranked candidate?

Independence of Irrelevant Alternatives (IIA): Does the outcome of the election depend only on voters' preferences between the actual available options, not on irrelevant or non-competing alternatives?

Proportionality: For multi-seat elections, does the system reflect the proportion of the votes in the allocation of seats?

Cloning Criterion: Will cloning (running a similar candidate) never hurt nor unfairly benefit the original candidate?

Participation Criterion: Will a voter never cause an outcome they consider worse by choosing to vote versus abstaining?

Consistency: If the electorate is divided into two (or more) groups and each group's election result is the same, will that candidate still win the overall election?

Resistance to Tactical Voting (Strategy-Proofness): How susceptible is the system to strategic voting, where casting a vote not according to genuine preference could result in a more favored outcome?

Simplicity: How easy is it for voters to understand the voting process and for officials to administer the election?

Voter Satisfaction Efficiency: How well does the system maximize voter satisfaction or utility?

# Potential definition elements?
Number of Winners: Single-winner versus multi-winner systems.
Ballot Type: Categorical (Choose one or more, like in FPTP, Approval, Cumulative)

Ordinal (Rank-order preference, like in IRV, STV, Condorcet Methods)

Cardinal (Score each option, like in Score Voting, STAR Voting)

Winner Determination:
Plurality (Highest vote count wins, like in FPTP)
Majority (More than 50% needed, employed in Runoff systems)
Supermajority (A higher than 50% threshold)
Quota (Proportional representation systems like STV use a quota)

Runoff Type:
None (Single round, winner determined immediately)
Sequential Elimination (like in IRV)
Top-Two (like in a Two-Round System)
Exhaustive Ballot (where several rounds of voting are held until someone wins a majority)

Maximum Runoff Count:
Specifies the number of runoff rounds permitted, which could be unlimited until a winner emerges, or fixed.

Threshold or Quota System:
The minimum percentage or vote count a candidate must achieve for election (used in systems like STV or List PR).

Redistribution Method:
How votes are transferred in multi-round systems or in quota systems upon reaching a threshold (like in STV, IRV).

Tie-Breaking Rules:
Rules for breaking ties between candidates with equal votes.

District Magnitude:
The number of representatives elected in each district (relevant for multi-winner systems).

Level of Proportionality:
Purely proportional, semi-proportional, or non-proportional representation.

Seat Allocation Method:
How seats are assigned to parties or candidates in multi-winner systems (like D'Hondt, Sainte-Laguë).

===

# Evaluation steps alternative.

Collect Preferences:
Operation: Gather voter preferences (could be ranking, rating, selection, etc.).

Initial Tally:
Operation: Apply an initial counting method to the preferences (e.g., tally first preferences, sum scores).

Check for Winner(s):
Operation: Determine if a candidate(s) meets the winning criteria (majority, plurality, supermajority, quota).

If no winner(s) is found:
Conditional Operation: Trigger a process for either redistribution or runoff, depending on the system.

Redistribution/Runoff:
(a) Redistribute votes according to the system's rules (e.g., transfer surplus or redistribute from eliminated).
(b) Conduct additional rounds of voting (runoffs) if necessary.

Re-evaluate Winner(s):
Operation: Return to step 3 until the winner(s) is determined.

Final Results:
Operation: Declare the winner(s) based on the accumulated tallies from previous steps.

Tie-breaking (if necessary):
Operation: Apply tie-breaking rules specific to the system in question.

**Ballot Type**: Categorical, Ordinal, Cardinal.
