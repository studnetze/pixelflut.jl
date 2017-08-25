using Retry
using Images
using Colors

function gieveconnection()
   return connect("pixelflut.selfnet.de", 1234)
end

function dowork()
   client = gieveconnection()
   while true
      sent = 1
      data = take!(pixel)
      @repeat 10 try
         println(client, data)
      catch
         close(client)
         client = gieveconnection()
         @retry if true end
      end
   end
end

# 1920 1080
pixel = Channel{String}(1000)

for _ in 1:50
   @async begin
      dowork()
   end
end

include(ARGS[1])
draw()
