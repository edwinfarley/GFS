#' This file is part of GFS.
#' 
#' GFS is free software: you can redistribute it and/or modify
#' it under the terms of the GNU General Public License as published by
#' the Free Software Foundation, either version 3 of the License, or
#' (at your option) any later version.
#' 
#' Foobar is distributed in the hope that it will be useful,
#' but WITHOUT ANY WARRANTY; without even the implied warranty of
#' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#' GNU General Public License for more details.
#' 
#' You should have received a copy of the GNU General Public License
#' along with GFS. If not, see <https://www.gnu.org/licenses/>.
#'
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
