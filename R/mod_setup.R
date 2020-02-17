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
#' @import shinyMobile
mod_setup_ui <- function(id){
  ns <- NS(id)
  
  tagList(
    f7Row(
      f7Col(    
        f7Card(title = "Outbreak settings",
               f7Slider(ns("num.initial.cases"),
                        label = "",
                        min = 5, 
                        max = 50, 
                        step = 5, 
                        value = 20),
               uiOutput(ns("num.initial.cases_label")),
               f7Slider(ns("r0community"),
                        label = NULL,
                        min = 0, 
                        max = 4,
                        value = 2.5,
                        step = 0.1),
               uiOutput(ns("r0community_label")),
               f7Slider(ns("dispcommunity"),
                        label = "",
                        min = 0, 
                        max = 4,
                        value = 0.16,
                        step = 0.01),
               uiOutput(ns("dispcommunity_label")),
               f7Slider(ns("r0isolated"),
                        label = "",
                        min = 0, 
                        max = 4,
                        value = 0,
                        step = 0.1),
               uiOutput(ns("r0isolated_label")),
               f7Slider(ns("dispisolation"),
                        label = "",
                        min = 0, 
                        max = 4,
                        value = 0.16,
                        step = 0.01),
               uiOutput(ns("dispisolation_label")),
               f7Radio(ns("theta"), 
                       label = "", 
                       choices = c("<1%",
                                   "15%",
                                   "30%"),
                       selected = "15%"),
               uiOutput(ns("theta_label")), 
               f7Slider(ns("prop.asym"),
                        label = "",
                        min = 0, 
                        max = 1,
                        value = 0.1,
                        step = 0.01),
               uiOutput(ns("prop.asym_label"))
        )
      ),
      f7Col(
        f7Card(title = "Run the model with current settings",
               actionButton(ns("go"), "Run")),
        f7Card(title = "Control settings",
               f7Slider(ns("prop.ascertain"),
                        label = "",
                        min = 0,
                        max = 1, 
                        value = 0.8,
                        step = 0.01),
               uiOutput(ns("prop.ascertain_label")),
               f7Radio(ns("delay"), 
                       label = "", 
                       choices = c("Short", 
                                   "Long"),
                       selected = "Short"),
               uiOutput(ns("delay_label")),
               # f7Radio(ns("quarantine"), 
               #         label = "", 
               #         choices = c("Symptom onset", "When contact traced"),
               #         selected = "Symptom onset")
               # uiOutput(ns("quarantine_label")),
        ),
        f7Card(title = "Assessment settings",
               f7Slider(ns("n_sim"),
                        label = "",
                        min = 1,
                        max = 20, 
                        value = 10,
                        step = 1),
               uiOutput(ns("n_sim_label")),
               f7Slider(ns("cap_cases"),
                        label = "",
                        min = 100,
                        max = 10000,
                        value = 5000, 
                        step = 100),
               uiOutput(ns("cap_cases_label")),
               f7Slider(ns("cap_max_days"),
                        label = "",
                        min = 10,
                        max = 700,
                        value = 365, 
                        step = 10),
               uiOutput(ns("cap_max_days_label"))
        )
      )
    )
  )
}
    
# Module Server
    
#' @rdname mod_setup
#' @export
#' @keywords internal
    
mod_setup_server <- function(input, output, session){
  ns <- session$ns
  
  ## Generic function to construct labels
  make_label <- function(label, var) {
      f7BlockHeader(paste0(label, 
                           var))
  }
  
  
  ## Outbreak reactive labels
  output$num.initial.cases_label <- renderUI({
    make_label("Number of initial cases: ", input$num.initial.cases)
  })
  
  output$r0community_label <- renderUI({
    make_label("Basic reproduction no. in the community: ", input$r0community)
  })
    
  output$dispcommunity_label <- renderUI({
    make_label("Dispersion of the reproduction no. in the community: ", 
               input$dispcommunity)
  })
  
  output$r0isolated_label <- renderUI({
    make_label("Basic reproduction no. in those isolated: ", input$r0isolated)
  })
  
  output$dispisolation_label <- renderUI({
    make_label( "Dispersion of the reproduction no. in those isolated: ", 
                input$dispisolation)
  })

  output$prop.asym_label <- renderUI({
    make_label( "Proportion of cases that are subclinical: ", 
                input$prop.asym)
  })
  
  output$theta_label <- renderUI({
    make_label( "Proportion of tranmission prior to symptom onset: ", 
                input$theta)
  })
  
  ## Control reactive labels
  
  output$prop.ascertain_label <- renderUI({
    f7BlockHeader(paste0("Contacts traced: ", 
                         round(100 * input$prop.ascertain, 0), "%"))
  })
  
  output$delay_label <- renderUI({
    make_label( "Delay from onset to isolation: ", 
                input$delay)
  })
  
  # output$quarantine_label <- renderUI({
  #   make_label( "Isolation at: ", 
  #               input$quarantine)
  # })
  
  ## Assessment settings
  
  output$n_sim_label <- renderUI({
    make_label("Number of model simulations to run: ", input$n_sim)
  })
  
  output$cap_cases_label <- renderUI({
    make_label( "The maximum number of cases to simulate: ", 
                input$cap_cases)
  })
  
  output$cap_max_days_label <- renderUI({
    f7BlockHeader(paste0("The maximum simulation time for the model: ", 
                input$cap_max_days, " days"))
  })
  
  return(input)
}
    
## To be copied in the UI
# mod_setup_ui("setup_ui_1")
    
## To be copied in the server
# callModule(mod_setup_server, "setup_ui_1")
 
