extends Node

var starButtonPressed=false;
var jump = false;
var grab = false;
var player = null;
var gravity = Vector2(0,5);
var mPos = Vector2();
var ridges = [];
var ridgeRad = 8;
var cam;


func _ready():
	if get_parent().has_node("gameplay"):
		for child in get_parent().get_node("gameplay").get_node("ridges").get_children():
			ridges.append(child);
		
		cam = get_parent().get_node("gameplay").get_node("cam");


func _process(delta):
	getInput();


func getInput():
	if starButtonPressed:
		respawnPlayer()
		starButtonPressed=false
	else:
			pass
	if Input.is_action_just_pressed("lmb"):
		if player:
			if player.floating:
				grab = true;
			else:
				mPos = get_viewport().get_mouse_position();
	elif Input.is_action_just_released("lmb"): jump = true;


func applyInput():
	if jump:
		
		if player:
			var force = get_viewport().get_mouse_position() - mPos;
			
			player.jump(force);
		else:
			respawnPlayer();
	
	elif grab:
		if player:
			player.grab();


func _physics_process(delta):
	
	applyInput();
	jump = false;
	grab = false;
	
	
	if get_parent().has_node("player"):
		print("girdimi player")
		player.move(delta);
	
	if player && !player.falling &&  get_parent().has_node("cam"):
		cam.set_position(player.get_position());
	
	


func respawnPlayer():
	if get_parent().has_node("gameplay"):
		print("respawn")
		
		var newPlayer = load("res://scenes/player.tscn");
		
		newPlayer = newPlayer.instance();
		
		get_parent().get_node("gameplay").add_child(newPlayer);
		print(player.get_position())