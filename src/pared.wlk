import wollok.game.*

class Muro {
	var property position
	
	constructor(_position){
		position = _position
	}
	
	method mover(direccion) {
		throw new Exception()
	}
	
	method puedePisarte(_) = false
	method image() = "muro.png"
	method explotar(){} //game.whenCollideDo(self, { explosion => explosion.finExplosion() })
	                     //^ Frena la explosion pero rompe todo.

	//method remover(fuego){
	//	game.removeVisual(fuego)
	//}
	
	method dibujarLineaDeMuros(lista,num2){
		lista.forEach({ num => if(num%2==0) game.addVisual(new Muro(new Position(num,num2))) })
		//game.whenCollideDo(explosion,{explosion=>self.remover(explosion)})
	}
	method tocar(){ }
	
	method puedeExplotar()= false
}

class Pared inherits Muro {
	override method image() = "Muro2.png"
	override method explotar(){ game.removeVisual(self) }
	override method puedeExplotar()= true
}
