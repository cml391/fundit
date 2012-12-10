$ ->
    $('.filepicker-btn').click ->
        filepicker.pick (file)->
            $('#avatar_url_field').val(file.url)
            $('.profile-pic').attr('src', file.url+'/convert?w=125&h=125&fit=crop')
