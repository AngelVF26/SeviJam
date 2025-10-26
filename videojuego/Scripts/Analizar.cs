using Godot;
using System;
using System.Text.RegularExpressions;

public partial class Analizar : Node
{
	[Signal]
	public delegate void PeticionSeñalEventHandler();
	[Signal]
	public delegate void CanClonarSeñalEventHandler(bool canClonar);
	private CharacterBody2D player;
	private CanvasLayer canvasLayer;
	private Node commandController;
	public static Analizar Instance;
	private RichTextLabel terminalLabel;
	private int numDeMuestras = 0;
	[Export]
	private int numMaxDeMuestras { get; set; } = 5;
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

	private AnimationPlayer animationPlayer;
	private bool isPlaying = false;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		Instance = this;
		AddToGroup("analizar");
		player = GetParent().GetParent().GetNode<CharacterBody2D>("SubViewportContainer/SubViewport/PhysicsScene/Player");
		commandController = GetParent();

		animationPlayer = GetParent().GetParent().GetNode<AnimationPlayer>("AnimationText");

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

		if (isPlaying)
		{
			if (!animationPlayer.IsPlaying())
			{
				GetTree().ChangeSceneToFile("res://Escenas/main_menu.tscn");
			}
		}
	}

	private void OnComandoEnviado()
	{
		tiempoEntreComandos++;
	}


	private void OnSiSeñal()
	{
		
		if (numDeMuestras > numMaxDeMuestras)
		{
			String linea1 = "\n\n\n  > Todos los compartimentos disponibles han sido ocupados.";
			String linea2 = "\n  > La misión ha fracasado.";
			String linea3 = "\n  > Se recomienda la desconexión de Sans0n.";

			// TODO: Setear esto
			terminalLabel.Text = linea1 + linea2 + linea3;
			animationPlayer.Play("finale");
		}
		else
		{
			isWriting = true;
			terminalLabel.VisibleCharacters = 0;
			numDeMuestras++;
			String analizandoMuestra = "\n\n\n > Analizando muestra. . .\n > Analizando muestra. . .\n > Analizando muestra. . .\n > Analizando muestra. . .";
			// String resultado = "\n\n > RESULTADO: ERROR. ADN INCOMPATIBLE O INEXISTENTE";
			Area2D area = (Area2D)player.Get("current_area");
			String resultado = (String)area.Get("objeto_analizar");
			String claveDic = (String)area.Get("objecto1");
			terminalLabel.Text = analizandoMuestra + "\n  > "+resultado;
			fullText = terminalLabel.Text;

			var value = Regex.Match(resultado, @"\b(CLONAR+.)$");
			GD.Print("miramos: " + numDeMuestras);
			// Estamos en el nodo final. El esqueleto.
			if (value.Success)
			{
				GD.Print("oleeee");
				EmitSignal("CanClonarSeñal", true);
			}
			else
			{
				if (numDeMuestras >= numMaxDeMuestras)
				{
					String linea1 = "\n  > Todos los compartimentos disponibles han sido ocupados.";
					String linea2 = "\n  > La misión ha fracasado.";
					String linea3 = "\n  > Se recomienda la desconexión de [color=blue]Sans0n.[/color]";

					numDeMuestras = 0;

					// TODO: Setear esto
					terminalLabel.Text = fullText + linea1 + linea2 + linea3;
					animationPlayer.Play("badEnding");
					isPlaying = true;

				}
			}

			area.Visible = false;
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
				ayudaTexto = "\n\n > Quedan cuatro compartimentos de análisis.";
				break;
			case int val when val == 2:
				ayudaTexto = "\n\n > Quedan tres compartimentos de análisis.";
				break;
			case int val when val == 3:
				ayudaTexto = "\n\n > Quedan dos compartimentos de análisis.";
				break;
			case int val when val == 4:
				ayudaTexto = "\n\n > [color=yellow]AVISO[/color]: Queda un solo compartimento de análisis";
				break;
			case int val when val == numMaxDeMuestras:
				ayudaTexto = "\n\n > Todos los compartimentos de análisis ocupados. Abortando.";
				break;
			default:
				break;
		}

		res += ayudaTexto;

		return res;
	}
}
