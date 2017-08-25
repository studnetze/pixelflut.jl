#!/usr/bin/env julia
using Retry

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

pixel = Channel{String}(1000)

for _ in 1:50
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
