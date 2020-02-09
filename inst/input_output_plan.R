library(ringbp)
library(ggplot2)
library(dplyr)
library(memoise)

mscenario_sim <- memoise(ringbp::scenario_sim)

res <- mscenario_sim(n.sim = 10, num.initial.cases = 10,prop.asym=0,
                              prop.ascertain = 0.2, cap_cases = 4500, cap_max_days = 350,
                              r0isolated = 0, r0community = 2.5, disp.com = 0.16, disp.iso = 1, delay_shape = 1.651524,
                              delay_scale = 4.287786,k = 0)

# Plot of weekly cases
ggplot2::ggplot(data=res, ggplot2::aes(x=week, y=cumulative, col=as.factor(sim))) +
  ggplot2::geom_line(show.legend = FALSE, alpha=0.3) +
  ggplot2::scale_y_continuous(name="Number of cases") + 
  ggplot2::theme_bw()

ringbp::extinct_prob(res,cap_cases = 4500)

single_time_point_per_sim <- res %>% 
  dplyr::group_by(sim) %>% 
  dplyr::slice(1) %>% 
  dplyr::ungroup()


effective_r0 <- single_time_point_per_sim %>% 
  dplyr::summarise(
    bottom = quantile(effective_r0, 0.025, na.rm = TRUE),
    lower = quantile(effective_r0, 0.25, na.rm = TRUE),
    median = median(effective_r0, na.rm = TRUE),
    upper = quantile(effective_r0, 0.75, na.rm = TRUE),
    top = quantile(effective_r0, 0.975, na.rm = TRUE)
  )

generation_sizes <- single_time_point_per_sim %>% 
  dplyr::mutate(cases_per_gen = purrr::map(cases_per_gen,
                                    ~ tibble::tibble(gen = 1:length(.),
                                           cases = .))
  ) %>% 
  tidyr::unnest("cases_per_gen") %>% 
  dplyr::group_by(gen) %>% 
  dplyr::summarise(
    bottom = quantile(cases, 0.025, na.rm = TRUE),
    lower = quantile(cases, 0.25, na.rm = TRUE),
    median = median(cases, na.rm = TRUE),
    upper = quantile(cases, 0.75, na.rm = TRUE),
    top = quantile(cases, 0.975, na.rm = TRUE),
    sims = dplyr::n()
  ) %>% 
  dplyr::ungroup()

ggplot2::ggplot(generation_sizes, 
                ggplot2::aes(x = gen, y = median)) +
  ggplot2::geom_ribbon(ggplot2::aes(ymin = bottom, ymax = top), alpha = 0.1) +
  ggplot2::geom_ribbon(ggplot2::aes(ymin = lower, ymax = upper), alpha = 0.4) +
  ggplot2::geom_point(ggplot2::aes(size = sims)) +
  ggplot2::geom_line()