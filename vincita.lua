function love.load()
	rectangleBox = {}

	immagine = {
	{i = love.graphics.newImage("immagini/Screen.png"), ox = 0 , oy = 0, sx = 1 ,sy = 1},
	{i = love.graphics.newImage("immagini/win1.png"), ox = 249.5 , oy = 99, sx = 1/2 ,sy = 1/2},
	{i = love.graphics.newImage("immagini/win2.png"), ox = 249.5 , oy = 99, sx = 1/2 ,sy = 1/2},
	{i = love.graphics.newImage("immagini/trasparente.png"), ox = 0 , oy = 0, sx = 1 ,sy = 1}
}
end

function love.update( dt )
	-- body
end

function love.draw()
	love.graphics.draw(immagine[1].i, 0, 0, 0, immagine[1].sx, immagine[1].sy, immagine[1].ox, immagine[1].oy)
	love.graphics.draw(immagine[4].i, 0, 0, 0, immagine[4].sx, immagine[4].sy, immagine[4].ox, immagine[4].oy)
	print (math.floor(love.timer.getMicroTime()) % 2)
	if (math.floor(love.timer.getMicroTime()) % 2) == 1 then
		love.graphics.draw(immagine[2].i, love.graphics.getWidth()/ 2, love.graphics.getHeight()/2, 0, immagine[2].sx, immagine[2].sy, immagine[2].ox, immagine[2].oy)
	else
		love.graphics.draw(immagine[3].i, love.graphics.getWidth()/ 2, love.graphics.getHeight()/2, 0, immagine[3].sx, immagine[3].sy, immagine[3].ox, immagine[3].oy)
	end 


	if love.mouse.isDown("l") then
		love.event.quit( )
	end

end
