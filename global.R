# Library判定とインストール ####

targetPackages <- c('shiny', 'shinythemes', "multcomp", "plater", "DT", "broom", "magrittr", "cowplot", "tidyverse") 
newPackages <- targetPackages[!(targetPackages %in% installed.packages()[,"Package"])]
if(length(newPackages)) install.packages(newPackages, repos = "http://cran.rstudio.com")
for(package in targetPackages) library(package, character.only = T)

# Library ####
library(shiny)
library(shinythemes)
library(multcomp)
library(plater)
library(DT)
library(broom)
library(magrittr)
library(cowplot)
library(tidyverse)

# ソース読み込み ####
source("module.R")
source("function.R")