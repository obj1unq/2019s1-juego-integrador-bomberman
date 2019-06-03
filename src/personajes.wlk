import wollok.game.*
import elementos.*

object bomberman {
	var property position = game.at(0,0)
	
	method image() = "jugador.png"
	
	method move(nuevaPosicion){
		position = nuevaPosicion
	}
	
	method dejarBomba(){
		game.addVisualIn(bomba,self.position())
	}
}

