module ParticipationsHelper
  def interpolate_email email, participation, donor=nil
    email ||= ''
    donor ||= 'Anonymous'

    event = participation.event
    org = event.organization.name
    date = event.date
    name = event.name
    volunteer = participation.volunteer.name
    link = 'https://fundit.herokuapp.com' + volunteer_participation_path(volunteer, participation)

    email.gsub('{{date}}', date.strftime('%B %d, %Y')).
          gsub('{{org}}', org).
          gsub('{{name}}', name).
          gsub('{{link}}', link).
          gsub('{{volunteer}}', volunteer).
          gsub('{{donor}}', donor)
  end
end
