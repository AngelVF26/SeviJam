extends Node

const OBJETOS = {
	"NADA" : {
		"OBJECTMSG" : "No hay muestra disponible para analizar.",
		"OBJECTANL" : ""
	},
	"ROCAS" : {
		"OBJECTMSG" : "Muestra inorgánica obtenida. Inicie ANÁLISIS para examinarla.",
		"OBJECTANL" : "Análisis completado. \n No hay muestras orgánicas. Se han encontrado trazas de silicio, hierro y níquel."
	},
	"PLANTA" : {
		"OBJECTMSG" : "Muestra de ADN obtenida. Inicie ANÁLISIS para examinarla.",
		"OBJECTANL" : "Análisis completado. \n Muestra orgánica de células vegetales. No es válido para la clonación. \n Parece que esta especie de planta absorbe el espectro rojizo de luz solar."
	},
	"LAGO" : {
		"OBJECTMSG" : "Muestra de ADN obtenida. Inicie ANÁLISIS para examinarla.",
		"OBJECTANL" : "Análisis completado. \n La muestra de agua contiene 34 tipos de bacterias, amebas, y una especie de animal microscópico\n en forma de cruasán."
	},
	"ANIMAL" : {
		"OBJECTMSG" : "Muestra de ADN obtenida. Inicie ANÁLISIS para examinarla.",
		"OBJECTANL" : "Análisis completado. \n Muestra orgánica de células animales. Se trata de un espécimen de la familia Canidae.\n El análisis de carbono indica una antiguedad de 50 décadas."
	},
	"MUSICA" : {
		"OBJECTMSG" : "Procesando audio...",
		"OBJECTANL" : ""
	},
	"ZAPATO" : {
		"OBJECTMSG" : "Muestra de ADN obtenida. Inicie ANÁLISIS para examinarla.",
		"OBJECTANL" : "Análisis completado. No sé qué objeto ha dibujado Dani.\n "
	},
	"ESQUELETO" : {
		"OBJECTMSG" : "Muestra de ADN obtenida. Inicie ANÁLISIS para examinarla.",
		"OBJECTANL" : "Análisis completado. Restos de células óseas de un homo sapiens. Se puede intentar CLONAR."
	},
}

const COMANDOS = {
	["mover", "desplazar", "avanzar", "/mover", "/desplazar", "/avanzar"]: {
		"commandname": "MOVER",
		"nombre_nodo": "Mover",
		"commanddescription": "Avanzando en la dirección indicada...",
		"commandaction": "Desplaza el rover en la dirección indicada. \n   Por ejemplo, MOVER 10 NORTE. \n   La velocidad máxima es 5. No se moverá más rápido.",
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
		"commanddescription":"Abre un mapa que muestra el entorno.\n   No se puede usar comando 'mover' con el mapa abierto."
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
		"comanddescription": "Analizando muestra...",
		"commandaction": "Analiza una muestra de ADN disponible."
	},
	["empanadas"]: {
	  "commanddescription": "EMPANADILLA RUSA DE CHILE",
	  "commandaction": "",
	  "type": "terminal"
	},
	["clonar"]: {
		"commanddescription": "Iniciando el proceso de clonación de la muestra obtenida. . .",
		"commandaction": "",
		"type": "terminal",
		"nombre_nodo":"Clonar"
	},
	["abortar"]: {
		"commanddescription":"",
		"commandaction": "",
		"type": "terminal",
		"nombre_nodo":"Abortar"
	}
  }
