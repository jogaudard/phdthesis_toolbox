authors <- function(authors_paper){
   
# paper_author_lists = c()
paper_authors <- read_sheet(gs4_find(authors_paper))

aut_paper <- Plume$new(paper_authors, dotted_initials = FALSE)
contributions_paper1 <- aut_paper$get_contributions(
  # dotted_initials = FALSE,
  sep_last = ", "
) |>
c()

contributions_paper1}


contrib_paper <- function(
  aut_vec, # a vector of author contributions as produced with aut$get_contributions() |> c()
  paper_name, # name of the paper
  split = ": ", # same as divider in get_contributions
  initials
){


lapply(aut_vec, string_to_table, n = 2, split_regex = split) |>
  bind_rows() |>
  rename(
    Role = "X1"
    # {{paper_name}} := "X2"
  ) |>
  mutate(
    {{paper_name}} := str_replace_all(X2, initials, "**\\0**")
  ) |>
  select(!X2)
}


# contrib_paper <- function(
#   aut_vec, # a vector of author contributions as produced with aut$get_contributions() |> c()
#   paper_name, # name of the paper
#   split = ": " # same as divider in get_contributions
# ){
# lapply(aut_vec, string_to_table, n = 2, split_regex = split) |>
#   bind_rows() |>
#   rename(
#     Role = "X1",
#     {{paper_name}} := "X2"
#   )
# }


