# Module UI
  
#' @title   mod_slice_time_point_ui and mod_slice_time_point_server
#' @description  Slice out a single time point from each model simulation
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_slice_time_point
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_slice_time_point_ui <- function(id){
  ns <- NS(id)
  tagList(
  
  )
}
    
# Module Server
    
#' @rdname mod_slice_time_point
#' @param sims dataframe of model simulations
#' @export
#' @importFrom dplyr group_by slice ungroup
#' @keywords internal
    
mod_slice_time_point_server <- function(input, output, session, sims){
  ns <- session$ns
  
  
  sliced_sims <- reactive({
     sims() %>% 
      dplyr::group_by(sim) %>% 
      dplyr::slice(1) %>% 
      dplyr::ungroup()
  })
  
  return(sliced_sims)
}
    
