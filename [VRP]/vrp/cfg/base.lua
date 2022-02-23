
local cfg = {}

cfg.save_interval = 25 -- seconds
cfg.whitelist = false -- enable/disable whitelist
cfg.ignore_ip_identifier = true -- This will allow multiple same IP connections (for families etc)

-- delay the tunnel at loading (for weak connections)
cfg.load_duration = 7 -- seconds, player duration in loading mode at the first spawn
cfg.load_delay = 7 -- milliseconds, delay the tunnel communication when in loading mode
cfg.global_delay = 7 -- milliseconds, delay the tunnel communication when not in loading mode


				-- SET YOUR LANGUAGE HERE - MAKE SURE IT'S INSIDE THE ""
cfg.lang = "en" -- en / fr / it / ger / pt / ru / lith / dan / ar / pl / es / swe / fin / cn / ro 
				-- English/Français/Italiano/Deutsche/Português/Pусский/Lietuvių/Dansk/العربية/Polskie/Español/Svenska/Suomalainen/中文/Română
cfg.debug = false


return cfg
