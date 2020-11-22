#' samples_full
#'
#' Example subset of the Behavioral Risk Factor Surveillance System Survey (BRFSS) data set
#' consisting of 3200 rows extracted from the full data set. Entries sampled at random from
#' complete rows (no missing or warning values). Blocked by respondent's sex, geographic 
#' stratum, and month of collection (blocking variables not included). See samples1 and 
#' samples2 data sets for partition of this full data set to perform linkage.
#'
#' This file is part of GFS.
#' 
#' GFS is free software: you can redistribute it and/or modify
#' it under the terms of the GNU General Public License as published by
#' the Free Software Foundation, either version 3 of the License, or
#' (at your option) any later version.
#' 
#' GFS is distributed in the hope that it will be useful,
#' but WITHOUT ANY WARRANTY; without even the implied warranty of
#' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#' GNU General Public License for more details.
#' 
#' You should have received a copy of the GNU General Public License
#' along with GFS. If not, see <https://www.gnu.org/licenses/>.
#'
#' @docType data
#'
#' @references Department of Health, Centers for Disease Control Human Services, and Pre-
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