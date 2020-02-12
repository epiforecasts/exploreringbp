
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
    f7Card(
      title = "Outbreak trajectories",
      plotOutput(ns("trace_plot"))
    )
  )
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
    quarantine <- params$quarantine
    disp.com <- params$dispcommunity
    disp.iso <- params$dispisolation
    if (params$delay %in% "Short") {
      delay_shape = 1.651524
      delay_scale = 4.287786
    }else if (params$delay %in% "Long") {
      delay_shape = 2.305172
      delay_scale = 9.483875
    }
    if (params$theta %in% "<1%") {
      k <- 30
    }else if (params$theta %in% "15%"){
      k <- 1.95
    }else if (params$theta %in% "30%"){
      k <- 0.7
    }
    # if (params$quarantine %in% "Symptom onset") {
    #   quarantine <- FALSE
    # }else{
    #   quarantine <- TRUE
    # }
    
    ## Run as a background process and cache results
    future({mscenario_sim(n.sim = n.sim, 
                          num.initial.cases = num.initial.cases,
                           prop.asym = prop.asym,
                           prop.ascertain = prop.ascertain, 
                           cap_cases = cap_cases, 
                           cap_max_days = cap_max_days,
                           r0isolated = r0isolated, 
                           r0community = r0community, 
                           disp.com = disp.com, 
                           disp.iso = disp.iso, 
                           delay_shape = delay_shape,
                           delay_scale = delay_scale, 
                           k = k,
                         #  quarantine = quarantine
                           )})
  }, ignoreNULL = FALSE)
  
  
  output$trace_plot <- renderPlot({
    out() %...>% {
      exploreringbp::plot_traces(.)
    }
  })
  
  return(out)
}
  