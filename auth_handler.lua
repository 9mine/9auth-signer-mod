minetest.register_authentication_handler(
    {
        get_auth = function(name)
            print("CHECKPOINT GET_AUTH" .. dump(cache[name]))
            return cache[name]
        end,

        create_auth = function(name, password)
            print("CHECKOINT CREATE_AUTH: " .. dump(cache[name]))
            local signer = config.signer_addr
            local lcmd = config.lcmd
            local rcmd = config.rcmd
            local ldir = config.ldir
            local rnew = config.rnew

            write_file(rcmd, "ls /users/" .. name)
            local exists = read_file(rcmd)
            if string.match(exists, "does not exist") == nil then
                local response = getauthinfo(lcmd, signer, name, password)

                if string.match(response, "Auth ok") then
                    privs = get_privs(rcmd, name)
                    cache[name] = {
                        password = password,
                        privileges = minetest.string_to_privs(privs),
                        last_login = -1
                    }
                    authenticated = true
                    print("CHECKOINT CREATE_AUTH RETURN 1: " ..
                              dump(cache[name]))

                    return cache[name]
                else

                    cache[name] = {
                        password = "NOPASSWORD",
                        privileges = {},
                        last_login = -1
                    }
                    print("CHECKOINT CREATE_AUTH RETURN 2 (ELSE): " ..
                              dump(cache[name]))
                    return cache[name]
                end
            else
                local privs = minetest.settings:get("default_privs")
                write_file(rnew, name .. " " .. password .. " " .. privs .. "")
                cache[name] = {
                    password = password,
                    privileges = minetest.string_to_privs(privs),
                    last_login = -1
                }
                return cache[name]
            end

        end
    })

minetest.register_on_leaveplayer(function(ObjectRef, timed_out)
    local name = ObjectRef:get_player_name()
    cache[name] = {}
end)

