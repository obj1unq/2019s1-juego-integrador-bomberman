class Pared {
	var property position
	
	constructor(_position){
		position = _position
	}
	
	method mover(direccion) {
		throw new Exception("No se puede pasar.")
	}
	
	method puedePisarte(_) = false
	method image() = "alpiste.png"
}