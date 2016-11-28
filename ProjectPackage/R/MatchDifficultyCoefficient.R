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

match_diff_coeff <- function(current_rank, match_matrix){
  # Define variables
  n <- length(current_rank)
  max_diff <- c(rep(0, n))
  current_diff <- c(rep(0, n))
  diff_futur <- c(rep(0, n))
  coeff_diff <- c(rep(0, n))
  
<<<<<<< HEAD:MatchDifficultyCoefficient.R
  # Compute the maximum difficulty possible (team plays against all teams including self)
  max_diff[1:20] <- 187 - (20 - current_rank[1:20])
=======
  # Compute the total difficulty over the season (team plays against all teams except self)
  max_diff <- 187 - (20 - current_points)
>>>>>>> origin/master:ProjectPackage/R/MatchDifficultyCoefficient.R
  
  # Compute the difficulty of first ten match played
  
  #Rescale the match matrix to have expected difficulty of each match
  match_diff_matrix <- (20 - match_matrix)/2
  
  for(i in 1:n){
    current_diff[i] <- sum(match_diff_matrix[i,1:10])
  }
  
  #Compute difficulty of future matches
  diff_futur <- max_diff - current_diff
  
  # Compute difficulty coefficient
  coeff_diff <- (diff_futur/current_diff)
  return(coeff_diff)
}
