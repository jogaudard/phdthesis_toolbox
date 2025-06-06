
# A PhD thesis with many co-authors

At the University of Bergen (probably other places too), it is required
to have a table presenting the author contributions from all the papers
included in the thesis. Doing it manually is prone to errors, or
forgetting to update, and annoying if some papers had many co authors.
Here I am showing how I did it for me. It is not a super elegant
solution, but it works, it is automated and I thought I’d share in case
it is useful to others. We are going to use the Plume R package Gallou
(2024), the [multibib
extension](https://github.com/wlupton/pandoc-multibib) and the
[bold-author
filter](https://stackoverflow.com/questions/76394078/format-specific-authors-with-bold-font-in-bibliography-created-with-quarto/76429867#76429867).
Additional resources used in this tutorial were found in this [blog
post](https://www.andrewheiss.com/blog/2023/12/11/separate-bibliographies-quarto/).
If you use this repo as a template you should be all set.

# References and list of papers

I have three bib files:

- Papers that are included in the thesis (`phd_paper.bib`)
- Papers and outreach pieces that are not included but were done during
  the time of the thesis (`others.bib`)
- Standard bibliography as produced by Zotero (`refs_list.bib`).

I use multibib to call them at different places. In the yaml, I add
`nocite:` with the keys of the items from `phd_paper.bib` and
`others.bib` since there are not cited in the text. Note that if no
items from one of the bibliographies is called, it will throw an error.
Which means that when you are just starting, you should just call at
least one reference of each to be able to render.

# Table with author contributions

To setup the Plume workflow, I can only point to Arnaud’s excellent
[documentation](https://arnaudgallou.github.io/plume/index.html).
Ideally you have done that for the papers already, so the google sheets
with author contributions are all set and you can reuse them. In the
code bloc `contributions`, I wrote the `contrib_paper` function that
transforms the output of Plume into a table. Then the tables of the
different papers are joined together (use `full_join` in case some
contributions appear for one paper and not the others).

# List of authors with affiliations

The list of authors and affiliations is produced with Plume. The only
tricks here are to first bind together the author tables from the
different paper, apply unique to avoid duplicates, and add a ranking
(optional). The ranking allows you to force the order if you want to
have everyone in alphabetical order, but yourself first following by
your supervisors and then the other co authors.

### References

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0" line-spacing="2">

<div id="ref-gallouPlumeSimpleAuthor2024" class="csl-entry">

Gallou, A. (2024), *Plume: A Simple Author Handler for Scientific
Writing*, Manual,.

</div>

</div>
