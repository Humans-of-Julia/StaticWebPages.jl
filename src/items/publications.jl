"""
    Publications

A structure that store all the informations required to build and export a bibloigraphy.
"""
struct Publications
    parser::Parser
    sort::FieldSort
    source::String
end

"""
    Publications(source::String; parser::Parser=bibtex, sort::FieldSort=required)

Import a bibliography from `source` using `parser`. Some sorting options can be given through `sort`. Please check the `Bibliography.jl` package.
"""
function Publications(source::String; parser::Parser = bibtex, sort::FieldSort = required)
    return Publications(parser, sort, joinpath(local_info["content"], source))
end

function to_html(publications::Vector{Bibliography.Publication})
    str = ""
    for p in publications
        str *= """
               <div class="publication cell small-12 large-6">
                   <div class="pub-contents">
                       <div class="pubassets">
               """

        if p.link != ""
            str *= """

                           <a href="$(p.link)" class="tooltips"
                               title="" target="_blank" data-original-title="External link">
                               <i class="fas fa-external-link-alt"></i>
                           </a>
                   """
        end
        if isfile(joinpath(local_info["content"], p.file))
            str *= """
                           <a href="$(p.file)"
                               class="tooltips" title="" target="_blank" data-original-title="Download">
                               <i class="fas fa-download"></i>
                           </a>
                   """
        end
        str *= """
                           <button type="button" data-open="$(p.id)-modal">
                                   <a class="tooltips" title="" target="_blank" data-original-title="Cite">
                                       <i class="fas fa-quote-left"></i>
                                   </a>
                           </button>
                           <div class="large reveal" id="$(p.id)-modal" data-reveal>
               <code class="code-block">$(p.cite)</code>
                                   <button class="close-button" data-close aria-label="Close bib" type="button">
                                       <span class="black-text" aria-hidden="true">&times;</span>
                                   </button>
                               </div>
                """
        if !isempty(p.abstract)
            str *= """
                            <button type="button" data-open="$(p.id)-modal2">
                                <a class="tooltips" title="" target="_blank" data-original-title="Cite">
                                    <i class="fa-solid fa-paragraph"></i>
                                </a>
                            </button>
                            <div class="large reveal" id="$(p.id)-modal2" data-reveal>
                                <div class="abstract">
                                <h5 class="pubtitle">$(p.title)</h5>
                                <p>$(p.abstract)</p>
                                </div>
                                <button class="close-button" data-close aria-label="Close bib" type="button">
                                    <span class="black-text" aria-hidden="true">&times;</span>
                                </button>
                            </div>
                    """
        end
        str *= """
                       </div>
                       <h4 class="pubtitle">$(p.title)</h4>
                       <div class="pubcontents">
               """
        for label in p.labels
            if label ∉ keys(publication_labels)
                push!(
                    publication_labels,
                    label => ColorLabel(mod(length(publication_labels), 22))
                )
            end
            color = color_to_label[publication_labels[label]]
            str *= """
                               <span class="label $color">$(uppercasefirst(label))</span>
                   """
        end

        str *= """
                           <div class="pubauthor">$(p.names)</div>
                           <div class="pubcite">$(p.in)</div>
                           <div class="pubyear">Publication year: $(p.year)</div>
                       </div>
                   </div>
               </div>
               """
    end
    return str
end

function to_html(bib::Publications)
    return to_html(Bibliography.bibtex_to_web(bib.source))
end
