$ ->
    $('.filepicker-btn').click ->
        filepicker.pick (file)->
            $('#avatar_url_field').val(file.url)
            $('.profilepic').attr('src', file.url+'/convert?w=75')
