# aplicación shiny demo Semillero La Salle
library(shiny)

# las funciones de la aplicación shiny
# la primera función que se define es la interfaz de usuario
# que tiene varios componentes que vamos a enumerar
# 1) fluidPage es la función general donde están contenidos todos los 
# componentes de la interfaz de usuario (UI)

userinterface <- fluidPage(
  #1.1) título de la aplicación con la función titlePanel
  titlePanel("Semillero La Salle"),
  #1.2) sidebarLayout con dos paneles
  sidebarLayout(
    #1.3) sidebarPanel, que es la barra lateral que se observa en la aplicación
    # con varios componentes
    sidebarPanel(
      #1.2.1) textInput para ingresar un nombre
      sliderInput(inputId = "valor_in_numerico",  # el identificador del componente que permite al servidor identificarlo
                  label= "Número de observaciones", # la etiqueta que se muestra en la interfaz
                  value = 100, # el valor inicial del componente
                  min = 1, # el valor mínimo que se puede ingresar
                  max = 1000), # el valor máximo que se puede ingresar
      
      wellPanel(
        #1.2.2) dateInput para ingresar una fecha
        dateInput(inputId= "valor_in_fecha", # el identificador del componente que permite al servidor identificarlo
                  label= "indicar fecha", # la etiqueta que se muestra en la interfaz
                  value = "2013-01-01"), # la fecha que aparece por defecrto en el componente
        #1.2.3) submitButton para guardar la información
        submitButton(text = "Guardar Información",
                     icon = icon("list-alt"))
      )
    ),
    #1.4) mainPanel, que es el panel principal ubicado al centro donde se muestran los resultados
    mainPanel(
      verbatimTextOutput("valor_out_fecha"), # muestra el valor de la fecha ingresada, que es remitido por el servidor
      textOutput("valor_out_numerico") # muestra el valor numérico ingresado, que es remitido por el servidor
    )
  )
)

# la segunda función que se define es el servidor
# que tiene varios componentes que vamos a enumerar
servidor <- function(input, output) {
    #2.1) renderPrint para mostrar el valor de la fecha ingresada que podemos modificar,
  # por ejemplo, sumándo 5 días
    output$valor_out_fecha <- renderPrint({ #output$valor_out_fecha es el identificador que se usa en la UI para mostrar el resultado
      input$valor_in_fecha + 5 #input$valor_in_fecha es la fecha ingresada en la UI que ahora le sumanos 5 días
      })
    
    #2.2) renderText para mostrar el valor numérico ingresado
    output$valor_out_numerico <- renderText({ #output$valor_out_numerico es el identificador que se usa en la UI para mostrar el resultado
      input$valor_in_numerico -10 #input$valor_in_numerico es el valor numérico ingresado en la UI que ahora le restamos 10
      })
}

# la función shinyApp es la que ejecuta la aplicación shiny
shinyApp(ui = userinterface,
         server = servidor)