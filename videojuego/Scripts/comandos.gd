extends Node

const COMANDOS = {
	["mover", "desplazar"]: {
		"commandname": "MOVER",
		"nombre_nodo": "Mover",
		"commanddescription": "El robot avanza",
		"commandaction": "",
		"type": "terminal",
		"distancia" : "",
		"direccion" : "",
	},
	["PROCESAR"]: {
	  "commanddescription": "El robot procesa la información",
	  "commandaction": "",
	  "type": "terminal"
	},
	["INTERACTUAR"]: {
	  "commanddescription": "El robot interactúa con el entorno",
	  "commandaction": "",
	  "type": "terminal"
	},
	["SALIR"]: {
	  "commanddescription": "El robot sale del terminal",
	  "commandaction": "",
	  "nombre_nodo": "Salir",
	  "type": "terminal"
	},
	["AYUDA"]: {
	  "commanddescription": "El robot muestra la ayuda",
	  "commandaction": "",
	  "nombre_nodo": "Ayuda",
	  "type": "terminal"
	},
	["YoVictore"]: {
	  "commanddescription": "A rockear siempre",
	  "commandaction": "",
	  "type": "terminal"
	}
	
  }
