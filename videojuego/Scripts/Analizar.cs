using Godot;
using System;

public partial class Analizar : Node
{
	[Signal]
	public delegate void PeticionSeñalEventHandler();
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
		terminalLabel = commandController.GetParent().GetNode<RichTextLabel>("InfoComandos");
		commandController.Connect(("AnalizarSeñal"), new Callable(this, nameof(OnAnalizarSeñal)));
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{

	}

	private void OnAnalizarSeñal()
	{
		String inicio = "\n\n\n\n > Necesito el input y tal";
		String peticion = "\n\n > ¿Deseas analizar la muestra?";
		String warning = "\n\n > Huecos disponibles: " + GetHuecosParaAnalizar();
		String sn = "\n\n > S/N";
		terminalLabel.Text = inicio + peticion + warning+sn;
		EmitSignal("PeticionSeñal");
		//OnAceptarAnalizarSeñal();
		//terminalLabel.Text = "\n\n\n\n" + GetHuecosParaAnalizar();
	}

	private String GetHuecosParaAnalizar()
	{
		String res = "";
		String ayudaTexto = "";

		for (int i = 0; i < numMaxDeMuestras; i++)
		{
			if (i < numDeMuestras)
			{
				res += "  [X]  ";
			}
			else
			{
				res += "  [ ]  ";
			}
		}

		switch (numDeMuestras)
		{
			case int val when val == 1:
				ayudaTexto = "\n\n > Quedan dos compartimentos de anális.";
				break;
			case int val when val == 2:
				ayudaTexto = "\n\n > AVISO: Queda un compartimento de análisis!";
				break;
			case int val when val == 3:
				ayudaTexto = "\n\n > Todos los compartimentos de análisis ocupados. Abortando.";
				break;
			default:
				break;
		}

		res += ayudaTexto;

		return res;
	}	
	
	private void OnAceptarAnalizarSeñal()
	{
		if (numDeMuestras >= numMaxDeMuestras)
		{
			// TODO: Fin del juego?
		}
		else
		{
			numDeMuestras++;
		}		
		GD.Print(numDeMuestras);
	}
}
