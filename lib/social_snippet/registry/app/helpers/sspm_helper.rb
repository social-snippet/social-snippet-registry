SocialSnippet::Registry::App.helpers do

  unless @app_no_config
    include ::SocialSnippet::RegistryCore::CommonHelpers
  end

end
