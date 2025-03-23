extends Node

var epsilon: float = 0.0001

func cmpFloats(a: float, b: float) -> bool:
	if a >= b-epsilon and a <= b+epsilon:
		return true
	return false 

func cmpRotations(a: float, b:float) -> bool:
	while (a >= 2*PI):
		a -= 2*PI
	while (b >= 2*PI):
		b -= 2*PI
	while (a < 0):
		a += 2*PI
	while (b < 0):
		b += 2*PI
	if a >= b-epsilon and a <= b+epsilon:
		return true
	return false 
	
	
