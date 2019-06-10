class NaveEspacial {
	var property velocidad = 0
	var property direccion = 0	
	var property combustible = 0
	
	method estaTranquila(){	}
	
	method recibirAmenaza(){
		self.escapar()
		
		self.avisar()
	}
	
	method escapar()
	method avisar()
	
	method cargarCombustible(cuanto){
		combustible += cuanto
	}
	
	method descargarCombustible(cuanto){combustible -= cuanto}
	
	method prepararViaje(){
		self.cargarCombustible(30000)
		self.acelerar(15000)
	}
	
	method velocidad(cuanto) { velocidad = cuanto }
	method acelerar(cuanto) { velocidad = (velocidad + cuanto).min(100000) }
	method desacelerar(cuanto) { velocidad = (velocidad - cuanto).max(0) }
	
	method irHaciaElSol() { direccion = 10 }
	method escaparDelSol() { direccion = -10 }
	method ponerseParaleloAlSol() { direccion = 0 }
	
	method acercarseUnPocoAlSol() { direccion = (direccion + 1).min(10) }
	method alejarseUnPocoDelSol() { direccion = (direccion - 1).max(-10) }
}


		
 



class NavesBaliza inherits NaveEspacial {
	var property color = "verde"
	var property amenaza = false
	
	
	//method estaTranquila(){return combustible > 4000 and }
	override method estaTranquila() { return super() and color != "Rojo" }
	
	override method escapar(){self.irHaciaElSol()}
	override method avisar(){self.cambiarColorDeBaliza("rojo")}
	
	override method prepararViaje(){
		super()
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()    //super solamente se usa cuando piso la super clase
		
	}
	
	method cambiarColorDeBaliza(colorNuevo){
		color = colorNuevo
	} 
}





class NavesDePasajeros inherits NaveEspacial{
	var property pasajeros = 0
	var property racionesComida = 0
	var property racionesBebida= 0
	
	
	override method estaTranquila(){ }
	override method escapar(){self.irHaciaElSol()}
	override method avisar() {
		racionesBebida -= 2 * pasajeros
		racionesComida -= pasajeros
	}
	
	override method prepararViaje(){
		super()
		self.cargarComida(4)
		self.cargarBebida(6)
		
	}

	
	method cargarComida(cantidad)	{ racionesComida += cantidad }
	method descargarComida(cantidad){ racionesComida = (racionesComida - cantidad).max(0)}
	method cargarBebida(cantidad)	{ racionesBebida = (racionesBebida + cantidad) }
	method descargarBebida(cantidad){ racionesBebida = (racionesBebida - cantidad).max(0)}
}




class NavesDeCombate inherits NaveEspacial{
	var  invisible 	= false
	var  misilesDesplegados	= false
	var property mensajesEmitidos 	= []
	
	override method estaTranquila(){super() and  }
	override method escapar(){2.times {i => self.acercarseUnPocoAlSol()} }
	override method avisar(){self.emitirMensaje("amenza recibida")}
	
	
	override method prepararViaje(){
		super()
		self.ponerseVisible() 
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("saliendo en mision")
		
	}
	
	method ponerseVisible() 	{ invisible = false  }
	method ponerseInvisible() 	{ invisible = true}
	method estaInvisible() 		{return  invisible}
	
	method  desplegarMisiles()	{ misilesDesplegados = true }
	method  replegarMisiles() 	{ misilesDesplegados = false }
	method  misilesDesplegados() = misilesDesplegados ==  "Desplegados"
	
	method emitirMensaje(mensaje)	{ mensajesEmitidos.add(mensaje)}
	method mensajesEmitidos() 		{ return mensajesEmitidos.size()} 
	method primerMensajeEmitido() 	{ return mensajesEmitidos.first()}
	method ultimoMensajeEmitido()	{ return mensajesEmitidos.last()}
	method esEscueta() 				{ return mensajesEmitidos.all{m => m.size() <= 30 }}
	method emitioMensaje(mensaje)   {// return    mensajesEmitidos.any{m = > m == mensaje}   
		return  mensajesEmitidos.contains(mensaje)
		//return not mensajesEmitidos.any{m => m.size > 30 }
	}
	
	
}



class NaveHospital inherits NavesDePasajeros{
	var property quirofanosPreparados = false
	
	method tieneQuirofanos(){}
	
	override method recibirAmenaza(){
		super()
		quirofanosPreparados = true
	}
	override method estaTranquila(){return super() and not quirofanosPreparados }
		}	

 
 
class NaveCombateSigilosa inherits NavesDeCombate {
		override method escapar() {
			super()
			misilesDesplegados = true
			self.ponerseInvisible()
		}
		override method estaTranquila(){return super() and not invisible }
		
}