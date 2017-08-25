function draw()
   size = 200
   while true
      for x = shuffle(1:size), y = shuffle(1:size)
            put!(pixel, "PX $x $y ffff00")
      end
   end
end
