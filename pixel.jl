#!/usr/bin/env julia
using Retry

const linebuffer = 1000
const connections = 50
const pixel = Channel{String}(linebuffer)

function gieveconnection()
   return connect("pixelflut.selfnet.de", 1234)
end

function dowork()
   client = gieveconnection()
   while true
      data = take!(pixel)
      @repeat 10 try
         println(client, data)
      catch e
         println("Resetting connection: $e")
         close(client)
         client = gieveconnection()
         @retry if true end
      end
   end
end

for _ in 1:connections
   @async begin
      dowork()
   end
end

if length(ARGS) > 0 && isfile(ARGS[1])
   include(ARGS[1])
   draw()
else
   error("Command line argument is not a painter.")
end
