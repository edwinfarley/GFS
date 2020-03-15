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
	df1_adj = df1[which(!is.na(p))]
	df2_unshuffled = df2[p, ]
	
	return(cbind(df1, df2_unshuffled))
}