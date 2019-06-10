import wollok.game.*
import personajes.*
import direcciones.*

class Bomba {
	method image() = "Bomb.png"
	
	method explotar(position){
		game.removeVisual(self)
		self.detonar(position)
	}

	method detonar(position){
		const explo = new Explosion()
		game.addVisualIn(explo, position)
		game.addVisualIn(explosionNorte, position.up(1))
		game.addVisualIn(explosionSur, position.down(1))
		game.addVisualIn(explosionEste, position.right(1))
		game.addVisualIn(explosionOeste, position.left(1))
		game.onTick(1500, "sacarExplosion", {
		
		explo.finExplosion()
		explosionNorte.finExplosion()
		explosionSur.finExplosion()
		explosionEste.finExplosion()
		explosionOeste.finExplosion()
		game.removeTickEvent("sacarExplosion")
		})
	}
	
	method removerExplosion(){ 
		game.removeVisual(new Explosion())
		game.removeVisual(explosionNorte)
		game.removeVisual(explosionSur)
		game.removeVisual(explosionEste)
		game.removeVisual(explosionOeste)
	}
	
	method puedePisarte(_) = false
	
}
//Explosion mirar bien.
class Explosion{ 
	//Agregar alcance de bomba que sera heredado.
	//Agregar posición acá o en game.
	method image()= "ExplosionCentro.png"
	
	method puedePisarte(_) = false
	
	method finExplosion(){
		game.removeVisual(self)
	}
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

