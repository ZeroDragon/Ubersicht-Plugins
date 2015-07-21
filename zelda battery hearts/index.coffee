# Zelda Battery Hearts
# By Carlos Flores
# https://github.com/ZeroDragon

command : "pmset -g batt"
refreshFrequency: 1000
render : (output)->
	source = ['outlined',''][~~(output.search('AC Power') is -1)]
	b = output.split('%')[0]
	batteryPercent = ~~b.split(/\s/).pop()
	
	part = batteryPercent%10
	heart = '♥'
	retval = """
	<div id="content" class="#{source}">
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
		}[part]

	retval+="</div>"
	return retval

style: """
	color: #a00;
	width:160px;
	.p1d4{
		display:inline-block;
		width:6px;
		height:10px;
		vertical-align:top;
		overflow:hidden;
	}
	.p1d2{
		display:inline-block;
		width:6px;
		overflow:hidden;
	}
	.p3d4{
		display:inline-block;
		width:20px;
		height:14px;
		position:relative;
	}
	.p3d4:after{
		content:"♥";
		position:absolute;
		top:0;
		left:0;
		width:6px;
		overflow:hidden;
	}
	.p3d4:before{
		content:"♥";
		position:absolute;
		bottom:-3px;
		left:0;
		height:10px;
		overflow:hidden;
		display:inline-block;
		line-height:5px;
	}
	.outlined{
		text-shadow:
	    -1px -1px 0 #fff,
	    1px -1px 0 #fff,
	    -1px 1px 0 #fff,
	    1px 1px 0 #fff;
	}

	/*SIZE AND POSITION*/
	zoom:135%;
	top: 7px;
	left 10px;

"""