---
title: "Train word2vec model"
output: html_document
date: '2022-06-18'
---

## Objective
  


## Dependencies / packages uses

```{r}
library(polmineR) # v0.8.6.9004
library(wordVectors) # devtools::install_github("bmschmidt/wordVectors")
library(readr)
library(parallel)
```

Note on the packages used:
  
- [word2vec](https://CRAN.R-project.org/package=word2vec) is an alternative to
the [wordVectors](https://github.com/bmschmidt/wordVectors) package used here, 
but we think that wordVectors is very usable and well maintained.

- The [readr](https://CRAN.R-project.org/package=readr) package is impressively
efficient to write a big character to disk.


# Settings

```{r}  
corpus_id <- "REUTERS"
split_by <- "article_article_id"

file_out <- "~/Lab/tmp/sz.txt"
vectors_bin <- "~/Lab/tmp/sz.bin"
cores <- detectCores() - 1L
```

## Write corpus data to disk

```{r}
corpus(corpus_id) %>%
  split(s_attribute = split_by, mc = cores, progress = TRUE) %>% 
  get_token_stream(p_attribute = "word", progress = TRUE, collapse = " ") %>%
  write_lines(file = file_out)
```


## Train word2vec model

```{r}
train_word2vec(
  file_out,
  vectors_bin,
  vectors = 200,
  threads = cores,
  window = 12,
  iter = 5,
  negative_samples = 0
)
```

## Result


