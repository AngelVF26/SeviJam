using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Transactions;

public partial class ComandController : Node
{
	[Signal]
	public delegate void ReturnErrorEventHandler();
	[Signal]
	public delegate void AyudaSeñalEventHandler();
	[Signal]
	public delegate void ProcesarSeñalEventHandler();
	[Signal]
	public delegate void InteractuarSeñalEventHandler();
	[Signal]
	public delegate void SalirSeñalEventHandler();
	[Signal]
	public delegate void AnalizarSeñalEventHandler();
	[Signal]
	public delegate void MinimapaSeñalEventHandler();
	[Signal]
	public delegate void MoverSeñalEventHandler(int distancia, string direccion);
	[Signal]
	public delegate void SiSeñalEventHandler();
	[Signal]
	public delegate void NoSeñalEventHandler();
	[Signal]
	public delegate void ComandoEnviadoEventHandler();
	[Signal]
	public delegate void CerrarVentanaEventHandler();
	[Signal]
	public delegate void ClonarSeñalEventHandler();
	[Signal]
	public delegate void AbortarSeñalEventHandler();
	private Node comandos;
	private Godot.Collections.Dictionary<String[], Godot.Collections.Dictionary<String, String>> fCommandDict;
	private Node2D fPadre;
	private Godot.Collections.Dictionary<String, String> fCommandToProcess;
	private Analizar analizar;
	private bool isPeticion = false;
	private bool fIsActividad = false;
	private Node minimapa;
	private bool fCanAnalizar = false;
	private Node interactuar;
	private RichTextLabel fCommandLabel;
	private LineEdit terminalInput;
	[Export]
	private bool fCanClonar { get; set; } = false;

	[Export]
	private bool fCanCuaderno { get; set; } = false;

	private Node clonar;
	private AnimationPlayer animationPlayer;
	private Node abortar;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		comandos = GetNode<Node>("Comandos");
		Variant dict = (Variant)comandos.Get("COMANDOS");
		fCommandDict= dict.AsGodotDictionary<String[], Godot.Collections.Dictionary<String, String>>();
		fPadre = (Node2D)this.GetParent();
		analizar = GetNode<Analizar>("Analizar");
		minimapa = GetNode<Node>("Minimapa");
		interactuar = GetNode<Node>("Interactuar");
		fCommandLabel = GetParent().GetNode<RichTextLabel>("InfoComandos");
		terminalInput = GetParent().GetNode<LineEdit>("TerminalComandos");
		clonar = GetNode<Node>("Clonar");
		animationPlayer = GetParent().GetNode<AnimationPlayer>("AnimationText");
		abortar = GetNode<Node>("Abortar");

		clonar.Connect(("cuadernoSeñal"), new Callable(this, nameof(OnCuadernoSeñal)));
		minimapa.Connect(("actividad_del_mapa"), new Callable(this, nameof(OnActividadDelMapa)));
		analizar.Connect(("PeticionSeñal"), new Callable(this, nameof(OnPeticionSeñal)));
		analizar.Connect(("CanClonarSeñal"), new Callable(this, nameof(OnCanClonar)));
		fPadre.Connect("señalControl", new Callable(this, nameof(this.ParseCommandLine)));
		GetParent().Connect("señalAnalizar", new Callable(this, nameof(this.OnCanAnalizar)));
		
		// interactuar.Connect((""), new Callable(this, nameof(this.OnCanAnalizar)));
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	private void OnPeticionSeñal()
	{
		isPeticion = true;
	}

	private void OnCanAnalizar(bool canAnalizar)
	{
		fCanAnalizar = canAnalizar;
	}

	private void OnCuadernoSeñal()
	{
		fCanCuaderno = true;
	}

	private void OnCanClonar(bool canClonar)
	{
		fCanClonar = canClonar;
	}

	private void OnActividadDelMapa(bool isActividad)
	{
		fIsActividad = isActividad;
	}

	private void ReturnErrorInTerminal(int flag)
	{
		String ret = "";
		if (fCommandLabel != null)
		{
			// 1 => no existe comando
			// 2 => mal puesto salir
			// 3 => mal puesto ayuda
			// 4 => malos argumentos en mover
			GD.Print(flag);
			ret = flag switch
			{
				1 => "\n\n\n> ERROR: El comando proporcionado no existe.",
				2 => "\n\n\n> ERROR: El comando proporcionado no admite argumentos",
				3 => "\n\n\n> ERROR: El comando proporcionado no admite argumentos",
				4 => "\n\n\n> ERROR: El comando proporcionado debe tener 2 argumentos.\n> Ej: mover 2 n",
				5 => "\n\n\n> ERROR: No hay muestras para analizar.",
				_ => "\n\n\n > ERROR. El comando proporcionado es incorrecto.",
			};
			if (ret != "")
			{
				fCommandLabel.Text = ret; 
			}
		}
		
	}

	public void ParseCommandLine(String line)
	{
		var value = Regex.Match(line, @"^(\/[\w\-]+)|([\w\-]+)"); // Devuelve la primera palabra de la cadena. Esperamos que eso sea el comando per se
		String result = value.Value.ToLower();

		if (fCommandDict != null)
		{
			bool analizarVisitado = false;
			bool isError = true;
			foreach (KeyValuePair<String[], Godot.Collections.Dictionary<String, String>> cmd in fCommandDict)
			{
				if (!cmd.Key.Contains(result) || isPeticion || fCanCuaderno)
				{
					if (line.ToLower() == "s" && isPeticion)
					{
						EmitSignal("SiSeñal");
						isPeticion = false;
						isError = false;
						break;
					}
					else if (line.ToLower() == "n" && isPeticion)
					{
						EmitSignal("NoSeñal");
						isPeticion = false;
						isError = false;
						break;
					}
					else if (line.ToLower() == "s" && fCanCuaderno)
					{
						String linea1 = "\n  ********************************************************";
						String linea2 = "\n  ***                   MISIÓN EDÉN                   ***";
						String linea3 = "\n  > Cuaderno de bitácora, día 2510 de expedición:";
						String linea4 = "\n  > Realizada la exploración del planeta [7191], o GAIA. Había";
						String linea5 = "\n  > rastros de vida, pero primitiva e inusual, incompatible con el clonador.";
						String linea6 = "\n  > He encontrado restos humanos, pero tan antiguos que a duras penas he obtenido unas pocas moléculas de ADN.";
						String linea7 = "\n  >  El resto del páramo estaba desierto. No había ni un pelo...";
						String linea8 = "\n  > Quizás tenga más suerte en otro planeta. Por ahora, lo mejor será ABORTAR MISION.";
						fCommandLabel.Text = linea1 + linea2 + linea1 + linea3 + linea4 + linea5 + linea6 + linea7 + linea8;

						animationPlayer.Play("finale");
						fCanCuaderno = false;
						isError = false;
					}
					else if (line.ToLower() == "n" && fCanCuaderno)
					{
						fCommandLabel.Text = "\n > Entrada descartada del cuaderno de bitácora.";
						fCanCuaderno = false;
						isError = false;
					}
				}
				
				else
				{
					// Encontrado el comando. 
					// Llamar al nodo. Señal. Etc.
					fCommandToProcess = cmd.Value;
					String nombreNodo = fCommandToProcess["nombre_nodo"];
					GD.Print(nombreNodo);

					if (fCanAnalizar)
					{
						if (nombreNodo == "Analizar")
						{
							analizarVisitado = true;
							fCanAnalizar = false;
							isError = false;
							ProcesarNodoAnalizar(line);
							EmitSignal("ComandoEnviado");
							break;
						}
					}
					else if (fCanClonar)
					{
						if (nombreNodo == "Clonar")
						{
							fCanClonar = false;
							isError = false;
							EmitSignal("ClonarSeñal");
							break;
						}
					}
					else if (fIsActividad)
					{
						if (nombreNodo == "Salir")
						{
							fIsActividad = false;
							isError = false;
							EmitSignal("CerrarVentana");
							break;
						}
					}
					
					switch (nombreNodo)
					{
						case string val when val == "Mover":
							ProcesarNodoMover(line);
							isError = false;
							EmitSignal("ComandoEnviado");
							break;
						case string val when val == "Ayuda":
							ProcesarNodoAyuda(line);
							GD.Print("no entro aqui");
							isError = false;
							EmitSignal("ComandoEnviado");
							break;
						case string val when val == "Salir":
							ProcesarNodoSalir(line);
							isError = false;
							EmitSignal("ComandoEnviado");
							break;
						case string val when val == "Procesar":
							ProcesarNodoProcesar(line);
							isError = false;
							EmitSignal("ComandoEnviado");
							break;
						case string val when val == "Interactuar":
							ProcesarNodoInteractuar(line);
							isError = false;
							EmitSignal("ComandoEnviado");
							break;
						case string val when val == "Minimapa":
							ProcesarNodoMapa(line);
							isError = false;
							EmitSignal("ComandoEnviado");
							break;
						case string val when val == "Abortar":
							GD.Print("a");
							ProcesarNodoAbortar(line);
							isError = false;
							EmitSignal("ComandoEnviado");
							break;
						default:
							isError = false;
							break;
					}
				}
			}

			if (!fCanAnalizar && !analizarVisitado)
			{
				if (line.ToLower() == "analizar")
				{
					ReturnErrorInTerminal(5);
					isError = false; // ironico
					EmitSignal("ReturnError");
				}
			}
			
			if (isError)
			{
				ReturnErrorInTerminal(1);
				EmitSignal("ReturnError");
			}
		}

	}

	private void ProcesarNodoMapa(String linea)
	{
		EmitSignal("MinimapaSeñal");
	}
	
	private void ProcesarNodoAbortar(String linea)
	{
		if (linea.ToLower() == "abortar mision")
		{
			EmitSignal("AbortarSeñal");
		}
		else
		{
			fCommandLabel.Text = "\n\n  > Comando inválido. ¿Has probado con ABORTAR MISION?";
		}
	}

	private void ProcesarNodoSalir(String linea)
	{
		var value = Regex.Match(linea, @"^(\/[\w\-]+)|([\w\-]+)");
		if (!value.Success)
		{
			ReturnErrorInTerminal(2);
			EmitSignal("ReturnError");
		}
		else
		{
			EmitSignal("SalirSeñal");
			GD.Print("SALGO.");
		}
	}



	private void ProcesarNodoInteractuar(String linea)
	{
		GD.Print("Interactuar");
		EmitSignal("InteractuarSeñal");
	}

	private void ProcesarNodoAyuda(String linea)
	{
		var value = Regex.Match(linea, @"^(\/[\w\-]+)|([\w\-]+)");
		if (!value.Success)
		{
			ReturnErrorInTerminal(3);
			EmitSignal("ReturnError");
		}
		else
		{
			EmitSignal("AyudaSeñal");
		}
	}

	private void ProcesarNodoProcesar(String linea)
	{
		EmitSignal("ProcesarSeñal");
	}

	private void ProcesarNodoAnalizar(String linea)
	{
		EmitSignal("AnalizarSeñal");
	}
	
	private void MinimapaNodoProcesar(String linea)
	{
		EmitSignal("MinimapaNodo");
	}

	private void ProcesarNodoMover(String linea)
	{
		// Procesamos si el comando está mal escrito. Si no, mandamos error.
		String lineaMin = linea.ToLower();
		var value = Regex.Match(lineaMin, @"^(\w+)\s(\d+)\s((norte)|(sur)|(este)|(oeste)|(n)|(e)|(o)|(s))");
		if (!value.Success)
		{
			ReturnErrorInTerminal(4);
			EmitSignal("ReturnError");
		}
		else
		{
			var arg1 = Regex.Match(lineaMin, @"(\d+)");
			var arg2 = Regex.Match(lineaMin, @"((norte)|(sur)|(este)|(oeste)|\sn$|\se$|\so$|\ss$)");

			int distancia = Int32.Parse(arg1.Value);
			String direccion = arg2.Value.Trim();
			EmitSignal("MoverSeñal", distancia, direccion);
		}
	}


}
