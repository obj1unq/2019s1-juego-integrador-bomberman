import wollok.game.*
import elementos.*
import direcciones.*

object bomberman {
	var property position = game.at(1,1)
	var property direccion
	
	method image() = "Bomberman.png"
	
	method mover(unaDireccion) {
		const posAlLado = unaDireccion.siguiente(position) 
		var lugarLibre = game.getObjectsIn(posAlLado)
			.all{ obj => obj.puedePisarte(self) } 
		
		if (lugarLibre){
		position = unaDireccion.siguiente(position)}
	}
	
	method puedePisarte(_) = false
	
	method dejarBomba(bomb){
		var bombPosition = position
        game.addVisualIn(bomb, bombPosition)
        game.onTick(2000, "explotarBomba", { 
        bomb.explotar(bombPosition) //Con este agregamos la explosión.
        game.removeTickEvent("explotarBomba")
        })
    }
    
    method irArriba() { direccion = arriba self.avanzar()}

	method irAbajo() { direccion = abajo self.avanzar() }

	method irIzquierda() { direccion = izquierda self.avanzar() }

	method irDerecha() { direccion = derecha self.avanzar() }
	
	method avanzar() { position = direccion.siguiente(position) }
	
	method explotar(){ }
}

 