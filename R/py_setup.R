#' Installs the required python files to the package directory.
#' No input is required. Python code can be found on GitHub at:
#' https://github.com/edwinfarley/GFSpython
#'
#' @export py_setup

py_setup = function(){
    package_path = paste(path.package('GFS'), '/python', sep ='')
    system(paste('rm -r', package_path, sep = ' '))
    system(paste('git clone https://github.com/edwinfarley/GFSpython', package_path, sep = ' '))
}
