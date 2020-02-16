#' Plot outbreak traces
#'
#' @param sims A dataframe produced by `ringbp::scenarios_sims`.
#'
#' @return A `ggplot2` plot of outbreak traces
#' @export
#' @importFrom ggplot2 ggplot aes geom_line scale_y_continuous labs scale_colour_brewer guides guide_legend theme
#' @importFrom cowplot theme_cowplot
#' @examples
#' 
#' 
plot_traces <- function(sims) {
  plot <- sims %>% 
  ggplot2::ggplot(ggplot2::aes(x=week, y=cumulative, 
                               group = as.factor(sim),
                               col = control)) + 
    ggplot2::geom_line(show.legend = TRUE, alpha=0.5, size = 1.1) +
    ggplot2::scale_y_continuous(name="Number of cases") + 
    ggplot2::labs(x = "Weeks since start of outbreak") +
    cowplot::theme_cowplot() +
    ggplot2::scale_colour_brewer(palette = "Set1", direction = -1) +
    ggplot2::guides(colour = ggplot2::guide_legend(title = "")) +
    ggplot2::theme(legend.position = "bottom")
    
    return(plot)
}