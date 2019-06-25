import wollok.game.*
import personajes.*
import direcciones.*

class Rival {
	var property position
	var property estaVivo = true
	
	constructor(_position){
		position = _position
	}
	
	method image() = if(estaVivo) "Gotita.png" else "RivalMuerto.png"
	
	method puedePisarte(_) = true
	
	method explotar(){
		estaVivo = false game.removeVisual(self)
	}
	
	method moverse(){
		if(estaVivo){
			self.moverseSiEstaLibre()
		}
	}
	
	method esDireccionPosible(dir) = game.getObjectsIn(dir.siguiente(position)).all{ obj => obj.esMatable() }

	method moverseSiEstaLibre(){
		const direccionesPosibles = [arriba,abajo,derecha,izquierda].filter { dir => self.esDireccionPosible(dir) }
		
		if (not direccionesPosibles.isEmpty()) {
			const unaDireccion = direccionesPosibles.anyOne()
			position = unaDireccion.siguiente(position)
		}
	}
	method puedeExplotar()= true
	
	method tocar(){ }
	
	method tieneLlave(){}
	
	method ganaste(){}
	
	method esMatable()= true
}

class Rival2 inherits Rival{
	var previousPosition = position

	override method image() = if(estaVivo) "Ballon.png" else "RivalMuerto.png"

	method acercarseA(personaje) {
		if(estaVivo) {
			var otraPosicion = personaje.position()

			var newX = position.x() + if (otraPosicion.x() > position.x()) 1 else -1
			var newY = position.y() + if (otraPosicion.y() > position.y()) 1 else -1
			position = game.at(newX, newY) }
	}

	method resetPreviousPosition(){
		position = previousPosition
	}
	
}
