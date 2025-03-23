extends Node

func cmpFloats(a: float, b: float) -> float:
	var epsilon: float = 0.0001
	if a >= b-epsilon and a <= b+epsilon:
		return true
	return false 
