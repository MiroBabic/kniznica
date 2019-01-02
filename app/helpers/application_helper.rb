module ApplicationHelper

	def resource_name
		:user
	end
	
	def resource
		@resource ||= User.new
	end
	
	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end
	
	
	def flash_class(level)
		case level
		when 'notice' then "alert alert-info"
		when 'success' then "alert alert-success"
		when 'error' then "alert alert-warning"
		when 'alert' then "alert alert-danger"
		end
	end

	def get_true_false_icon(param)
		begin
			if param == true
				res = '<i class="fa fa-check-square-o fa-2x" aria-hidden="true"></i>'
			else
				res = '<i class="fa fa-window-close-o fa-2x" aria-hidden="true"></i>'
			end
			return res.html_safe
		rescue
			return 'Nezistené'
		end
	end

	def prettyDate(date)

  	monthNames = [
		  "Január", "Február", "Marec",
		  "Apríl", "Máj", "Jún", "Júl",
		  "August", "September", "Október",
		  "November", "December"
		];

    if date.present?
  	 @res= (date.day.to_s + '. ' + monthNames[date.month-1].to_s + ' ' + date.year.to_s )
    else
      @res = 'Dátum neuvedený'
    end

    return @res

  end
	
end