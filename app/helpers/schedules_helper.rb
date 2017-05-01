module SchedulesHelper
	def scheduleToString(val)
		val 		=	val
		valDay		=	val.strftime("%d/%m/%Y").to_i
		valMonth	=	monthString(val.strftime("%m").to_i)
		valYear		=	val.strftime("%Y").to_i
		val 	=	"#{valDay.to_s} #{valMonth.to_s} de #{valYear.to_s}"
		return val
	end
	def monthString(val)
		val  = val
		months 	=	['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre']
		name	=	months[val -1]
		return name
	end
end
