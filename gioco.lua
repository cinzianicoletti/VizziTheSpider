
function love.load()
	--love.filesystem.setSource( )
	boxBalls = {}
	angolo = 600
	boxPuntiCorda = {}
	boxGiunzioni = {}

    -- Crea il mondo.
    love.physics.setMeter( 1.5 )
    mondo = love.physics.newWorld(0, 9.81*60, true)
 
	-- immagini
	images = {
	{i = love.graphics.newImage("immagini/green_ball.png"), r = 32, oX = 36.5, oY = 36, sx = 1, sy = 1},
	{i = love.graphics.newImage("immagini/tree.png"), r = 0, ox = 0, oy = 0},
	{i = love.graphics.newImage("immagini/vizzi.png")},
	{i = love.graphics.newImage("immagini/mosca2.png"), r = 20, oX = 36.5, oY = 36, sx = 1/2, sy = 1/2 },
	{i = love.graphics.newImage("immagini/suolo.png"), ox = 450 , oy = 80, sx = (love.graphics.getWidth() / 900)},
	{i = love.graphics.newImage("immagini/sfondo.png"), ox = 425 , oy = 312.5, sx = (love.graphics.getWidth() / 850) ,sy = (love.graphics.getHeight() / 625)}
} 

addBallDynamic(images[1], 600, 300)
mosquito(images[4], 900, 500)


	-- Suolo
	createGround()


	-- AUDIO
	source = love.audio.newSource("audio/gameplay.ogg", "stream")
	love.audio.play(source)


	canvas = love.graphics.newCanvas( love.graphics.getWidth(), love.graphics.getHeight())

	boxBalls[2].b:setFixedRotation(true)

	local x = 305
	local y = 525

	
	creaCorda(x,y,347,444, 20)

	creaCorda(347,444, 320,447, 20)

	creaCorda(320,447, x, y, 20)

	creaCorda(x,y,309,445, 20)
	--
	creaCorda(309,445,284,457, 20)
	--Prima corda
	creaCorda(284,457,x,y, 20)
	--Seconda corda
	creaCorda(x,y,273,455, 20)
	-- 3 corda
	creaCorda(273,455,253,494, 20)
	-- 4 corda
	creaCorda(253,494,x,y, 20)

	creaCorda(x,y,338,585, 20)

	creaCorda(338,585,278,565, 20)

	creaCorda(278,565,x,y, 20)

	creaCorda(x,y,258,540, 20)

	creaCorda(258,540,253,494, 20)

	printx = 0
	printy = 0
end

function love.update(dt)
	-- Mettiamo il mondo in moto! --
	mondo:update(dt)
	mondo:setCallbacks(beginContact, endContact, preSolve, postSolve)

	if love.mouse.isDown( "l" ) and love.mouse.getY() < boxBalls[2].b:getY() then
		boxBalls[2].y = (boxBalls[2].b:getY() - 10)
	end
	if love.mouse.isDown( "l" ) and love.mouse.getY() > boxBalls[2].b:getY() then
		boxBalls[2].y = (boxBalls[2].b:getY() + 10)
	end
	
	movimentoMosca(boxBalls[2])

	if source:isStopped() then
		love.audio.play(source)
	else
		source:setVelocity( 1000, 100, 100)

	end
	
end


function love.draw()
	r, g, b, a = love.graphics.getColor()
	-- CIELO
	--love.graphics.rectangle( "line", background.oX, background.oY, love.graphics.getWidth(), love.graphics.getHeight())
	love.graphics.draw(images[6].i, love.graphics.getWidth()/2, love.graphics.getHeight( )/2, 0, images[6].sx, images[6].sy, images[6].ox, images[6].oy)
	
	-- ALBERO

	love.graphics.draw(images[2].i, -50, 130, -0.1, 1/2, 1/2, 0, 0)

	-- Vizzi
	love.graphics.draw(images[3].i, 220, 350, -0.1, 1/4, 1/4, 0, 0)
	-- Disegno palla
	-- love.graphics.draw(oggDaDis, posX, posY, orientRad, scalaX, scalaY, offsetX, offsetY, fattDiTaglioX, fattoreDiTaglioY)

	for i, v in ipairs(boxBalls) do
		love.graphics.draw(v.i, v.b:getX(), v.b:getY(), v.b:getAngle(), v.sX, v.sY, v.oX, v.oY)
	end

	--PUNTI CORDA
	love.graphics.setColor(130,123,99,80)
	for i, v in ipairs(boxPuntiCorda) do
		--love.graphics.draw(v.i, v.b:getX(), v.b:getY(), v.b:getAngle(), v.sX, v.sY, v.oX, v.oY)
		--love.graphics.line( body1.b:getX(), body1.b:getY(), body2.b:getX(), body2.b:getY())
		love.graphics.circle( "fill", v.b:getX(), v.b:getY(), v.s:getRadius(), 10)
	end
	love.graphics.setColor(r, g, b,a)

	-- LINEE CORDA
	love.graphics.setColor(130,123,99,80)
	i=1
	while (i < #boxPuntiCorda) do
		j = i + 1
		love.graphics.line(boxPuntiCorda[i].b:getX(), boxPuntiCorda[i].b:getY(), boxPuntiCorda[j].b:getX(), boxPuntiCorda[j].b:getY())
		i = i+1
	end
	love.graphics.setColor(r, g, b,a)
	
	-- SUOLO
	love.graphics.draw(images[5].i, love.graphics.getWidth()/ 2, love.graphics.getHeight() - 40, 0, images[5].sx, 1, images[5].ox, images[5].oy)

end

-- La utilizzo quando non sto toccando lo schermo 
function love.focus( f) 
	if not f then
		text = "UNFOCUSED!!"
		print("LOST FOCUS")
	else
		text = "FOCUSED!"
		print("GAINED FOCUS")
	end
end
function mosquito(image, x, y)
	local ogg = {}
	ogg.b = love.physics.newBody(mondo, x, y, "dynamic")
	ogg.s = love.physics.newCircleShape(image.r)
	ogg.f = love.physics.newFixture(ogg.b, ogg.s)
	ogg.f:setUserData("Mosquito")
	ogg.f:setRestitution(0.7)
	ogg.i = image.i
	ogg.oX = image.oX -- Offset
	ogg.oY = image.oY
	ogg.sX = image.sx -- Scala
	ogg.sY = image.sy
	ogg.y = y
	ogg.x = x
	table.insert(boxBalls, ogg)
end
function love.mousepressed(x, y, button)
	
end
function addBallDynamic(image, x, y)
	local ogg = {}
	ogg.b = love.physics.newBody(mondo, x, y, "dynamic")
	ogg.s = love.physics.newCircleShape(image.r)
	ogg.f = love.physics.newFixture(ogg.b, ogg.s)
	ogg.f:setRestitution(0.7)
	ogg.f:setUserData("Ball")
	ogg.i = image.i
	ogg.oX = image.oX -- Offset
	ogg.oY = image.oY
	ogg.sX = image.sx -- Scala
	ogg.sY = image.sy
	ogg.y = y
	ogg.x = x
	table.insert(boxBalls, ogg)
end

function movimentoMosca(body)
	
	-- Equazione cerchio: (x-alfa)^2+(y-beta)^2 - r^2

	-- if (love.mouse.getX() > 0 and love.mouse.getY() > 0 and angolo >= 0) then
	-- 	body:setX(love.mouse.getX() + 10*math.cos(angolo))
	-- 	body:setY(love.mouse.getY() + 10*math.sin(angolo))
	-- 	angolo = angolo + 0.1
	-- end

	-- Equazione per traiettoria sinusoidale mosca
	x = body.b:getX()
	y = body.y
	if angolo >= 0 then
		body.b:setX(x-2)
		body.b:setY(y + 10 * math.cos(angolo))
		angolo = angolo + 0.1
		if x < - 50 then
		body.b:setX(x+950)
	end
	end
	

end

function creaCorda(a1, a2, b1, b2,lunghezza)
	local x1 = a1
	local y1 = a2
	local x2 = b1
	local y2 = b2
	local a = 1
	local corpo1
	local corpo2
	local giunzione

	while (a < lunghezza) do
		--lua_toPointer()
		if a == 1 then
			
			corpo1 = creaPuntoCordaStatico(x1, y1)
			y1 = y1 + 1
			corpo2 = creaPuntoCordaDinamico(x1, y1)
			giunzione = creaGiunzione(corpo1, corpo2)
			x = giunzione:getDampingRatio()
			y = giunzione:getFrequency()
			z = giunzione:getLength()
			giunzione:setLength(1)
			table.insert(boxGiunzioni, giunzione)
		else  
			if a == lunghezza - 1 then
				corpo1 = corpo2
				corpo2 = creaPuntoCordaStatico(x2, y2)
				giunzione = creaGiunzione(corpo1, corpo2)
				giunzione:setFrequency(10)
				giunzione:setLength(1)
				table.insert(boxGiunzioni, giunzione)
			else
				corpo1 = corpo2
				y1 = y1 + 1
				corpo2 = creaPuntoCordaDinamico(x1, y1)
			--x, y = corpo2.b:getPosition()
				--print (x, y)
				giunzione = creaGiunzione(corpo1, corpo2)
				giunzione:setLength(1)
				giunzione:setDampingRatio(0.5)
				giunzione:setFrequency(10)
				table.insert(boxGiunzioni, giunzione)
			--print(giunzione:getLength())
		end
	end
	a = a + 1
end
end

function creaGiunzione(body1, body2 )
	local joint = love.physics.newDistanceJoint(body1.b, body2.b, body1.b:getX(), body1.b:getY(), body2.b:getX(), body2.b:getY())

	return joint
end

function creaPuntoCordaDinamico(x,y)
	local ogg = {}
	ogg.b = love.physics.newBody(mondo, x, y, "dynamic")
	ogg.b:setMass(0)
	ogg.b:setFixedRotation(true)
	ogg.s = love.physics.newCircleShape(0)
	ogg.f = love.physics.newFixture(ogg.b, ogg.s)
	--ogg.f:setRestitution(0.7)
	ogg.f:setUserData("BallRope")
	--ogg.i = love.graphics.newImage("immagini/ballRope4.png")
	ogg.oX =  150-- Offset
	ogg.oY =  150
	ogg.sX = 1/50-- Scala
	ogg.sY = 1/50
	ogg.x = x
	ogg.y = y
	table.insert(boxPuntiCorda, ogg)
	return ogg
end
function creaPuntoCordaStatico(x,y)
	local ogg = {}
	ogg.b = love.physics.newBody(mondo, x, y, "static")
	ogg.b:setFixedRotation(true)
	ogg.s = love.physics.newCircleShape(0)
	ogg.f = love.physics.newFixture(ogg.b, ogg.s)
	--ogg.f:setRestitution(0.7)
	ogg.f:setUserData("BallRope")
	--ogg.i = love.graphics.newImage("immagini/ballRope4.png")
	ogg.oX = 150 -- Offset
	ogg.oY = 150
	ogg.sX = 1/50-- Scala
	ogg.sY = 1/50
	ogg.x = x
	ogg.y = y
	table.insert(boxPuntiCorda, ogg)
	return ogg
end

function createGround()
	ground = {}
	ground.b = love.physics.newBody(mondo, love.graphics.getWidth()/ 2, love.graphics.getHeight() * 3.141592 , "static")
	ground.s = love.physics.newCircleShape(1605)

	--ground.s = love.physics.newChainShape( true, 0, 665, 180, 615, 405, 591 , 498, 706, 706, 610 )
	--ground.s = love.physics.newChainShape( false, 610, 706, 706, 498, 591, 405 , 615, 180, 665, 0 )
	ground.f = love.physics.newFixture(ground.b, ground.s, 0.7)
	ground.f:setUserData("Suolo")

end




function beginContact(a, b, coll)
	-- Se si sta verificando un contatto
	--x,y = coll:getNormal()
	

	if b:getUserData() == "BallRope" and a:getUserData() == "Mosquito" then
		print("ciao")
		screenshot = love.graphics.newScreenshot()
		screenshot:encode( "immagini/Screen.png" )
		require("vincita")
		love.load()
	end

end

function endContact(a, b, coll)
return false
end

function preSolve(a, b, coll)
	return false
end
function postSolve(a, b, coll)
	return false
end
