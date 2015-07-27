# Zelda Battery Hearts
# By Carlos Flores
# https://github.com/ZeroDragon

style = '''
	&
		width 170px
		zoom 135%
		top  7px
		left 10px
		color #a00

	.bk
		position absolute
		top 0
		left 0
		color #000
		z-index -1

	.p1d4
		display inline-block
		width 6px
		height 10px
		vertical-align top
		overflow hidden
		margin-right 6px

	.p1d2
		display inline-block
		width 6px
		overflow hidden
		margin-right 6px

	.p3d4
		display inline-block
		width 20px
		height 14px
		position relative
		vertical-align top

		&:after
			content "♥"
			position absolute
			top 0
			left 0
			width 6px
			overflow hidden
		
		&:before
			content "♥"
			position absolute
			bottom -2px
			left 0
			height 7px
			overflow hidden
			display inline-block
			line-height 1px

	.outlined
		text-shadow -1px -1px 0 #fff, 1px -1px 0 #fff, -1px 1px 0 #fff, 1px 1px 0 #fff

	.pound
		animation pound .25s infinite alternate

@keyframes pound{
	to{
		transform: scale(1.02);
	}
}
'''

command : "pmset -g batt"
refreshFrequency: 60000
render : (output)->
	source = ['outlined',''][~~(output.search('AC Power') is -1)]
	b = output.split('%')[0]
	batteryPercent = ~~b.split(/\s/).pop()

	pound = if batteryPercent < 15 then 'pound' else ''
	part = batteryPercent%10
	heart = '♥'
	retval = """
	<div class"container">
		<div class="bk">
	"""
	retval += "<span>#{heart}</span> " for bk in [0...20]
	retval += """
		</div>
		<div class="#{source} #{pound}">
	"""
	for item in [0...20]
		rep = ((item+1)*10)*.5
		if rep <= batteryPercent
			retval+="<span>#{heart}</span> "

	if part isnt 0 and part isnt 5
		retval+={
			1:"<span class='p1d4'>♥</span>"
			2:"<span class='p1d2'>♥</span>"
			3:"<span class='p1d2'>♥</span>"
			4:"<span class='p3d4'> </span>"
			6:"<span class='p1d4'>♥</span>"
			7:"<span class='p1d2'>♥</span>"
			8:"<span class='p1d2'>♥</span>"
			9:"<span class='p3d4'> </span>"
		}[~~part]

	retval+="</div></div>"
	return retval

style: style