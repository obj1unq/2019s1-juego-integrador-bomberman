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
	method explotar(){ }
	
	method dibujarLineaDeMuros(lista,num2){
		lista.forEach({ num => if(num%2==0) game.addVisual(new Muro(new Position(num,num2))) })
	}
}

class Pared inherits Muro {
	override method image() = "Muro2.png"
	override method explotar(){ game.removeVisual(self) }
}
