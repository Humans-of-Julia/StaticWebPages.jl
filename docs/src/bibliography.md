# Bibliography.jl

`StaticWebPages.jl` relies on the bibliography stack for publication and
metadata sections. The stack is split across three packages:

- `BibInternal.jl` for the canonical entry model;
- `BibParser.jl` for importing bibliography formats;
- `Bibliography.jl` for high-level import/export helpers.

The dedicated shared documentation site will gather these packages later, but
this page keeps the `StaticWebPages` integration documented for now.

```@contents
Pages = ["bibliography.md"]
Depth = 5
```

```@autodocs
Modules = [Bibliography]
```
