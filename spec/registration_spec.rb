require 'spec_helper'

def start_bot(token)
  app = BotClient.new(token)
  app.run_once
end

describe 'Registro' do
  token = 'fake_token'

  it 'El bot responde a que equipo pertenece' do
    when_i_send_text(token, '/equipo')
    then_i_get_text(token, 'Hola Nairobi')

    start_bot(token)
  end

  it 'cuando me /registro deberia responder con Bienvenido nombre!, te registraste exitosamente.' do
    dado_que_me_quiero_registrar
    cuando_envio(token, '/registrar Juan, 1144449999, paseo colon 850')
    entonces_estoy_registrado
    y_recibo_mensaje(token, 'Bienvenido Juan!, te registraste exitosamente.')

    start_bot(token)
  end

  it 'cuando me /registro con un numero con menos de 10 caracteres falla la registración' do
    nombre = 'Juan'
    numero = '123'
    direccion = 'paseo colon 850'
    dado_que_me_quiero_registrar_mal(nombre, numero, direccion)
    cuando_envio(token, "/registrar #{nombre}, #{numero}, #{direccion}")
    entonces_no_estoy_registrado
    y_recibo_mensaje(token, 'Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end

  it 'cuando me /registro con un numero con mas de 10 caracteres falla la registración' do
    nombre = 'Juan'
    numero = '12345678910111213'
    direccion = 'paseo colon 850'
    dado_que_me_quiero_registrar_mal(nombre, numero, direccion)
    cuando_envio(token, "/registrar #{nombre}, #{numero}, #{direccion}")
    entonces_no_estoy_registrado
    y_recibo_mensaje(token, 'Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end

  it 'cuando me /registro con un numero que no es un valor numerico' do
    nombre = 'Juan'
    numero = 'Juan'
    direccion = 'paseo colon 850'
    dado_que_me_quiero_registrar_mal(nombre, numero, direccion)
    cuando_envio(token, "/registrar #{nombre}, #{numero}, #{direccion}")
    entonces_no_estoy_registrado
    y_recibo_mensaje(token, 'Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end

  it 'cuando me /registro con un numero es vacio' do
    nombre = 'Juan'
    numero = ''
    direccion = 'paseo colon 850'
    dado_que_me_quiero_registrar_mal(nombre, numero, direccion)
    cuando_envio(token, "/registrar #{nombre}, #{numero}, #{direccion}")
    entonces_no_estoy_registrado
    y_recibo_mensaje(token, 'Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end

  it 'cuando me /registro con un nombre con numero o caracteres especiales' do
    nombre = '1J23'
    numero = '1144449999'
    direccion = 'paseo colon 850'
    dado_que_me_quiero_registrar_mal(nombre, numero, direccion)
    cuando_envio(token, "/registrar #{nombre}, #{numero}, #{direccion}")
    entonces_no_estoy_registrado
    y_recibo_mensaje(token, 'Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end

  it 'cuando me /registro sin ingresar la información necesaria' do
    nombre = '1J23'
    direccion = 'paseo colon 850'
    dado_que_me_quiero_sin_numero(nombre, direccion)
    cuando_envio(token, "/registrar #{nombre}, #{direccion}")
    entonces_no_estoy_registrado
    y_recibo_mensaje(token, 'Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end

  it 'cuando me /registro con un numero que ya esta en uso' do
    nombre = 'Juan'
    numero = '1144449999'
    direccion = 'paseo colon 850'
    cuando_envio(token, "/registrar #{nombre}, #{numero}, #{direccion}")

    dado_que_me_quiero_registrar_mal(nombre, numero, direccion)
    cuando_envio(token, "/registrar #{nombre}, #{numero}, #{direccion}")
    entonces_no_estoy_registrado
    y_recibo_mensaje(token, 'Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end
end
