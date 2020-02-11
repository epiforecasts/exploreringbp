
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Explore the feasibility of controlling 2019-nCoV outbreaks by isolation of cases and contacts

This application allows interactive exploration of individual contact
tracing and isolation scenarios for the 2019-nCoV outbreak using the
branching process model developed in [“Feasibility of
controlling 2019-nCoV outbreaks by isolation of cases and
contacts”](https://cmmid.github.io/ncov/isolation_contact_tracing/) by
Hellewell et al. For more details on the model used or the scenarios
considered please see the paper.

## Running the app

Install the application and required dependencies with the
following:

``` r
remotes::install_github("epiforecasts/exploreringbp", dependencies = TRUE)
```

For use cases in which high loads are expected the app can be run in
parallel using the `future` package. *This step is optional.*

``` r
## For high load settings with multiple cores available
future::plan("multisession")
```

Run the app locally.

``` r
exploreringbp::run_app()
```

## Usage

The results tab contains a summary of a single outbreak scenario.

<img src="man/figures/results.png" width="100%" />

The settings tab contains sliders which can be used to vary the outbreak
scenario.

<img src="man/figures/settings.png" width="100%" />

The details tab contains a brief overview of the model used in the app
and links to resources for further information.

<img src="man/figures/details.png" width="100%" />

## Docker

This app was developed in a docker container based on the tidyverse
docker image.

To build the docker image run (from the `exploreringbp` directory):

``` bash
docker build . -t exploreringbp
```

To run the docker image
run:

``` bash
docker run -d -p 8787:8787 --name exploreringbp -e USER=exploreringbp -e PASSWORD=exploreringbp exploreringbp
```

The rstudio client can be found on port :8787 at your local machines ip.
The default username:password is exploreringbp:exploreringbp, set the
user with -e USER=username, and the password with - e
PASSWORD=newpasswordhere.
