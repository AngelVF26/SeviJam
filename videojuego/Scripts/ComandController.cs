using Godot;
using System;
using System.Collections.Generic;

public partial class ComandController : Node
{
	[Signal]
	public delegate void ReturnErrorEventHandler();
	private Node comandos;
	private Godot.Collections.Dictionary<String, Godot.Collections.Dictionary<String, String>> fCommandDict;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		comandos = GetNode<Node>("Comandos");
		Variant dict = (Variant)comandos.Get("COMANDOS");
		fCommandDict= dict.AsGodotDictionary<String, Godot.Collections.Dictionary<String, String>>();

		Comando comando = GetComando("comando4");

	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	public void ParseCommandLine(String line)
	{
		if (fCommandDict != null)
		{
			if (fCommandDict[line] == null)
			{
				// No existe el comando
				EmitSignal("ReturnError");
			}
			else
			{
				// Existe el comando
				Comando comando = GetComando(line);
            }
        }

	}

	// Recibe un "comando1" "comando2" "comando3"... etc
	private Comando GetComando(String comando)
	{
		
		String commandName = fCommandDict[comando]["commandname"];
		String commandDescription = fCommandDict[comando]["commanddescription"];
		String commandAction = fCommandDict[comando]["commandaction"];
		String type = fCommandDict[comando]["type"];


		return new Comando(commandName, commandDescription, commandAction, type);
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
