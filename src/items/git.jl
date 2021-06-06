const RepoLabels = Union{String, Pair{String, Vector{String}}}

struct GitRepo <: AbstractItem
    fullnames::Vector{RepoLabels}
    filter::Vector{String}

    function GitRepo(args::RepoLabels...; filter = ["github-actions[bot]"])
        return new([r for r in args], filter)
    end
end

struct Git
    name::String
    url::String
    language::String
    description::String
    size::Int
    contributors::String
end

function to_name(user::String)
    str = get(user_to_name, lowercase(user), "")
    return str == "" ? user : "$str ($user)"
end

"""
GitBuilder(r, contributors)

Generate the Git struct according to the repository `r`.
If `r` does not have all its fields specified (*i.e.* `Nothing`), then a default value is used instead.

Return `g::Git`
"""
function GitBuilder(r::Repo, contrib::String)
    if isnothing(r.name)
        r.name = "The repository has no name"
    end
    if isnothing(r.html_url.uri)
        r.html_url.uri = ":blank"
    end
    if isnothing(r.language)
        r.language = "Language unspecified"
    end
    if isnothing(r.description)
        r.description = "No description"
    end
    if isnothing(r.size)
        r.size = 0
    end
    g = Git(
        r.name,
        r.html_url.uri,
        r.language,
        r.description,
        r.size,
        lowercase(contrib)
    )
    return g
end

# TODO: make it a multiple dispatched function
function Git(gh_rl::RepoLabels, git_filter)
    if @isdefined(github_pat)
        myauth = GitHub.authenticate(github_pat)
    else
        myauth = GitHub.AnonymousAuth()
    end

    gh = isa(gh_rl, Pair) ? gh_rl.first : gh_rl

    r = GitHub.repo(gh;auth = myauth)
    contributors = filter(c -> c ∉ git_filter, GitHub.contributors(gh;auth = myauth)[1])

    is_github = "github" ∈ keys(info)
    this_user = is_github ? lowercase(split(info["github"], "/")[end]) : ""
    bound = min(10, length(contributors))
    user_in_bound = true
    for (i, u) in enumerate(contributors)
        if this_user == lowercase(u["contributor"].login)
            user_in_bound = i ≤ bound
            break
        end
    end
    max_users = user_in_bound ? 10 : 9

    str = to_name(contributors[1]["contributor"].login)
    for c in contributors[2:(min(max_users, bound))]
        str *= ", " * to_name(c["contributor"].login)
    end
    str *= user_in_bound ? "" : ", " * to_name(this_user)
    str *= bound < length(contributors) ? ", et al." : ""

    return GitBuilder(r, str)
end

function to_html(repos::GitRepo)
    str = ""
    for r in repos.fullnames
        g = Git(r, repos.filter)
        str *=
        """
        <div class="publication cell small-12 large-6">
            <div class="pub-contents">
                <div class="pubassets">
        """

        if g.url != ""
            str *=
            """
                    <a href="$(g.url)" class="tooltips"
                        title="" target="_blank" data-original-title="External link">
                        <i class="fas fa-external-link-alt"></i>
                    </a>
            """
        end
        str *=
        """
                </div>
                <h4 class="pubtitle">$(g.name)</h4>
                <div class="pubcontents">
        """
        labels = Set([g.language])
        typeof(r) <: Pair && union!(labels, r.second)
        for label in labels
            if label ∉ keys(publication_labels)
                push!(publication_labels, label => ColorLabel(length(publication_labels)))
            end
            color = color_to_label[publication_labels[label]]

            str *=
            """
                        <span class="label $color">$(uppercasefirst(label))</span>
            """
        end

        str *=
        """
                    <div class="pubauthor">$(g.contributors)</div>
                    <div class="pubcite">$(g.description)</div>
                    <div class="pubyear">Size: $(g.size) KB</div>
                </div>
            </div>
        </div>
        """
    end
    return str
end
