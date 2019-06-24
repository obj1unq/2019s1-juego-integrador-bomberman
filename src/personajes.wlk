import wollok.game.*
import elementos.*
import direcciones.*

object bomberman {
	var property position = game.at(1,1)
	var property direccion = abajo //Posible valor para mover a bomberman
	
	var property estaVivo = true //Con esto se frena movimiento y dejar bombas.
	
	var poseeLlave = false
	
	var poseePoder = false
	
	method poseePoder() = return poseePoder
	
	method poseeLlave()= return poseeLlave
    
    method image() = if(estaVivo){ "Bomberman.png"  }
    				else { "BombermanRIP.png" } //Asi por ahora.

	method mover(unaDireccion) {
		if(estaVivo){const posAlLado = unaDireccion.siguiente(position) 
		var lugarLibre = game.getObjectsIn(posAlLado).all{ obj => obj.puedePisarte(self) } 
		
		if (lugarLibre){
		position = unaDireccion.siguiente(position)}
		}
	}
	
	method puedePisarte(_) = false
	
	method dejarBomba(bomb){
		if(estaVivo){
			var bombPosition = position
        	game.addVisualIn(bomb, bombPosition)
        	game.onTick(2000, "explotarBomba", { 
        	bomb.explotar(bombPosition) //Con este agregamos la explosión.
        	game.removeTickEvent("explotarBomba") })
        }
    }
    

    method irArriba() { direccion = arriba self.avanzar() }

	method irAbajo() { direccion = abajo self.avanzar() }

	method irIzquierda() { direccion = izquierda self.avanzar() }

	method irDerecha() { direccion = derecha self.avanzar() }
	
	method avanzar() { position = direccion.siguiente(position) }
	
	method explotar(){
		estaVivo = false
		game.addVisualIn(cartelGameOver, game.at(1, game.height()/2))
	}
	
	method tocar(){ self.explotar() }
	
	method puedeExplotar()= true
	
	method esMatable()= true
	
	method tieneLlave(){
	   poseeLlave = true
	   game.removeVisual(key)
	}
	
	method tienePoder(){
	   poseePoder = true
	   game.removeVisual(powerUp)
	}
	
	method ganaste(){}
	
	method revivir(){
		estaVivo = true
		poseePoder = false
		position = game.at(1,1)		
	}
}



 