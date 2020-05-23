library(rmarkdown)
setwd("C:/Users/guanhua.huang/github/victorhuangkk.github.io/_scripts")
render("portfolio_management.Rmd", 
       output_file = "2020-05-01-stock-investment", 
       intermediates_dir = "/img",
       output_dir = "C:/Users/guanhua.huang/github/victorhuangkk.github.io/_posts", 
       md_document(toc=TRUE))
