###
 * $.TruncateText
 *
 * @author     Naoki Sekiguchi
 * @license    MIT
 * @require    jquery.js, underscore.js, backbone.js
 *
 * truncate some texts that overflow specified lines. and insert "…"
###

((Backbone, _, $, window, document) ->
  'use strict'

  $.TruncateText = Backbone.View.extend(

    initialize: (options) ->
      # default option
      @opt =
        line: 2
        mark: decodeURIComponent('%E2%80%A6')

      _.extend(@opt, options)
      _.bindAll(@, 'setLine', 'run', 'truncate', 'measure', 'render')

      @setLine(@opt.line)

      @$el.each((i, el) ->
        $el = $(el)
        ref = {}
        ref.$inner = $('<div />').css('display', 'inline-block')
        ref.$clone = $el.clone().css('visibility', 'hidden')
        ref.$clone.append(ref.$inner)
        ref.originaltext = $el.text()
        $el.data(ref)
      )

    setLine: (line) ->
      @boxHeight = parseInt(@$el.css('line-height'), 10) * line

    run: () ->
      self = @
      @$el.each((i, el) ->
        $el = $(el)
        $el.parent().append($el.data('$clone'))
        $el.data('$inner').text($el.data('originaltext'))
        self.truncate(el, true)
        $el.data('$clone').remove()
      )
      @render()

    truncate: (el, first) ->
      $el = $(el)
      text = $el.data('$inner').text().slice(0, -1)
      result = @measure($el.data('$inner'))

      if (result and first)
        return # do nothing
      else if (result)
        text = text.slice(0, -2) + '…'
        $el.data('text', text) # end
      else
        $el.data('$inner').text(text)
        @truncate(el) # recurse
      return

    measure: ($box) ->
      if ($box.height() <= @boxHeight)
        return true
      else
        return false

    render: () ->
      @$el.each((i, el) ->
        $el = $(el)
        text = $el.data('text') ? $el.text()
        $el.text(text)
      )
  )

  return
)(Backbone, _, jQuery, window, document)
