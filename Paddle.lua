Paddle = Class{}

function Paddle:init( x, y, width, height )
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
end

function Paddle:predictBall( ball, dt )
    
    n_0 = ( self.x - ball.x ) / ( ball.dx * dt )
    y = ball.y + n_0 * ( ball.dy * dt )

    while y < 0 or y > VIRTUAL_HEIGHT do
        
        if y < 0 then

            hitCeiling = ( 0 - ball.y ) / ( ball.dy * dt )
            ceilingPoint = ball.x + hitCeiling * ( ball.dx * dt )

            n = ( self.x - ceilingPoint ) / ( ball.dx * dt )
            y = n * ( -1 * ball.dy * dt )

        elseif y > VIRTUAL_HEIGHT then

            hitFloor = ( VIRTUAL_HEIGHT - 4 - ball.y ) / ( ball.dy * dt )
            floorPoint = ball.x + hitFloor * ( ball.dx * dt )

            n = ( self.x - floorPoint ) / ( ball.dx * dt )
            y = VIRTUAL_HEIGHT - 4 + n * ( -1 * ball.dy * dt )

        end

    end

    return y
end

function Paddle:update( dt )
    if self.dy < 0 then
        self.y = math.max( 0, self.y + self.dy * dt )
    else
        self.y = math.min( VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt )
    end
end

function Paddle:render()
    love.graphics.rectangle( "fill", self.x, self.y, self.width, self.height )
end