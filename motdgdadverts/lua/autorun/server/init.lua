local userid = 0 -- Your /motd/?user=X, where X is your userid, as specified on the MOTDgd portal
local forced = 1 -- Force players to wait 10 seconds before they can close the MOTD window, enabled if set to 1
local seconds = 10 -- How long to force the advertisement for, if forced is 1, would recommend around 10 seconds

-- Do not modify code below this line!
local ip = ""
local port = ""
local version = "1.00"

AddCSLuaFile( "autorun/client/cl_init.lua" )

local function GetIP()
        local hostip = GetConVarString( "hostip" )
        hostip = tonumber( hostip )
        
        local ip = {}
        ip[ 1 ] = bit.rshift( bit.band( hostip, 0xFF000000 ), 24 )
        ip[ 2 ] = bit.rshift( bit.band( hostip, 0x00FF0000 ), 16 )
        ip[ 3 ] = bit.rshift( bit.band( hostip, 0x0000FF00 ), 8 )
        ip[ 4 ] = bit.band( hostip, 0x000000FF )
        
        return table.concat( ip, "." )
end

local function InitPost( )
        ip = GetIP()
        port = GetConVarString( "hostport" )
end

local function FirstSpawn( ply )
  ply:SendLua( "showMotdGD( \""..userid.."\", "..forced..", \""..ip.."\", \""..port.."\", \""..ply:SteamID().."\", \""..version.."\", "..seconds.." )" )
end

hook.Add( "InitPostEntity", "serverReady", InitPost )
hook.Add( "PlayerInitialSpawn", "playerInitialSpawn", FirstSpawn )
