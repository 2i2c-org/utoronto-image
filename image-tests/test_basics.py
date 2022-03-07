def test_numpy():
	"""
	Test that numpy is installed
	"""
	import numpy
	a = numpy.arange(5)
	assert a is not None