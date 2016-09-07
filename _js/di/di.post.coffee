di.namespace 'di.post', (exports) ->
  'use strict'

  on_post_init = ->
    post = $(@)
    content = post.find('section.js-post-content')

    # make links open new window
    $.each content.find('a'), ->
      $(@).attr
        target: '_blank'

    # add lity
    $.each content.find('a img'), ->
      $(@).attr
        'data-lity': ''
        'data-lity-target': $(@).parents('a').attr('href')

    # set up caption
    $.each content.find('img'), ->
      caption = $(@).attr('alt')
      return unless caption
      after = $(@).parents('a') 
      after = $(@) unless after?
      $('<div/>').addClass('caption').html(caption).insertAfter after

  di.init ->
    $('article.js-post').each on_post_init

