class APIBobe
  def initialize
    @header = {
      'Content-Type' => 'application/json'
    }
  end

  def registro_usuario(nombre, telefono, direccion)
    url = obtener_url('/usuarios')
    parametros = { 'nombre' => nombre, 'telefono' => telefono, 'direccion' => direccion }.to_json
    respuesta = Faraday.post(url, parametros, @header)
    respuesta
  end

  private

  def obtener_url(directorio)
    (ENV['API_URL']).to_s + directorio
  end
end
