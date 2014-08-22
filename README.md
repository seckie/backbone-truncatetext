# backbone-truncatetext

Text truncation module (on Backbone.View)

This truncates some texts that overflow specified lines. And insert "…".  
If you take only one line texts, use [``text-overflow: ellipsis``](https://developer.mozilla.org/ja/docs/Web/CSS/text-overflow).

---
## Demo
- http://seckie.github.io/backbone-truncatetext/demo/

---
## Usage

Load jquery.js, underscore.js, backbone.js and this script

```
<script src="jquery.js"></script>
<script src="underscore.js"></script>
<script src="backbone.js"></script>
<script src="truncatetext.js"></script>
```

Instantiate $.TruncateText object with some [options](#options).  
You must pass "el" option on Backbone.js rule.
And call "run()" method.

```
<script>
var tt = new $.TruncateText({
  el: '.textbox',
  line: 2
});
tt.run();
</script>
```

If you want to be the content resizable, please call "run()" method again.
Do as follows.

```
$(window).on('resize orientationchange', function () {
  tt.run()
});
```

### Options

<table border="1">
<thead>
<tr>
<th>option name</th>
<th>default value</th>
<th>data type</th>
<th>description</th>
</tr>
</thead>
<tbody>
<tr>
<td>line</td>
<td>2</td>
<td>Number</td>
<td>Number of lines. Over this number lines will be truncate.</td>
</tr>
<tr>
<td>mark</td>
<td>…</td>
<td>String</td>
<td>&quot;…&quot; string</td>
</tr>
</tbody>
</table>

---
## License
[MIT License](http://www.opensource.org/licenses/mit-license.html)
