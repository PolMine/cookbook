library(polmineR) # v0.8.6.9004
library(wordVectors) # devtools::install_github("bmschmidt/wordVectors")
library(readr)
library(pbapply)
library(parallel)

# alternative: https://cran.r-project.org/web/packages/word2vec

file_out <- "~/Lab/tmp/sz.txt"
vectors_bin <- "~/Lab/tmp/sz.bin"
cores <- detectCores() - 1L

corpus("NADIRASZ") %>%
  split(s_attribute = "article_article_id", mc = cores, progress = TRUE) %>% 
  get_token_stream(p_attribute = "word", progress = TRUE, collapse = " ", boost = TRUE) %>%
  write_lines(file = file_out)

train_word2vec(
  file_out,
  vectors_bin,
  vectors = 200,
  threads = cores,
  window = 12,
  iter = 5,
  negative_samples = 0
)
