require 'spec_helper'
require 'web_mock'

require_relative 'bot_spec_steps/registrar_repartidor_steps'

describe 'Registrar Repartidor' do
  token = 'fake_token'

  it 'cuando me registro como repartidor deberia responder con Bienvenido nombre!, te registraste como repartidor exitosamente.' do
    nombre = 'Juan'
    dni = '45571468'
    telefono = '1147239653'
    dado_que_me_quiero_registrar_como_repartidor
    cuando_envio(token, "/registrarRepartidor #{nombre}, #{dni}, #{telefono}")
    entonces_estoy_registrado_como_repartidor
    y_recibo_mensaje(token, 'Bienvenido Juan!, te registraste exitosamente como repartidor.')

    start_bot(token)
  end

  it 'cuando me registro con un telefono con menos de 10 caracteres falla la registración' do
    nombre = 'Juan'
    dni = '45571468'
    telefono = '1147'
    dado_que_me_quiero_registrar_como_repartidor_con_telefono_invalido
    cuando_envio(token, "/registrarRepartidor #{nombre}, #{dni}, #{telefono}")
    entonces_no_estoy_registrado_como_repartidor
    y_recibo_mensaje_repartidor_no_registrado(token)

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end
end
