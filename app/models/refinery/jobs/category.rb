module Refinery
  module Jobs
    class Category < ActiveRecord::Base
      has_many :jobs

      acts_as_indexed :fields => [:name]

      validates :name, :presence => true, :uniqueness => true

      attr_accessible :name

    end
  end
end
