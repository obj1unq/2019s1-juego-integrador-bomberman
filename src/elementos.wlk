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
	
	method tocar(){ }
	
	method puedeExplotar()= true
	
}

class Explosion{ 
	
	var hayFlama = false
	
	method existe() { hayFlama = not hayFlama }

	method image()= "ExplosionCentro.png"
	
	method puedePisarte(_) = true
	
    method explotar()={ }

	method crearExplosion(position){
		game.addVisualIn(self, position)
		self.existe()
		game.whenCollideDo(self, { alguien => alguien.explotar() })
		
		const exploN = new ExplosionNorte()
		if(exploN.hayLugar(position.up(1))){
	    exploN.existe()
		game.addVisualIn(exploN, position.up(1))
		game.whenCollideDo(exploN, { alguien => alguien.explotar() })	
		}
		
		const exploS = new ExplosionSur()
		if(exploS.hayLugar(position.down(1))){
	    exploS.existe()
		game.addVisualIn(exploS, position.down(1))
		game.whenCollideDo(exploS, { alguien => alguien.explotar() })
		}
		
		const exploE = new ExplosionEste()
		if(exploE.hayLugar(position.right(1))){
		exploE.existe()
		game.addVisualIn(exploE, position.right(1))
		game.whenCollideDo(exploE, { alguien => alguien.explotar() })
		}
		
		const exploO = new ExplosionOeste()
		if(exploO.hayLugar(position.left(1))){
		exploO.existe()
		game.addVisualIn(exploO, position.left(1))
		game.whenCollideDo(exploO, { alguien => alguien.explotar() })
		}
		
		game.onTick(500, "sacarExplosion", {	
		self.finExplosion()
		exploN.finExplosion()
		exploS.finExplosion()
		exploE.finExplosion()
		exploO.finExplosion()
			game.removeTickEvent("sacarExplosion")
		})
	}
	
	method hayLugar(direccion) {
		return  game.getObjectsIn(direccion).all{ obj => obj.puedeExplotar() }
	}
	
	method puedeExplotar()= true
		
	method finExplosion(){
		if(hayFlama){game.removeVisual(self)}
	}
	
	method remover(visual){
		game.removeVisual(visual)
	}	
	method tocar(){
		
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

