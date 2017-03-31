class CircleApi
  include HTTParty
  base_uri 'https://circleci.com'

  def initialize(circleci_token)
    @circleci_token = circleci_token
  end

  def trigger_new_build(branch)

    self.class.post("/api/v1.1/project/github/oozou/rocky-ios/tree/#{branch}",
      {
        body: {
          "build_parameters": {
            "RUN_NIGHTLY_BUILD": "true"
          }
        },
        query: {
          "circle-token": @circleci_token
        },
        headers: { 'Content-Type: application/json', 'Accept: application/json'} 
      }
    )
  end

end
