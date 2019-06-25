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
		if (not bomberman.poseePoder()) { explo.crearExplosion(position) } else { explo.crearExplosion2(position) }
	}	
	
	method puedePisarte(_) = false
	
	method tocar(){ }
	
	method puedeExplotar()= true
	
	method esMatable()= false 
	
	method tieneLlave(){}
	
	method ganaste(){}
	
	method tienePoder(){}
	
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
	method tocar(){}
	
	method tienePoder(){}
	
	method esMatable()= true //No pero los enemigos tienen que pisar el fuego
	
	method tieneLlave(){}
	
	method ganaste(){}
	
	method crearExplosion2(position){
		game.addVisualIn(self, position)
		self.existe()
		game.whenCollideDo(self, { alguien => alguien.explotar() })
		
		
		//Expansion
		const exploNS1 = new ExplosionNorteSur()
		if(exploNS1.hayLugar(position.up(1))){
	    exploNS1.existe()
		game.addVisualIn(exploNS1, position.up(1))
		game.whenCollideDo(exploNS1, { alguien => alguien.explotar() })	
		}
		const exploN = new ExplosionNorte()
		if(exploN.hayLugar(position.up(1)) && exploN.hayLugar(position.up(2))){
	    exploN.existe()
		game.addVisualIn(exploN, position.up(2))
		game.whenCollideDo(exploN, { alguien => alguien.explotar() })	
		}
		
		const exploS = new ExplosionSur()
		if(exploS.hayLugar(position.down(1)) && exploS.hayLugar(position.down(2))){
	    exploS.existe()
		game.addVisualIn(exploS, position.down(2))
		game.whenCollideDo(exploS, { alguien => alguien.explotar() })
		}
		//Expansion
		const exploNS2 = new ExplosionNorteSur()
		if(exploNS2.hayLugar(position.down(1))){
	    exploNS2.existe()
		game.addVisualIn(exploNS2, position.down(1))
		game.whenCollideDo(exploNS2, { alguien => alguien.explotar() })	
		}
		
		const exploE = new ExplosionEste()
		if(exploE.hayLugar(position.right(1)) && exploE.hayLugar(position.right(2))){
		exploE.existe()
		game.addVisualIn(exploE, position.right(2))
		game.whenCollideDo(exploE, { alguien => alguien.explotar() })
		}
		//Expansion
		const exploEO1 = new ExplosionEsteOeste()
		if(exploEO1.hayLugar(position.right(1))){
	    exploEO1.existe()
		game.addVisualIn(exploEO1, position.right(1))
		game.whenCollideDo(exploEO1, { alguien => alguien.explotar() })	
		}
		
		
		const exploO = new ExplosionOeste()
		if(exploO.hayLugar(position.left(1)) && exploO.hayLugar(position.left(2))){
		exploO.existe()
		game.addVisualIn(exploO, position.left(2))
		game.whenCollideDo(exploO, { alguien => alguien.explotar() })
		}
		//Expansion
		const exploEO2 = new ExplosionEsteOeste()
		if(exploEO2.hayLugar(position.left(1))){
	    exploEO2.existe()
		game.addVisualIn(exploEO2, position.left(1))
		game.whenCollideDo(exploEO2, { alguien => alguien.explotar() })	
		}
		
		game.onTick(500, "sacarExplosion", {	
		self.finExplosion()
		exploN.finExplosion()
		exploS.finExplosion()
		exploE.finExplosion()
		exploO.finExplosion()
		
		exploNS1.finExplosion()
		exploNS2.finExplosion()
		exploEO1.finExplosion()
		exploEO2.finExplosion()
			game.removeTickEvent("sacarExplosion")
		})
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

class ExplosionNorteSur inherits Explosion {
	override method image() = "CuerpoExplosionNorteSur.png"
}
class ExplosionEsteOeste inherits Explosion {
	override method image() = "CuerpoExplosionOesteEste.png"
}

object door{
	method image()= "Door.png"
	
	method position()= game.at(1,11)
	
	method tocar(){}
		
    method esMatable()= true
    
    method explotar(){ }
    
    method puedePisarte(_) = true
    
    method puedeExplotar()= true
    
    method tieneLlave(){}
    
    method tienePoder(){}
    
    method ganaste(){ if(bomberman.poseeLlave()){
    	game.addVisualIn(cartelVictory, game.at(game.width()/2, game.height()/2))
    	game.removeVisual(bomberman)
    }}
	
}

object key{
	method image()= "Llave.png"
	
	method position()= game.at(16,11)
	
	method tocar(){}
		
    method esMatable()= true
    
    method explotar(){ }
    
    method puedePisarte(_) = true
    
    method puedeExplotar()= true
    
    method tieneLlave(){
       bomberman.tieneLlave()
    }
    
    method ganaste(){}
    
    method tienePoder(){}
}

object powerUp{
	method image()= "PowerUp.png"
	
	method position()= game.at(7,7)
	
	method tocar(){}
		
    method esMatable()= true
    
    method explotar(){ }
    
    method puedePisarte(_) = true
    
    method puedeExplotar()= true
    
    method tienePoder(){
       bomberman.tienePoder()
    }
    
    method ganaste(){}
}
 
object cartelVictory{
 
    var property position
    
    method posicion(_position){
		position = _position
	}
	method image()= "YouWin.png"
		
	method tocar(){}
		
    method esMatable()= true
    
    method explotar(){ }
    
    method puedePisarte(_) = true
    
    method puedeExplotar()= true
    
    method tieneLlave(){
    }
    
    method ganaste(){}
    
    method tienePoder(){}
}   

object cartelGameOver{
 
    var property position
    
    method posicion(_position){
		position = _position
	}
	method image()= "GameOver.png"
		
	method tocar(){}
		
    method esMatable()= true
    
    method explotar(){ }
    
    method puedePisarte(_) = true
    
    method puedeExplotar()= true
    
    method tieneLlave(){
    }
    
    method ganaste(){}
    
    method tienePoder(){}
}   

object caratula{
	method image() = "Caratula.png"
	method position() = game.origin()
}