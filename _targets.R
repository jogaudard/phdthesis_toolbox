# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
library(tarchetypes)
# library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  packages = c(
    "quarto",
    "tibble",
    "googlesheets4",
    "plume",
    "tidyverse",
    "rticles",
    "knitr"
  ) # Packages that your targets need for their tasks.
  # format = "qs", # Optionally set the default storage format. qs is fast.
  #
  # Pipelines that take a long time to run may benefit from
  # optional distributed computing. To use this capability
  # in tar_make(), supply a {crew} controller
  # as discussed at https://books.ropensci.org/targets/crew.html.
  # Choose a controller that suits your needs. For example, the following
  # sets a controller that scales up to a maximum of two workers
  # which run as local R processes. Each worker launches when there is work
  # to do and exits if 60 seconds pass with no tasks to run.
  #
  #   controller = crew::crew_controller_local(workers = 2, seconds_idle = 60)
  #
  # Alternatively, if you want workers to run on a high-performance computing
  # cluster, select a controller from the {crew.cluster} package.
  # For the cloud, see plugin packages like {crew.aws.batch}.
  # The following example is a controller for Sun Grid Engine (SGE).
  #
  #   controller = crew.cluster::crew_controller_sge(
  #     # Number of workers that the pipeline can scale up to:
  #     workers = 10,
  #     # It is recommended to set an idle time so workers can shut themselves
  #     # down if they are not running tasks.
  #     seconds_idle = 120,
  #     # Many clusters install R as an environment module, and you can load it
  #     # with the script_lines argument. To select a specific verison of R,
  #     # you may need to include a version string, e.g. "module load R/4.3.2".
  #     # Check with your system administrator if you are unsure.
  #     script_lines = "module load R"
  #   )
  #
  # Set other options as needed.
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source() # Source other scripts as needed.
# tar_source("other_functions.R") # Source other scripts as needed.

# Replace the target list below with your own:
list(
  tar_target(
    name = authors_paper1,
    command = read_sheet(gs4_find("authors_paper1"))
  ),
  tar_target(
    name = authors_paper2,
    command = read_sheet(gs4_find("authors_paper2"))
  ),
  tar_target(
    name = contrib_paper1,
    command = contrib_paper(authors_paper1)
  ),
  tar_target(
    name = contrib_paper2,
    command = contrib_paper(authors_paper2)
  ),
  tar_target(
    name = contributions_tbl_paper1,
    command = contrib_paper_tbl(
      aut_vec = contrib_paper1,
      paper_name = "Paper 1",
      initials = "J-BD" # the initials you want in bold
    )
  ),
  tar_target(
    name = contributions_tbl_paper2,
    command = contrib_paper_tbl(
      aut_vec = contrib_paper2,
      paper_name = "Paper 2",
      initials = "J-BD"
    )
  ),
  tar_target(
    name = contrib_tbl,
    command = full_join(
      contributions_tbl_paper1,
      contributions_tbl_paper2,
      by = "Role")
  ),
  tar_target(
    name = all_authors,
    command = authors_list(
      ranks = c(1, 2, 3, 3),
      authors_paper1,
      authors_paper2
    )
  ),
  tar_quarto(
    name = render_authorship_statement,
    path = "authorship_statement.qmd",
    extra_files = c(
      "phd_papers.bib"
    )
  ),
  tar_quarto(
    name = render_paper_list,
    path = "paper_list.qmd",
    extra_files = c(
      "phd_papers.bib",
      "others.bib"
    )
  ),
  tar_quarto(
    name = render_thesis,
    path = "phdthesis.qmd",
    extra_files = c(
      "paper_list.md"
    )
  )
)
