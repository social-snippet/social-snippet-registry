SocialSnippet::Registry::App.controllers :repos do

  get :index do
    render :empty_view
  end

  get :new do
    render :empty_view
  end

  get :r, :with => [:repo_name] do
    render :empty_view
  end

end
