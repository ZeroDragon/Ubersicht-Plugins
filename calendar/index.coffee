# Calenar for Übersicht
# By Carlos Flores
# https://github.com/ZeroDragon

command : "/usr/local/bin/icalbuddy -nrd eventsToday+30"
refreshFrequency: 60000

render : (o)->
	return """"""
update : (o,domEl)->
	dias = ['Dom','Lun','Mar','Mie','Jue','Vie','Sab']
	meses = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic']
	now = new Date()
	now.setHours 0
	now.setMinutes 0
	now.setSeconds 0
	addZ = (i)-> ('00'+i).slice(-2)

	_events = (cb)->
		events = o.split('•').filter (e)-> e isnt ''
		events = events.map(
			(e)-> e.split('\n').map(
				(e)-> e.trim()
			).filter (e)->
				e isnt ''
		)
		events = events.map (e)->
			obj = {}
			name = e[0].trim()
			regExp = /\(([^)]+)\)/
			[exclude,calendar] = regExp.exec(name)
			obj.name = name.replace(exclude,'')
			obj.calendar = calendar
			fecha = e.pop()
			fecha = fecha.split(' at ')[0].replace(',','')
			[m,d,a] = fecha.split(' ')
			m = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dec'].indexOf(m)
			obj.fecha = new Date(a,m,d,0,0,0).getTime()
			obj.desc = e.filter((e)-> e[0...7] is 'notes: ').join('').replace('notes: ','').trim()
			return obj
		cb events[0...10]

	_events (data)->
		out = ""
		firstDate = null
		for event in data
			d = new Date(event.fecha)
			firstDate ?= d
			out += """
				<div class="row">
					<div class="cal">
						<div class="date">
							#{d.getDate()}
						</div>
						<div class="month">
							#{meses[d.getMonth()]}
						</div>
					</div>
					<div class="desc">
						<div class="time">
							#{dias[d.getDay()]} (#{event.calendar})
						</div>
						<div class="desc2">
							#{event.name}
							<br/>
							 #{event.desc}
						</div>
					</div>
				</div>
			"""
			out += """<div class="hour"></div>"""

		faltan = Math.round((firstDate-now)/(1000*60*60*24))
		top = """
			<div class="today">
				<div class="cal main">
					<div class="date">
						#{now.getDate()}
					</div>
					<div class="month">
						#{meses[now.getMonth()]}
					</div>
				</div>
				<div class="desc3">
					#{faltan}
				</div>
			</div>
		"""
		$(domEl).html top+out


style: """
	top 10%
	left 1%
	width 600px
	padding 2px
	box-sizing border-box
	font-family Arial, sans-serif
	color #fff
	.today
		text-align right
		.cal .month
			background-color #484
		margin-bottom 5px
	.row
		padding 4px
		background-color rgba(0,0,0,0.2)
		overflow hidden
		border-radius 8px
		margin-bottom 2px
	.cal, .desc, .desc3
		display inline-block
		vertical-align top
	.cal
		background-color #fff
		width 40px
		overflow hidden
		border-radius 8px
		.date
			color #448
			text-align center
			font-size 20px
		.month
			background-color #448
			font-size 15px
			text-align center
	.desc
		width 500px
		padding 2px
		box-sizing border-box
	.desc2
		font-size 13px
		color #eee
	.desc3
		width 40px
		height 40px
		overflow hidden
		border-radius 8px
		text-align center
		font-size 25px
		line-height 40px
		background-color #000
		color #fff
"""