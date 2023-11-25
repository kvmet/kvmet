---
title: Automated Changelogs on GitHub
lang: en-US
---

# Automated Changelogs on GitHub

Well, this isn't something that I thought would have been worth writing down but it actually wound up being quite a bit more work than I anticipated.
The deployment workflow for this website is currently automated and, since I plan to change the layout of this site on a whim, I thought that it would be useful to have an automatically-updating changelog that shows what files changed recently within the repo.
Little did I know that I was going to spend 5 hours troubleshooting GitHub Actions scripts.

I started by just asking GPT4 to generate a script. The first iteration didn't quite do what I wanted but I was able to tweak it to make it work. It was pretty functional but I wanted to change the formatting. I kept trying to tweak it to get it to function but I kept running into issues with the formatting not surviving the different stages of the build pipeline or other mysterious problems. Back to GPT4. This is where I wound up losing a lot of time. No matter what I tried I wound up only being able to get the first one working. Turns out that GitHub actions doesn't make a full-depth fetch so I had to instruct it to fetch additional commits while generating the changelog. 

Here's what I wound up on for the current version of the changelog generation. I think something like `awk` would be much more robust, but after all the troubleshooting I decided to just make it as simple and direct as possible to keep it simple:

```yaml
- name: Update Changelog
  run: |
    git fetch --depth 11 origin main
    cat docs/CHANGELOG\_TEMPLATE.md > docs/CHANGELOG.md
    git log -n 10 --pretty=format:'---%n%n## %s%n%n%ad%n%n Commit: \[%h]\(https://github.com/${{ github.repository }}/commit/%H)%n%n\*\*Changed Files:\*\*%n' --name-only | sed 's/$/  /' >> docs/CHANGELOG.md
```

!!! question "Why is fetch depth 11 when only 10 commits are displayed?"
	The oldest fetched commit will show all files as changing since it is the sum of all prior commits. Fetching one extra commit ensures that the 10th one will only show files that were updated in that commit.

That's pretty much it. I wound up chasing my tail a lot in order to fix it, but I am glad that it works and accomplishes what I wanted.
