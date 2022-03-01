##### BSEM example with blavaan #####
## Author: Sara van Erp

library(blavaan)
library(bayesplot)

## Step 1: define the model
model <- '
  # measurement model
    ind60 =~ x1 + x2 + x3
    dem60 =~ y1 + y2 + y3 + y4
    dem65 =~ y5 + y6 + y7 + y8
  # regressions
    dem60 ~ ind60
    dem65 ~ ind60 + dem60
  # residual correlations
    y1 ~~ y5
    y2 ~~ y4 + y6
    y3 ~~ y7
    y4 ~~ y8
    y6 ~~ y8
'

## Step 2: think about the priors
# what are the blavaan defaults?
dpriors()

# prior predictive plot
priorcheck <- bsem(model, 
                   data = PoliticalDemocracy,
                   prisamp = TRUE)

samples <- as.matrix(blavInspect(priorcheck, what = "mcmc"))
pars <- dimnames(samples)[[2]]
mcmc_areas(na.omit(samples),
           pars = pars[1:8])

# change the priors


## Step 3: run the model

## Step 4: check convergence

## Step 5: check the results
summary(fit)