#' samples1
#'
#' Partition 1 of example subset of the Behavioral Risk Factor Surveillance System Survey (BRFSS) data set
#' consisting of 3200 rows extracted from the full data set. Entries sampled at random from
#' complete rows (no missing or warning values).
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
#'  \item{PHYSHLTH}{A measure of physical health on a scale of 1 to 30.}
#'  \item{MENTHLTH}{A measure of mental health on a scale of 1 to 30.}
#'  \item{AGE}{The respondent's age.}
#'  \item{WEIGHT}{The respondent's weight in lbs.}
#'  \item{block}{Blocking index.}
#' }
#' @examples
#' \dontrun{
#'  samples1
#' }
"samples1"