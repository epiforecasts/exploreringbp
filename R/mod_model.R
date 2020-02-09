
#' @title   mod_model_ui and mod_model_server
#' @description  A module for running the `ringbp` model
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_model
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_model_ui <- function(id){
  ns <- NS(id)
  tagList(
  
  )
}
    
    
#' @rdname mod_model
#' @export
#' @importFrom ringbp scenario_sim
#' @importFrom memoise memoise
#' @keywords internal
    
mod_model_server <- function(input, output, session){
  ns <- session$ns
  
  mscenario_sim <- memoise::memoise(ringbp::scenario_sim)
  
  out <- reactive({
    res <- mscenario_sim(n.sim = 10, num.initial.cases = 10,prop.asym=0,
                         prop.ascertain = 0.2, cap_cases = 4500, cap_max_days = 350,
                         r0isolated = 0, r0community = 2.5, disp.com = 0.16, disp.iso = 1, delay_shape = 1.651524,
                         delay_scale = 4.287786,k = 0)
  })
  return(out)
}
  