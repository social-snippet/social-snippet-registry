SocialSnippet::Registry::UserPages.helpers do

  unless @app_no_config
    include ::SocialSnippet::RegistryCore::CommonHelpers

    def authenticate_with_github(new_access_token)
      api_client = Octokit::Client.new(:access_token => new_access_token)
      github_info = api_client.user
      unless github_info.nil?
        user = ::SocialSnippet::RegistryCore::Models::UserAccount.find_or_create_by(:github_user_id => github_info.id)
        user.update_attributes!(
          :github_access_token => new_access_token,
        )
        session[:user] = user
        user
      else
        raise "error"
      end
    end
  end

end
