import wollok.game.*
import elementos.*

object bomberman {
	var property position = game.at(0,0)
	
	method image() = "Bomberman.png"
	
	method move(nuevaPosicion){
		position = nuevaPosicion
	}
	
	method dejarBomba(bomb){
       game.addVisualIn(bomb, position)
	}
}

