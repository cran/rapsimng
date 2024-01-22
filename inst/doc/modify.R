## ---- include = FALSE, warning=FALSE, error=FALSE, message=FALSE--------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, echo=FALSE, warning=FALSE, error=FALSE, message=FALSE-------------
library(rapsimng)
suppressPackageStartupMessages(library(magrittr))

## ----read-apsimx--------------------------------------------------------------
library(rapsimng)
wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
#wheat <- read_apsimx("inst/Wheat.json")

## -----------------------------------------------------------------------------
# Find the ThermalTime model 
a <- search_path(wheat, '[Wheat].Phenology.ThermalTime')
a$node$Children[[1]]$X[[2]]
# Update the optimum temperature
a$node$Children[[1]]$X[[2]] <- 27
# Replace with new value
wheat_new <- replace_model(wheat, a$path, a$node)
b <- search_path(wheat_new, '[Wheat].Phenology.ThermalTime')
# The optimum temperature should be updated now
b$node$Children[[1]]$X[[2]]

# The ThermalTime model can also be removed
a <- search_path(wheat, '[Wheat].Phenology.ThermalTime')
wheat_new <- remove_model(wheat, a$path)
b <- search_path(wheat_new, '[Wheat].Phenology.ThermalTime')
# The ThermalTime model should not be found now (i.e. Empty list)
b

## -----------------------------------------------------------------------------
new_cultivar <- new_model("PMF.Cultivar", name = "Hartog")
new_cultivar

## -----------------------------------------------------------------------------
new_cultivar$Command <- list(
  "[Phenology].MinimumLeafNumber.FixedValue = 6",
  "[Phenology].VrnSensitivity.FixedValue = 0")

## -----------------------------------------------------------------------------
# Read the apsimx file
wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
# Create a new Replacements
replacements <- new_model("Core.Replacements")
# Insert the replacements into root folder
wheat_new <- insert_model(wheat, 1, replacements)
replacements_node <- search_path(wheat_new, ".Simulations.Replacements")
replacements_node$path

# Insert the new cultivar
wheat_new <- insert_model(wheat_new, replacements_node$path, new_cultivar)

# Check the new cultivar
cultivar_node <- search_path(wheat_new,
                                        ".Simulations.Replacements.Hartog")
cultivar_node$path
cultivar_node$node$Command
    

## -----------------------------------------------------------------------------
head(data.frame(model = available_models()))

## -----------------------------------------------------------------------------
wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
# Update cultivars
df <- data.frame(name = rep("Hartog", 3),
                  parameter = c("[Phenology].MinimumLeafNumber.FixedValue",
                               "[Phenology].VrnSensitivity.FixedValue",
                               "[Phenology].PpSensitivity.FixedValue"),
                 value = c(9, 7, 3))
wheat_cultivar <- update_cultivar(wheat, df)
# Check update cultivar paramters
hartog <- search_path(wheat_cultivar, "[Replacements].Hartog")
hartog$path

