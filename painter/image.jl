function draw()
   if length(ARGS) > 1
      filename = ARGS[2]
   else
      filename = "stunet.png"
   end
   stunet = load(filename)
   while true
      centerX = rand(1:(1920-size(stunet,2)))
      centerY = rand(1:(1080-size(stunet,1)))
      shift = rand(1:360)
      println("Drawing $filename at $centerX $centerY")
      for _ = 1:2
         for x = shuffle(1:size(stunet, 2)), y = shuffle(1:size(stunet, 1))
            color = stunet[y,x]
            if convert(RGBA, color).alpha == 0 || color == RGB(1,1,1)
               color = HSV(shift, 1, 1)
            end
            color = convert(HSV, color)
            color = HSV(mod(color.h + shift, 360), color.s, color.v)
            color = convert(RGB24, color).color
            put!(pixel, "PX $(centerX+x) $(centerY+y) $(hex(color,6))")
         end
      end
      sleep(.1)
   end
end
