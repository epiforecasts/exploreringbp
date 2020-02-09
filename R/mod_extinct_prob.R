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
#' @param setup A list of inputs for the model
#' @export
#' @importFrom ringbp extinct_prob
#' @keywords internal
    
mod_extinct_prob_server <- function(input, output, session, sims, setup){
  ns <- session$ns
  
  extinct_prob <- reactive({
    sims() %...>% {
      ringbp::extinct_prob(., cap_cases = setup$cap_cases)
    }
  })
  
  
  return(extinct_prob)
}
    
## To be copied in the UI
# mod_extinct_prob_ui("extinct_prob_ui_1")
    
## To be copied in the server
# callModule(mod_extinct_prob_server, "extinct_prob_ui_1")
 
