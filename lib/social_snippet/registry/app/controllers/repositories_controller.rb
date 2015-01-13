SocialSnippet::Registry::App.controllers :repositories do

  get :index do
    render :empty_view
  end

  get :index, :with => [:repo_name] do
    render :empty_view
  end

end
