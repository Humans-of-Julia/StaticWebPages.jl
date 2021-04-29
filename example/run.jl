# import the website generator functions
import StaticWebPages
import StaticWebPages: local_info

## private information (local folders, connection infos, etc.)
# content and site paths are always required
local_info["content"] = "/home/azzaare/website"
local_info["site"] = "/home/azzaare/website/site"

## Private Access Token (PAT) for GitHub as a github.jl file ; It is optional and can be commented/decommented using #
# local_info["auth_tokens"] = "/home/azzaare/website"

# necessary only if using the upload_site function
local_info["protocol"] = "ftp"
local_info["user"] = "user"
local_info["password"] = "password"
local_info["server"] = "server_address"

# `rm_dir = true` will clean up the site folder before generating it again. Default to false.
# `opt_in = true` will a link to this generator website in the side menu. Default to false.
StaticWebPages.export_site(d=local_info, rm_dir = true, opt_in = true)

## upload website (comment/delete if not needed)
# unfortunately does not work yet on windows system, please sync manually for the moment
# StaticWebPages.upload_site(local_info)
