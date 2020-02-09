#' @import shiny
app_server <- function(input, output,session) {
  
  # Implement model settings
  setup <- callModule(mod_setup_server, "setup_ui_1")
  
  # Run the model simulation
  sims <- callModule(mod_model_server, "model_ui_1", setup)
  
  # Calculate the extinction probability
  extinct_prob <- callModule(mod_extinct_prob_server, "extinct_prob_ui_1", sims, setup)

  # SLice out a singe timepoint from the model simulation
  sliced_sims <- callModule(mod_slice_time_point_server, "slice_time_point_ui_1", sims)

  # Extract and summarise the effective R0
  effective_r0 <- callModule(mod_effective_r0_server, "effective_r0_ui_1", sliced_sims)

  # Extract and summarise cases per generation
  cases_per_gen <- callModule(mod_cases_per_gen_server, "cases_per_gen_ui_1", sliced_sims)

  output$extinct_prob <- renderText({
    extinct_prob() 
  })

  output$effective_r0 <- renderDataTable({
    effective_r0()
  })

  output$cases_per_gen <- renderDataTable({
    cases_per_gen()
  })

}
