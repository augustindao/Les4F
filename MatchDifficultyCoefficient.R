#' Match Difficulty Coefficient function 
#'
#' This function creates a coefficient that evaluates for each team the difficulty of the first ten games (and therefore the next 28).
#' 
#'   
#' [INSERT MOTIVATION OF DIFFICULTY COEFF COMPUTATION]
#'  
#' Formula: 
#' [INSERT FORMULA]
#'
#' @export
#' @examples
#' match_diff_coeff()

match_diff_coeff <- function(current_points, match_matrix){
  # Define variables
  n <- length(current_points)
  max_diff <- c(rep(0, n))
  current_diff <- c(rep(0, n))
  diff_futur <- c(rep(0, n))
  coeff_diff <- c(rep(0, n))
  
  # Compute the total difficulty over the season (team plays against all teams except self)
  max_diff <- 187 - (20 - current_points)
  
  # Compute the difficulty of first ten match played
  # Note: Couldn't find a way to get rid of the for-loop, if anyone has an idea...
  for(i in 1:n){
    current_diff[i] <- sum(20 - as.numeric(match_matrix[i,1:10]/2)) 
  }
   
  #Compute difficulty of future matches
  diff_futur <- max_diff - current_diff
                      
  # Compute difficulty coefficient
  coeff_diff <- (diff_futur/current_diff)
  return(coeff_diff)
}

