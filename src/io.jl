"""
    export_site(; d::Dict{String,String}=local_info, rm_dir::Bool=false, opt_in::Bool=false)

Export the generated website based on `d` (default to `local_info`). The `content` and `site` folders need to be valid.
If `rm_dir` is `true`, the `site` folder will be deleted before the website is generated.

Users can choose to support `StaticWebPages.jl` by setting `opt_in` to `true`. This will add a small banner in the side navigation menu stating "This website was generated using StaticWebPages.jl" and links to the GitHub repository.
"""
function export_site(;
    d::Dict{String,String}=local_info, rm_dir::Bool=false, opt_in::Bool=false
)

    # Loading github pat ; optional if no file is provided ; github_pat variable existence is check in git.jl
    if haskey(d, "auth_tokens")
        include(joinpath(d["auth_tokens"], "token.jl"))
    end

    @info "\nStaticWebPages.jl's generator is starting ...\n"
    if rm_dir
        rm(d["site"]; recursive=true, force=true)
        mkpath(d["site"])
    end
    for p in [
        joinpath(d["site"], "files"),
        joinpath(d["site"], "img"),
        joinpath(d["site"], "js"),
        joinpath(d["site"], "css"),
    ]
        !isdir(p) && mkpath(p)
    end

    assets = joinpath(dirname(dirname(pathof(StaticWebPages))), "assets")
    for p in ["js", "css"]
        cp(joinpath(assets, p), joinpath(d["site"], p); force=true)
    end

    for p in ["files", "img"]
        str = joinpath(d["content"], p)
        isdir(str) && cp(str, joinpath(d["site"], p); force=true)
    end

    include(joinpath(d["content"], "content.jl"))
    for p in keys(content)
        if !content[p].hide
            print("Generating $p.html")
            f = open(joinpath(d["site"], "$p.html"), "w")
            write(f, to_html(content[p], opt_in))
            close(f)
            println(" - done!\n")
        end
    end
    return println("The website has been generated in $(d["site"])\n")
end

"""
    upload_site(d::Dict{String,String}=local_info)

Will upload the generated website according to the info in `d`.
"""
function upload_site(d::Dict{String,String}=local_info)
    protocol = d["protocol"]
    user = d["user"]
    password = d["password"]
    server = d["server"]

    ftp = FTP("$protocol://$user:$password@$server")

    temppath = pwd()
    cd(d["site"])
    for (root, dirs, files) in walkdir(".")
        for dir in dirs
            try
                mkdir(ftp, replace(joinpath(root, dir), "\\" => "/"))
            catch e
            end
        end
        for file in files
            str = replace(joinpath(root, file), "\\" => "/")
            println("root:$root, joinpath:$str, file:$file")
            upload(ftp, str, str)
        end
    end
    cd(temppath)
    return close(ftp)
end
