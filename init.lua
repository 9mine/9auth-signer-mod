print("Authentication handler is loading ...")

np = require '9p'
data = require 'data'
socket = require 'socket'
pprint = require 'pprint'
readdir = require 'readdir'
cache = {}
authenticated = false
local path = minetest.get_modpath("auth")
auth_settings = Settings(path .. "/mod.conf")
dofile(path .. "/auth_help.lua")
dofile(path .. "/auth_handler.lua")
print("Signer is mounting . . . to " .. auth_settings:get("newuser_addr"))
local result = mount_signer(auth_settings:get("newuser_addr"))
if result == "nil" then
    print("Mounting returned no error")
else
    print("Result of mounting: " .. tostring(result))
end
print("Authentication handler successfully loaded")
