extends Node

const OBJETOS = {
	"NADA" : {
		"OBJECTMSG" : "No hay muestra disponible",
		"OBJECTANL" : ""
	},
	"ROCAS" : {
		"OBJECTMSG" : "PRUEBA1",
		"OBJECTANL" : ""
	},
	"PLANTA" : {
		"OBJECTMSG" : "PRUEBA2",
		"OBJECTANL" : ""
	},
	"LAGO" : {
		"OBJECTMSG" : "PRUEBA3",
		"OBJECTANL" : ""
	},
	"ANIMAL" : {
		"OBJECTMSG" : "PRUEBA4",
		"OBJECTANL" : ""
	},
	"MUSICA" : {
		"OBJECTMSG" : "PRUEBA5",
		"OBJECTANL" : ""
	},
	"ZAPATO" : {
		"OBJECTMSG" : "PRUEBA6",
		"OBJECTANL" : ""
	},
	"ESQUELETO" : {
		"OBJECTMSG" : "PRUEBA7",
		"OBJECTANL" : ""
	},
}

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
	["interactuar"]: {
	  "commanddescription": "Recopilando muestra...",
	  "commandaction": "",
	  "nombre_nodo": "Interactuar",	  
	  "type": "terminal"
	},
	["salir", "cerrar"]: {
	  "commanddescription": " ", #A: este no necesita que devuelva texto, no?
	  "commandaction": "",
	  "nombre_nodo": "Salir",
	  "type": "terminal"
	},
	["mapa","minimapa"] : {
		"nombre_nodo":"Minimapa",
		"commanddescription":""
	},
	["ayuda"]: {
	  "commanddescription": " ", #A: este tampoco
	  "commandaction": "",
	  "nombre_nodo": "Ayuda",
	  "type": "terminal"
	},
	["yovictore"]: {
	  "commanddescription": "A rockear siempre",
	  "commandaction": "",
	  "type": "terminal"
	},
	["analizar", "adn", "analisis"]: {
		"nombre_nodo":"Analizar",
		"comanddescription": "Analizando muestra..."
	},
	["empanadas"]: {
	  "commanddescription": "EMPANADILLA RUSA DE CHILE",
	  "commandaction": "",
	  "type": "terminal"
	}
  }
