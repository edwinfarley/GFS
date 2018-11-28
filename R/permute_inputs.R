#' Runs the permutation sampling procedure on the two datasets specified by the
#' df1_path and df2_path inputs over the blocks defined in the datasets.
#'
#' @param df1_path A string with the path (from the R working directory) to the
#' first dataset with blocks.
#' @param df2_path A string with the path (from the R working directory) to the
#' 			second dataset with blocks.
#' @param formula A string with the formula specifying the response variable
#' 			and the covariates. Written in the R format (e.g. 'y ~ x1 + x2 + x3').
#' @param family A string specifying the family of distributions used in the
#' 			regression step. Current supported families are 'Normal', 'Logistic',
#'			"Poisson".
#' @param N An integer specifying the number of desired full permutations. The
#' 			number of iterations will be burn_in + N*sample_interval.
#' @param I An integer specifying how many iterations to complete in sampling
#' 			the regression parameters.
#' @param t An integer specifying the number of iterations (successful or not)
#' 			in the Metropolis-Hastings step.
#' @param burn_in An integer specifying the number of full iterations to be
#' 			completed before any samples are taken.
#' @param sample_interval An integer specifying the period of sampling. If 
#'			sample_interval is 1, every full iteration will be a sample, if
#'			sample_interval is 2, every other full iteration will be a sample,
#'          and so on.
#' @param conda_env 'NA' by default. If using the Anaconda distribution of
#' 			python, specify which environment to use. Runs 'source activate conda_env'.
#' @param activate_env 'NA' by default. Enter a string with the command used to
#'			activate the desired python environment if it is neither the default
#'			environment nor an Anaconda environment.
#' @param keep_csv FALSE by default. If TRUE, the .csv file containing the
#'			permutations will not be automatically deleted upon completion of the
#'			procedure.
#' @return A dataframe with number of rows equal to the number of rows in the
#' 			first dataset and N columns. Each column is a full permutation with
#' 			respect to the first dataset to be applied to the second dataset.
#' @export permute_inputs

permute_inputs = function(df1_path, df2_path, formula, family, N, I, t, burn_in, sample_interval, block_name = 'block', conda_env = 'NA', activate_env = 'NA', keep_csv = FALSE){
	package_path = path.package('GFS')
	exec_file = paste(package_path, '/python/exec.py', sep = '')

	if(!file.exists(exec_file)){py_setup()}

	fileConn<-file("input.txt")
	writeLines(c(df1_path, df2_path, formula, family, toString(N), toString(I),
	 	toString(t), toString(burn_in), toString(sample_interval), block_name), fileConn)
	close(fileConn)

	command = ''

	if(conda_env != 'NA'){
		command = paste('source activate', conda_env, ';', sep = ' ')
	} else if(activate_env != 'NA'){
		command = paste(activate_env, ';', sep = ' ')
		}
	killed = FALSE
	command = paste(command, 'python', exec_file, package_path, getwd(), sep = ' ')
	
	tryCatch(system(command), interrupt = print("Process Start."), finally = system("pkill python"))
	perms = read.csv('permutations.csv')
	perms$X = NULL
	system('rm input.txt')
	system(paste('rm -r ', package_path, '/python/__pycache__', sep = ''))
	if(! keep_csv){system('rm permutations.csv')}

	perms[perms == -1] = NA
	return(perms+1)
	
}
