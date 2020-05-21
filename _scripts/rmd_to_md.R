library(rmarkdown)
setwd("C:/Users/guanhua.huang/github/victorhuangkk.github.io/_scripts")
render("portfolio_management.Rmd", 
       output_file = "2020-05-1-stock-investment", 
       output_dir = "C:/Users/guanhua.huang/github/victorhuangkk.github.io/_posts", 
       md_document(toc=TRUE))
