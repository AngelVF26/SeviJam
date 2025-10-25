extends Node

const COMANDOS = {
	["mover", "desplazar", "avanzar"]: {
		"commandname": "MOVER",
		"nombre_nodo": "Mover",
		"commanddescription": "Avanzando en la dirección indicada...",
		"commandaction": "",
		"type": "terminal",
		"distancia" : "",
		"direccion" : "",
	},
	["procesar", "imagen", "captura"]: {
	  "commanddescription": "Procesando interfaz óptica...",
	  "commandaction": "",
	  "nombre_nodo": "Procesar",
	  "type": "terminal"
	},
	["INTERACTUAR"]: {
	  "commanddescription": "Recopilando muestra...",
	  "commandaction": "",
	  "nombre_nodo": "Interactuar",	  
	  "type": "terminal"
	},
	["SALIR"]: {
	  "commanddescription": " ", #A: este no necesita que devuelva texto, no?
	  "commandaction": "",
	  "nombre_nodo": "Salir",
	  "type": "terminal"
	},
	["AYUDA"]: {
	  "commanddescription": " ", #A: este tampoco
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
