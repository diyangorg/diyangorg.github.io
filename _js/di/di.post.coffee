di.namespace 'di.post', (exports) ->
  'use strict'

  on_post_init = ->
    post = $(@)
    content = post.find('section.js-post-content')

    # make links open new window
    $.each content.find('a'), ->
      $(@).attr
        target: '_blank'

  di.init ->
    $('article.js-post').each on_post_init

