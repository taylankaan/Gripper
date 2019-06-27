extends Node2D


var velocity = Vector2();
var acceleration = Vector2();
var floating = false;
var justGrabbed = false;
var falling = false;



func _ready():
	print(str(get_position().y))
	G.player = self;
	set_position(Vector2(0, 3*get_viewport_rect().size.y/4));
	print(get_viewport_rect().size)
	print(get_viewport_rect().size.x)
	print(get_viewport_rect().size.y)


func move(d):
	print("move")
	print(str(get_position().y))
	if get_position().y > 640:
		die();
	
	if floating:
		acceleration += G.gravity;
	velocity += acceleration;
	set_position(get_position() + velocity * d);
	acceleration *= 0;
	
	
	if get_position().x < -172:
		set_position(Vector2(-172,get_position().y));
		velocity.x *= -1;
	elif get_position().x > 172:
		set_position(Vector2(172,get_position().y));
		velocity.x *= -1;



func grab():
	if !falling:
		for r in G.ridges:
			if (get_position() - r.get_position()).length_squared() <= 400:
				floating = false;
				set_position( r.get_position());
				velocity *= 0;
				justGrabbed = true;
				return;
		
		velocity.x = 0;
		velocity.y = 10;
		falling = true;
		get_node("Sprite").set_modulate(Color(0.9,0.2,0.2));



func jump(force):
#	print("vel: " , velocity);
#	print("force: " , -force*2);
	if !floating:
		if justGrabbed:
			justGrabbed = false;
			return;
		acceleration -= force*3;
		floating = true;



func die():
	print("girdi")

	self.queue_free();