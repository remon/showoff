module ShowOff
  class User
    def create(args)
      params = args.merge(
        client_id: $client_id,
        client_secret: $client_secret,
      )
      begin
        r = RestClient.post($AUTH_USERS_URL, params.to_json, { content_type: :json, accept: :json })
      rescue RestClient::ExceptionWithResponse => err
        err.response
      end
    end
  end
end
