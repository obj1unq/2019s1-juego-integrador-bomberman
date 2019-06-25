
class Direccion {
	method siguiente(position)
	method puntoCardinal(){ return 0 }
}

object izquierda inherits Direccion { 
	override method siguiente(position) = position.left(1) 
	method opuesto() = derecha
	override method puntoCardinal(){
		return "izquierda"
	}
}

object derecha inherits Direccion { 
	override method siguiente(position) = position.right(1) 
	method opuesto() = izquierda
	override method puntoCardinal(){
		return "derecha"
	}
}

object abajo inherits Direccion { 
	override method siguiente(position) = position.down(1) 
	method opuesto() = arriba
	override method puntoCardinal(){
		return "abajo"
	}
}

object arriba inherits Direccion { 
	override method siguiente(position) = position.up(1) 
	method opuesto() = abajo
	override method puntoCardinal(){
		return "arriba"
	}
}
