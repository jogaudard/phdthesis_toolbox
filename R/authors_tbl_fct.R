authors_tbl_fct <- function(authors_paper1, authors_paper2){
   
# paper_author_lists = c()
paper1_authors <- read_sheet(gs4_find(authors_paper1))

aut_paper1 <- Plume$new(paper1_authors)
contributions_paper1 <- aut_paper1$get_contributions(
  dotted_initials = FALSE,
  sep_last = ", "
) |>
c()

paper2_authors <- read_sheet(gs4_find(authors_paper2))

aut_paper2 <- Plume$new(paper2_authors)
contributions_paper2 <- aut_paper2$get_contributions(
  dotted_initials = FALSE,
  sep_last = ", "
) |>
c()

contrib_paper <- function(
  aut_vec, # a vector of author contributions as produced with aut$get_contributions() |> c()
  paper_name, # name of the paper
  split = ": " # same as divider in get_contributions
){
lapply(aut_vec, string_to_table, n = 2, split_regex = split) |>
  bind_rows() |>
  rename(
    Role = "X1",
    {{paper_name}} := "X2"
  )
}




contrib_paper1 <- contrib_paper(
  contributions_paper1,
  "Paper I"
)

contrib_paper2 <- contrib_paper(
  contributions_paper2,
  "Paper II"
)

contrib_tbl <- full_join(
  contrib_paper1,
  contrib_paper2,
  by = "Role"
)

contrib_tbl
}
