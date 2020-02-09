
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

}
    
    
#' @rdname mod_model
#' @param params A list of inputs for the model
#' @export
#' @importFrom ringbp scenario_sim
#' @importFrom memoise memoise
#' @importFrom future future
#' @keywords internal
    
mod_model_server <- function(input, output, session, params){
  
  ns <- session$ns
  
  mscenario_sim <- memoise::memoise(ringbp::scenario_sim)
  
  out <-  eventReactive(params$go, {
    ## Define parameters for future
    n.sim <- params$n_sim
    num.initial.cases <- params$num.initial.cases
    prop.asym <- params$prop.asym
    prop.ascertain <- params$prop.ascertain
    cap_cases  <- params$cap_cases 
    cap_max_days <- params$cap_max_days
    r0isolated <- params$r0isolated
    r0community <- params$r0community
    
    ## Run as a background process and cache results
    future({mscenario_sim(n.sim = n.sim, #params$n_sim, 
                          num.initial.cases = num.initial.cases,
                           prop.asym = prop.asym,
                           prop.ascertain = prop.ascertain, 
                           cap_cases = cap_cases, 
                           cap_max_days = cap_max_days,
                           r0isolated = r0isolated, 
                           r0community = r0community, 
                           disp.com = 0.16, 
                           disp.iso = 1, 
                           delay_shape = 1.651524,
                           delay_scale = 4.287786, k = 0)})
  }, ignoreNULL = FALSE)
  
  return(out)
}
  