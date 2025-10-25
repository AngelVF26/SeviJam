using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

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
	private Node comandos;
	private Godot.Collections.Dictionary<String[], Godot.Collections.Dictionary<String, String>> fCommandDict;
	private Node2D fPadre;
	private Godot.Collections.Dictionary<String, String> fCommandToProcess;
	private Analizar analizar;
	private bool isPeticion = false;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		comandos = GetNode<Node>("Comandos");
		Variant dict = (Variant)comandos.Get("COMANDOS");
		fCommandDict= dict.AsGodotDictionary<String[], Godot.Collections.Dictionary<String, String>>();
		fPadre = (Node2D)this.GetParent();
		analizar = GetNode<Analizar>("Analizar");

		analizar.Connect(("PeticionSeñal"), new Callable(this, nameof(OnPeticionSeñal)));
		fPadre.Connect("señalControl", new Callable(this, nameof(this.ParseCommandLine)));

	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	private void OnPeticionSeñal()
	{
		isPeticion = true;
	}

	public void ParseCommandLine(String line)
	{
		var value = Regex.Match(line, @"^([\w\-]+)"); // Devuelve la primera palabra de la cadena. Esperamos que eso sea el comando per se
		String result = value.Value.ToLower();

		if (fCommandDict != null)
		{
			foreach (KeyValuePair<String[], Godot.Collections.Dictionary<String, String>> cmd in fCommandDict)
			{
				if (!cmd.Key.Contains(result) || isPeticion)
				{
					if (line.ToLower() == "s")
					{
						EmitSignal("SiSeñal");
						isPeticion = false;
						break;
					}
					else if (line.ToLower() == "n")
					{
						EmitSignal("NoSeñal");
						isPeticion = false;
						break;
					}
					else
					{
						EmitSignal("ReturnError");
						isPeticion = false;
					}					
					//TODO: Hacerlo
				}
				else
				{
					// Encontrado el comando. 
					// Llamar al nodo. Señal. Etc.
					fCommandToProcess = cmd.Value;
					String nombreNodo = fCommandToProcess["nombre_nodo"];
					
					switch (nombreNodo)
					{
						case string val when val == "Mover":
							ProcesarNodoMover(line);
							break;
						case string val when val == "Ayuda":
							ProcesarNodoAyuda(line);
							break;
						case string val when val == "Salir":
							ProcesarNodoSalir(line);
							break;
						case string val when val == "Procesar":
							ProcesarNodoProcesar(line);
							break;
						case string val when val == "Interactuar":
							ProcesarNodoInteractuar(line);
							break;
						case string val when val == "Analizar":
							ProcesarNodoAnalizar(line);
							break;
						default:
							GD.Print("ERROR: NO NODO1?");
							break;
					}
				}
			}
		}

	}

	private void ProcesarNodoSalir(String linea)
	{
		var value = Regex.Match(linea, @"^(\w+)");
		if (!value.Success)
		{
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
		var value = Regex.Match(linea, @"^(\w+)");
		if (!value.Success)
		{
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
		var value = Regex.Match(linea, @"^(\w+)\s(\d+)\s((norte)|(sur)|(este)|(oeste)|(n)|(e)|(o)|(s))");
		if (!value.Success)
		{
			EmitSignal("ReturnError");
		}
		else
		{
			var arg1 = Regex.Match(linea, @"(\d+)");
			var arg2 = Regex.Match(linea, @"((norte)|(sur)|(este)|(oeste)|\sn$|\se$|\so$|\ss$)");

			int distancia = Int32.Parse(arg1.Value);
			String direccion = arg2.Value.Trim();
			EmitSignal("MoverSeñal", distancia, direccion);
		}
	}


}
