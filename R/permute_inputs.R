#' Runs the permutation sampling procedure on the two data sets specified by the
#' df1_path and df2_path inputs over the blocks defined in the data sets. A
#' sampled permutation can be applied to the data set at df2_path to aling its
#' rows with those of the data set at df1_path.
#'
#' @param df1_path A string with the path (from the R working directory) to the
#' first data set with blocks.
#' @param df2_path A string with the path (from the R working directory) to the
#' 			second data set with blocks. This data set MUST contain the response
#'          variable from the formula.
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
#' @param block_name The name of the column in the two input data sets that
#'          contains the number of the block to which each row belongs. Set to
#'          "block" by default. Column name must be the same in the two data sets.
#' @param conda_env 'NA' by default. If using the Anaconda distribution of
#' 			python, specify which environment to use. Runs 'source activate conda_env'.
#' @param activate_env 'NA' by default. Enter a string with the command used to
#'			activate the desired python environment if it is neither the default
#'			environment nor an Anaconda environment.
#' @param python The name of the installed python deployment. If a conda environment
#'			was set up with create_conda_environment, this should be "python".
#' @return A dataframe with number of rows equal to the number of rows in the
#' 			first data set and N columns. Each column is a full permutation with
#' 			respect to the first data set to be applied to the second data set.
#' @export permute_inputs
#' @importFrom utils read.csv

permute_inputs = function(df1_path, df2_path, formula, family, N, I, t, burn_in, sample_interval, block_name = 'block', conda_env = 'NA', activate_env = 'NA', python = "python"){
	# Get path of package. The python code will be kept here.
	package_path = path.package('GFS')
	# Get path of session temporary files. Need to replace double backslash in path.
	temp_path = stringr::str_replace(tempdir(), "//", "/")
	exec_file = paste(package_path, '/python/exec.py', sep = '')

	if(!file.exists(exec_file)){py_setup()}
	input_path = paste(temp_path, "/input.txt", sep = "")
	fileConn = file(input_path)
	writeLines(c(df1_path, df2_path, toString(formula), toString(family), toString(N), toString(I),
	 	toString(t), toString(burn_in), toString(sample_interval), block_name), fileConn)
	close(fileConn)

	command = ''

	if(conda_env != 'NA'){
		command = paste('source activate', conda_env, ';', sep = ' ')
	} else if(activate_env != 'NA'){
		command = paste(activate_env, ';', sep = ' ')
		}
	killed = FALSE
	command = paste(command, python, exec_file, package_path, getwd(), temp_path, sep = ' ')
	
	tryCatch(system(command), interrupt = print("Process Start."), finally = system("pkill python"))
	csv_path = paste(temp_path, "/permutations.csv", sep = "")
	perms = read.csv(csv_path)
	perms$X = NULL
	# Remove the inputs file
	system(paste("rm ", input_path, sep = ""))
	# Clear python cache
	system(paste("rm -r ", package_path, "/python/__pycache__", sep = ""))
	# Remove .csv file
	system(paste("rm ", csv_path, sep = ""))

	perms[perms < 0] = NA
	return(perms+1)
}
