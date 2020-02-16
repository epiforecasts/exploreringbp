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
    f7Card(
      title = "Percentage of outbreaks controlled",
      textOutput(ns("extinct_prob"))
    )
  )
}
    
# Module Server
    
#' @rdname mod_extinct_prob
#' @param sliced_sims dataframe of the first time point of model simulations
#' @param setup A list of inputs for the model
#' @export
#' @keywords internal
    
mod_extinct_prob_server <- function(input, output, session, sliced_sims, setup){
  ns <- session$ns
  
  extinct_prob <- reactive({
    sliced_sims() %...>% {
      sum(.$extinct, na.rm = TRUE) / setup$n_sim
    }
  })
  
  
  output$extinct_prob <- renderText({
    extinct_prob()  %...>% {
      paste0(round(. * 100, 0), "%")
    }
  })
}
    
## To be copied in the UI
# mod_extinct_prob_ui("extinct_prob_ui_1")
    
## To be copied in the server
# callModule(mod_extinct_prob_server, "extinct_prob_ui_1")
 
