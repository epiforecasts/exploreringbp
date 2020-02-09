#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  sims <- callModule(mod_run_model_server, "run_model_ui_1")
  
  
  output$table <- renderDataTable({
    sims()
  })
}
