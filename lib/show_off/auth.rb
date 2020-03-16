module ShowOff
  class Auth
    ####
    #Login method used to authenticate user with username and password
    #it should return access_token and refresh_token
    ####
    def login(args)
      params = args.merge("grant_type": "password",
                          client_id: $client_id,
                          client_secret: $client_secret)

      begin
        res = RestClient.post($AUTH_CREATE_URL, params.to_json, { content_type: :json, accept: :json })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    def logout(token)
      auth = "Bearer #{token}"

      begin
        res = RestClient.get($AUTH_REVOKE_URL, { :Authorization => auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end
  end
end
