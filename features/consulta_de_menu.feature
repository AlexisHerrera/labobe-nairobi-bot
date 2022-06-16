#language: es

Característica: Consulta de menú
  Como sistema
  Quiero informar el menú a los usuarios
  Para que conozcan las opciones disponibles

Escenario: 01 - Consulta de menú
  Dado que el usuario quiere conocer los menues
  Cuando el usuario ingresa "/menu"
  Entonces recibe el mensaje "1-Menu individual ($1000), 2-Menu parejas ($1500), 3-Menu familiar ($2500)"
