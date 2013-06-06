local pulse = {}
local io = io
local math = math
local tonumber = tonumber
local tostring = tostring
local string = string

pulse.step = 655 * 5

function pulse.getVolume()
	local f = io.popen("pacmd dump | grep set-sink-volume")
	local v = f:read()
	local volume = tonumber(string.sub(v, string.find(v, 'x') - 1))
	f:close()
	return volume
end
function pulse.getMute()
	local g = io.popen("pacmd dump | grep set-sink-mute")
	local mute = g:read()
	g:close()
	return string.find(mute, "no")
end
function pulse.volumeUp()
	local newVolume = pulse.getVolume() + pulse.step
	if newVolume > 65536 then newVolume = 65536 end

	io.popen("pacmd set-sink-volume 0 " .. newVolume)
end
function pulse.volumeDown()
	local newVolume = pulse.getVolume() - pulse.step
	if newVolume < 0 then newVolume = 0 end

	io.popen("pacmd set-sink-volume 0 " .. newVolume)
end
function pulse.toggleMute()
	io.popen("pacmd set-sink-mute 0 " .. (pulse.getMute() and "no" or "yes"))
end
function pulse.info()
	if pulse.getMute() then return false end
	return pulse.getVolume()
end

return pulse
