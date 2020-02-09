# Module UI
  
#' @title   mod_extinct_prob_ui and mod_extinct_prob_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_extinct_prob
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_extinct_prob_ui <- function(id){
  ns <- NS(id)
  tagList(
  
  )
}
    
# Module Server
    
#' @rdname mod_extinct_prob
#' @param sims dataframe of model simulations
#' @export
#' @importFrom ringbp extinct_prob
#' @keywords internal
    
mod_extinct_prob_server <- function(input, output, session, sims){
  ns <- session$ns
  
  extinct_prob <- reactive({
    ringbp::extinct_prob(sims(),cap_cases = 4500)
  })
  
  
  return(extinct_prob)
}
    
## To be copied in the UI
# mod_extinct_prob_ui("extinct_prob_ui_1")
    
## To be copied in the server
# callModule(mod_extinct_prob_server, "extinct_prob_ui_1")
 
