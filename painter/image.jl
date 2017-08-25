using Images
using Colors

function draw()
   if length(ARGS) > 1
      filename = ARGS[2]
   else
      filename = "images/stunet.png"
   end
   stunet = load(filename)'
   sizeX = size(stunet, 1)
   sizeY = size(stunet, 2)
   while true
      centerX = rand(1:(1920-sizeX))
      centerY = rand(1:(1080-sizeY))
      shift = rand(1:360)
      println("Drawing $filename at $centerX $centerY")
      # Draw twice for more drawing power
      for _ = 1:2
         for x = shuffle(1:sizeX), y = shuffle(1:sizeY)
            color = stunet[x,y]
            if convert(RGBA, color).alpha == 0 || color == RGB(1,1,1)
               color = HSV(shift, 1, 1) # Change background
               # continue # Transparent Background
            end
            # Shift color for more colors
            color = convert(HSV, color)
            color = HSV(mod(color.h + shift, 360), color.s, color.v)
            # Convert to hex
            color = convert(RGB24, color).color
            put!(pixel, "PX $(centerX+x) $(centerY+y) $(hex(color,6))")
         end
      end
      sleep(.1)
   end
end
