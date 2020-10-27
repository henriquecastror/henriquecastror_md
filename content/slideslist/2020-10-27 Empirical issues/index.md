---
authors:
- admin

date: "2020-10-27T00:00:00Z"

tags: 
- Português
- Slides
- Brazil

title: 2019-10-19 Conteúdo Café IAG PUC-Rio

url_slides: "https://zenodo.org/record/3518114"

---

## _Render arbitrary Rmd files on a blogdown website_

This is a minimal example to show how you can render arbitrary Rmd files on a website based on [**blogdown**](https://github.com/rstudio/blogdown). 

The key is that you add an R script `build.R` under the `R/` directory (in which you can use one line of code `blogdown::build_dir('static')`), and put your Rmd files under the `static/` directory. See the brief documentation in the [**blogdown** book](https://bookdown.org/yihui/blogdown/static-files.html).

It does not matter which output formats your Rmd files are generated to; `build_dir()` will call `rmarkdown::render()` to render them. On this example website, I provided two examples (R packages [**xaringan**](https://github.com/yihui/xaringan) and [**bookdown**](https://github.com/rstudio/bookdown) are required):

- Generating an HTML5 presentation based on **xaringan**: [slides/xaringan.html](/slides/slides1-empiricalissues.html) 


(Rmd source: [static/slides/xaringan.Rmd](https://github.com/yihui/blogdown-static/blame/master/static/slides/xaringan.Rmd)).

- Generating a PDF document using the `bookdown::pdf_document2` format: [pdf/example.pdf](/pdf/example.pdf) (Rmd source: [static/pdf/example.Rmd](https://github.com/yihui/blogdown-static/blame/master/static/pdf/example.Rmd)).

Below is a list of example blog posts on this website rendered by Hugo instead of **rmarkdown**: