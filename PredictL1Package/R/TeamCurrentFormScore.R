#' Team Current Form Score function 
#'
#' This function assigns a score evaluating the current form 
#' of a team based on its first ten results of the current season
#'   
#' 
#'  
#'
#' 
#'
#' @export
#' @examples
#' score_team_form()

score_team_form <- function(current_points, difficulty_coefficient){
  form_score <- coeff_diff*current_points + current_points
  return(form_score)
}

