/** First Wollok example */
object wollok {
	method howAreYou() {
		return 'I am Wolloktastic!'
	}
}


class Espacio{
	var property km = 0
	var integrantes = []
	
	method cuantosIntegrantes()= integrantes.size()
	method mudarse(donde){
		self.km(donde)
	}
	method urgencia(donde){
		self.mudarse(donde)
	}
}
class PuestoComida inherits Espacio{
	var property dinero
	var catalogo
	
	method sacarDeCatalogo(comida){
		catalogo.remove(comida)
	}
	method cobrarDinero(numero){
		dinero+= numero
	}
	method quedarseSeco(){dinero = 0}
	method vender(comida,cantidad){
		if(catalogo.contains(comida)){
			comida.vender(cantidad, self)
		}
	}
	override method urgencia(donde){
		super(donde)
		self.vender(catalogo.min({comida => comida.valor()}), 20)
	}
}
class EstacionPolicia inherits Espacio{
	method echarATodos(){
		integrantes.clear()
	}
	override method urgencia(donde){
		super(donde)
		self.echarATodos()
	}
}

class Comida{
	var property valor
	
	method vender(cantidad, puesto){
		puesto.cobrarDinero(cantidad*valor)
	}
}
object tortasFritas inherits Comida(valor = 12){
	override method vender(cantidad, puesto){
		super(cantidad, puesto)
		if(cantidad == 1){
			puesto.sacarDeCatalogo(self)
		}
	}
}
object bogaALaPizza inherits Comida (valor = 150){
	override method vender(cantidad, puesto){
		puesto.quedarseSeco()
	}
}
object dorado inherits Comida (valor = 10){
	override method vender(cantidad, puesto){
		super(cantidad, puesto)
		puesto.mudarse(125)
	}
}




object ruta{
	var property todosLosEspacios=[]
	
	method delegado() = todosLosEspacios.max({unEspacio => unEspacio.cuantosIntegrantes()})
	
	
	method urgenciaTotal(donde){
		todosLosEspacios.forEach({unEspacio => 
			unEspacio.urgencia(donde)
		})
	}
	
	//antes lo había hecho con fold
	//var property delegado=todosLosEspacios.fold(todosLosEspacios.first(), {answer, each => if (each.cuantosIntegrantes()> answer.cuantosIntegrantes()){each}else answer})
}
