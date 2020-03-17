module ShowOff
  class User
    def initialize(token = nil)
      @token = token
      @auth = "Bearer #{@token}"
    end

    def show(id)
      begin
        res = RestClient.get($AUTH_USERS_URL + "/#{id}", { :Authorization => @auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    ####
    # check email method is used to check email availability
    # return boolean (true , false)
    ####

    def check_email(email)
      params = {
        email: email,
        client_id: $client_id,
        client_secret: $client_secret,
      }

      begin
        res = RestClient.get($AUTH_USERS_URL_CHECK, params: params)
        body = JSON.parse(res.body)
        return body["data"]["available"]
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    ####
    # SignUp method used to create a new user
    # return user data
    #TODO:  change it to return the user data or errors only
    ####
    def sign_up(args)
      params = args.merge(
        client_id: $client_id,
        client_secret: $client_secret,
      )

      begin
        res = RestClient.post($AUTH_USERS_URL, params.to_json, { content_type: :json, accept: :json })
        body = JSON.parse(res.body)
        user_data = body["data"]
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response)
      end
    end
  end
end
