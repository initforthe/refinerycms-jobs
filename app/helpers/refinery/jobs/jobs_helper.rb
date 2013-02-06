module Refinery
  module Jobs
    module JobsHelper

      def salary_benefits(model)
        string = ''
        if model.day_rate_from
          string = string + number_to_currency(model.day_rate_from, precision: 0, :locale => 'en-GB')
          string = string + ' - ' + number_to_currency(model.day_rate_to, precision: 0, :locale => 'en-GB') if model.day_rate_to
          string = string + ' per day'
        elsif model.salary_from
          string = string + number_to_currency(model.salary_from, precision: 0, :locale => 'en-GB')
          string = string + ' - ' + number_to_currency(model.salary_to, precision: 0, :locale => 'en-GB') if model.salary_to
        end
        string = string + ' + ' + model.benefits unless model.benefits.blank?
        string
      end

    end
  end
end
