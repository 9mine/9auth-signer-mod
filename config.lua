-- used in TCP connection to the local inferno instance
local_addr = "getauth"
local_addr_port = 1917
-- signer address; used in 'getauthinfo *signer_addr* default user password' 
signer_addr = "auth"
-- specify remote inferno instance, which will be mounted during startup; passed to the 'mount -A *newuser_addr* /n/client' 
newuser_addr = "tcp!auth!1917"
-- path to local cmd
lcmd = "/tmp/file2chan/cmd"
-- path to local users dir
ldir = "/tmp/users/"
-- mount point of signer
smount = "/n/client"
-- path to remote cmd
rcmd = smount .. "/cmd"
-- path to remote newuser
rnew = smount .. "/newuser"
