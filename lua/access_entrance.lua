local check = require "all_check"

function split(s)
    local t = {}
    for w in string.gmatch(s, "%a+") do
        table.insert(t, w)
    end
    return t
end


local upstreams = {
    admin = 'api-admin',
    config = 'api-config',
}

local function main()
    local uri_table = split(ngx.var.uri)
    
    
    if table.getn(uri_table) < 3 or uri_table[1] ~= 'api' then
        ngx.exit(400)
    end
    
    if upstreams[uri_table[2]] == nil then
        ngx.exit(416)
    end
    
    local authorization = ngx.req.get_headers()['Authorization']
    if (authorization == '' or authorization == nil) and 
       (ngx.var.cookie_auth == '' or ngx.var.cookie_auth == nil) and 
        uri_table[3] ~= 'auth' then
        ngx.exit(401)
    end
    
    
    if uri_table[3] ~= 'auth' then
        local res = check.auth_check(ngx.var.request_method)
    end
    
    local location_format = string.gsub(ngx.var.request_uri, '/api/'..uri_table[2] , '', 1)
    local real_uri = upstreams[uri_table[2]]..location_format
    
    ngx.var.my_upstream = real_uri
end

main()
