## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message=FALSE, warning=FALSE--------------------------------------
library(rapsimng)
library(tidyverse)

## ----define-parameter---------------------------------------------------------
phyllochron_para <- tibble(parameter = "[Phenology].Phyllochron.BasePhyllochron.FixedValue", 
                           value = seq(60, 130, by = 1)) %>% 
  mutate(name = paste0("Cultivar", seq_len(n())))
head(phyllochron_para)

## -----------------------------------------------------------------------------
template <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))

## -----------------------------------------------------------------------------
template <- update_cultivar(template, phyllochron_para)

node <- search_path(template, "[Permutation].Cv")    
if (length(node) == 0) {
  stop("[Permutation].Cv is not found")
}
new_value <- paste0("\\1", paste(phyllochron_para$name, collapse = ","))
node$node$Specification <- gsub("(.+ *= *)(.+)$", new_value, node$node$Specification)

node$node$Specification

template <- replace_model(template, node$path, node$node)

## -----------------------------------------------------------------------------

# write_apsimx(template, "new-path.apsimx")
# models_path <- "path-to-Models.exe"
# run_models(models_path, sim_name, csv = TRUE, parallel = FALSE)

