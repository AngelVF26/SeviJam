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
	["mover", "desplazar", "avanzar", "/mover", "/desplazar", "/avanzar"]: {
		"commandname": "MOVER",
		"nombre_nodo": "Mover",
		"commanddescription": "Avanzando en la dirección indicada...",
		"commandaction": "Este comando desplaza el rover en la dirección indicada. Por ejemplo, MOVER 10 NORTE.",
		"type": "terminal",
		"distancia" : "",
		"direccion" : "",
	},
	["procesar", "imagen", "captura", "foto","/procesar", "/imagen", "/captura", "/foto"]: {
	  "commanddescription": "Procesando interfaz óptica...",
	  "commandaction": "Toma una fotografía del entorno.",
	  "nombre_nodo": "Procesar",
	  "type": "terminal"
	},
	["interactuar", "/interactuar"]: {
	  "commanddescription": "Recopilando muestra...",
	  "commandaction": "Obtiene una muestra del entorno.",
	  "nombre_nodo": "Interactuar",	  
	  "type": "terminal"
	},
	["salir", "cerrar","/salir", "/cerrar"]: {
	  "commanddescription": " ", #A: este no necesita que devuelva texto, no?
	  "commandaction": "Vuelve a la pantalla inicial.",
	  "nombre_nodo": "Salir",
	  "type": "terminal"
	},
	["mapa","minimapa","/mapa","/minimapa"] : {
		"nombre_nodo":"Minimapa",
		"commanddescription":"Abre un mapa que muestra el entorno."
	},
	["ayuda", "help", "/help", "/ayuda"]: {
	  "commanddescription": " ", #A: este tampoco
	  "commandaction": "Muestra los comandos básicos",
	  "nombre_nodo": "Ayuda",
	  "type": "terminal"
	},
	["yovictore"]: {
	  "commanddescription": "A rockear siempre",
	  "commandaction": "",
	  "type": "terminal"
	},
	["analizar", "adn", "analisis","análisis","/analizar", "/adn", "/analisis","/análisis"]: {
		"nombre_nodo":"Analizar",
		"comanddescription": "Analizando muestra..."
	},
	["empanadas"]: {
	  "commanddescription": "EMPANADILLA RUSA DE CHILE",
	  "commandaction": "",
	  "type": "terminal"
	}
  }
