#' Switch the direction of the permutation to be in terms of the data set. The
#' permute_inputs function returns a permutation in terms of the second data set
#' with respect to the first data set. This function will change the permutation
#' to be in terms of the first data set with respect to the second.
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