module ShowOff
  class Auth
    def generate_token(args)
      params = args.merge(grant_type: "password",
                          client_id: $client_id,
                          client_secret: $client_secret)

      begin
        r = RestClient.post($AUTH_CREATE_URL, params.to_json, { content_type: :json, accept: :json })
      rescue RestClient::ExceptionWithResponse => err
        err.response
      end
    end
  end
end
