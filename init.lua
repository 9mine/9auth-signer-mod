print("Authentication handler is loading ...")
config = luaconfig.loadConfig();
np = require '9p'
data = require 'data'
socket = require 'socket'
pprint = require 'pprint'
readdir = require 'readdir'
cache = {}
authenticated = false
local path = minetest.get_modpath("auth")
dofile(path .. "/config.lua")
dofile(path .. "/auth_help.lua")
dofile(path .. "/auth_handler.lua")
print("Singer is mounting . . .")
mount_signer(config.newuser_addr)
print("Signer successfully mounted")
print("Authentication handler successfully loaded")