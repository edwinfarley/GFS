#' create_python_environment
#' 
#' Create a Conda environment with name conda_envname and install 
#' all needed packages. When using permute_inputs, pass the name 
#' of your Conda environment to the conda_env input as a string.
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
#' @param conda_envname The name of the new Conda environment.
#' @export create_python_environment

create_python_environment = function(conda_envname){
	conda = conda_envname
	if(conda %in% reticulate::conda_list()$name){
			print(paste("A conda environment with the name", conda, "already exists. Proceding with installation."))
	} else {
		reticulate::conda_create(conda)
	}
	reticulate::conda_install(conda, c("numpy", "pandas", "pymc3", "mkl", "theano", "mkl-service"))
	print(paste("Installation complete. Environment ", conda, "now active."))
}
