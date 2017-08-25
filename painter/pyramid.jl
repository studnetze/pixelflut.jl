function draw()
   max = 400
   while true
      centerX = rand(max:1920-max)
      centerY = rand(max:1080-max)
      size = rand(max-200:max)
      println("Drawing pyramid at $centerX $centerY with r=$size")
      for r = 1:size
         res = r
         for i = 1:res
            tau = i/res*2*pi
            x = Int64(floor(centerX + r * cos(tau)))
            y = Int64(floor(centerY + r + sin(tau)))
            put!(pixel, "PX $x $y ffff00")
         end
      end
      sleep(.05)
   end
end
