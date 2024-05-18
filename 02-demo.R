# Actividad de repaso propuesta
# 1) Identificar mediante comentarios los componentes de la interfaz de usuario 
# en la aplicación shiny demo Semillero La Salle.
# 2) Modificar el nombre de la aplicación
# 3) Ejecutar la aplicación

##NOTA: de la línea 10 a la 48 se están definiendo los datos con los que se va a trabajar en la aplicación
# pero no es código propiamente de la aplicación shiny

# Cargar librerias
library(shiny)

## definir datos
nombres <- c('Edgar Silva',
             'Cassiel Avendaño',
             '',
             'D',
             'Kevin77K',
             'Maurizio Trapani',
             'Rosy DAF',
             'Sebas',
             'Sofi',
             '',
             '',
             '',
             '',
             '',
             '')

telefonos <- c('+58 414-2235388',
               '+58 4242189967',
               '+58 412-6126358',
               '+58 414-2342759',
               '+58 412-3908838',
               '+58 414-3206540',
               '+58 412-7291261',
               '+58 424-1204404',
               '+58 412-2847886',
               '+58412-3219377',
               '+58 412-6042054',
               '+58 412-6153956',
               '+58 424-1905252',
               '+58 424-2992583',
               '+58 426-6171425')

datos_semillero <- data.frame(nombres, 
                              telefonos)

## Definir UI
ui <- fluidPage(
  titlePanel("Semillero de Investigación"), # modificar el título de la aplicación
  sidebarLayout(
    sidebarPanel(
      textInput(inputId="nombre_in",
                label= "Nombre nuevo"),
      textInput(inputId="telefono_in",
                "Teléfono nuevo"),
      actionButton(inputId="agregar", 
                   label="Agregar"),
      
      selectInput(inputId = "telefonos_grupo",
                  label= "Teléfono seleccionar", 
                  choices =datos_semillero$telefonos),
      
      textInput(inputId="nombre_faltante_in",
                label="Nombre Faltante"),
      
      actionButton(inputId="modificar", 
                   label="Modificar")
      
    ),
    mainPanel(
      tableOutput("tabla")
    )
  )
)

server <- function(input, output, session) {
  datos <- reactiveVal(datos_semillero)
  
  observeEvent(input$agregar, {
    datos(rbind (datos(), 
                    data.frame(nombres = input$nombre_in, 
                               telefonos = input$telefono_in)))
  })
  
  observeEvent(input$modificar, {
    fila_seleccionada <- input$telefonos_grupo
    nuevo_nombre <- input$nombre_faltante_in
    
    df_actualizado <- datos()
    
    df_actualizado[df_actualizado$telefonos == fila_seleccionada, "nombres"] <- nuevo_nombre
    datos(df_actualizado)
  })

  
  output$tabla <- renderTable({
    datos()
  })
  
}

shinyApp(ui = ui, 
         server = server)
