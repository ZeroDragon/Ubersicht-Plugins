# Time in Words widget for Übersicht
# By Carlos Flores
# https://github.com/ZeroDragon

# Original by:
# Raphael Hanneken
# behoernchen.github.io

#
# Adjust the styles as you like
#
styles =
	# Define the maximum width of the widget.
	width: "45%"

	# Define the position, where to display the time.
	# Set properties you don't need to "auto"
	position:
		bottom: "2%"
		right:  "2%"


	# Font properties
	font:            "'Mexcellent', sans-serif"
	font_color:      "rgba(255,255,255,0.8)"
	font_size:       "6vw"
	font_weight:     "100"
	letter_spacing:  "0.025em"
	line_height:     ".9em"

	# Text shadow
	text_shadow:
		blur: 		"0px"
		x_offset: "1px"
		y_offset: "1px"
		color:    "rgba(0, 0, 0, .4)"

	# Misc
	text_align:     "right"
	text_transform: "uppercase"

command : ""
refreshFrequency: 1000
render : (o)->
	horas = [
		'doce','una','dos','tres','cuatro','cinco','seis',
		'siete','ocho','nueve','diez','once','doce',
		'una','dos','tres','cuatro','cinco','seis',
		'siete','ocho','nueve','diez','once'
	]
	minutos = {
		enteros : [
			null,'uno','dos','tres','cuatro','cinco','seis','siete','ocho','nueve','diez'
		]
		diez : [
			null, 'once', 'doce', 'trece', 'catorce', 'quince',
			'dieciseis', 'diecisiete', 'dieciocho', 'diecinueve'
		]
		veinte : [
			null, 'veintinuno', 'veintidós','veintitrés','veinticuatro',
			'veinticinco','veintiséis','veintisiete','veintiocho','veintinueve'
		]
		decenas : [
			null,null,'veinte', 'treinta', 'cuarenta', 'cincuenta'
		]
	}
	now = new Date()
	hora = horas[now.getHours()]
	currmin = now.getMinutes()
	if currmin is 0
		cont = 'en punto'
	else if currmin > 0 and currmin < 11
		cont = 'con '+minutos.enteros[currmin]
	else if currmin > 10 and currmin < 20
		cont = minutos.diez[currmin-10]
	else if currmin > 20 and currmin < 30
		cont = minutos.veinte[currmin-20]
	else
		decena = currmin.toString().slice(0,-1)
		unidad = ~~currmin.toString().slice(-1)
		cont = minutos.decenas[decena]
		if unidad > 0 and unidad < 10
			cont+=' y '+minutos.enteros[unidad]

	"""
	<div id="content">
		<span>
			#{hora}
		</span>
		<span>
			#{cont}
		</span>
	</div>
	"""

style: """
	top: #{styles.position.top}
	bottom: #{styles.position.bottom}
	right: #{styles.position.right}
	left: #{styles.position.left}
	width: #{styles.width}
	font-family: #{styles.font}
	color: #{styles.font_color}
	font-weight: #{styles.font_weight}
	text-align: #{styles.text_align}
	text-transform: #{styles.text_transform}
	font-size: #{styles.font_size}
	letter-spacing: #{styles.letter_spacing}
	font-smoothing: antialiased
	text-shadow: #{styles.text_shadow.x_offset} #{styles.text_shadow.y_offset} #{styles.text_shadow.blur} #{styles.text_shadow.color}
	line-height: #{styles.line_height}
"""