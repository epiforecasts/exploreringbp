# Module UI
  
#' @title   mod_run_model_ui and mod_run_model_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_run_model
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_run_model_ui <- function(id){
  ns <- NS(id)
  tagList(
  
  )
}
    
# Module Server
    
#' @rdname mod_run_model
#' @export
#' @keywords internal
    
mod_run_model_server <- function(input, output, session){
  ns <- session$ns
  
  
  out <- reactive({
    ringbp::scenario_sim(n.sim = 10, num.initial.cases = 10,prop.asym=0,
                         prop.ascertain = 0.2, cap_cases = 4500, cap_max_days = 350,
                         r0isolated = 0, r0community = 2.5, disp.com = 0.16, disp.iso = 1, delay_shape = 1.651524,
                         delay_scale = 4.287786,k = 0)
  })
  return(out)
}
    
## To be copied in the UI
# mod_run_model_ui("run_model_ui_1")
    
## To be copied in the server
# callModule(mod_run_model_server, "run_model_ui_1")
 
