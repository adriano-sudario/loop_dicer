///// @function src_wait_for_seconds(duration, on_finished, step_to_check);
///// @param {duration} duration in seconds
///// @param {on_finished} action on finished timout
///// @param {step_to_check} step on which to check timeout (optional)

function wait_for_seconds(_duration, _on_finished, _is_endless = false, _step_to_check = undefined)
{
	return wait_for_milliseconds(_duration * 1000, _on_finished, _is_endless, _step_to_check)
}