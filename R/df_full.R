#' This file is part of GFS.
#' 
#' GFS is free software: you can redistribute it and/or modify
#' it under the terms of the GNU General Public License as published by
#' the Free Software Foundation, either version 3 of the License, or
#' (at your option) any later version.
#' 
#' Foobar is distributed in the hope that it will be useful,
#' but WITHOUT ANY WARRANTY; without even the implied warranty of
#' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#' GNU General Public License for more details.
#' 
#' You should have received a copy of the GNU General Public License
#' along with GFS. If not, see <https://www.gnu.org/licenses/>.
#'
#' Full simulated example data set for reference.
#'
#' @format A data frame with columns:
#' \describe{
#'   df_full = data.frame(x1 = rnorm(20), x2 = rnorm(20), x3 = rnorm(20))
#'   # Define y1 according to Normal model
#'   df_full$y1 = df_full$x1 + 2*df_full$x2 + 3*df_full$x3
#'   # Define y2 according to Logistic model
#'   df_full$y2 = 2*df_full$x1 + 1*df_full$x2
#'   df_full$y2 = 1 / ( 1 + exp(-1 * df_full$y2)) 
#' }
#' @examples
#' \dontrun{
#'  df_full
#' }
"df_full"
