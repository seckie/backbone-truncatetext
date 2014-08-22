
/*
 * $.TruncateText
 *
 * @author     Naoki Sekiguchi
 * @license    MIT
 * @require    jquery.js, underscore.js, backbone.js
 *
 * truncate some texts that overflow specified lines. and insert "…"
 */
(function(Backbone, _, $, window, document) {
  'use strict';
  $.TruncateText = Backbone.View.extend({
    initialize: function(options) {
      this.opt = {
        line: 2,
        mark: decodeURIComponent('%E2%80%A6')
      };
      _.extend(this.opt, options);
      _.bindAll(this, 'setLine', 'run', 'truncate', 'measure', 'render');
      this.setLine(this.opt.line);
      return this.$el.each(function(i, el) {
        var $el, ref;
        $el = $(el);
        ref = {};
        ref.$inner = $('<div />').css('display', 'inline-block');
        ref.$clone = $el.clone().css('visibility', 'hidden');
        ref.$clone.append(ref.$inner);
        ref.originaltext = $el.text();
        return $el.data(ref);
      });
    },
    setLine: function(line) {
      return this.boxHeight = parseInt(this.$el.css('line-height'), 10) * line;
    },
    run: function() {
      var self;
      self = this;
      this.$el.each(function(i, el) {
        var $el;
        $el = $(el);
        $el.parent().append($el.data('$clone'));
        $el.data('$inner').text($el.data('originaltext'));
        self.truncate(el, true);
        return $el.data('$clone').remove();
      });
      return this.render();
    },
    truncate: function(el, first) {
      var $el, result, text;
      $el = $(el);
      text = $el.data('$inner').text().slice(0, -1);
      result = this.measure($el.data('$inner'));
      if (result && first) {
        return;
      } else if (result) {
        text = text.slice(0, -2) + '…';
        $el.data('text', text);
      } else {
        $el.data('$inner').text(text);
        this.truncate(el);
      }
    },
    measure: function($box) {
      if ($box.height() <= this.boxHeight) {
        return true;
      } else {
        return false;
      }
    },
    render: function() {
      return this.$el.each(function(i, el) {
        var $el, text, _ref;
        $el = $(el);
        text = (_ref = $el.data('text')) != null ? _ref : $el.text();
        return $el.text(text);
      });
    }
  });
})(Backbone, _, jQuery, window, document);
