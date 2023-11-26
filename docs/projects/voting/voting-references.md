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

# Evaluation steps alternative. Here's some operations

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
