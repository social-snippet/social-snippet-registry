SocialSnippet::Registry::App.controllers :repos do

  get :index do
    render :all_view
  end

  get :new do
    render :all_view
  end

  get :r, :with => [:repo_name] do
    render :all_view
  end

end
