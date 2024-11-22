class Persona{
    var edad
    var emociones = []
    
    method esAdolescente() {
        return edad >= 12 && edad <= 19 
}
    method agregarEmocion(emocion) {
        emociones.add(emocion)
    }
    method estaPorExplotar() {
        return emociones.all { emocion => emocion.puedeLiberarse() }
    }

    method vivirEvento(evento) {
        emociones.forEach { emocion =>
            emocion.incrementarEventos()
            emocion.liberarse(evento)
        }
    }
    
    method modificarIntensidadElevada(nuevaIntensidad) {
        Emocion.cambiarIntensidadElevada(nuevaIntensidad)
    }
    
    method vivirEventoEnGrupo(grupo, evento) {
        grupo.forEach { persona => persona.vivirEvento(evento) }
    }
}

 class Emocion {
    var property intensidad
    var  property intensidadElevada = 50
    var eventosVividos = 0
    
    method incrementarEventos() {
        eventosVividos += 1
    }
    method puedeLiberarse() {
        return intensidad >= intensidadElevada
    }
     method cambiarIntensidadElevada(nuevaIntensidad) {
        intensidadElevada = nuevaIntensidad
    }
}

class Evento {
    var property impacto
    var property descripcion
}   

class Furia inherits Emocion(intensidad=100) {
    var palabrotas = []
    override method puedeLiberarse() =liberacionAux.puedeLiberarse(self,palabrotas.any{ palabra => palabra.size() > 7 })
    method liberarse(evento) {
        if(self.puedeLiberarse()){
        intensidad -= evento.impacto()
        palabrotas.remove(palabrotas.head())
    }
}}

class Alegria inherits Emocion {
    
override method puedeLiberarse() =liberacionAux.puedeLiberarse(self,eventosVividos.even())
    method liberarse(evento) {
        if(self.puedeLiberarse()){
        intensidad = (intensidad - evento.impacto()).abs()
    }
}
}
class Tristeza inherits Emocion {
    var causa = "melancolia"
    override method puedeLiberarse() =liberacionAux.puedeLiberarse(self,causa != "melancolia")

    method liberarse(evento) {
        causa = evento.descripcion()
        intensidad -= evento.impacto()
    }
}

class DesagradoYTemor inherits Emocion {
    override method puedeLiberarse() =liberacionAux.puedeLiberarse(self,eventosVividos > intensidad)

    method liberarse(evento) {
        intensidad -= evento.impacto()
    }
}

class Ansiedad inherits Emocion {
    var nivelDeEstres
override method puedeLiberarse()=liberacionAux.puedeLiberarse(self,nivelDeEstres>5)

    method liberarse(evento) {
        if(self.puedeLiberarse()){
        intensidad -= evento.impacto()
        nivelDeEstres = 0
    }}

    method incrementarPreocupacion() {
        nivelDeEstres+=1
    }
}

//implementado para no repetir return super() && condicionDeEmocion
object liberacionAux {
    method puedeLiberarse(emocion, condicionAdicional) {
        return emocion.intensidad() >= emocion.intensidadElevada() && condicionAdicional
    }
}
    
/*
Herencia: Permite que una clase (subclase) herede propiedades y métodos de otra clase (superclase). 
En este caso, todas las emociones heredan de la clase Emocion, lo que permite compartir y reutilizar el comportamiento común, como la gestión de la intensidad y los eventos vividos.

Polimorfismo: Permite que objetos de diferentes clases sean tratados como objetos de una clase común. En este caso, cada emoción tiene su propia implementación del método liberarse, pero todas pueden ser manejadas de la misma manera a través de la clase Emocion.

Estos dos conceptos nos sirven para mantener el código organizado, reducir la duplicación y facilitar la extensión del sistema con nuevas emociones,
 como la Ansiedad, que tiene un comportamiento específico diferente al de las otras emociones.



*/
