#' @import shiny
#' @import shinyMobile
#' @import waiter
app_ui <- function() {
  version <- paste0("v", packageVersion("exploreringbp"))
  
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    f7Page(
      title = "Explore the feasibility of controlling 2019-nCoV outbreaks by isolation of cases and contacts",
      preloader = FALSE,
      init = f7Init(
        skin = "md", 
        color = "gray",
        theme = "light"
      ),
      f7TabLayout(
        navbar = f7Navbar(
          title = "Explore the feasibility of controlling 2019-nCoV outbreaks by isolation of cases and contacts",
          hairline = FALSE,
          shadow = TRUE,
          left_panel = TRUE,
          right_panel = FALSE
        ),
          panels = 
            tagList(
              f7Panel(
                title = "About", 
                side = "left", 
                theme = "light",
                effect = "cover",
                p(includeRMarkdown(system.file("app/www/markdown/what_does_this_app_do.Rmd", package = "exploreringbp"))),
                f7Link(label = "Authors", src = "https://cmmid.github.io/ncov", external = TRUE),
                f7Link(label = "Application code", src = "https://github.com/epiforecasts/exploreringbp", 
                       external = TRUE
                ),
                f7Link(label = "Model code", src = "https://github.com/epiforecasts/ringbp", 
                       external = TRUE
                ),
                tags$pre(tags$code(version))
              )),
              f7Tabs(
                animated = TRUE,
                id = 'tabs',
                f7Tab(
                  tabName = "Results",
                  icon = f7Icon("square_line_vertical_square_fill"),
                  active = TRUE,
                  waiter::waiter_show_on_load(loader),
                  waiter::waiter_hide_on_render("model_ui_1-trace_plot"),
                  f7Row(
                    f7Col(
                      mod_extinct_prob_ui("extinct_prob_ui_1")
                    ),
                    f7Col(
                      mod_effective_r0_ui("effective_r0_ui_1")
                    )
                  ),
                  f7Row(
                    f7Col(
                      mod_model_ui("model_ui_1")
                    ),
                    f7Col(
                      mod_cases_per_gen_ui("cases_per_gen_ui_1")
                    )
                  ),
                  mod_setup_ui("setup_ui_1"),
                  h1("")
                ),
                f7Tab(
                  tabName = "Details",
                  icon = f7Icon("square_line_vertical_square_fill"),
                  active = FALSE,
                  f7Card(
                    title = "What does this app do?",
                    includeRMarkdown(system.file("app/www/markdown/what_does_this_app_do.Rmd", package = "exploreringbp"))
                  ),
                  f7Card(
                    title = "Learning more",
                    includeRMarkdown(system.file("app/www/markdown/learning_more.Rmd", package = "exploreringbp"))
                  )
                )
              )
         )
      )
    )
}

#' @import shiny
golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'exploreringbp')
  )
 
  tags$head(
    golem::activate_js(),
    golem::favicon(),
    waiter::use_waiter(include_js = FALSE)
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}

loader <- tagList(
  waiter::spin_loaders(42),
  br(),
  h3("Simulating outbreaks")
)