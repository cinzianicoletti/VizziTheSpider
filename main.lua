contenitoreNuvole= {}

function love.load()
   -- Crea il mondo.
   mondo = love.physics.newWorld(9.81, 0)
	-- Creiamo un vettore d'immagini
	immagini = {
	{i = love.graphics.newImage("immagini/cloud.png"), r = 32 , ox = 10, oy = 10},
	{i = love.graphics.newImage("immagini/gr.png"), ox = 450, oy = 80, sx = (love.graphics.getWidth() / 900) },
	{i = love.graphics.newImage("immagini/sfondo.png"), ox = 425 , oy = 312.5, sx = (love.graphics.getWidth() / 850) ,sy = (love.graphics.getHeight() / 625)},
	{i = love.graphics.newImage("immagini/logo2.png"), ox = 112 , oy = 60.5, sx = 1 ,sy = 1},
	{i = love.graphics.newImage("immagini/play1.png"), ox = 141.5 , oy = 75, sx = 1/2.5 ,sy = 1/2.5},
	{i = love.graphics.newImage("immagini/play2.png"), ox = 141.5 , oy = 75, sx = 1/2.5 ,sy = 1/2.5},
	{i = love.graphics.newImage("immagini/esci1.png"), ox = 129.5 , oy = 75, sx = 1/2.5 ,sy = 1/2.5},
	{i = love.graphics.newImage("immagini/esci2.png"), ox = 129.5 , oy = 75, sx = 1/2.5 ,sy = 1/2.5}
}

inserisciTotNuvole(immagini[1])
source = love.audio.newSource("audio/menu.ogg", "stream")
love.audio.play(source)
end

function love.update(dt)
	-- Mettiamo il mondo in moto! --
	mondo:update(dt)
	inserisciTotNuvole(immagini[1])

	if love.mouse.isDown( "l" ) and love.mouse.getX() >  390 and love.mouse.getX() < 505 and love.mouse.getY() < 317 and love.mouse.getY() > 284  then
		require("gioco")
		love.load()
	end
	if love.mouse.isDown( "l" ) and love.mouse.getX() < 500 and love.mouse.getX() > 400 and love.mouse.getY() > 335 and love.mouse.getY() < 370  then
		love.event.quit( )
	end
	
	if source:isStopped() then
		love.audio.play(source)
	else
		source:setVelocity( 1000, 100, 100)

	end
	
end
function love.draw()
	-- CIELO
	love.graphics.draw(immagini[3].i, love.graphics.getWidth()/ 2, love.graphics.getHeight() / 2, 0, immagini[3].sx, immagini[3].sy, immagini[3].ox, immagini[3].oy)

	for i, v in ipairs(contenitoreNuvole) do
		love.graphics.draw(v.i, v.b:getX(), v.b:getY(), v.b:getAngle(), v.sX, v.sY, v.ox, v.oy, 0 , 0)
	end

	-- love.graphics.setColor(130,123,99,80)
	-- love.graphics.line(love.graphics.getWidth()/ 2, 0, love.graphics.getWidth()/ 2, 700)
	-- love.graphics.setColor(255,255,255,255)
	-- love.graphics.draw(oggDaDis, posX, posY, orientRad, scalaX, scalaY, offsetX, offsetY, fattDiTaglioX, fattoreDiTaglioY)

	-- VIZZI
	love.graphics.draw(immagini[4].i, love.graphics.getWidth()/ 2, 200, 0, immagini[4].sx, immagini[4].sy, immagini[4].ox, immagini[4].oy)

	-- local x, y = love.mouse.getPosition()
	-- love.graphics.print( x..","..y, 300, 300, 0, 2, 2, 0, 0)

	-- PLAY
	if love.mouse.getX() >  390 and love.mouse.getX() < 505 and love.mouse.getY() < 317 and love.mouse.getY() > 284 then
		love.graphics.draw(immagini[5].i, love.graphics.getWidth()/ 2, 300, 0, immagini[5].sx, immagini[5].sy, immagini[5].ox, immagini[5].oy)
	else
		love.graphics.draw(immagini[6].i, love.graphics.getWidth()/ 2, 300, 0, immagini[6].sx, immagini[6].sy, immagini[6].ox, immagini[6].oy)
	end

	if love.mouse.getX() < 500 and love.mouse.getX() > 400 and love.mouse.getY() > 335 and love.mouse.getY() < 370 then
		love.graphics.draw(immagini[7].i, love.graphics.getWidth()/ 2, 350, 0, immagini[7].sx, immagini[7].sy, immagini[7].ox, immagini[7].oy)
	else
		love.graphics.draw(immagini[8].i, love.graphics.getWidth()/ 2, 350, 0, immagini[8].sx, immagini[8].sy, immagini[8].ox, immagini[8].oy)
	end


	-- SUOLO
	love.graphics.draw(immagini[2].i, love.graphics.getWidth()/ 2, love.graphics.getHeight() - 40, 0, immagini[2].sx, 1, immagini[2].ox, immagini[2].oy)
	
end

function inserisciTotNuvole(nuvola, n)
	local i = math.random(1,5)
	if i == 2 then
		local t = {}
		t.b = love.physics.newBody(mondo, math.random(-10000,-200), math.random(0,700), "dynamic")
		t.b:setLinearVelocity(35, 0)
		t.b:setGravityScale(0)
		t.s = love.physics.newCircleShape(immagini[1].r)
		t.f = love.physics.newFixture(t.b, t.s)
		t.i = immagini[1].i
		t.ox = immagini[1].ox
		t.oy = immagini[1].oy
		local j = math.random(2.5,8)
		t.sX = 1 /j
		t.sY = 1 /j
		table.insert(contenitoreNuvole,t)

	end
end
