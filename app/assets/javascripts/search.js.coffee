Search =
    filter: ->
        query = $('.search-query').val()

        if query.length == 0
            $(".search-table-entry").slideDown()
        else
            $(".search-table-entry")
                .filter(":Contains(#{query})")
                    .slideDown()
                .end()
                .not(":Contains(#{query})")
                    .slideUp()

$ ->
    $('.search-query').keyup Search.filter



# Make a :Contains() pseudo-class that works like a case-insensitive :contains()
$.expr[":"].Contains = $.expr.createPseudo (arg)->
    return (elem) ->
        return $(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0

# Add a delete button to text fields that have data-deletable
$ ->
    $('input[data-deletable]')
        .wrap('<span class="deleteicon" />')
        .after $('<span/>').click ->
             $(this).prev('input').val('').focus()
             Search.filter()