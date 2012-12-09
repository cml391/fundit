module ApplicationHelper
  def profile_image_tag_for org_or_volunteer
    if org_or_volunteer.avatar_url?
      src = org_or_volunteer.avatar_url + '/convert?w=125'
    else
      src = "/assets/blank-profile.png"
    end

    return "<img src='#{src}' class='profile-pic' />".html_safe
  end
  
  def icon_image_tag_for org_or_volunteer
    if org_or_volunteer.avatar_url?
      src = org_or_volunteer.avatar_url + '/convert?w=60'
    else
      src = "/assets/blank-profile.png"
    end

    return "<img src='#{src}' class='icon-pic-center' />".html_safe
  end
  
  def mini_icon_image_tag_for org_or_volunteer
    if org_or_volunteer.avatar_url?
      src = org_or_volunteer.avatar_url + '/convert?w=40'
    else
      src = "/assets/blank-profile.png"
    end

    return "<img src='#{src}' class='mini-icon-pic' />".html_safe
  end
  
   def profile_event_image_tag_for event
    if event.image_url?
      src = org_or_volunteer.image_url + '/convert?w=125'
    else
      src = "/assets/blank-event.png"
    end

    return "<img src='#{src}' class='profile-pic' />".html_safe
  end
  
  def icon_event_image_tag_for event
    if event.image_url?
      src = org_or_volunteer.image_url + '/convert?w=60'
    else
      src = "/assets/blank-event.png"
    end

    return "<img src='#{src}' class='icon-pic-top' />".html_safe
  end
  
end
