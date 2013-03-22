(Refinery.i18n_enabled? ? Refinery::I18n.frontend_locales : [:en]).each do |lang|
  I18n.locale = lang
  
  if defined?(Refinery::User)
    Refinery::User.all.each do |user|
      if user.plugins.where(:name => 'refinerycms-jobs').blank?
        user.plugins.create(:name => 'refinerycms-jobs',
                            :position => (user.plugins.maximum(:position) || -1) +1)
      end
    end
  end

  url = "/jobs"
  if defined?(Refinery::Page) && Refinery::Page.where(:link_url => url).empty?
    page = Refinery::Page.create(
      :title => 'Jobs',
      :link_url => url,
      :deletable => false,
      :menu_match => "^#{url}(\/|\/.+?|)$"
    )
    Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
      page.parts.create(:title => default_page_part, :body => nil, :position => index)
    end
  end

  unless Refinery::Page.where(:link_url => '/jobs/thank_you').any?
    thank_you_page = Refinery::Page.where(link_url: url).first.children.create({
      :title => "Thank You",
      :link_url => "/jobs/thank_you",
      :menu_match => "^/(jobs)/thank_you$",
      :show_in_menu => false,
      :deletable => false
    })
    thank_you_page.parts.create({
      :title => "Body",
      :body => "<p>We've received your job application and will get back to you with a response shortly.</p><p><a href='/'>Return to the home page</a></p>",
      :position => 0
    })
  end 
end

(Refinery::Jobs::Setting.methods.sort - ActiveRecord::Base.methods).each do |setting|
  Refinery::Jobs::Setting.send(setting) unless setting.to_s =~ /=$/
end
