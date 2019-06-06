import wollok.game.*
import elementos.*

object bomberman {
	var property position = game.at(7,7)
	
	method image() = "Bomberman.png"
	
	method move(nuevaPosicion){
		position = nuevaPosicion
	}
	
	method dejarBomba(bomb){
        game.addVisualIn(bomb, position)
        game.onTick(2000, "explotarBomba", { 
        bomb.explotar() //Con este agregamos la explosión.
        game.removeTickEvent("explotarBomba")
        })
    }
}

 