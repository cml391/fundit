module ApplicationHelper
  def profile_image_tag_for org_or_volunteer
    if org_or_volunteer.avatar_url?
      src = org_or_volunteer.avatar_url + '/convert?w=75'
    else
      src = "/assets/blank-profile.jpg"
    end

    return "<img src='#{src}' class='profilepic' />".html_safe


  end
end
