#' Plot outbreak traces
#'
#' @param sims A dataframe produced by `ringbp::scenarios_sims`.
#'
#' @return A `ggplot2` plot of outbreak traces
#' @export
#' @importFrom ggplot2 ggplot aes geom_line scale_y_continuous labs
#' @importFrom cowplot theme_cowplot
#' @examples
#' 
#' 
plot_traces <- function(sims) {
  plot <- sims %>% 
  ggplot2::ggplot(ggplot2::aes(x=week, y=cumulative, group = as.factor(sim))) +
    ggplot2::geom_line(show.legend = FALSE, alpha=0.2, size = 1.1) +
    ggplot2::scale_y_continuous(name="Number of cases") + 
    ggplot2::labs(x = "Weeks since start of outbreak") +
    cowplot::theme_cowplot()
    
    return(plot)
}