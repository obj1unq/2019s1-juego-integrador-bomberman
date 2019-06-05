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
       game.onTick(2000,"SacarBomba",{ game.removeVisual(bomb) }) /* Es repetitivo, saca la bomba, pero
       															     despues sigue buscando sacar mas bombas */
       /* game.removeTickEvent("SacarBomba")  Esta linea elimina el onTick,
       										  pero me anula la accion anterior*/
    }
}

