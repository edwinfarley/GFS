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
#' Apply a permuation to obtain a full linked data set from df1 and df2. 
#' The permutation is applied to df2, reordering its rows with respect to df1.
#'
#' @param df1 	The first dataframe.
#' @param df2 	The second dataframe.
#' @param p		The permutation to apply.	
#' @export build_permutation

build_permutation = function(df1, df2, p){
	stopifnot(ncol(p) == 1)
	stopifnot(length(p) == nrow(df1))
	df1_adj = df1[which(!is.na(p)),]
	df2_unshuffled = df2[p[which(!is.na(p))], ]
	
	return(cbind(df1_adj, df2_unshuffled))
}
