import wollok.game.*
import personajes.*
import direcciones.*

class Rival {
	var property position
	var property estaVivo = true
	//var property unaDireccion = 1.randomUpTo(4).truncate(0)
	
	constructor(_position){
		position = _position
	}
	
	method image() = if(estaVivo) "Rival.png" else "RivalMuerto.png"
	
	method puedePisarte(_) = true
	
	method explotar(){
		estaVivo = false game.removeVisual(self)
	}
	
	method moverse(){
		if(estaVivo){
			self.moverseSiEstaLibre()
		}
	}
	
	method esDireccionPosible(dir) = game.getObjectsIn(dir.siguiente(position)).all{ obj => obj.puedePisarte(self) }

	method moverseSiEstaLibre(){
		const direccionesPosibles = [arriba,abajo,derecha,izquierda].filter { dir => self.esDireccionPosible(dir) }
		
		if (not direccionesPosibles.isEmpty()) {
			const unaDireccion = direccionesPosibles.anyOne()
			position = unaDireccion.siguiente(position)
		}
	}
	
	
	/*method acercarseA(personaje) {
		if(estaVivo) {
			var otraPosicion = personaje.position()
			
			var newX = position.x() + if (otraPosicion.x() > position.x()) 1 else -1
		 	var newY = position.y() + if (otraPosicion.y() > position.y()) 1 else -1
			//newX = newX.max(0).min(game.width() - 2)
			//newY = newY.max(0).min(game.height() - 2) 
			position = game.at(newX, position.y())
			position = game.at(newX,newY) }
	}*/
	
	method tocar(){ }
}

