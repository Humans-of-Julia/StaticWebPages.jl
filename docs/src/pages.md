# Pages

A page is composed of a name and a list of sections which can each be either single or double column. Each section is either a single `Item` or a pair of `Item`s.

##### A publication page with only one single column section (by default, publications spread over two columns on large screens)

```julia
######################################
# publications.html
#   option 1: background for the page is set to start with white to emphasize the bibliographic items
######################################
page(
    title="publications",
    background=bg_white,
    sections=[
        Section(
            title="Publications",
            items=Publications("publications.bib")
        )
    ]
)
```

##### An index page with a TextSection and a double column (Card, TimeLine)

```julia
######################################
# index.html
# biography
# academic positions | honors, awards, and grants
######################################

# using previously defined items, we can define sections
section_biography = Section(title="Biography", items=biography)
positions_grants = Double(
    Section(title="Positions", items=work_cards),
    Section(title="Grants", items=grants)
)

# the next line will add the index page to the generated content
page(
    title="index",
    sections=[section_biography, positions_grants]
)
```

##### The `hide` option for `page` and `Section`

```julia
# Both page() and Section() can take the hide option
# If a page is hidden, it will not be generated, but it will still appear in the side menu
# If a section is hidden, it will just not appear (and the content will not be generated, including request to external API, such as GitHub)

page(
    title="software",
    background=bg_white,
    sections=[
        Section(
            title="Software",
            hide=true, # default to false
            items=github,
        )
    ]
)
```