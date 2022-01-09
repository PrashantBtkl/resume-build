module ProfilesHelper
    include HomeHelper

    def get_date_in_month_year_format(date)
        if date.nil?
            return ""
        end
        date.strftime("%b %Y")
    end

    def update_array_attributes_in_params(params)
        params[:career_highlights] = get_array_from_comma_separated_string(params[:career_highlights])
        params[:primary_skills] = get_array_from_comma_separated_string(params[:primary_skills])
        params[:secondary_skills] = get_array_from_comma_separated_string(params[:secondary_skills])
        params
    end

    def profile_pic(profile)
        if profile.avatar.attached?
            profile.avatar.variant(resize: "200x200")
        else
            user = User.find_by(params[:id])
            gravatar_url_for(user)
        end
    end
    
end
