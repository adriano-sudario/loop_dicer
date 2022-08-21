function linear(_t) {
	return _t;
}

function in_quad(_t) {
	return _t * _t;
}

function out_quad(_t) {
	return 1 - in_quad(1 - _t);
}

function in_out_quad(_t)
{
	if (_t < .5)
		return in_quad(_t * 2) / 2;
	return 1 - in_quad((1 - _t) * 2) / 2;
}

function in_cubic(_t) {
	return _t * _t * _t;
}

function out_cubic(_t) {
	return 1 - in_cubic(1 - _t);
}

function in_out_cubic(_t)
{
	if (_t < .5)
		return in_cubic(_t * 2) / 2;
	return 1 - in_cubic((1 - _t) * 2) / 2;
}

function in_quart(_t) {
	return _t * _t * _t * _t;
}

function out_quart(_t) {
	return 1 - in_quart(1 - _t);
}

function in_out_quart(_t)
{
	if (_t < .5)
		return in_quart(_t * 2) / 2;
	return 1 - in_quart((1 - _t) * 2) / 2;
}

function in_quint(_t) {
	return _t * _t * _t * _t * _t;
}

function out_quint(_t) {
	return 1 - in_quint(1 - _t);
}

function in_out_quint(_t)
{
	if (_t < .5) 
		return in_quint(_t * 2) / 2;
	return 1 - in_quint((1 - _t) * 2) / 2;
}

function in_sine(_t) {
	return -cos(_t * pi / 2);
}

function out_sine(_t) {
	return sin(_t * pi / 2);
}

function in_out_sine(_t) {
	return (cos(_t * pi) - 1) / -2;
}

function in_expo(_t) {
	return power(2, 10 * (_t - 1));
}

function out_expo(_t) {
	return 1 - in_expo(1 - _t);
}

function in_out_expo(_t)
{
	if (_t < .5)
		return in_expo(_t * 2) / 2;
	return 1 - in_expo((1 - _t) * 2) / 2;
}

function in_circ(_t) {
	return -(sqrt(1 - _t * _t) - 1);
}

function out_circ(_t) {
	return 1 - in_circ(1 - _t);
}

function in_out_circ(_t)
{
	if (_t < .5)
		return in_circ(_t * 2) / 2;
	return 1 - in_circ((1 - _t) * 2) / 2;
}

function out_elastic(_t)
{
	var p = .3;
	return power(2, -10 * _t) * sin((_t - p / 4) * (2 * pi) / p) + 1;
}

function in_elastic(_t) {
	return 1 - out_elastic(1 - _t);
}

function in_out_elastic(_t)
{
	if (_t < .5) return in_elastic(_t * 2) / 2;
	return 1 - in_elastic((1 - _t) * 2) / 2;
}

function in_back(_t)
{
	var s = 1.70158;
	return _t * _t * ((s + 1) * _t - s);
}

function out_back(_t) {
	return 1 - in_back(1 - _t);
}

function in_out_back(_t)
{
	if (_t < .5)
		return in_back(_t * 2) / 2;
	return 1 - in_back((1 - _t) * 2) / 2;
}

function out_bounce(_t)
{
	var divisor = 2.75;
	var multiplier = 7.5625;

	if (_t < 1 / divisor)
	{
		return multiplier * _t * _t;
	} else if (_t < 2 / divisor)
	{
		t -= 1.5 / divisor;
		return multiplier * _t * _t + .75;
	} else if (_t < 2.5 / divisor)
	{
		t -= 2.25 / divisor;
		return multiplier * _t * _t + .9375;
	} else {
		_t -= 2.625 / divisor;
		return multiplier * _t * _t + .984375;
	}
}

function in_bounce(_t) {
	return 1 - out_bounce(1 - _t);
}

function in_out_bounce(_t)
{
	if (_t < .5)
		return in_bounce(_t * 2) / 2;
	return 1 - in_bounce((1 - _t) * 2) / 2;
}