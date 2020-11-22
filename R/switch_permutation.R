#' switch_permutation
#' 
#' Switch the direction of the permutation to be in terms of the data set. The
#' permute_inputs function returns a permutation in terms of the second data set
#' with respect to the first data set. This function will change the permutation
#' to be in terms of the first data set with respect to the second.
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
#' @param P Dataframe/matrix of permutations as columns.
#' @export switch_permutation

switch_permutation = function(P) {
	new_P = data.frame(P)
	for(j in 1:ncol(P)) {
		for(i in 1:nrow(P)) {
			val = P[i, j]
			new_P[val, j] = i
		}
	}
	return(new_P)
}