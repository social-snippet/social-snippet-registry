require "spec_helper"

describe "Padrino.application" do
  app Padrino.application

  before do
    FactoryGirl.define do
      factory "my-repo", :class => Repository do
        name "my-repo"
        url "git://github.com/user/my-repo"
        desc "This is my repository"
      end
    end

    FactoryGirl.create("my-repo")
  end # prepare my-repo

  before do
    FactoryGirl.define do
      factory "new-repo", :class => Repository do
        name "new-repo"
        url "git://github.com/user/new-repo"
        desc "This is my new repository"
        dependencies [
          "my-repo"
        ]
      end
    end

    FactoryGirl.create("new-repo")
  end # prepare new-repo

  context "POST /api/v0/repositories", :use_real_net => true do

    before do
      header "X-CSRF-TOKEN", "dummy"
      post(
        "/api/v0/repositories",
        {
          :url => "git://github.com/social-snippet/example-repo",
        },
        {
          "rack.session" => {
            :csrf => "dummy",
          }
        },
      )
    end

    context "response" do

      subject { last_response }
      it { should be_ok }

      context "check repo" do

        subject { Repository.where(:name => "example-repo").exists? }
        it { should be_truthy }

      end # check repo

    end # response

  end # POST /api/v0/repositories

  context "GET /api/v0/repositories" do

    before { get "/api/v0/repositories" }

    context "response" do

      subject { last_response }
      it { should be_ok }

      context "repo list" do

        subject(:result) { JSON.parse(last_response.body) }
        it { expect(result.length).to eq 2 }

        context "names" do
          subject { result.map {|repo| repo["name"] } }
          it { should include "my-repo" }
          it { should include "new-repo" }
        end # names
        
        context "urls" do
          subject { result.map {|repo| repo["url"] } }
          it { should include "git://github.com/user/my-repo" }
          it { should include "git://github.com/user/new-repo" }
        end # urls

      end # repo list

    end # response

  end # GET /api/v0/repositories

end # Padrino.application
