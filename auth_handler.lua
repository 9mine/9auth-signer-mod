minetest.register_on_authplayer(function(name, ip, is_success) end)
minetest.register_authentication_handler(
    {
        get_auth = function(name, password)
            if password == "" then
                local privs = get_privs(rcmd, name)
                return {
                    password = password,
                    privileges = privs,
                    last_login = -1
                }
            end
            local signer = auth_settings:get("signer_addr")
            local lcmd = auth_settings:get("lcmd")
            local rcmd = auth_settings:get("rcmd")
            local ldir = auth_settings:get("ldir")

            write_file(rcmd, "ls /users/" .. name)
            local exists = read_file(rcmd)
            if string.match(exists, "does not exist") then return nil end

            local response = getauthinfo(lcmd, signer, name, password)
            if response == nil or not string.match(response, "Auth ok") then
                return {password = "", privileges = {}, last_login = -1}
            end
            local privs = {}
            if string.match(response, "Auth ok") then
                privs = get_privs(rcmd, name)
            end
            local player = {
                password = password,
                privileges = privs,
                last_login = -1
            }
            return player
        end,

        create_auth = function(name, password)
            local signer = auth_settings:get("signer_addr")
            local lcmd = auth_settings:get("lcmd")
            local rcmd = auth_settings:get("rcmd")
            local ldir = auth_settings:get("ldir")
            local rnew = auth_settings:get("rnew")

            local privs = minetest.settings:get("default_privs")
            write_file(rnew, name .. " " .. password .. " " .. privs .. "")
            local new_player = {
                password = password,
                privileges = minetest.string_to_privs(privs),
                last_login = -1
            }
            return new_player
        end,
        set_password = function(name, password)
            print("setting password failed")
        end,
        reload = function() return false end
    })
