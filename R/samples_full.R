#' Example subset of the Behavioral risk factor surveillance system survey data set (BRFSS)
#' consisting of 3200 rows extracted from the full data set. Entries sampled at random from
#' complete rows (no missing or warning values). Blocked by respondent's sex, geographic 
#' stratum, and month of collection (blocking variables not included). See samples1 and 
#' samples2 data sets for partition of this full data set to perform linkage.
#'
#' @source Department of Health, Centers for Disease Control Human Services, and Pre-
#' vention (CDC). Behavioral risk factor surveillance system survey data, 2001.
#' @format A data frame with columns:
#' \describe{
#'  \item{GENHLTH}{A measure of general health on a scale of 1 to 5.}
#'  \item{PHYSHLTH}{A measure of physical health on a scale of 1 to 30.}
#'  \item{MENTHLTH}{A measure of mental health on a scale of 1 to 30.}
#'  \item{AGE}{The respondent's age.}
#'  \item{ALCDAY}{The number of days a year the respondent drinks alcohol.}
#'  \item{WEIGHT}{The respondent's weight in lbs.}
#'  \item{ASTHMA}{Whether the respondent has asthma.}
#'  \item{block}{Blocking index.}
#' }
#' @examples
#' \dontrun{
#'  samples_full
#' }
"samples_full"