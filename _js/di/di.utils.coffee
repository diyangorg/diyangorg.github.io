di.namespace 'di.utils', (exports) ->
  'use strict'

  load = (src, options) ->
    options = $.extend
      url: src
      dataType: 'script'
      cache: true
    , options
    $.ajax options

  analytics = (account) ->
    return unless account

    unless window.ga
      window['GoogleAnalyticsObject'] = 'ga'
      window.ga = window.ga or -> (window.ga.q = window.ga.q or []).push arguments
      window.ga.l = 1 * new Date()
      window.ga 'create', account, 'none'
      load '//www.google-analytics.com/analytics.js'

    window.ga 'send', 'pageview',
      page: location.pathname + location.search + location.hash
      location: location.href

  on_disqus_init = ->
    disqus = $(@)
    window.disqus_shortname = 'di-yang'
    window.disqus_identifier = disqus.data('id')
    window.disqus_url = disqus.data('url')
    window.disqus_title = disqus.data('title')
    window.disqus_config = ->
      @language = disqus.data('language')

    if window.DISQUS
      window.DISQUS.reset
        reload: true
      return

    load '//di.disqus.com/embed.js'

  document_write = null
  document_writeln = null
  on_gist_init = ->
    return if document_write or document_writeln

    element = $(@)
    id = element.data('id')
    file = element.data('file')

    document_write = document.write
    document_writeln = document.writeln
    document.write = (html) ->
      element.append(html)
    document.writeln = (html) ->
      element.append(html + '\n')

    load 'https://gist.github.com/' + id + '.js',
      data:
        file: file
      complete: ->
        document.write = document_write
        document.writeln = document_writeln
        document_write = null
        document_writeln = null

  default_map_options = 
    backgroundColor: 'transparent'
    zoomOnScroll: false
    zoomButtons: false
    panOnDrag: true
    regionStyle:
      initial:
        fill: '#f9f9f9'
        'fill-opacity': 1
      selected:
        fill: '#27ae60'
        'fill-opacity': 1
      selectedHover:
        fill: '#27ae60'
        'fill-opacity': 1
    focusOn:
      scale: 2
      x: 0.5
      y: 0.6

  on_map_init = ->
    map = $(@)
    regions = {}
    map.find('div').each ->
      region = $(@).data('region')
      return unless region
      regions[region] = $(@).data('regions').split(',')
    region = map.data('region')
    debug.debug 'di.map', region, regions
    init = ->
      map.data 'jvm', new jvm.Map $.extend {}, default_map_options,
        container: map
        map: region
        selectedRegions: regions[region]

    return init() if window.jvm?

    load di.settings.STATIC_URL + '/js/jvm.js',
      complete: init

  di.init ->
    analytics(di.settings.ANALYTICS)

    $('div.js-disqus').each on_disqus_init
    $('div.js-gist').each on_gist_init
    $('div.js-map').each on_map_init
