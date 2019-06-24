import wollok.game.*
import personajes.*
import rivales.*
import pared.*
import elementos.*
import direcciones.*

object plataforma1 {
	
	method cargar(){
	//	PAREDES
		const ancho = game.width() - 1
		const largo = game.height() - 1
	
		var posMuros = []
		(0 .. ancho).forEach{ n => posMuros.add(new Position(n, 0)) } // bordeAbajo
		(0 .. ancho).forEach{ n => posMuros.add(new Position(n, largo)) } // bordeArriba 
		(0 .. largo).forEach{ n => posMuros.add(new Position(0, n)) } // bordeIzq 
		(0 .. largo).forEach{ n => posMuros.add(new Position(ancho, n)) } // bordeDer
	
		game.addVisual(door)
		game.addVisual(bomberman)
		game.addVisual(key)
		game.addVisual(powerUp)
	
		game.whenCollideDo(bomberman, { llave => llave.tieneLlave()})
		game.whenCollideDo(bomberman, { poder => poder.tienePoder() })
	
	
		const paredes = [new Pared(new Position(3,3)),new Pared(new Position(3,5)),new Pared(new Position(3,7)),
						 new Pared(new Position(5,5)),new Pared(new Position(5,7)),new Pared(new Position(5,9)),
						 new Pared(new Position(7,7)),new Pared(new Position(7,9)),new Pared(new Position(7,11)),
						 new Pared(new Position(9,7)),new Pared(new Position(9,5)),new Pared(new Position(9,3)),
						 new Pared(new Position(11,3)),new Pared(new Position(11,9)),new Pared(new Position(11,11)),
						 new Pared(new Position(1,6)),new Pared(new Position(1,11)),new Pared(new Position(1,4)),
						 new Pared(new Position(5,2)),new Pared(new Position(9,2)),new Pared(new Position(11,1)),
						 new Pared(new Position(8,3)),new Pared(new Position(8,9)),new Pared(new Position(8,5)),
						 new Pared(new Position(10,2)),new Pared(new Position(10,7)),new Pared(new Position(10,9)),
						 new Pared(new Position(15,1)),new Pared(new Position(14,6)),new Pared(new Position(13,8)),
						 new Pared(new Position(17,2)),new Pared(new Position(17,7)),new Pared(new Position(16,9)),
						 new Pared(new Position(15,7)),new Pared(new Position(16,11)),new Pared(new Position(17,8))]
 
		paredes.forEach({pared => game.addVisual(pared)})
	
		posMuros.forEach { unMuro => game.addVisual(new Muro(unMuro)) }
	
		(0 .. largo).forEach({ num => if(num%2==0) new Muro(new Position(0,0)).dibujarLineaDeMuros((0..ancho),num) })
	
	
	// RIVALES
		const rivales = [new Rival(new Position(9,9)), new Rival(new Position(1,5)), 
		        	     new Rival(new Position(13,3)), new Rival(new Position(3,8)),
		     	         new Rival(new Position(13,9))]
	
		rivales.forEach { rival => game.addVisual(rival)
					    	game.whenCollideDo(rival, { personaje => personaje.tocar()})
					
							game.onTick(600,"AcercarseA",{rival.moverse()})
		}
	
  	 	const rivales2 = [/*new Rival2(game.at(8,8)), new Rival2(game.at(10,11)),
   		 	              new Rival2(game.at(1,14)),*/new Rival2(game.at(50,50)),
  		  	              new Rival2(game.at(0,90))]

		rivales2.forEach { rival => game.addVisual(rival)
					game.whenCollideDo(rival, { personaje => personaje.tocar()})

					game.onTick(1200,"AcercarseA",{rival.acercarseA(bomberman)})
		}
	// VICTORIA

 		game.whenCollideDo(bomberman, { door => door.ganaste()})


	//	TECLADO
		keyboard.up().onPressDo { bomberman.mover(arriba) }
		keyboard.down().onPressDo { bomberman.mover(abajo) }
		keyboard.right().onPressDo { bomberman.mover(derecha) }
		keyboard.left().onPressDo { bomberman.mover(izquierda) }

		keyboard.a().onPressDo { bomberman.dejarBomba(new Bomba()) }
	
		keyboard.r().onPressDo{ self.restart() 
								bomberman.revivir() }
	
	}
	
	method restart() {
		game.clear()
		self.cargar()
	}
	
}
