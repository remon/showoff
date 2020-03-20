module ShowOff
  class Auth

    ####
    #it should allow users to reset their passwords with email
    ####
    def reset_password(user_params)
      params = user_params.merge(
        client_id: $client_id,
        client_secret: $client_secret,
      )

      begin
        res = RestClient.post(ShowOff::Constants::AUTH_USERS_RESET_PASSWORD, params.to_json, { content_type: :json, accept: :json })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    ####
    #Login method used to authenticate user with username and password
    #it should return data user if  authenticated  or no user data if not authenticated
    ####
    def login(args)
      params = args.merge("grant_type": "password",
                          client_id: $client_id,
                          client_secret: $client_secret)

      begin
        res = RestClient.post(ShowOff::Constants::AUTH_CREATE_URL, params.to_json, { content_type: :json, accept: :json })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    ####
    # logout the user method
    ####
    def logout(token)
      auth = "Bearer #{token}"

      begin
        res = RestClient.get(ShowOff::Constants::AUTH_REVOKE_URL, { :Authorization => auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end
  end
end
