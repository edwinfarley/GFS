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
