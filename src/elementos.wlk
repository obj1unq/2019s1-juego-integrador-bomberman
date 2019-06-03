import wollok.game.*

object bomba {
	method image() = "manzana.png"
}

object muro {
	var property position = game.at(5,5)
	
	method image() = "muro.png"
}

object paredIrrompible {
	method image() = "alpiste.png"
}

