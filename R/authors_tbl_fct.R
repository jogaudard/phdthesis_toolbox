
contrib_paper <- function(paper_authors){
   
# paper_author_lists = c()
# paper_authors <- read_sheet(gs4_find(authors_paper))

aut_paper <- Plume$new(paper_authors, dotted_initials = FALSE)

contributions_paper <- aut_paper$get_contributions(
  # dotted_initials = FALSE,
  sep_last = ", "
) |>
c()

contributions_paper
}


contrib_paper_tbl <- function(
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


authors_list <- function(ranks, ...) {
  authors <- bind_rows(...)
  authors <- authors |>
  select(given_name, family_name, affiliation_1, affiliation_2) |>
  unique() |>
  # pass this as comments first to see what the order is, and then attribute ranking and arrange
  mutate( # we add ranking to sort by me, supervisors, others
    ranking = ranks
  ) |>
  arrange(ranking, family_name)

  authors
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


