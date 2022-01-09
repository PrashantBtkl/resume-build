module ProfilesHelper
  include HomeHelper

  def get_date_in_month_year_format(date)
    if date.nil?
      return ""
    else
      date.strftime("%b %Y")
    end
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

  def attach_profile_pic(profile, avatar_image)
    profile.avatar.purge_later  # doing purge_later because 'avatar' has 'has_one_attached' which makes the foreign key nil if deleted.
    profile.avatar.attach(avatar_image)
  end
end
