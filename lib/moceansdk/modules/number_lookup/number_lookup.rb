require_relative '../abstract'

class NumberLookup < MoceanFactory
  def initialize(client)
    super(client)
    @required_fields = ['mocean-api-key', 'mocean-api-secret', 'mocean-to']
  end

  def set_to(param)
    @params['mocean-to'] = param
    self
  end

  def set_nl_url(param)
    @params['mocean-nl-url'] = param
    self
  end

  def set_resp_format(param)
    @params['mocean-resp-format'] = param
    self
  end

  def inquiry(params = {})
    create(params)
    createFinalParams
    isRequiredFieldsSet
    response = Transmitter.new('/rest/1/nl', 'get', @params)
    reset
    response.getResponse
  end
end
