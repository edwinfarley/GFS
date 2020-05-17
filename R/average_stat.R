#' Use permutations to estimate the statistic stat using multiple imputation
#' over the full data set. Return the estimate, total variance (between and
#' within imputation variance), and confidence interval at the 'a' level.
#'
#' @param df1 The R data frame of the first data set.
#' @param df2 The R data frame of the second data set. This is the data set 
#' 			to which the permutations in P will be applied.
#' @param P	Matrix of permutations where each column is a complete permutation
#' 			with respect to df2. The number of columns is the number of 
#' 			imputations.
#' @param stat The statistic to be computed. A function that accepts a data frame
#'          and returns a number.
#' @param stat_var An optional argument that is a function to compute the variance
#'			of the statistic defined by stat. If no function is specified, then the
#'			value for variance that will be returned is the sample variance of the 
#'			estimates for stat (the between imputation variance). If a function is 
#'			specified, then the value for variance that is returned is the total 
#'			variance computed according to Rubin's rules for multiple imputation, 
#'			where stat_var is the within imputation variance.
#' @param a Confidence level for the confidence interval.
#' @param block Name of the block column. The block column is removed.
#' @export average_stat

average_stat = function(df1, df2, P, stat, stat_var = NULL, a = 0.95, block = "block"){
	df1[block] = NULL
	df2[block] = NULL
	if(is.null(stat_var)){
		#No within imputation variance for 'stat'
		var_mult = 1
		stat_var = function(x){ return(0) }
	} else {
		#From Rubin's rule for multiple imputation
		var_mult = (1 + (1/ncol(P)))
	}
	df2_unshuffled = df2 * 0
    values = as.numeric(ncol(P))
    stderrs = as.numeric(ncol(P))
	for(i in 1:ncol(P)){
		p = as.vector(P[, i])
		#Unshuffle df2 to link data sets
		df_i = build_permutation(df1, df2, p) 
		values[i] = stat(df_i)
		stderrs[i] = stat_var(df_i)
	}
	#Total variance
	total_var = (var_mult * var(values)) + mean(stderrs)
	value_estimate = mean(values)
	Z = qnorm(a + ((1-a)/2))
	hi = value_estimate + (Z * sqrt(total_var))
	lo = value_estimate - (Z * sqrt(total_var))
	return(list(value_estimate, total_var, c(lo, hi)))
}
