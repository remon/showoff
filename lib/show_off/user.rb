module ShowOff
  class User
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

    def create(args)
      params = args.merge(
        client_id: $client_id,
        client_secret: $client_secret,
      )

      begin
        res = RestClient.post($AUTH_USERS_URL, params.to_json, { content_type: :json, accept: :json })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response)
      end
    end
  end
end
