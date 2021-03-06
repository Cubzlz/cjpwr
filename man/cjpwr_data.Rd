% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cjpwr_data.R
\name{cjpwr_data}
\alias{cjpwr_data}
\title{Simple Power Analysis and Sample Size Diagnostic for Conjoint Designs}
\usage{
cjpwr_data(data, id, contest_no, profile_no, features)
}
\arguments{
\item{data}{A tidy, long-formate conjoint dataframe.}

\item{id}{A variable, within data, containing respondent IDs. Must be numeric.}

\item{contest_no}{A variable, within data, containing contest/choice-task numbers. Must be numeric.}

\item{profile_no}{A variable, within data, containing within-contest/choice-task profile numbers. Must be numeric.}

\item{features}{Numbers of columns/variables containing features. If you plan to calculate AMCEs/MMs of interactions between variables, use interaction() to create a new variable for each interacted feature pair, and include these new variables in the features argument. It is likely that it will be one of these these that is eventually passed to `c` (it takes the feature with the largest number of unique levels). This may seem like a lot of work but these new variables are needed anyway if you wish to analyse interactions in e.g. `cregg`.}
}
\description{
Johnson's rule-of-thumb calculation for determining power of conjoint designs.
}
\details{
\code{cjpwr_data} finds and calculates n, t, a, and c from a tidy conjoint data input (with certain variables specified) and divides the product of n, t, and a by c, to give Johnson's rule-of-thumb estimation of conjoint design power. It returns a dataframe containing the inputs and result of this calculation, whether (yes/no) this exceeds the minimal minimum threshold (500) and ideal minimum threshold (1000), and the sample sizes (rounded up) necessary for minimum and ideal power thresholds. {cjpwr_data} uses features of tidyeval which mean variable names can be specified without quoting ("") and without referring back to the dataframe every time (via data$).
}
\examples{
#load example datasets from {cregg} (Leeper 2019)
library(cregg)
data(immigration)
data(taxes)
#run cjpwr_data seamlessly on immigration dataset
cjpwr_data(data = immigration, id = CaseID, profile_no = profile, contest_no = contest_no, features = 3:11)
#or
cjpwr_data(immigration, CaseID, profile, contest_no, 3:11)
##for taxes dataset, need to create contest_no and profile_no vars
#work out how many contests/tasks per respondent
tasks_taxes <- sum(taxes$chose_plan)/length(unique(taxes$ID))
#work out number of profiles per task
profiles_taxes <- nrow(taxes$ID)/length(unique(taxes$ID))
profiles_tasks <- profiles_taxes/tasks_taxes
#create profile_no and contest_no based on values of profiles_tasks and tasks_taxes
taxes$profile_no <- rep(c(1,2))
taxes$contest_no <- rep(c(1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8))
#run cjpwr_data for power analysis
cjpwr_data(data = taxes, id = ID, profile_no = profile_no, contest_no = contest_no, features = 2:8)
#include interaction variable for a pair of features
library(tidyverse)
immigration$ints <- interaction(immigration$Gender, immigration$PriorEntry)
#move `ints` to be among other feature variables for easier specification of features
immigration <- select(immigration, CaseID, contest_no, ints, everything())
#run cjpwr_data with extra feature included
cjpwr_data(immigration, CaseID, profile, contest_no, 3:12)
}
