
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
    actionButton(ns("go"), "Simulate"),
    sliderInput(ns("prop.ascertain"),
                label = "Control effectiveness:",
                min = 0,
                max = 1, 
                value = 0.8,
                step = 0.1),
    sliderInput(ns("num.initial.cases"),
                label = "Number of initial cases:",
                min = 1, 
                max = 50, 
                step = 1, 
                value = 20),
    sliderInput(ns("r0community"),
                label = "Basic reproduction no. in the community:",
                min = 0, 
                max = 4,
                value = 2.5,
                step = 0.1),
    sliderInput(ns("r0isolated"),
                label = "Basic reproduction no. in those isolated:",
                min = 0, 
                max = 4,
                value = 0,
                step = 0.1),
    sliderInput(ns("prop.asym"),
                label = "Proportion of cases that are asymptomatic:",
                min = 0, 
                max = 1,
                value = 0.1,
                step = 0.1)
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
  
  out <-  eventReactive(input$go, {
    res <- mscenario_sim(n.sim = 10, 
                         num.initial.cases = input$num.initial.cases,
                         prop.asym= input$prop.asym,
                         prop.ascertain = input$prop.ascertain, 
                         cap_cases = 4500, 
                         cap_max_days = 350,
                         r0isolated = input$r0community, 
                         r0community = input$r0community, 
                         disp.com = 0.16, 
                         disp.iso = 1, 
                         delay_shape = 1.651524,
                         delay_scale = 4.287786,k = 0)
  }, ignoreNULL = FALSE)
  
  return(out)
}
  