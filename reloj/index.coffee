# Time in Words widget for Übersicht
# By Carlos Flores
# https://github.com/ZeroDragon

# Original by:
# Raphael Hanneken
# behoernchen.github.io

#
# Adjust the styles as you like
#
style =
	# Define the maximum width of the widget.
	width: "45%"

	# Define the position, where to display the time.
	# Set properties you don't need to "auto"
	position:
		top:    "auto"
		bottom: "13%"
		left:   "auto"
		right:  "2%"


	# Font properties
	font:            "'Helvetica Neue', sans-serif"
	font_color:      "#F5F5F5"
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
		decenas : [
			null,null,'veinte', 'treinta', 'cuarenta', 'cincuenta'
		]
	}
	now = new Date
	inicio = "son las"
	inicio = "es la" if now.getHours() is 13 or now.getHours() is 1
	hora = horas[now.getHours()]
	currmin = now.getMinutes()
	if currmin is 0
		cont = 'en punto'
	else if currmin > 0 and currmin < 11
		cont = 'con '+minutos.enteros[currmin]
	else if currmin > 10 and currmin < 20
		cont = minutos.diez[currmin-10]
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
	top: #{@style.position.top}
	bottom: #{@style.position.bottom}
	right: #{@style.position.right}
	left: #{@style.position.left}
	width: #{@style.width}
	font-family: #{@style.font}
	color: #{@style.font_color}
	font-weight: #{@style.font_weight}
	text-align: #{@style.text_align}
	text-transform: #{@style.text_transform}
	font-size: #{@style.font_size}
	letter-spacing: #{@style.letter_spacing}
	font-smoothing: antialiased
	text-shadow: #{@style.text_shadow.x_offset} #{@style.text_shadow.y_offset} #{@style.text_shadow.blur} #{@style.text_shadow.color}
	line-height: #{@style.line_height}

"""