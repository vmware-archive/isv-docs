# ISV Tech Docs

[Installation](#install)  
[Adding Content](#content)  
[Pipeline](#pipeline)  

<a name="install"></a>
## Installation Steps, only if you want to run MkDocs locally.

[Install MkDocs](#mkdocs_install)  
[Install MkDocs Material Theme](#mkdocs_theme_install)  
[Clone this repo & create your working branch](#content)  

## MkDocs

MkDocs is a tool to create a static site from markdown.  You can read more here - [MkDocs](https://www.mkdocs.org/)

Configuration is done via `mkdocs.yml`

<a name="mkdocs_install"></a>
[MkDocs Installation](https://www.mkdocs.org/#installing-mkdocs)

**!Important** - install using pip and not `homebrew`, [issues](https://squidfunk.github.io/mkdocs-material/getting-started/#troubleshooting) with custom themes will occur

```bash
pip install mkdocs && mkdocs --version
```

Verify that the version of MkDocs >= 0.17.1 (required for MkDocs Material theme)

## MkDocs Material Theme

Material for MkDocs is a custom theme used for ISV Tech Hub documentation. You can read more - [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)

The theme is easily customizable by extending elements [Extending the Theme](https://squidfunk.github.io/mkdocs-material/customization/#extending-the-theme) , which is done in `theme` directory of this repository.

<a name="mkdocs_theme_install"></a>
[MkDocs Material Theme Installation](https://squidfunk.github.io/mkdocs-material/getting-started/)

```bash
pip install mkdocs-material
```

<a name="content"></a>
## Content

#### Clone this repo, if you have not already done so.

https://github.com/cf-platform-eng/isv-tech-docs

#### Create your working branch
The master branch is protected, so you have two possibilities: work on a branch or work with the github inline editor which will allow you to create branch + PR on save.

For more complex work that needs to be saved/backed up in between we recommend to create a branch directly.

#### Adding content

All content is located in the `content` directory.  [GitLab Markdown Guide](https://about.gitlab.com/handbook/product/technical-writing/markdown-guide/)

#### Add to the top level menu

If you need to add to the top level menu, it's needs to be added to `mkdocs.yml`

Here's the current structure of the menu

```
# Page tree
nav:
  - Home: index.md
  - Releases:
    - PCF 2.6 and PKS 1.5: releases/pcf2_6.md
    - PCF 2.5 and PKS 1.4: releases/pcf2_5.md
    - PCF 2.4 and PKS 1.3: releases/pcf2_4.md
  - FAQs:
    - BOSH: faqs/bosh_faq.md
    - Tile Generator: faqs/tilegenerator_faq.md
  - About: about.md
```

<a name="pipeline"></a>
## Pipeline

The pipeline is running at https://hush-house.pivotal.io/teams/PE/pipelines/isvtechhub-deploy-docs.  It's manually triggered.

It is deployed via the `pipeline/set-pipline.sh` script.

The current iteration of this pipline builds the doc from one repistory (isv-tech-docs), the ability to build from multiple repistory can be done in the `collect_docs()` function in the job `deploy-isv-tech-docs`

The docs are hosted here, deployed by the job `build-and-deploy` of the pipeline - https://cf-platform-eng.github.io/isv-tech-hub/

This is enabled by turning on `GitHub Pages` settings for the `https://github.com/cf-platform-eng/isv-tech-hub` repo, the branch `gh-pages` is where the pipeline pushes the content to.

View the ISV Tech Hub documentation here - https://cf-platform-eng.github.io/isv-tech-hub

**To use the set-pipeline.sh to set the pipeline you are expected to have the environment variable `CONCOURSE_TARGET_NAME` set which is the name of your "fly target". It could easily go into an `.envrc`file using direnv so you have per project control over your fly target.**
