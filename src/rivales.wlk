import wollok.game.*
import personajes.*

class Rival {
	const numero
	var property position
	var property estaVivo = true
	var previousPosition = position
	
	constructor(_numero) {
		numero = _numero
		position = game.at(numero + 1, numero + 1)
	}
	
	method image() = if(estaVivo) "Rival.png" else "RivalMuerto.png"
	
	method puedePisarte(bomberman) = true
	
	method explotar(){
		estaVivo = false game.removeVisual(self)
	}
	
	method acercarseA(personaje) {
		if(estaVivo) {
			var otraPosicion = personaje.position()
			
			var newX = position.x() + if (otraPosicion.x() > position.x()) 1 else -1
		 	var newY = position.y() + if (otraPosicion.y() > position.y()) 1 else -1
			//newX = newX.max(0).min(game.width() - 2)
			//newY = newY.max(0).min(game.height() - 2) 
			position = game.at(newX, newY) }
	}
	
	
	method resetPreviousPosition(){
		position = previousPosition
	}
	
	method tocar(){ }
}

