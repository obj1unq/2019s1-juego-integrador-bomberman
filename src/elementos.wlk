import wollok.game.*

class Bomba {
	method image() = "Bomb.png"
	method explotar(){     //Ver cómo agregar la explosión.  new Explosion
		game.removeVisual(self)
	}
}

class Muro {
	var property position
	
	method image() = "muro.png"
}

object paredIrrompible {
	method image() = "alpiste.png"
}


//Explosion mirar bien.
class Explosion{ 
	//Agregar alcance de bomba que sera heredado.
	//Agregar posición acá o en game.
	method image()= "ExplosionCentro.png"
}

object explosionNorte inherits Explosion {
	//Posicion +1Norte +Alcance que dejaría cuerpo.
	override method image()= "ExplosionNorte.png"
}

object explosionEste inherits Explosion {
	override method image()= "ExplosionEste.png"
}

object explosionSur inherits Explosion {
	override method image()= "ExplosionSur.png"
}

object explosionOeste inherits Explosion {
	override method image()= "ExplosionOeste.png"
}

//TEMPORAL
object cuerpoNS inherits Explosion {
	override method image()= "CuerpoExplosionNorteSur.png"
}
object cuerpoOE inherits Explosion {
	override method image()= "CuerpoExplosionOesteEste.png"
}

