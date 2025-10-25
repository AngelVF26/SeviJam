using Godot;
using System;

public partial class Analizar : Node
{

	private CharacterBody2D player;
	private CanvasLayer canvasLayer;
	private Node commandController;
	public static Analizar Instance;
	private RichTextLabel terminalLabel;
	private int numDeMuestras = 0;
	[Export]
	private int numMaxDeMuestras { get; set; } = 3;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		Instance = this;
		AddToGroup("analizar");
		canvasLayer = GetParent().GetParent().GetNode<CanvasLayer>("CanvasLayer");
		player = canvasLayer.GetNode<CharacterBody2D>("SubViewportContainer/SubViewport/PhysicsScene/Player");
		commandController = GetParent();
		terminalLabel = commandController.GetParent().GetNode<RichTextLabel>("RichTextLabel");
		commandController.Connect(("AnalizarSeñal"), new Callable(this, nameof(OnAnalizarSeñal)));
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{

	}
	
	private void OnAnalizarSeñal()
	{
		if (numDeMuestras >= numMaxDeMuestras)
		{
			// Do nothing. Error.
		}
		else
        {
			numDeMuestras++;
        }		
		GD.Print(numDeMuestras);
	}
}
