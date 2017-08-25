function draw()
   max = 200
   while true
      centerX = rand(max:1920-max)
      centerY = rand(max:1080-max)
      size = rand(max-200:max)
      color = rand(1:0xffffff)
      println("Drawing circle at $centerX $centerY with r=$size")
      for r = 1:size
         res = 2*r^1.2
         for i = 1:res
            color = mod(color + 10, 0xffffff)
            tau = i/res*2*pi
            x = Int64(floor(centerX + r * cos(tau)))
            y = Int64(floor(centerY + r * sin(tau)))
            put!(pixel, "PX $x $y $(hex(color,6))")
         end
      end
      sleep(0.5)
   end
end
