# Module UI
  
#' @title   mod_setup_ui and mod_setup_server
#' @description A module for setting up input parameters
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_setup
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
#' @importFrom shinyWidgets prettyRadioButtons
#' @import shinyMobile
mod_setup_ui <- function(id){
  ns <- NS(id)
  tagList(
    f7Card(title = "Run the model with current settings",
           actionButton(ns("go"), "Run")
    ),
    f7Card(title = "Outbreak settings",
    f7Slider(ns("num.initial.cases"),
             label = "Number of initial cases:",
             min = 1, 
             max = 50, 
             step = 1, 
             value = 20),
    f7Slider(ns("r0community"),
             label = "Basic reproduction no. in the community:",
             min = 0, 
             max = 4,
             value = 2.5,
             step = 0.1),
    f7Slider(ns("r0isolated"),
             label = "Basic reproduction no. in those isolated:",
             min = 0, 
             max = 4,
             value = 0,
             step = 0.1),
    f7Slider(ns("prop.asym"),
             label = "Proportion of cases that are asymptomatic:",
             min = 0, 
             max = 1,
             value = 0.1,
             step = 0.1)
    ),
    f7Card(title = "Control settings",
    f7Slider(ns("prop.ascertain"),
             label = "Control effectiveness:",
             min = 0,
             max = 1, 
             value = 0.8,
             step = 0.1)
    ),
    f7Card(title = "Assessment settings",
           f7Slider(ns("n_sim"),
                    label = "Number of model simulations to run:",
                    min = 1,
                    max = 100, 
                    value = 10,
                    step = 1),
           f7Slider(ns("cap_cases"),
                    label = "The maximum number of cases to simulate:",
                    min = 100,
                    max = 10000,
                    value = 4500, 
                    step = 100),
           f7Slider(ns("cap_max_days"),
                    label = "The maximum simulation time for the model:",
                    min = 10,
                    max = 700,
                    value = 350, 
                    step = 10)
           )
  )
}
    
# Module Server
    
#' @rdname mod_setup
#' @export
#' @keywords internal
    
mod_setup_server <- function(input, output, session){
  ns <- session$ns
  return(input)
}
    
## To be copied in the UI
# mod_setup_ui("setup_ui_1")
    
## To be copied in the server
# callModule(mod_setup_server, "setup_ui_1")
 
