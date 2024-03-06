module("all_check", package.seeall)
local json = require("cjson")

function auth_check(request_method)
    

    local body_content = {}
    body_content['origin'] = ngx.var.uri
    body_content['request_method'] = request_method
    local res = ngx.location.capture('/has_permission',
        {
            method = ngx.HTTP_PUT,
        }
    )

    if res.status ~= 200 then
        ngx.log(ngx.ERR, 'token check', ' ----> ', res.body)
        ngx.exit(res.status)
    end

    return res
end
