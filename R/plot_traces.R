#' Plot outbreak traces
#'
#' @param sims A dataframe produced by `ringbp::scenarios_sims`.
#'
#' @return A `ggplot2` plot of outbreak traces
#' @export
#' @importFrom ggplot2 ggplot aes geom_line scale_y_continuous labs scale_colour_brewer guides guide_legend theme scale_y_log10
#' @importFrom cowplot theme_cowplot
#' @examples
#' 
#' 
plot_traces <- function(sims, log = FALSE) {
  plot <- sims %>% 
  ggplot2::ggplot(ggplot2::aes(x=week, y=cumulative, 
                               group = as.factor(sim),
                               col = control)) + 
    ggplot2::geom_line(show.legend = TRUE, alpha=0.5, size = 1.1) +
    ggplot2::labs(x = "Weeks since start of outbreak", y = "Number of cases") +
    cowplot::theme_cowplot() +
    ggplot2::scale_colour_brewer(palette = "Set1", direction = -1) +
    ggplot2::guides(colour = ggplot2::guide_legend(title = "")) +
    ggplot2::theme(legend.position = "bottom")
    
  if (log) {
    plot <- plot + 
      ggplot2::scale_y_log10()
  }
  
    return(plot)
}