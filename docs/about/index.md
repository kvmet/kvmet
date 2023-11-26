---
title: About
lang: en-US
keywords:
  - about
  - website
  - contact
  - information
  - meta
---

# About This Website

The content of this site is written almost exclusively in [Markdown](https://en.wikipedia.org/wiki/Markdown) and converted into a static website using [MkDocs](https://www.mkdocs.org/) and [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/reference/admonitions/).
Its source is available via [GitHub](https://github.com/kvmet/kvmet/actions) and the static website is hosted using GitHub Pages.

When an update is pushed to the `main` branch of this site's git repo, an [Action](https://github.com/kvmet/kvmet/blob/main/.github/workflows/ci.yml) is run that builds the site and deploys it to the `gh-pages` branch. That branch is then served directly via GitHub Pages.
DNS is all handled by [CloudFlare](https://www.cloudflare.com/). 

## Additional Plugins

- **Math Rendering:** [KaTeX](https://katex.org/)

## Privacy

I use CloudFlare Analytics for this site with the minimum amount of data collected. It only logs page views (all of the other fancy stuff like click and egress tracking is not included).
None of this data should be stored in cookies either as far as I am aware, although it does use a bit of javascript.
