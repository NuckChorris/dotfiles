define(`COLOR', ifdef(`COLOR', COLOR, `000000'))dnl
define(`OPACITY', ifdef(`OPACITY', OPACITY, `1.0'))dnl
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="64" height="64" id="magnify">
	<defs>
		<path id="corner" d="m 0,0 h 23 v 7 h -13 v 11 h -10 z" />
	</defs>
	<g id="icon" fill="COLOR" fill-opacity="OPACITY">
		<use id="corner-tl" xlink:href="#corner" x="7" y="12" transform="scale(1,1)" />
		<use id="corner-bl" xlink:href="#corner" x="7" y="-52" transform="scale(1,-1)" />
		<use id="corner-tr" xlink:href="#corner" x="-57" y="12" transform="scale(-1,1)" />
		<use id="corner-br" xlink:href="#corner" x="-57" y="-52" transform="scale(-1,-1)" />
		<rect width="22" height="18" x="21" y="23" />
	</g>
</svg>
