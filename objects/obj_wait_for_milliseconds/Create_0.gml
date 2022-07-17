enum STEP_EVENT { BEGIN_STEP, STEP, END_STEP }

on_finished = noone;
caller = noone;
step_to_check = STEP_EVENT.STEP;
duration = 0;
elapsed_time = 0;
is_paused = false;
is_endless = false;

function stop()
{
	instance_destroy();
}

function unpause()
{
	is_paused = false;
}

function pause()
{
	is_paused = true;
}

function update_routine()
{
	if (is_paused)
		return;
	
	elapsed_time += delta_time / 1000;

	if (elapsed_time >= duration)
	{
		if (instance_exists(caller))
			method(caller, on_finished)();
			
		if (!is_endless)
			instance_destroy();
		else
			elapsed_time = 0;
	}
}