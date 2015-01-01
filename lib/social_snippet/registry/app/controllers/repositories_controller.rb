SocialSnippet::Registry::App.controllers :repositories do

  get :index do
    render :empty
  end

  get :index, :with => [:repo_name] do
    render :empty
  end

end
