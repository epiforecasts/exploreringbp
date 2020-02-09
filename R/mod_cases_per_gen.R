# Module UI
  
#' @title   mod_cases_per_gen_ui and mod_cases_per_gen_server
#' @description  Extract and summarise the number of cases per generation
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_cases_per_gen
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_cases_per_gen_ui <- function(id){
  ns <- NS(id)
  tagList(
  
  )
}
    
# Module Server
    
#' @rdname mod_cases_per_gen
#' @export
#' @importFrom dplyr mutate group_by summarise n
#' @importFrom purrr map
#' @importFrom tibble tibble
#' @importFrom tidyr unnest
#' @importFrom promises %...>%
#' @keywords internal
    
mod_cases_per_gen_server <- function(input, output, session, sliced_sims){
  ns <- session$ns
  
  
  generation_sizes <- reactive({
    sliced_sims() %...>% 
      dplyr::mutate(cases_per_gen = purrr::map(cases_per_gen,
                                               ~ tibble::tibble(gen = 1:length(.),
                                                                cases = .))
      ) %...>% 
      tidyr::unnest("cases_per_gen") %...>% 
      dplyr::group_by(gen) %...>% 
      dplyr::summarise(
        bottom = quantile(cases, 0.025, na.rm = TRUE),
        lower = quantile(cases, 0.25, na.rm = TRUE),
        median = median(cases, na.rm = TRUE),
        upper = quantile(cases, 0.75, na.rm = TRUE),
        top = quantile(cases, 0.975, na.rm = TRUE),
        sims = dplyr::n()
      ) 
  })
  
  return(generation_sizes)
}
    
 
