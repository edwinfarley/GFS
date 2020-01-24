#' Installs the required python files to the package directory.
#' No input is required, but the force argument can be set. 
#' Python code can be found on GitHub at:
#' https://github.com/edwinfarley/GFSpython
#'
#' @param force Whether to remove existing python directory and re-install components.
#' @export py_setup

py_setup = function(force = FALSE){
    python_path = paste(path.package('GFS'), '/python', sep ='')
    if(!file.exists(python_path)){
        system(paste('git clone https://github.com/edwinfarley/GFSpython', python_path, sep = ' '))
    } else if(force) {
    		system(paste('rm -r', python_path, sep = ' '))
    		system(paste('git clone https://github.com/edwinfarley/GFSpython', python_path, sep = ' '))
    } else {
    		print("Python components already installed. Set force to TRUE to re-install python components.")
    }
}
