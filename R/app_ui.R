#' @import shiny
#' @import shinyMobile
#' @import waiter
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    f7Page(
      title = "Explore: Feasibility of controlling 2019-nCoV outbreaks by isolation of cases and contacts",
      preloader = TRUE,
      init = f7Init(
        skin = "md", 
        color = "gray",
        theme = "light"
      ),
      f7TabLayout(
        navbar = f7Navbar(
          title = "Explore: Feasibility of controlling 2019-nCoV outbreaks by isolation of cases and contacts",
          hairline = FALSE,
          shadow = TRUE,
          left_panel = TRUE,
          right_panel = FALSE
        ),
        panels = tagList(
          f7Panel(
            title = "About", 
            side = "left", 
            theme = "light",
            effect = "cover",
            p("Explore: Feasibility of controlling 2019-nCoV outbreaks by isolation of cases and contacts"),
            f7Link(label = "Authors", src = "https://cmmid.github.io/ncov", external = TRUE),
            f7Link(label = "App code", src = "https://github.com/epiforecasts/exploreringbp", 
                   external = TRUE
          ),
          f7Link(label = "Model code", src = "https://github.com/epiforecasts/ringbp", 
                 external = TRUE
          )
        ),
        f7Tabs(
          animated = TRUE,
          id = 'tabs',
          f7Tab(
            tabName = "Results",
            icon = f7Icon("square_line_vertical_square_fill"),
            active = TRUE,
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
            )
          ),
          f7Tab(
            tabName = "Settings",
            icon = f7Icon("rectangle_3_offgrid"),
            active = FALSE,
            mod_setup_ui("setup_ui_1"),
            h1("")
          ),
          f7Tab(
            tabName = "Details",
            icon = f7Icon("square_line_vertical_square_fill"),
            active = FALSE,
            f7Card(
              title = "Summary",
              "In this section give a brief overview of the model. What it is, who made it and 
              what it can be used for (i.e a shortened version of the blog post.)"
            ),
            f7Card(
              title = "Learning more",
              "In this section link out to the model preprint and add contact details for the corresponding 
              author. Could also potentially link out to whatever instructions are written for the App (i.e 
              as done by Billy and team."
            )
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
    golem::favicon()
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}

