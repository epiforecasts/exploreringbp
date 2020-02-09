#' Plot cases per generation
#'
#' @param generation_sizes A dataframe containing cases per generation
#'
#' @return A `ggplot2` object plotting cases per generation
#' @export
#'
#' @importFrom ggplot2 ggplot aes geom_ribbon geom_point geom_line theme guide_legend guides
#' @importFrom cowplot theme_cowplot
#' @examples
#' 
#' 
plot_generation_size <- function(generation_sizes) {
  plot <-  ggplot2::ggplot(generation_sizes, 
                           ggplot2::aes(x = gen, y = median)) +
    ggplot2::geom_ribbon(ggplot2::aes(ymin = bottom, ymax = top), alpha = 0.1) +
    ggplot2::geom_ribbon(ggplot2::aes(ymin = lower, ymax = upper), alpha = 0.3) +
    ggplot2::geom_point(ggplot2::aes(size = as.integer(sims)), alpha = 0.4) +
    ggplot2::geom_line() +
    cowplot::theme_cowplot() +
    ggplot2::labs(
      x = "Outbreak generation",
      y = "Cases in generation"
    ) +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::guides(size = ggplot2::guide_legend(title = "Simulations that reach this generation"))
  
  return(plot)
}