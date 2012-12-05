# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.Participation =
    eventName: null
    eventDate: null
    url: null
    volunteerName: null

    popup: (url)->
        newWindow = window.open url, '_blank', 'height=300, width=600'
        if window.focus
            newWindow.focus()
        return false

    shareTwitter: ->
        message = "Please support me in #{this.eventName}. Donate online and track my progress: #{this.url}."
        encodedMessage = encodeURIComponent(message)
        this.popup("http://twitter.com/home?status=#{encodedMessage}")

    shareFacebook: ->
        message = "Please support me in #{this.eventName}. Donate online and track my progress on FundIt."
        encodedMessage = encodeURIComponent(message)
        title = "Support me in #{this.eventName}"
        encodedTitle = encodeURIComponent(title)
        encodedUrl = encodeURIComponent(this.url)
        this.popup("""
                   https://www.facebook.com/dialog/feed?
                   app_id=495928953775088&
                   link=#{encodedUrl}&
                   picture=http://fbrell.com/f8.jpg&
                   name=#{encodedTitle}&
                   description=#{encodedMessage}&
                   redirect_uri=#{encodedUrl}
                   """)


    shareEmail: ->
        subject = "Please support me in #{this.eventName}"
        encodedSubject = encodeURIComponent(subject)

        body = """
               Dear Friends,

               On #{this.eventDate}, I'll be participating in #{this.eventName}.
               You can donate online and track my progress online:
               #{this.url}.

               Thank you for your support,
               #{this.volunteerName}
               """
        encodedBody = encodeURIComponent(body)

        mailTo = "mailto: ?subject=#{encodedSubject}&body=#{encodedBody}"
        this.popup(mailTo)



$ ->
    $('.twitter-link').click ->
        Participation.shareTwitter()
        return false

    $('.facebook-link').click ->
        Participation.shareFacebook()
        return false

    $('.email-link').click ->
        Participation.shareEmail()
        return false
