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

painter = ARGS[1]
if isfile(painter)
   include(ARGS[1])
   draw()
else
   error("Command line argument is not a painter: $painter")
end
