class PaymentMethod
  attr_reader :name, :code

  def initialize(name:, code:)
    @name = name
    @code = code
  end

  def self.all
    response = Faraday.get('pagamentos.com.br/api/v1/payment_methods')
    return [] if response.status == 403 #Guard Clause

    json_response = JSON.parse(response.body, symbolize_names: true)

    json_response.map { |r| new(name: r[:name], code: r[:code]) }
  end
end
