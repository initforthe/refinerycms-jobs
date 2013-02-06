require 'spec_helper'

module Refinery
  module Jobs
    describe Job do
      describe "validations" do
        subject do
          FactoryGirl.create(:job,
          :reference => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:reference) { should == "Refinery CMS" }
      end
    end
  end
end
