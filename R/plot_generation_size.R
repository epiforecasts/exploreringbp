#' Plot cases per generation
#'
#' @param generation_sizes A dataframe containing cases per generation
#'
#' @return A `ggplot2` object plotting cases per generation
#' @export
#'
#' @importFrom ggplot2 ggplot aes geom_ribbon geom_point geom_line theme guide_legend guides scale_colour_brewer scale_fill_brewer
#' @importFrom cowplot theme_cowplot
#' @examples
#' 
#' 
plot_generation_size <- function(generation_sizes) {
  plot <- ggplot2::ggplot(generation_sizes, 
                           ggplot2::aes(x = gen, y = median, 
                                        col = control, fill = control)) +
    ggplot2::geom_ribbon(ggplot2::aes(ymin = bottom, ymax = top, col = NULL), 
                         alpha = 0.1, show.legend = FALSE) +
    ggplot2::geom_ribbon(ggplot2::aes(ymin = lower, ymax = upper, col = NULL), 
                         alpha = 0.3, show.legend = FALSE) +
    ggplot2::geom_point(aes(size = sims), alpha = 0.4) +
    ggplot2::geom_line(alpha = 1, show.legend = FALSE) +
    cowplot::theme_cowplot() +
    ggplot2::labs(
      x = "Outbreak generation",
      y = "Cases in generation"
    ) +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::scale_size_continuous(breaks = seq(2, max(generation_sizes$sims), 2)) +
    ggplot2::scale_colour_brewer(palette = "Set1", direction = -1, guide = FALSE) +
    ggplot2::scale_fill_brewer(palette = "Set1", direction = -1, guide = FALSE) +
    ggplot2::guides(size = ggplot2::guide_legend(title = "Simulations that reach this generation"))
  return(plot)
}