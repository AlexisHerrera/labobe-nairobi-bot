class APIBobe
  def initialize
    @header = {
      'Content-Type' => 'application/json'
    }
  end

  def registro_usuario(nombre, numero, direccion)
    url = obtener_url('/usuarios')
    parametros = { 'nombre' => nombre, 'numero' => numero, 'direccion' => direccion }.to_json
    respuesta = Faraday.post(url, parametros, @header)
    respuesta
  end

  private

  def obtener_url(directorio)
    # TODO: La base de la url debe ser una variable de entorno
    'https://labobe-nairobi-test.herokuapp.com' + directorio
  end
end
