using Godot;
using System;
using System.Collections.Generic;
using System.Linq;

public partial class ComandController : Node
{
	[Signal]
	public delegate void ReturnErrorEventHandler();
	private Node comandos;
	private Godot.Collections.Dictionary<String[], Godot.Collections.Dictionary<String, String>> fCommandDict;
	private Node2D fPadre;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		comandos = GetNode<Node>("Comandos");
		Variant dict = (Variant)comandos.Get("COMANDOS");
		fCommandDict= dict.AsGodotDictionary<String[], Godot.Collections.Dictionary<String, String>>();
		fPadre = (Node2D)this.GetParent();

		fPadre.Connect("señalControl", new Callable(this, nameof(this.ParseCommandLine)));

	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	public void ParseCommandLine(String line)
	{
		if (fCommandDict != null)
		{
			foreach (KeyValuePair<String[], Godot.Collections.Dictionary<String, String>> cmd in fCommandDict)
			{
				if (!cmd.Key.Contains(line))
				{
					EmitSignal("ReturnError");
					//TODO: Hacerlo
				}
				else
				{
					GD.Print("FUNCIONO");
				}
			}

		}

	}

	// Recibe un "comando1" "comando2" "comando3"... etc
	private Godot.Collections.Dictionary<String, String> GetComando(String comando)
	{
		/*Godot.Collections.Dictionary<String, String> res = new Godot.Collections.Dictionary<String, String>();	
		String commandName = fCommandDict[comando]["commandname"];
		String commandDescription = fCommandDict[comando]["commanddescription"];
		String commandAction = fCommandDict[comando]["commandaction"];
		String type = fCommandDict[comando]["type"];

		return res; */

		return null;
	}



}

public partial class Comando
{
	public String fCommandName;
	public String fCommandDescription;
	public String fCommandAction;
	public String fType;

	public Comando(String commandName, String commandDescription, String commandAction, String type)
	{
		fCommandAction = commandAction;
		fCommandDescription = commandDescription;
		fCommandName = commandName;
		fType = type;
	}

}
