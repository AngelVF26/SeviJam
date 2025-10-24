extends Node

const COMANDOS = {
	["mover", "HOLA"]: {
		"commandname": "MOVER",
		"nombre_nodo": "Mover",
		"commanddescription": "Avanzando en la dirección indicada...",
		"commandaction": "",
		"type": "terminal",
		"distancia" : "",
		"direccion" : "",
	},
	["PROCESAR"]: {
	  "commanddescription": "Procesando interfaz óptica...",
	  "commandaction": "",
	  "type": "terminal"
	},
	["INTERACTUAR"]: {
	  "commanddescription": "Recopilando muestra...",
	  "commandaction": "",
	  "type": "terminal"
	},
	["SALIR"]: {
	  "commanddescription": " ", #A: este no necesita que devuelva texto, no?
	  "commandaction": "",
	  "type": "terminal"
	},
	["AYUDA"]: {
	  "commanddescription": " ", #A: este tampoco
	  "commandaction": "",
	  "type": "terminal"
	},
	["YoVictore"]: {
	  "commanddescription": "A rockear siempre",
	  "commandaction": "",
	  "type": "terminal"
	}
	
  }
