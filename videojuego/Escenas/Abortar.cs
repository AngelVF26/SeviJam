using Godot;
using System;

public partial class Abortar : Node
{
	private Node commandController;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		commandController = GetParent();

		commandController.Connect(("AbortarSeñal"), new Callable(this, nameof(OnAbortarSeñal)));
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	private void OnAbortarSeñal()
	{
		// MORIR!!!
		GetTree().ChangeSceneToFile("res://Escenas/main_menu.tscn");
	}
}
