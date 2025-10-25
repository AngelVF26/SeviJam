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
	private int tiempoEntreComandos = 0;
	private int rndTiempo1;
	private int rndTiempo2;
	private int rndTiempo3;
	private bool isAnalizar = false;
	private bool isSi = false;
	private bool isWriting = false;
	private bool isWritingReallyReallySlow = false;
	private String fullText = "";
	[Export]
	public double charactersPerSecond = 6f;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		Instance = this;
		AddToGroup("analizar");
		player = GetParent().GetParent().GetNode<CharacterBody2D>("SubViewportContainer/SubViewport/PhysicsScene/Player");
		commandController = GetParent();
		terminalLabel = commandController.GetParent().GetNode<RichTextLabel>("InfoComandos");
		commandController.Connect(("AnalizarSeñal"), new Callable(this, nameof(OnAnalizarSeñal)));
		commandController.Connect(("SiSeñal"), new Callable(this, nameof(OnSiSeñal)));
		commandController.Connect(("NoSeñal"), new Callable(this, nameof(OnNoSeñal)));
		commandController.Connect(("ComandoEnviado"), new Callable(this, nameof(OnComandoEnviado)));
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if (isWriting)
		{
			terminalLabel.VisibleCharacters += (int)Math.Ceiling(charactersPerSecond * delta);
			if (terminalLabel.VisibleCharacters >= fullText.Length)
			{
				FinishTyping();
			}
		}
	}

	private void OnComandoEnviado()
	{
		tiempoEntreComandos++;
	}

	private void OnSiSeñal()
	{
		
		if (numDeMuestras >= numMaxDeMuestras)
		{
			isWriting = true;
			// TODO: Fin del juego?
			String loDeAntes = terminalLabel.Text;
			String fallo = "\n\n > Todas las muestras han sido recogidas";
			terminalLabel.Text = loDeAntes + fallo;
		}
		else
		{
			isWriting = true;
			terminalLabel.VisibleCharacters = 0;
			numDeMuestras++;
			String analizandoMuestra = "\n\n\n > Analizando muestra. . .\n > Analizando muestra. . .\n > Analizando muestra . . .\n > Analizando muestra. . .";
			// String resultado = "\n\n > RESULTADO: ERROR. ADN INCOMPATIBLE O INEXISTENTE";
			Area2D area = (Area2D)player.Get("current_area");
			String resultado = (String) area.Get("objeto_analizar");
			terminalLabel.Text = analizandoMuestra + "\n  > "+resultado;
			fullText = terminalLabel.Text;
		}
	}

	private void OnNoSeñal()
	{
		String loDeAntes = terminalLabel.Text;
		String fallo = "\n\n > Muestra rechazada.";
		terminalLabel.Text = loDeAntes + fallo;
	}
	
	private void FinishTyping()
	{
		GD.Print("Aqui2");
		terminalLabel.VisibleCharacters = -1;
		isWriting = false;
		isWritingReallyReallySlow = false;
	}

	private void OnAnalizarSeñal()
	{
		isWriting = true;

		String peticion = "\n\n > ¿Deseas analizar la muestra?";
		String warning = "\n\n > Huecos disponibles: " + GetHuecosParaAnalizar();
		String sn = "\n\n > S/N";
		terminalLabel.VisibleCharacters = 0;
		terminalLabel.Text = peticion + warning + sn;
		fullText = terminalLabel.Text;
		GD.Print("Aqui1");
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
				ayudaTexto = "\n\n > Quedan dos compartimentos de análisis.";
				break;
			case int val when val == 2:
				ayudaTexto = "\n\n > AVISO: ¡Queda un solo compartimento de análisis!";
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
}
