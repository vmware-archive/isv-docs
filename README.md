# ISV Tech Docs

## MkDocs

[MkDocs](https://www.mkdocs.org/)

Theme is extending the material, you can override by placing/removing items under `theme` directory

### Material for MkDocs

[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)

## Pipeline

The current version of this pipeline is running at https://hush-house.pivotal.io/teams/PE/pipelines/isvtechhub-deploy-docs

It is deployed via the `pipeline/set-pipline.sh` script.

The current iteration of this pipline builds the doc from one repistory (isv-tech-docs), the ability to build from multiple repistory can be done in the `collect_docs()` function in the job `deploy-isv-tech-docs`

The docs are hosted here, deployed by the job `build-and-deploy` of the pipeline - https://cf-platform-eng.github.io/isv-tech-hub/

This is enabled by turning on `GitHub Pages` settings for the `https://github.com/cf-platform-eng/isv-tech-hub` repo, the branch `gh-pages` is where the pipeline pushes the content to.
