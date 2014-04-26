local pulse = {}
local io = io
local math = math
local tonumber = tonumber
local tostring = tostring
local string = string

pulse.sink = 0                         -- sink id
pulse.minVolume = 0                    -- min volume
pulse.maxVolume = 65536                -- max volume
pulse.defaultStep = 0.01               -- percent per default step

-- reads dumps
function pulse.volumeGet()
	local f = io.popen("pacmd dump | grep set-sink-volume")
	local v = f:read()
	local volume = tonumber(string.sub(v, string.find(v, 'x') - 1))
	f:close()
	print(pulse.minVolume .. " / " .. volume .. " / " .. pulse.maxVolume)
	return (volume - pulse.minVolume) / pulse.maxVolume
end
function pulse.muteGet()
	local g = io.popen("pacmd dump | grep set-sink-mute")
	local mute = g:read()
	g:close()
	return not string.find(mute, "no")
end

-- volume management
function pulse.volumeUp(step)
	local step = step or pulse.defaultStep
	pulse.volumeSet(pulse.volumeGet() + step)
end
function pulse.volumeDown(step)
	local step = step or pulse.defaultStep
	pulse.volumeSet(pulse.volumeGet() - step)
end
function pulse.volumeSet(percent)
	if percent > 1 then percent = 1 end
	if percent < 0 then percent = 0 end
	local volume = pulse.minVolume + (percent * (pulse.maxVolume - pulse.minVolume))

	print(volume)
	io.popen("pacmd set-sink-volume " .. pulse.sink .. " " .. math.floor(volume))
end

-- mute management
function pulse.muteOn()
	io.popen("pacmd set-sink-mute " .. pulse.sink .. " yes")
end
function pulse.muteOff()
	io.popen("pacmd set-sink-mute " .. pulse.sink .. " no")
end
function pulse.muteToggle()
	io.popen("pacmd set-sink-mute " .. pulse.sink .. " " .. (pulse.muteGet() and "no" or "yes"))
end

return pulse
