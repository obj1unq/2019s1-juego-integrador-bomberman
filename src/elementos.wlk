import wollok.game.*
import personajes.*
import direcciones.*

class Bomba {
	method image() = "Bomb.png"
	
	method explotar(){ }
	
	method explotar(position){
		game.removeVisual(self)
		self.detonar(position)
	}

	method detonar(position){
		const explo = new Explosion()
		
		explo.crearExplosion(position)
	}	
	
	method puedePisarte(_) = false
	
}

class Explosion{ 

	method image()= "ExplosionCentro.png"
	
	method puedePisarte(_) = true
	
    method explotar()={ }

	method crearExplosion(position){
		game.addVisualIn(self, position)
		const exploN = new ExplosionNorte()
		game.addVisualIn(exploN, position.up(1))
		const exploS = new ExplosionSur()
		game.addVisualIn(exploS, position.down(1))
		const exploE = new ExplosionEste()
		game.addVisualIn(exploE, position.right(1))
		const exploO = new ExplosionOeste()
		game.addVisualIn(exploO, position.left(1))
		
		game.whenCollideDo(self, { alguien => alguien.explotar() })
		game.whenCollideDo(exploN, { alguien => alguien.explotar() })
		game.whenCollideDo(exploS, { alguien => alguien.explotar() })
		game.whenCollideDo(exploE, { alguien => alguien.explotar() })
		game.whenCollideDo(exploO, { alguien => alguien.explotar() })
		
		game.onTick(5000, "sacarExplosion", {
			
		self.finExplosion()
		exploN.finExplosion()
		exploS.finExplosion()
		exploE.finExplosion()
		exploO.finExplosion()
			game.removeTickEvent("sacarExplosion")
		})
	}
		
	method finExplosion(){
		game.removeVisual(self)
	}
	
	method remover(visual){
		game.removeVisual(visual)
	}	
}

class ExplosionNorte inherits Explosion {
	override method image() = "ExplosionNorte.png"
}

class ExplosionEste inherits Explosion {
	override method image() = "ExplosionEste.png"
}

class ExplosionSur inherits Explosion {
	override method image() = "ExplosionSur.png"
}

class ExplosionOeste inherits Explosion {
	override method image() = "ExplosionOeste.png"
}

class CuerpoNS inherits Explosion {
	override method image() = "CuerpoExplosionNorteSur.png"
}
class CuerpoOE inherits Explosion {
	override method image() = "CuerpoExplosionOesteEste.png"
}

