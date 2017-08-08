local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end
--------------------------------
local api_key = nil
local base_api = "https://maps.googleapis.com/maps/api"
--------------------------------
local function get_latlong(area)
	local api      = base_api .. "/geocode/json?"
	local parameters = "address=".. (URL.escape(area) or "")
	if api_key ~= nil then
		parameters = parameters .. "&key="..api_key
	end
	local res, code = https.request(api..parameters)
	if code ~=200 then return nil  end
	local data = json:decode(res)
	if (data.status == "ZERO_RESULTS") then
		return nil
	end
	if (data.status == "OK") then
		lat  = data.results[1].geometry.location.lat
		lng  = data.results[1].geometry.location.lng
		acc  = data.results[1].geometry.location_type
		types= data.results[1].types
		return lat,lng,acc,types
	end
end
--------------------------------
local function get_staticmap(area)
	local api        = base_api .. "/staticmap?"
	local lat,lng,acc,types = get_latlong(area)
	local scale = types[1]
	if scale == "locality" then
		zoom=8
	elseif scale == "country" then 
		zoom=4
	else 
		zoom = 13 
	end
	local parameters =
		"size=600x300" ..
		"&zoom="  .. zoom ..
		"&center=" .. URL.escape(area) ..
		"&markers=color:red"..URL.escape("|"..area)
	if api_key ~= nil and api_key ~= "" then
		parameters = parameters .. "&key="..api_key
	end
	return lat, lng, api..parameters
end
--------------------------------
local function get_weather(location)
	print("Finding weather in ", location)
	local BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
	local url = BASE_URL
	url = url..'?q='..location..'&APPID=eedbc05ba060c787ab0614cad1f2e12b'
	url = url..'&units=metric'
	local b, c, h = http.request(url)
	if c ~= 200 then return nil end
	local weather = json:decode(b)
	local city = weather.name
	local country = weather.sys.country
	local temp = 'دمای شهر '..city..' هم اکنون '..weather.main.temp..' درجه سانتی گراد می باشد\n____________________\n @RsEvEn:)'
	local conditions = 'شرایط فعلی آب و هوا : '
	if weather.weather[1].main == 'Clear' then
		conditions = conditions .. 'آفتابی☀'
	elseif weather.weather[1].main == 'Clouds' then
		conditions = conditions .. 'ابری ☁☁'
	elseif weather.weather[1].main == 'Rain' then
		conditions = conditions .. 'بارانی ☔'
	elseif weather.weather[1].main == 'Thunderstorm' then
		conditions = conditions .. 'طوفانی ☔☔☔☔'
	elseif weather.weather[1].main == 'Mist' then
		conditions = conditions .. 'مه 💨'
	end
	return temp .. '\n' .. conditions
end
--------------------------------
local function calc(exp)
	url = 'http://api.mathjs.org/v1/'
	url = url..'?expr='..URL.escape(exp)
	b,c = http.request(url)
	text = nil
	if c == 200 then
    text = 'Result = '..b..'\n____________________\n @RsEvEn:)'
	elseif c == 400 then
		text = b
	else
		text = 'Unexpected error\n'
		..'Is api.mathjs.org up?'
	end
	return text
end
--------------------------------
function exi_file(path, suffix)
    local files = {}
    local pth = tostring(path)
	local psv = tostring(suffix)
    for k, v in pairs(scandir(pth)) do
        if (v:match('.'..psv..'$')) then
            table.insert(files, v)
        end
    end
    return files
end
--------------------------------
function file_exi(name, path, suffix)
	local fname = tostring(name)
	local pth = tostring(path)
	local psv = tostring(suffix)
    for k,v in pairs(exi_file(pth, psv)) do
        if fname == v then
            return true
        end
    end
    return false
end
--------------------------------
function run(msg, matches)
local mtnnn = matches[2]
local uhash = 'user:'..msg.from.id
local user = redis:hgetall(uhash)
local um_hash = 'msgs:'..msg.from.id..':'..msg.to.id
user_info_msgs = tonumber(redis:get(um_hash) or 0)
local CPU = io.popen("sh ./data/cmd.sh"):read('*all')
 local cmd = redis:hget('group:'..msg.to.id..':cmd', 'bot')
if cmd == 'moderator' and not is_mod(msg) or cmd == 'owner' and not is_owner(msg) then
 return 
 else
	if matches[1]:lower() == "calc" and matches[2] or  matches[1]:lower() == "Calc" and matches[2] or  matches[1]:lower() == "حساب" and matches[2] then 
		if msg.to.type == "pv" then 
			return 
       end
		return calc(matches[2])
	end
--------------------------------
 if matches[1] == "getpro" or matches[1] == "Getpro" or matches[1] == "پروفایل" then
 local function dl_photo(arg,data)
 tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'YOUR iD >>'..msg.sender_user_id_..' ') 
end
  tdcli_function ({ID = 
"GetUserProfilePhotos",user_id_ = 
msg.sender_user_id_,offset_ = 
matches[2],limit_ = 100000}, dl_photo, nil) 
end
--------------------------------
if matches[1] == 'serverinfo' and is_sudo(msg) or matches[1] == 'Serverinfo' and is_sudo(msg) or matches[1] == 'اطلاعات سرور' and is_sudo(msg) then
  return CPU
end
--------------------------------
	if matches[1]:lower() == 'praytime' or matches[1] == 'azan' or  matches[1]:lower() == 'Praytime' or matches[1] == 'Azan' or  matches[1]:lower() == 'اذان' or matches[1] == 'اذان' then
		if matches[2] then
			city = matches[2]
		elseif not matches[2] then
			city = 'Tehran'
		end
		local lat,lng,url	= get_staticmap(city)
		local dumptime = run_bash('date +%s')
		local code = http.request('http://api.aladhan.com/timings/'..dumptime..'?latitude='..lat..'&longitude='..lng..'&timezonestring=Asia/Tehran&method=7')
		local jdat = json:decode(code)
		local data = jdat.data.timings
		local text = 'شهر: '..city
		text = text..'\nاذان صبح: '..data.Fajr
		text = text..'\nطلوع آفتاب: '..data.Sunrise
		text = text..'\nاذان ظهر: '..data.Dhuhr
		text = text..'\nغروب آفتاب: '..data.Sunset
		text = text..'\nاذان مغرب: '..data.Maghrib
		text = text..'\nعشاء : '..data.Isha
		text = text..'\n@MaTaDoRTeaM\n'
		return tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'html')
	end
--------------------------------
  if matches[1] == 'rank' or matches[1] == 'Rank' or matches[1] == 'مقام من' then
    if is_sudo(msg) then
    tdcli.sendDocument(msg.chat_id_, 0, 0, 1, nil, './Fun/sudo.webp', '', dl_cb, nil)
      return "*Sudo Bots*"
    elseif is_admin(msg) then
    tdcli.sendDocument(msg.chat_id_, 0, 0, 1, nil, './Fun/admin.webp', '', dl_cb, nil)
      return "*Admin*"
    elseif is_owner(msg) then
    tdcli.sendDocument(msg.chat_id_, 0, 0, 1, nil, './Fun/owner.webp', '', dl_cb, nil)
      return "*Owner GP*"
    elseif is_mod(msg) then
    tdcli.sendDocument(msg.chat_id_, 0, 0, 1, nil, './Fun/mod.webp', '', dl_cb, nil)
      return "*Moderator*"
    else
    tdcli.sendDocument(msg.chat_id_, 0, 0, 1, nil, './Fun/member.webp', '', dl_cb, nil)
      return "*Member*"
    end
  end
--------------------------------
if matches[1]:lower() == 'test' then
return tdcli.sendDocument(msg.chat_id_, 0, 0, 1, nil, './Fun/ping.gif', '@MaTaDoRTeaM', dl_cb, nil)
end
--------------------------------
if matches[1] == 'bold' or matches[1] == 'Bold' or matches[1] == 'بولد' then
  return '*'..mtnnn..'*'
elseif matches[1] == 'code' or matches[1] == 'Code' or matches[1] == 'کدنویس' then
  return '`'..mtnnn..'`'
elseif matches[1] == 'italic' or matches[1] == 'Italic' or matches[1] == 'ایتالیک' then
  return '_'..mtnnn..'_'
end
--------------------------------
	if matches[1]:lower() == 'weather' or matches[1]:lower() == 'Weather' or  matches[1]:lower() == 'اب و هوا' then
		city = matches[2]
		local wtext = get_weather(city)
		if not wtext then
			wtext = 'مکان وارد شده صحیح نیست'
		end
		return wtext
	end
--------------------------------
	if matches[1]:lower() == 'time' or matches[1]:lower() == 'Time' or matches[1]:lower() == 'ساعت' then
local url , res = http.request('http://irapi.ir/time/')
if res ~= 200 then return "No connection" end
local jdat = json:decode(url)
local text = '*Ir Time:* _'..jdat.FAtime..'_\n*Ir Data:* _'..jdat.FAdate..'_\n------------\n*En Time:* _'..jdat.ENtime..'_\n *En Data:* _'..jdat.ENdate.. '_\n'
  tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
	end
-----------------
  if matches[1] == 'me' or matches[1] == 'Me' or matches[1] == 'من' then
    if is_sudo(msg) then
      return "*υšeяɳαɱҽ:* @"..(check_markdown(msg.from.username) or 'No υʂҽɾɳαɱҽ').."\n*ιԃ:* `"..msg.from.id.."`\n*ɾαɳĸ:* `ғυll αdмιɴ🎭`\n*тσтαʅ ɱҽαʂαɠҽʂ:* `"..user_info_msgs.."️`"
    elseif is_admin(msg) then
      return "*υšeяɳαɱҽ:* @"..(check_markdown(msg.from.username) or 'No υʂҽɾɳαɱҽ').."\n*ιԃ:* `"..msg.from.id.."`\n*ɾαɳĸ:* `вoт αdмιɴ🎭`\n*тσтαʅ ɱҽαʂαɠҽʂ:* `"..user_info_msgs.."`"
    elseif is_owner(msg) then
      return "*υšeяɳαɱҽ:* @"..(check_markdown(msg.from.username) or 'No υʂҽɾɳαɱҽ').."\n*ιԃ:* `"..msg.from.id.."`\n*ɾαɳĸ:* `ɢroυp owɴer👤`\n*тσтαʅ ɱҽαʂαɠҽʂ:* `"..user_info_msgs.."`"
    elseif is_mod(msg) then
      return "*υšeяɳαɱҽ:* @"..(check_markdown(msg.from.username) or 'No υʂҽɾɳαɱҽ').."\n*ιԃ:* `"..msg.from.id.."`\n*ɾαɳĸ:* `ɢroυp мoderαтor👮`\n*тσтαʅ ɱҽαʂαɠҽʂ:* `"..user_info_msgs.."`"
    else
      return "*υšeяɳαɱҽ:* @"..(check_markdown(msg.from.username) or 'No υʂҽɾɳαɱҽ').."\n*ιԃ:* `"..msg.from.id.."`\n*ɾαɳĸ:* `ɢroυp мeмвer😑`\n*тσтαʅ ɱҽαʂαɠҽʂ:* `"..user_info_msgs.."`"
    end
  end
 --------------------------------
	if matches[1] == "tr" or matches[1] == "Tr" or matches[1] == "ترجمه" then 
		url = https.request('https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160119T111342Z.fd6bf13b3590838f.6ce9d8cca4672f0ed24f649c1b502789c9f4687a&format=plain&lang='..URL.escape(matches[2])..'&text='..URL.escape(matches[3]))
		data = json:decode(url)
		return 'زبان : '..data.lang..'\nترجمه : '..data.text[1]..'\n____________________\n @RsEvEn:)'
	end
--------------------------------
	if matches[1]:lower() == 'short' or matches[1]:lower() == 'Short' or matches[1]:lower() == 'کوتاه' then
		if matches[2]:match("[Hh][Tt][Tt][Pp][Ss]://") then
			shortlink = matches[2]
		elseif not matches[2]:match("[Hh][Tt][Tt][Pp][Ss]://") then
			shortlink = "https://"..matches[2]
		end
		local yon = http.request('http://api.yon.ir/?url='..URL.escape(shortlink))
		local jdat = json:decode(yon)
		local bitly = https.request('https://api-ssl.bitly.com/v3/shorten?access_token=f2d0b4eabb524aaaf22fbc51ca620ae0fa16753d&longUrl='..URL.escape(shortlink))
		local data = json:decode(bitly)
		local yeo = http.request('http://yeo.ir/api.php?url='..URL.escape(shortlink)..'=')
		local opizo = http.request('http://api.gpmod.ir/shorten/?url='..URL.escape(shortlink)..'&username=mersad565@gmail.com')
		local u2s = http.request('http://u2s.ir/?api=1&return_text=1&url='..URL.escape(shortlink))
		local llink = http.request('http://llink.ir/yourls-api.php?signature=a13360d6d8&action=shorturl&url='..URL.escape(shortlink)..'&format=simple')
		local text = ' 🌐لینک اصلی :\n'..check_markdown(data.data.long_url)..'\n\nلینکهای کوتاه شده با 6 سایت کوتاه ساز لینک : \n》کوتاه شده با bitly :\n___________________________\n'..check_markdown(data.data.url)..'\n___________________________\n》کوتاه شده با yeo :\n'..check_markdown(yeo)..'\n___________________________\n》کوتاه شده با اوپیزو :\n'..check_markdown(opizo)..'\n___________________________\n》کوتاه شده با u2s :\n'..check_markdown(u2s)..'\n___________________________\n》کوتاه شده با llink : \n'..check_markdown(llink)..'\n___________________________\n》لینک کوتاه شده با yon : \nyon.ir/'..check_markdown(jdat.output)..'\n____________________\n @RsEvEn:)'
		return tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'html')
	end
--------------------------------
	if matches[1]:lower() == "sticker" or matches[1]:lower() == "Sticker" or matches[1]:lower() == "استیکر" then 
		local eq = URL.escape(matches[2])
		local w = "500"
		local h = "500"
		local txtsize = "100"
		local txtclr = "ff2e4357"
		if matches[3] then 
			txtclr = matches[3]
		end
		if matches[4] then 
			txtsize = matches[4]
		end
		if matches[5] and matches[6] then 
			w = matches[5]
			h = matches[6]
		end
		local url = "https://assets.imgix.net/examples/clouds.jpg?blur=150&w="..w.."&h="..h.."&fit=crop&txt="..eq.."&txtsize="..txtsize.."&txtclr="..txtclr.."&txtalign=middle,center&txtfont=Futura%20Condensed%20Medium&mono=ff6598cc"
		local receiver = msg.to.id
		local  file = download_to_file(url,'text.webp')
		tdcli.sendDocument(msg.to.id, 0, 0, 1, nil, file, '', dl_cb, nil)
	end
--------------------------------
	if matches[1]:lower() == "photo" or  matches[1]:lower() == "Photo" or matches[1]:lower() == "عکس" then 
		local eq = URL.escape(matches[2])
		local w = "500"
		local h = "500"
		local txtsize = "100"
		local txtclr = "ff2e4357"
		if matches[3] then 
			txtclr = matches[3]
		end
		if matches[4] then 
			txtsize = matches[4]
		end
		if matches[5] and matches[6] then 
			w = matches[5]
			h = matches[6]
		end
		local url = "https://assets.imgix.net/examples/clouds.jpg?blur=150&w="..w.."&h="..h.."&fit=crop&txt="..eq.."&txtsize="..txtsize.."&txtclr="..txtclr.."&txtalign=middle,center&txtfont=Futura%20Condensed%20Medium&mono=ff6598cc"
		local receiver = msg.to.id
		local  file = download_to_file(url,'text.jpg')
		tdcli.sendPhoto(msg.to.id, 0, 0, 1, nil, file, "@MaTaDoRTeaM", dl_cb, nil)
	end

end
end
--------------------------------
return {               
	patterns = {
               	"^[!/#](weather) (.*)$",
		"^[!/](calc) (.*)$",
		"^[#!/](time)$",
        "^[#!/](serverinfo)$",
		"^[#!/](rank)$",
		"^[#!/](tophoto)$",
		"^[#!/](tosticker)$",
		"^[!/#](voice) +(.*)$",
		"^[/!#]([Pp]raytime) (.*)$",
		"^[/!#](praytime)$",
		"^[/!#]([Aa]zan) (.*)$",
		"^[/!#](azan)$",
		"^[!/]([Tt]r) ([^%s]+) (.*)$",
		"^[!/]([Ss]hort) (.*)$",
		"^[!/](photo) (.+)$",
		"^[!/](sticker) (.+)$",
		"^[!/#]([Mm]e)$",
		"^[!/#]([Gg]etpro) (%d+)$",
        "^([Ww]eather) (.*)$",
		"^[!#/]([Cc]ode) (.*)$",
        "^[!#/]([Ii]talic) (.*)$",
        "^[!#/]([Bb]old) (.*)$",
		"^([Cc]alc) (.*)$",
		"^([Tt]ime)$",
        "^([SS]erverinfo)$",
		"^([Rr]ank)$",
		"^([Tt]ophoto)$",
		"^([Tt]osticker)$",
		"^([Vv]oice) +(.*)$",
		"^([Pp]raytime) (.*)$",
		"^([Pp]raytime)$",
		"^([Aa]zan) (.*)$",
		"^([Aa]zan)$",
		"^([Tt]r) ([^%s]+) (.*)$",
		"^([Ss]hort) (.*)$",
		"^([Pp]hoto) (.+)$",
		"^([Ss]ticker) (.+)$",
		"^([Mm]e)$",
		"^([Gg]etpro) (%d+)$",
		"^([Cc]ode) (.*)$",
        "^([Ii]talic) (.*)$",
        "^([Bb]old) (.*)$",
		"^(اب و هوا) (.*)$",
		"^(حساب) (.*)$",
		"^(ساعت)$",
		"^(مقام من)$",
		"^(اطلاعات سرور)$",
		"^(به عکس)$",
		"^(به استیکر)$",
		"^(ویس) +(.*)$",
		"^(اذان) (.*)$",
		"^(اذان)$",
		"^(ترجمه) ([^%s]+) (.*)$",
		"^(کوتاه) (.*)$",
		"^(عکس) (.+)$",
		"^(استیکر) (.+)$",
		"^(من)$",
		"^(test)$",
		"^(پروفایل) (%d+)$",
		"^(کدنویس) (.*)$",
        "^(بولد) (.*)$",
        "^(ایتالیک) (.*)$",
		}, 
	run = run,
	}

--#by @RsEvEn:)

