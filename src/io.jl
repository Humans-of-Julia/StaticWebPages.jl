function export_site(
    d::Dict{AbstractString,AbstractString};
    rm_dir::Bool=false,
    opt_in::Bool=false
    )
    if rm_dir
        rm(d["site"], recursive=true, force=true)
        mkpath(d["site"])
    end
    for p in [joinpath(d["site"], "files"), joinpath(d["site"], "img"), joinpath(d["site"], "js"), joinpath(d["site"], "css")]
        isdir(p) ? () : mkpath(p)
    end

    assets = joinpath(dirname(dirname(pathof(StaticWebPages))), "assets")
    for p in ["js", "css"]
        cp(joinpath(assets, p), joinpath(d["site"], p); force=true)
    end

    for p in ["files", "img"]
        cp(joinpath(d["content"], p), joinpath(d["site"], p); force=true)
    end

    include(joinpath(d["content"], "content.jl"))
    for p in keys(content)
        f = open(joinpath(d["site"], "$p.html"), "w")
        write(f, page(info, content, p, opt_in))
        close(f)
    end
end

function upload_site(d::Dict{AbstractString,AbstractString})
    protocole = d["protocole"]
    user = d["user"]
    password = d["password"]
    server = d["server"]

    ftp = FTP("$protocole://$user:$password@$server")
    temppath = pwd()
    cd(d["site"])
    for (root, dirs, files) in walkdir(".")
        for file in files
            println("root:$root, joinpath:$(joinpath(root, file)), file:$file")
            upload(ftp, joinpath(root, file), joinpath(root, file))
        end
    end
    cd(temppath)
    close(ftp)
end
