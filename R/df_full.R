#' Full simulated example data set for reference.
#'
#' @format A data frame with columns:
#' \describe{
#'   df_full = data.frame(x1 = rnorm(20), x2 = rnorm(20), x3 = rnorm(20))
#'   # Define y1 according to Normal model
#'   df_full$y1 = df_full$x1 + 2*df_full$x2 + 3*df_full$x3
#'   # Define y2 according to Logistic model
#'   df_full$y2 = 2*df_full$x1 + 1*df_full$x2
#'   df_full$y2 = 1 / ( 1 + exp(-1 * df_full$y2)) 
#' }
#' @examples
#' \dontrun{
#'  df_full
#' }
"df_full"
