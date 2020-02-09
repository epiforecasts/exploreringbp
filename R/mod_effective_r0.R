# Module UI
  
#' @title   mod_effective_r0_ui and mod_effective_r0_server
#' @description  Extract and summarise the effective R0
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_effective_r0
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_effective_r0_ui <- function(id){
  ns <- NS(id)
  tagList(
  )
}
    
# Module Server
    
#' @rdname mod_effective_r0
#' @param sliced_sims A single timepoint from each model simulation
#' @export
#' @importFrom dplyr summarise
#' @keywords internal
    
mod_effective_r0_server <- function(input, output, session, sliced_sims){
  ns <- session$ns
  
  effective_r0 <- reactive({
    effective_r0 <- sliced_sims() %>% 
      dplyr::summarise(
        bottom = quantile(effective_r0, 0.025, na.rm = TRUE),
        lower = quantile(effective_r0, 0.25, na.rm = TRUE),
        median = median(effective_r0, na.rm = TRUE),
        upper = quantile(effective_r0, 0.75, na.rm = TRUE),
        top = quantile(effective_r0, 0.975, na.rm = TRUE)
      )
  })
  
  return(effective_r0)
}
    
## To be copied in the server
# callModule(mod_effective_r0_server, "effective_r0_ui_1")
 
