extends Node




func engineering_notation(value : int) -> String:
	if(value < 1000000):
		return str(value)
	else:
		var multiplier : int = value
		var exponent : int = 0
		while(multiplier >= 1000):
			exponent += 3
			multiplier /= 1000
		return str(multiplier) + "e" + str(exponent)
