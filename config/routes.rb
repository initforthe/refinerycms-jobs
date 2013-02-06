Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :jobs do
    resources :jobs, :path => '', :only => [:index, :show] do
      member do
        post :apply
      end
    end
  end

  # Admin routes
  namespace :jobs, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :jobs, :except => :show
      scope :path => 'jobs' do
        root :to => 'jobs#index'
        resources :jobs, :only => [] do
          resources :job_applications, :only => [:index, :show, :destroy]
        end
        resources :job_applications, :only => [:index, :show, :destroy]
        resources :categories
      end
    end
  end

end
