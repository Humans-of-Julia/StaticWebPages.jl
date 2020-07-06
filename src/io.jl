local dummy_info = OrderedDict{AbstractString,AbstractString}()
local dummy_content = OrderedDict{AbstractString,Any}()

function export_site(
    d::Dict{AbstractString, AbstractString};
    content_info::OrderedDict{AbstractString,AbstractString} = dummy_info,
    content::OrderedDict{AbstractString,Any} = dummy_content
    )
    temppath = pwd()
    cd(d["content"])
    include(pwd() * "/content.jl")

    println(content_info)
    println(content)

    for p in keys(content)
        f = open("$(d["site"])/$p.html", "w")
        write(f, page(content_info, content, p))
        close(f)
    end
    cd(temppath)
end

function upload_site(path::AbstractString)
    protocole = "ftp"
    user = "cuvdeeu"
    password = "i5IKuG0YBNh0bjZ1"
    server = "ftp.cluster028.hosting.ovh.net/www"
    folder = "perso"

    ftp = FTP("$protocole://$user:$password@$server")
    temppath = pwd()
    cd(path)
    for (root, dirs, files) in walkdir(".")
        for file in files
            println("root:$root, joinpath:$(joinpath(root, file)), file:$file")
            upload(ftp, joinpath(root, file), joinpath(root, file))
        end
    end
    cd(temppath)
    close(ftp)

end
