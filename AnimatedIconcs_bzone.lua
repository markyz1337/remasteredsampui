--[[
      _             _  _          _                         _        _
     | |           (_)| |        (_)                       (_)      | |
   __| | _ __ ___   _ | |_  _ __  _  _   _   ___ __      __ _   ___ | |__
  / _` || '_ ` _ \ | || __|| '__|| || | | | / _ \\ \ /\ / /| | / __|| '_ \
 | (_| || | | | | || || |_ | |   | || |_| ||  __/ \ V  V / | || (__ | | | |
  \__,_||_| |_| |_||_| \__||_|   |_| \__, | \___|  \_/\_/  |_| \___||_| |_|
                                      __/ |
                                     |___/                                 ]]
script_name("AnimatedIconcs")
script_authors("deddosouru(idea), dmitriyewich")
script_url("https://vk.com/dmitriyewichmods")
script_dependencies("mimgui", "MoonAdditions" )
script_properties('work-in-pause', 'forced-reloading-only')
script_version("1.7.0.3")

changelog = [[
	NoNameAnimHud 0.1beta
		- Релиз
	NoNameAnimHud v1.0
		- Код стал большим, лучше на него не смотреть, когда-нибудь оптимизирую
		- Количество кадров в .txd определяется автоматически
		- Реализована задержка кадров, повтора анимации(настраивается через конфиг или /animhud)
		- Добавлена проверка на наличие файла анимации(Если его нет, то будет стандартная иконка)
		- Добавил проверку на изменение конфига(мне так удобней настраивать😄)
		- Что-то ещё добавил, исправил
	NoNameAnimHud v1.2
		- Оптимизировал код, он стал легче на 50%
		- Добавил кнопку полного выключения анимированных иконок
		- Кнопка "Включить стандартные иконки" не выключает анимацию
		- В списке выбора иконок отображаются только существующие .txd
		- Что-то ещё исправлено, что-то добавлено
	NoNameAnimHud v1.3
		- Добавлена кнопка переключения анимации на передний/задний фон
		- Микрофиксы
	NoNameAnimHud v1.4
		- Добавлена поддержка связки Widescreen Fix by ThirteenAG + Widescreen HOR+ Support by Wesser
		- Добавлено отображение позиции редактируемой стороны
		- При отсутствии SAMPFUNCS окно открывается чит-кодом ANIMHUD
		- Микрофиксы
	NoNameAnimHud v1.5
		- Добавлено альтернативное окно настроек, при условии отсутствии mimgui.
		- Исправлена ситуация, когда крашило скрипт, если в папке с анимацией была папка или другие файлы.
		- Микрофиксы
	NoNameAnimHud v1.5.2
		- Исправлена ошибка с combo в окне mimgui
		- Исправлена ошибка при поиске файлов, если название будет указано неправильно, то такой файл будет игнорироваться.
		- Микрофиксы
	AnimatedIconcs v1.6
		- Изменено название скрипта на AnimatedIconcs, так же изменено название папки и .json с NoNameAnimHUD на AnimatedIconcs
		- Изменены команда акцивации на /aic и чит-код AIC
		- Добавлена функция изменения команды или чит-кода.(только для версии с mimgui)
		- Нужно больше потоков! Шутка. Серьёзно, не знаю зачем, но вывел отключение стандартных иконок в отдельный поток, так в 2 раза быстрее скрываются стандартные иконки. (Хуки делать я ещё не научился)
		- Изменён метод получения координат иконки
		- Микрофиксы
	AnimatedIconcs v1.6.1
		- Исправлен краш при открытии окна настроек без mimgui
		- Микрофиксы
	AnimatedIconcs v1.6.2
		- Добавлена одна функция. Обводка - при выбранном outline_anim отключает обводку на всех оружиях, при выбранном оружии отключает обводку только у выбранного оружия.
	AnimatedIconcs v1.6.3
		- Добавлена одна функция. Задержка после завершения анимации(последний кард).
		- Исправлена ошибка когда не работал checkbox на "Поверх обводки".
	AnimatedIconcs v1.6.4 FINAL
		- Задержка после завершения анимации(последний кард) теперь и в меню без mimgui
		- Мелкие графические изменения в mimgui
		- Микрофиксы
	AnimatedIconcs v1.7.0
		- Добавлено оповещение если нет необходимых библиотек
		- При выборе иконки для редактирования, так же переключается оружие, при условии, что оно у вас есть.
		- Появление стандартной иконки при переключении оружия сведено к минимуму.
		- Используется тестовая функция для сампа на проверку коннекта и спавна (что-то вроде sampIsLocalPlayerSpawned() опкод 0B61 из SAMPFUNCS)
		- Изменена система позиционирования иконки, 4 режима:
			ручная настройка
			координаты заданный игрой(оригинальные)(по умолчанию)
			координаты с учетом sa_widescreenfix_lite.asi/Widescreen ThirteenAG
			координаты с учетом Widescreen ThirteenAG + Wesser
		- те же изменение, которые выше, для lite window
		- Мелкие графические изменения в mimgui
		- Мелкие графические изменения в lite window
		- Микрофиксы
	AnimatedIconcs v1.7.0.1
		- Дополнительная проверка
	AnimatedIconcs v1.7.0.2
		- Фикс мигания если в .txd одна текстура
		- Микрофиксы настройки задержек
	AnimatedIconcs v1.7.0.3
		- Фикс краша при отсутвии mimgui(временное решение, как будет время доработаю эту функцию).
		- Микрофикс, который надеюсь не поломает скрипт...
]]

local lvkeys, vkeys = pcall(require, 'vkeys')
local lffi, ffi = pcall(require, 'ffi')
local lmemory, memory = pcall(require, 'memory')
local lmad, mad = pcall(require, 'MoonAdditions')   -- https://github.com/THE-FYP/MoonAdditions
local lwm, wm = pcall(require, 'windows.message')
local limgui, imgui = pcall(require, 'mimgui') -- https://github.com/THE-FYP/mimgui
	if not limgui then
		print('Library \'mimgui\' not found. Download: https://github.com/THE-FYP/mimgui . Lite menu active.')
		main_window_noi = false
	else
		new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
	end

local lencoding, encoding = pcall(require, 'encoding')

encoding.default = 'CP1251'
u8 = encoding.UTF8
CP1251 = encoding.CP1251

local active = true

ffi.cdef[[
	typedef void* HANDLE;
	typedef void* LPSECURITY_ATTRIBUTES;
	typedef unsigned long DWORD;
	typedef int BOOL;
	typedef const char *LPCSTR;
	typedef struct _FILETIME {
    DWORD dwLowDateTime;
    DWORD dwHighDateTime;
	} FILETIME, *PFILETIME, *LPFILETIME;

	BOOL __stdcall GetFileTime(HANDLE hFile, LPFILETIME lpCreationTime, LPFILETIME lpLastAccessTime, LPFILETIME lpLastWriteTime);
	HANDLE __stdcall CreateFileA(LPCSTR lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES lpSecurityAttributes, DWORD dwCreationDisposition, DWORD dwFlagsAndAttributes, HANDLE hTemplateFile);
	BOOL __stdcall CloseHandle(HANDLE hObject);
]]

local function isarray(t, emptyIsObject) -- by Phrogz, сортировка
	if type(t)~='table' then return false end
	if not next(t) then return not emptyIsObject end
	local len = #t
	for k,_ in pairs(t) do
		if type(k)~='number' then
			return false
		else
			local _,frac = math.modf(k)
			if frac~=0 or k<1 or k>len then
				return false
			end
		end
	end
	return true
end

local function map(t,f)
	local r={}
	for i,v in ipairs(t) do r[i]=f(v) end
	return r
end

local keywords = {["and"]=1,["break"]=1,["do"]=1,["else"]=1,["elseif"]=1,["end"]=1,["false"]=1,["for"]=1,["function"]=1,["goto"]=1,["if"]=1,["in"]=1,["local"]=1,["nil"]=1,["not"]=1,["or"]=1,["repeat"]=1,["return"]=1,["then"]=1,["true"]=1,["until"]=1,["while"]=1}

local function neatJSON(value, opts) -- by Phrogz, сортировка
	opts = opts or {}
	if opts.wrap==nil  then opts.wrap = 80 end
	if opts.wrap==true then opts.wrap = -1 end
	opts.indent         = opts.indent         or "  "
	opts.arrayPadding  = opts.arrayPadding  or opts.padding      or 0
	opts.objectPadding = opts.objectPadding or opts.padding      or 0
	opts.afterComma    = opts.afterComma    or opts.aroundComma  or 0
	opts.beforeComma   = opts.beforeComma   or opts.aroundComma  or 0
	opts.beforeColon   = opts.beforeColon   or opts.aroundColon  or 0
	opts.afterColon    = opts.afterColon    or opts.aroundColon  or 0
	opts.beforeColon1  = opts.beforeColon1  or opts.aroundColon1 or opts.beforeColon or 0
	opts.afterColon1   = opts.afterColon1   or opts.aroundColon1 or opts.afterColon  or 0
	opts.beforeColonN  = opts.beforeColonN  or opts.aroundColonN or opts.beforeColon or 0
	opts.afterColonN   = opts.afterColonN   or opts.aroundColonN or opts.afterColon  or 0

	local colon  = opts.lua and '=' or ':'
	local array  = opts.lua and {'{','}'} or {'[',']'}
	local apad   = string.rep(' ', opts.arrayPadding)
	local opad   = string.rep(' ', opts.objectPadding)
	local comma  = string.rep(' ',opts.beforeComma)..','..string.rep(' ',opts.afterComma)
	local colon1 = string.rep(' ',opts.beforeColon1)..colon..string.rep(' ',opts.afterColon1)
	local colonN = string.rep(' ',opts.beforeColonN)..colon..string.rep(' ',opts.afterColonN)

	local build
	local function rawBuild(o,indent)
		if o==nil then
			return indent..'null'
		else
			local kind = type(o)
			if kind=='number' then
				local _,frac = math.modf(o)
				return indent .. string.format( frac~=0 and opts.decimals and ('%.'..opts.decimals..'f') or '%g', o)
			elseif kind=='boolean' or kind=='nil' then
				return indent..tostring(o)
			elseif kind=='string' then
				return indent..string.format('%q', o):gsub('\\\n','\\n')
			elseif isarray(o, opts.emptyTablesAreObjects) then
				if #o==0 then return indent..array[1]..array[2] end
				local pieces = map(o, function(v) return build(v,'') end)
				local oneLine = indent..array[1]..apad..table.concat(pieces,comma)..apad..array[2]
				if opts.wrap==false or #oneLine<=opts.wrap then return oneLine end
				if opts.short then
					local indent2 = indent..' '..apad;
					pieces = map(o, function(v) return build(v,indent2) end)
					pieces[1] = pieces[1]:gsub(indent2,indent..array[1]..apad, 1)
					pieces[#pieces] = pieces[#pieces]..apad..array[2]
					return table.concat(pieces, ',\n')
				else
					local indent2 = indent..opts.indent
					return indent..array[1]..'\n'..table.concat(map(o, function(v) return build(v,indent2) end), ',\n')..'\n'..(opts.indentLast and indent2 or indent)..array[2]
				end
			elseif kind=='table' then
				if not next(o) then return indent..'{}' end

				local sortedKV = {}
				local sort = opts.sort or opts.sorted
				for k,v in pairs(o) do
					local kind = type(k)
					if kind=='string' or kind=='number' then
						sortedKV[#sortedKV+1] = {k,v}
						if sort==true then
							sortedKV[#sortedKV][3] = tostring(k)
						elseif type(sort)=='function' then
							sortedKV[#sortedKV][3] = sort(k,v,o)
						end
					end
				end
				if sort then table.sort(sortedKV, function(a,b) return a[3]<b[3] end) end
				local keyvals
				if opts.lua then
					keyvals=map(sortedKV, function(kv)
						if type(kv[1])=='string' and not keywords[kv[1]] and string.match(kv[1],'^[%a_][%w_]*$') then
							return string.format('%s%s%s',kv[1],colon1,build(kv[2],''))
						else
							return string.format('[%q]%s%s',kv[1],colon1,build(kv[2],''))
						end
					end)
				else
					keyvals=map(sortedKV, function(kv) return string.format('%q%s%s',kv[1],colon1,build(kv[2],'')) end)
				end
				keyvals=table.concat(keyvals, comma)
				local oneLine = indent.."{"..opad..keyvals..opad.."}"
				if opts.wrap==false or #oneLine<opts.wrap then return oneLine end
				if opts.short then
					keyvals = map(sortedKV, function(kv) return {indent..' '..opad..string.format('%q',kv[1]), kv[2]} end)
					keyvals[1][1] = keyvals[1][1]:gsub(indent..' ', indent..'{', 1)
					if opts.aligned then
						local longest = math.max(table.unpack(map(keyvals, function(kv) return #kv[1] end)))
						local padrt   = '%-'..longest..'s'
						for _,kv in ipairs(keyvals) do kv[1] = padrt:format(kv[1]) end
					end
					for i,kv in ipairs(keyvals) do
						local k,v = kv[1], kv[2]
						local indent2 = string.rep(' ',#(k..colonN))
						local oneLine = k..colonN..build(v,'')
						if opts.wrap==false or #oneLine<=opts.wrap or not v or type(v)~='table' then
							keyvals[i] = oneLine
						else
							keyvals[i] = k..colonN..build(v,indent2):gsub('^%s+','',1)
						end
					end
					return table.concat(keyvals, ',\n')..opad..'}'
				else
					local keyvals
					if opts.lua then
						keyvals=map(sortedKV, function(kv)
							if type(kv[1])=='string' and not keywords[kv[1]] and string.match(kv[1],'^[%a_][%w_]*$') then
								return {table.concat{indent,opts.indent,kv[1]}, kv[2]}
							else
								return {string.format('%s%s[%q]',indent,opts.indent,kv[1]), kv[2]}
							end
						end)
					else
						keyvals = {}
						for i,kv in ipairs(sortedKV) do
							keyvals[i] = {indent..opts.indent..string.format('%q',kv[1]), kv[2]}
						end
					end
					if opts.aligned then
						local longest = math.max(table.unpack(map(keyvals, function(kv) return #kv[1] end)))
						local padrt   = '%-'..longest..'s'
						for _,kv in ipairs(keyvals) do kv[1] = padrt:format(kv[1]) end
					end
					local indent2 = indent..opts.indent
					for i,kv in ipairs(keyvals) do
						local k,v = kv[1], kv[2]
						local oneLine = k..colonN..build(v,'')
						if opts.wrap==false or #oneLine<=opts.wrap or not v or type(v)~='table' then
							keyvals[i] = oneLine
						else
							keyvals[i] = k..colonN..build(v,indent2):gsub('^%s+','',1)
						end
					end
					return indent..'{\n'..table.concat(keyvals, ',\n')..'\n'..(opts.indentLast and indent2 or indent)..'}'
				end
			end
		end
	end

	local function memoize()
		local memo = setmetatable({},{_mode='k'})
		return function(o,indent)
			if o==nil then
				return indent..(opts.lua and 'nil' or 'null')
			elseif o~=o then
				return indent..(opts.lua and '0/0' or '"NaN"')
			elseif o==math.huge then
				return indent..(opts.lua and '1/0' or '9e9999')
			elseif o==-math.huge then
				return indent..(opts.lua and '-1/0' or '-9e9999')
			end
			local byIndent = memo[o]
			if not byIndent then
				byIndent = setmetatable({},{_mode='k'})
				memo[o] = byIndent
			end
			if not byIndent[indent] then
				byIndent[indent] = rawBuild(o,indent)
			end
			return byIndent[indent]
		end
	end

	build = memoize()
	return build(value,'')
end

function savejson(table, path)
    local f = io.open(path, "w")
    f:write(table)
    f:close()
end

function convertTableToJsonString(config)
	return (neatJSON(config, { wrap = 40, short = true, sort = true, aligned = true, arrayPadding = 1, afterComma = 1, beforeColon1 = 1 }))
end

local config = {}

function defalut_config()
	config = {
		["MAIN"] = {["main_active"] = true, ["command"] = "aic", ["cheatcode"] = "AIC", ["language"] = "RU", ["standard_icons"] = false},
		["outline_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["fist_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["brassknuckle_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["golfclub_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["nitestick_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["knifecur_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["bat_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["shovel_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["poolcue_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["katana_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["chnsaw_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["colt45_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["silenced_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["desert_eagle_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["chromegun_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["sawnoff_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["shotgspa_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["micro_uzi_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["mp5lng_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["tec9_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["ak47_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["m4_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["cuntgun_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["sniper_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["rocketla_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["heatseek_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["flame_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["minigun_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["grenade_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["teargas_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["molotov_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["satchel_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["spraycan_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["fire_ex_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["camera_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["gun_dildo1_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["gun_dildo2_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["gun_vibe1_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["gun_vibe2_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["flowera_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["gun_cane_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["nvgoggles_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["irgoggles_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["gun_para_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0},
		["bomb_anim"] = {["outline"] = true, ["foreground"] = false, ["delay"] = 0, ["delay_replay"] = 0, ["delay_replay_end"] = 0, ["posX"] = 497, ["posY"] = 20, ["posW"] = 47, ["posH"] = 47, ["customX1"] = 0, ["customY1"] = 0, ["customX2"] = 0, ["customY2"] = 0};
	}
    savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
end

if doesFileExist("moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json") then
    local f = io.open("moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
    config = decodeJson(f:read("*a"))
    f:close()
else
	defalut_config()
end

function Standart()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	local ImVec2 = imgui.ImVec2

    style.WindowPadding = ImVec2(15, 15)
	style.WindowRounding = 4.7
    style.WindowBorderSize = 1.0
	style.WindowMinSize = ImVec2(1.5, 1.5)
	style.WindowTitleAlign = ImVec2(0.5, 0.5)
	style.ChildRounding = 4.7
	style.ChildBorderSize = 1
	style.PopupRounding = 4.7
	style.PopupBorderSize  = 1
	style.FramePadding = ImVec2(5, 5)
	style.FrameRounding = 4.7
	style.FrameBorderSize  = 1.0
	style.ItemSpacing = ImVec2(2, 7)
	style.ItemInnerSpacing = ImVec2(8, 6)
	style.ScrollbarSize = 8.0
	style.ScrollbarRounding = 15.0
	style.GrabMinSize = 15.0
	style.GrabRounding = 4.7
	style.IndentSpacing = 25.0
	style.ButtonTextAlign = ImVec2(0.5, 0.5)
	style.SelectableTextAlign = ImVec2(0.5, 0.5)
	style.TouchExtraPadding = ImVec2(0.00, 0.00)
	style.TabBorderSize = 1
	style.TabRounding = 4

	colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled] = ImVec4(0.50, 0.50, 0.50, 1.00)
	colors[clr.WindowBg] = ImVec4(0.15, 0.15, 0.15, 1.00)
	colors[clr.ChildBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.PopupBg] = ImVec4(0.19, 0.19, 0.19, 0.92)
	colors[clr.Border] = ImVec4(0.19, 0.19, 0.19, 0.29)
	colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.24)
	colors[clr.FrameBg] = ImVec4(0.05, 0.05, 0.05, 0.54)
	colors[clr.FrameBgHovered] = ImVec4(0.19, 0.19, 0.19, 0.54)
	colors[clr.FrameBgActive] = ImVec4(0.20, 0.22, 0.23, 1.00)
	colors[clr.TitleBg] = ImVec4(0.00, 0.00, 0.00, 1.00)
	colors[clr.TitleBgActive] = ImVec4(0.06, 0.06, 0.06, 1.00)
	colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 1.00)
	colors[clr.MenuBarBg] = ImVec4(0.14, 0.14, 0.14, 1.00)
	colors[clr.ScrollbarBg] = ImVec4(0.05, 0.05, 0.05, 0.54)
	colors[clr.ScrollbarGrab] = ImVec4(0.34, 0.34, 0.34, 0.54)
	colors[clr.ScrollbarGrabHovered] = ImVec4(0.40, 0.40, 0.40, 0.54)
	colors[clr.ScrollbarGrabActive] = ImVec4(0.56, 0.56, 0.56, 0.54)
	colors[clr.CheckMark] = ImVec4(0.33, 0.67, 0.86, 1.00)
	colors[clr.SliderGrab] = ImVec4(0.34, 0.34, 0.34, 0.54)
	colors[clr.SliderGrabActive] = ImVec4(0.56, 0.56, 0.56, 0.54)
	colors[clr.Button] = ImVec4(0.05, 0.05, 0.05, 0.54)
	colors[clr.ButtonHovered] = ImVec4(0.19, 0.19, 0.19, 0.54)
	colors[clr.ButtonActive] = ImVec4(0.20, 0.22, 0.23, 1.00)
	colors[clr.Header] = ImVec4(0.00, 0.00, 0.00, 0.52)
	colors[clr.HeaderHovered] = ImVec4(0.00, 0.00, 0.00, 0.36)
	colors[clr.HeaderActive] = ImVec4(0.20, 0.22, 0.23, 0.33)
	colors[clr.Separator] = ImVec4(0.28, 0.28, 0.28, 0.29)
	colors[clr.SeparatorHovered] = ImVec4(0.44, 0.44, 0.44, 0.29)
	colors[clr.SeparatorActive] = ImVec4(0.40, 0.44, 0.47, 1.00)
	colors[clr.ResizeGrip] = ImVec4(0.28, 0.28, 0.28, 0.29)
	colors[clr.ResizeGripHovered] = ImVec4(0.44, 0.44, 0.44, 0.29)
	colors[clr.ResizeGripActive] = ImVec4(0.40, 0.44, 0.47, 1.00)
	colors[clr.Tab]  = ImVec4(0.00, 0.00, 0.00, 0.52)
	colors[clr.TabHovered] = ImVec4(0.14, 0.14, 0.14, 1.00)
	colors[clr.TabActive] = ImVec4(0.20, 0.20, 0.20, 0.36)
	colors[clr.TabUnfocused] = ImVec4(0.00, 0.00, 0.00, 0.52)
	colors[clr.TabUnfocusedActive] = ImVec4(0.14, 0.14, 0.14, 1.00)
	colors[clr.PlotLines] = ImVec4(1.00, 0.00, 0.00, 1.00)
	colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.00, 0.00, 1.00)
	colors[clr.PlotHistogram] = ImVec4(1.00, 0.00, 0.00, 1.00)
	colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.00, 0.00, 1.00)
	colors[clr.TextSelectedBg] = ImVec4(0.20, 0.22, 0.23, 1.00)
	colors[clr.DragDropTarget] = ImVec4(0.33, 0.67, 0.86, 1.00)
	colors[clr.NavHighlight] = ImVec4(1.00, 0.00, 0.00, 1.00)
	colors[clr.NavWindowingHighlight]  = ImVec4(1.00, 0.00, 0.00, 0.70)
	colors[clr.NavWindowingDimBg] = ImVec4(1.00, 0.00, 0.00, 0.20)
	colors[clr.ModalWindowDimBg] = ImVec4(1.00, 0.00, 0.00, 0.35)
end

if limgui then
	main_window, standard_icons, main_active_imgui, icon_foreground, outline_checkbox = new.bool(), new.bool(config.MAIN.standard_icons), new.bool(config.MAIN.main_active), new.bool(), new.bool()
	local sizeX, sizeY = getScreenResolution()

	local int_item = new.int(0)
	item_list = {"outline_anim"}
	ImItems = new['const char*'][#item_list](item_list)

	local offset_item = new.int(5)
	offset_list = {'0.1', '0.2', '0.3', '0.4', '0.5', '1.0', '2.0', '4.0', '6.0', '8.0'}
	local offset_ImItems = new['const char*'][#offset_list](offset_list)

	local ImageButton_color = imgui.ImVec4(1,1,1,1)

	local input_delay = new.char[128]()
	local input_delay_replay = new.char[128]()
	local input_delay_replay_end = new.char[128]()
	local cmdbuffer = new.char[128]()

	local changecmdtext = ''

	imgui.OnInitialize(function()
		Standart()

		logo = imgui.CreateTextureFromFileInMemory(_logo, #_logo)
		close_window = imgui.CreateTextureFromFileInMemory(_close, #_close)

		imgui.GetIO().IniFilename = nil
	end)

	local mainFrame = imgui.OnFrame(
		function() return main_window[0] and not isPauseMenuActive() end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(247, 227), imgui.Cond.FirstUseEver, imgui.NoResize)
			imgui.Begin("##Main Window", main_window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoScrollbar)
			imgui.SetCursorPosX((imgui.GetWindowWidth() - 220) / 2)
			imgui.SetCursorPosY(imgui.GetCursorPosY() - 18)
			imgui.Image(logo, imgui.ImVec2(210, 50))
			imgui.Hint('hint_by', config.MAIN.language == "RU" and 'by dmitriyewich aka Valgard Dmitriyewich.\nРаспространение допускается только с указанием автора или ссылки на пост в ВК/mixmods/github\nПКМ - Открыть группу в ВК' or 'by dmitriyewich aka Valgard Dmitriyewich.\nDistribution is allowed only with the indication of the author or a link to the post in the VK/mixmods/github\nRMB - Open a group in VK')
			if imgui.IsItemClicked(1) then os.execute(('explorer.exe "%s"'):format('https://vk.com/dmitriyewichmods')) end
			---------------------------------------------------------
			imgui.PushStyleVarFloat(imgui.StyleVar.FrameBorderSize, 0.0)
			imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.00, 0.00, 0.00, 0.0))
			imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
			imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.76, 0.76, 0.76, 1.00))
			imgui.SetCursorPosX((imgui.GetWindowWidth() - 24))
			imgui.SetCursorPosY(imgui.GetCursorPosY() - 50)
			if imgui.ImageButton(close_window, imgui.ImVec2(16, 16), _,  _, 1, imgui.ImVec4(0,0,0,0), ImageButton_color) then
				main_window[0] = false
			end
			if imgui.IsItemHovered() then
				ImageButton_color = imgui.ImVec4(1,1,1,0.5)
			else
				ImageButton_color = imgui.ImVec4(1,1,1,1)
			end
			imgui.PopStyleColor(3)
			imgui.PopStyleVar()
			---------------------------------------------------------

			imgui.SetCursorPosX(imgui.GetCursorPosX() + 0)
			imgui.SetCursorPosY(imgui.GetCursorPosY() - 32)
			if config.MAIN.language == "RU" then imgui.Text("RU") else imgui.TextDisabled("RU") end
			if imgui.IsItemClicked(0) then
				config.MAIN.language = "RU"
				savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
			end
			imgui.SameLine(nil, 0)
			imgui.Text("|")
			imgui.SameLine(nil, 0)
			if config.MAIN.language == "EN" then imgui.Text("EN") else imgui.TextDisabled("EN") end
			if imgui.IsItemClicked(0) then
				config.MAIN.language = "EN"
				savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
			end

			---------------------------------------------------------
			imgui.SetCursorPosX((imgui.GetWindowWidth() - 215) / 2)
			imgui.SetCursorPosY(imgui.GetCursorPosY() - 4)
			imgui.PushItemWidth(215)
			if imgui.Combo("##Combo1", int_item, ImItems, #item_list, -1) then
				if hasCharGotWeapon(PLAYER_PED, id_gun[item_list[int_item[0] + 1]]) then
					setCurrentCharWeapon(PLAYER_PED, id_gun[item_list[int_item[0] + 1]])
				end
			end
			imgui.PopItemWidth()
			---------------------------------------------------------

			---------------------------------------------------------
			imgui.SetCursorPosY(imgui.GetCursorPosY() - 5)
			imgui.BeginChild('##settings', imgui.ImVec2(220, 25), false, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoBackground)
				outline_checkbox[0] = config[''..item_list[int_item[0] + 1]].outline
				imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(config.MAIN.language == "RU" and 'Обводка' or 'Outline').x - imgui.CalcTextSize(config.MAIN.language == "RU" and 'Поверх обводки' or 'Foreground').x - 69) / 2)
				if imgui.Checkbox("##6", outline_checkbox) then
					config[''..item_list[int_item[0] + 1]].outline = outline_checkbox[0]
				end
				imgui.SameLine(nil, 0)
				imgui.SetCursorPosX(imgui.GetCursorPosX() + 4.7)
				imgui.Text(config.MAIN.language == "RU" and 'Обводка' or 'Outline')
				imgui.SameLine(nil, 0)
				imgui.TextDisabled("|")
				imgui.SameLine(nil, 0)
				icon_foreground[0] = config[''..item_list[int_item[0] + 1]].foreground
				if imgui.Checkbox("##4", icon_foreground) then
					config[''..item_list[int_item[0] + 1]].foreground = icon_foreground[0]
				end
				imgui.SameLine(nil, 0)
				imgui.SetCursorPosX(imgui.GetCursorPosX() + 4.7)
				imgui.Text(config.MAIN.language == "RU" and 'Поверх обводки' or 'Foreground')

			imgui.EndChild()
			---------------------------------------------------------
			imgui.BeginChild('##settings2', imgui.ImVec2(80, 52), false, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoBackground)
				imgui.SetCursorPosX((imgui.GetWindowWidth() - 74) / 2)
				imgui.PushItemWidth(74)
				imgui.Combo("##Combo2", offset_item, offset_ImItems, #offset_list)
				imgui.PopItemWidth()

				imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(config.MAIN.language == "RU" and '  Размер\nсмещения' or 'Offset\n  size').x) / 2)
				imgui.SetCursorPosY(imgui.GetCursorPosY() - 8)
				imgui.Text(config.MAIN.language == "RU" and '  Размер\nсмещения' or 'Offset\n  size')
			imgui.EndChild()
			imgui.SameLine(nil, 0)
			---------------------------------------------------------
			imgui.SetCursorPosY(imgui.GetCursorPosY() - 6)
			imgui.BeginChild('##settings3', imgui.ImVec2(220, 68), false, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoBackground)
				if imgui.DegradeButton("X1+##1", imgui.ImVec2(32, 32)) then
					config[''..item_list[int_item[0] + 1]].customX1 = config[''..item_list[int_item[0] + 1]].customX1 + offset_list[offset_item[0] + 1]
				end
				if imgui.IsItemHovered() then
					draw_text("X1+ "..config[''..item_list[int_item[0] + 1]].customX1, convert(config[''..item_list[int_item[0] + 1]].posX + config[''..item_list[int_item[0] + 1]].customX1 - 10)[1], convert(config[''..item_list[int_item[0] + 1]].posY + (config[''..item_list[int_item[0] + 1]].posH / 2))[2])
				end
				imgui.SameLine(nil, 0)
				if imgui.DegradeButton("X2+##1", imgui.ImVec2(32, 32)) then
					config[''..item_list[int_item[0] + 1]].customX2 = config[''..item_list[int_item[0] + 1]].customX2 + offset_list[offset_item[0] + 1]
				end
				if imgui.IsItemHovered() then
					draw_text("X2+ "..config[''..item_list[int_item[0] + 1]].customX2, convert(config[''..item_list[int_item[0] + 1]].posX + config[''..item_list[int_item[0] + 1]].customX2 + config[''..item_list[int_item[0] + 1]].posW + 10)[1], convert(config[''..item_list[int_item[0] + 1]].posY + (config[''..item_list[int_item[0] + 1]].posH / 2))[2])
				end
				imgui.SameLine(nil, 0)
				if imgui.DegradeButton("Y1+##1", imgui.ImVec2(32, 32)) then
					config[''..item_list[int_item[0] + 1]].customY1 = config[''..item_list[int_item[0] + 1]].customY1 + offset_list[offset_item[0] + 1]
				end
				if imgui.IsItemHovered() then
					draw_text("Y1+ "..config[''..item_list[int_item[0] + 1]].customY1, convert(config[''..item_list[int_item[0] + 1]].posX + config[''..item_list[int_item[0] + 1]].customX1 + (config[''..item_list[int_item[0] + 1]].posW / 2))[1], convert(config[''..item_list[int_item[0] + 1]].posY + config[''..item_list[int_item[0] + 1]].customY1 - 7)[2])
				end
				imgui.SameLine(nil, 0)
				if imgui.DegradeButton("Y2+##1", imgui.ImVec2(32, 32)) then
					config[''..item_list[int_item[0] + 1]].customY2 = config[''..item_list[int_item[0] + 1]].customY2 + offset_list[offset_item[0] + 1]
				end
				if imgui.IsItemHovered() then
					draw_text("Y2+ "..config[''..item_list[int_item[0] + 1]].customY2, convert(config[''..item_list[int_item[0] + 1]].posX + config[''..item_list[int_item[0] + 1]].customX1 + (config[''..item_list[int_item[0] + 1]].posW / 2))[1], convert((config[''..item_list[int_item[0] + 1]].posY + config[''..item_list[int_item[0] + 1]].posH) + config[''..item_list[int_item[0] + 1]].customY2)[2])
				end

				imgui.SetCursorPosY(imgui.GetCursorPosY() - 6)
				if imgui.DegradeButton("X1-##1", imgui.ImVec2(32, 32)) then
					config[''..item_list[int_item[0] + 1]].customX1 = config[''..item_list[int_item[0] + 1]].customX1 - offset_list[offset_item[0] + 1]
				end
				if imgui.IsItemHovered() then
					draw_text("X1- "..config[''..item_list[int_item[0] + 1]].customX1, convert(config[''..item_list[int_item[0] + 1]].posX + config[''..item_list[int_item[0] + 1]].customX1 - 10)[1], convert(config[''..item_list[int_item[0] + 1]].posY + (config[''..item_list[int_item[0] + 1]].posH / 2))[2])
				end
				imgui.SameLine(nil, 0)
				if imgui.DegradeButton("X2-##1", imgui.ImVec2(32, 32)) then
					config[''..item_list[int_item[0] + 1]].customX2 = config[''..item_list[int_item[0] + 1]].customX2 - offset_list[offset_item[0] + 1]
				end
				if imgui.IsItemHovered() then
					draw_text("X2- "..config[''..item_list[int_item[0] + 1]].customX2, convert(config[''..item_list[int_item[0] + 1]].posX + config[''..item_list[int_item[0] + 1]].customX2 + config[''..item_list[int_item[0] + 1]].posW + 10)[1], convert(config[''..item_list[int_item[0] + 1]].posY + (config[''..item_list[int_item[0] + 1]].posH / 2))[2])
				end
				imgui.SameLine(nil, 0)
				if imgui.DegradeButton("Y1-##1", imgui.ImVec2(32, 32)) then
					config[''..item_list[int_item[0] + 1]].customY1 = config[''..item_list[int_item[0] + 1]].customY1 - offset_list[offset_item[0] + 1]
				end
				if imgui.IsItemHovered() then
					draw_text("Y1- "..config[''..item_list[int_item[0] + 1]].customY1, convert(config[''..item_list[int_item[0] + 1]].posX + config[''..item_list[int_item[0] + 1]].customX1 + (config[''..item_list[int_item[0] + 1]].posW / 2))[1], convert(config[''..item_list[int_item[0] + 1]].posY + config[''..item_list[int_item[0] + 1]].customY1 - 8)[2])
				end
				imgui.SameLine(nil, 0)
				if imgui.DegradeButton("Y2-##1", imgui.ImVec2(32, 32)) then
					config[''..item_list[int_item[0] + 1]].customY2 = config[''..item_list[int_item[0] + 1]].customY2 - offset_list[offset_item[0] + 1]
				end
				if imgui.IsItemHovered() then
					draw_text("Y2- "..config[''..item_list[int_item[0] + 1]].customY2, convert(config[''..item_list[int_item[0] + 1]].posX + config[''..item_list[int_item[0] + 1]].customX1 + (config[''..item_list[int_item[0] + 1]].posW / 2))[1], convert((config[''..item_list[int_item[0] + 1]].posY + config[''..item_list[int_item[0] + 1]].posH) + config[''..item_list[int_item[0] + 1]].customY2)[2])
				end
			imgui.EndChild()
			---------------------------------------------------------

			---------------------------------------------------------
			imgui.SetCursorPosX((imgui.GetWindowWidth() - 205) / 2)
			imgui.SetCursorPosY(imgui.GetCursorPosY() - 8)
			imgui.PushItemWidth(60)

			local input_delay_hint = config[''..item_list[int_item[0] + 1]].delay
			-- print()
				imgui.StrCopy(input_delay, ''..config[''..item_list[int_item[0] + 1]].delay)
			if imgui.InputTextWithHint('##input_delay'..item_list[int_item[0] + 1], input_delay_hint..'##'..item_list[int_item[0] + 1], input_delay, sizeof(input_delay) - 1, imgui.InputTextFlags.CharsDecimal) then
				if str(input_delay) == nil or str(input_delay) == "" then
					imgui.StrCopy(input_delay, '0')
				end
				config[''..item_list[int_item[0] + 1]].delay = tonumber(str(input_delay))
			end
			imgui.PopItemWidth()
			imgui.SameLine(nil, 0)
			imgui.Hint('hint_input_delay', config.MAIN.language == "RU" and 'Задержка между кадрами' or 'Delay between frames')
			imgui.SameLine(nil, 0)
			imgui.Text(" |")
			imgui.SameLine(nil, 0)
			imgui.PushItemWidth(60)
			local input_delay_replay_hint = config[''..item_list[int_item[0] + 1]].delay_replay
				imgui.StrCopy(input_delay_replay, ''..config[''..item_list[int_item[0] + 1]].delay_replay)
			if imgui.InputTextWithHint('##input_delay_replay'..item_list[int_item[0] + 1], input_delay_replay_hint..'##'..item_list[int_item[0] + 1], input_delay_replay, sizeof(input_delay_replay) - 1, imgui.InputTextFlags.CharsDecimal) then
				if str(input_delay_replay) == nil or str(input_delay_replay) == "" then
					imgui.StrCopy(input_delay_replay, '0')
				end
				config[''..item_list[int_item[0] + 1]].delay_replay = tonumber(str(input_delay_replay))
			end
			imgui.PopItemWidth()
			imgui.SameLine(nil, 0)
			imgui.Hint('hint_input_delay_replay', config.MAIN.language == "RU" and 'Задержка перед началом анимации' or 'Delay before animation starts')
			imgui.SameLine(nil, 0)
			imgui.Text(" |")
			imgui.SameLine(nil, 0)
			imgui.PushItemWidth(60)
			local input_delay_replay_end_hint = config[''..item_list[int_item[0] + 1]].delay_replay_end
				imgui.StrCopy(input_delay_replay_end, ''..config[''..item_list[int_item[0] + 1]].delay_replay_end)
			if imgui.InputTextWithHint('##input_delay_replay_end'..item_list[int_item[0] + 1], input_delay_replay_hint..'##'..item_list[int_item[0] + 1], input_delay_replay_end, sizeof(input_delay_replay_end) - 1, imgui.InputTextFlags.CharsDecimal) then
				if str(input_delay_replay_end) == nil or str(input_delay_replay_end) == "" then
					imgui.StrCopy(input_delay_replay_end, '0')
				end
				config[''..item_list[int_item[0] + 1]].delay_replay_end = tonumber(str(input_delay_replay_end))
			end
			imgui.PopItemWidth()
			imgui.Hint('hint_input_delay_replay_end', config.MAIN.language == "RU" and 'Задержка по окончанию анимации' or 'Delay at end animation')
			---------------------------------------------------------

			---------------------------------------------------------
			imgui.SetCursorPosY(imgui.GetCursorPosY() - 4)
			imgui.SetCursorPosX((imgui.GetWindowWidth() - 205) / 2)
			if imgui.DegradeButton(config.MAIN.language == "RU" and 'Сохранить' or 'Save'.."##1", imgui.ImVec2(100, 30)) then
				savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
			end
			imgui.SameLine(nil, 0)
			if imgui.DegradeButton(config.MAIN.language == "RU" and 'Сброс' or 'Reset'.."##2", imgui.ImVec2(100, 30)) then
				config[''..item_list[int_item[0] + 1]].customX1 = 0
				config[''..item_list[int_item[0] + 1]].customX2 = 0
				config[''..item_list[int_item[0] + 1]].customY1 = 0
				config[''..item_list[int_item[0] + 1]].customY2 = 0
				config[''..item_list[int_item[0] + 1]].delay = 0
				imgui.StrCopy(input_delay, '0')
				config[''..item_list[int_item[0] + 1]].delay_replay = 0
				imgui.StrCopy(input_delay_replay, '0')
				config[''..item_list[int_item[0] + 1]].delay_replay_end = 0
				imgui.StrCopy(input_delay_replay_end, '0')
			end
			---------------------------------------------------------

			imgui.SetCursorPosY(imgui.GetCursorPosY() + 3)
			imgui.Separator()
			if imgui.Checkbox(string.format("%s: %s##1", config.MAIN.language == "RU" and 'Стандартные иконки' or 'Standard icons', config.MAIN.standard_icons), standard_icons) then
				config.MAIN.standard_icons = standard_icons[0]
			end
			imgui.Separator()
			imgui.SetCursorPosX((imgui.GetWindowWidth() - 223) / 2)
			if imgui.DegradeButton(config.MAIN.language == "RU" and 'Ручная позиция' or 'Manual position'.."##1", imgui.ImVec2(225, 25)) then
				main_window[0] = false
				pos_active = true
				pos_active_thread:run()
			end
			imgui.SetCursorPosY(imgui.GetCursorPosY() - 7)
			imgui.SetCursorPosX((imgui.GetWindowWidth() - 223) / 2)
			if imgui.DegradeButton((config.MAIN.language == "RU" and 'Позиция оригинала' or 'Standard position').."##1", imgui.ImVec2(225, 25)) then
				for k, v in pairs(config) do
					if k ~= "MAIN" then
						v.posX = currentXYWH("standard").x
						v.posY = currentXYWH("standard").y
						v.posW = currentXYWH("standard").w
						v.posH = currentXYWH("standard").h
					end
				end
				savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
			end
			imgui.SetCursorPosY(imgui.GetCursorPosY() - 7)
			imgui.SetCursorPosX((imgui.GetWindowWidth() - 223) / 2)
			if imgui.DegradeButton((config.MAIN.language == "RU" and 'sa_widescreenfix_lite.asi/ThirteenAG' or 'sa_widescreenfix_lite.asi/ThirteenAG').."##1", imgui.ImVec2(225, 25)) then
				for k, v in pairs(config) do
					if k ~= "MAIN" then
						v.posX = currentXYWH("widescreen").x
						v.posY = currentXYWH("widescreen").y
						v.posW = currentXYWH("widescreen").w
						v.posH = currentXYWH("widescreen").h
					end
				end
				savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
			end
			imgui.SetCursorPosY(imgui.GetCursorPosY() - 7)
			imgui.SetCursorPosX((imgui.GetWindowWidth() - 223) / 2)
			if imgui.DegradeButton(config.MAIN.language == "RU" and 'Widescreen ThirteenAG + Wesser' or 'Widescreen ThirteenAG + Wesser'.."##1", imgui.ImVec2(225, 25)) then
				for k, v in pairs(config) do
					if k ~= "MAIN" then
						v.posX = currentXYWH("widescreen_Wesser").x
						v.posY = currentXYWH("widescreen_Wesser").y
						v.posW = currentXYWH("widescreen_Wesser").w
						v.posH = currentXYWH("widescreen_Wesser").h
					end
				end
				savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
			end

			imgui.Separator()
			if imgui.Checkbox(string.format("%s: %s##3", config.MAIN.language == "RU" and 'Анимированные иконки' or 'Animated icons', config.MAIN.main_active), main_active_imgui) then
				config.MAIN.main_active = main_active_imgui[0]
			end

			if samp == 2 then
				imgui.Separator()
				if changecmdtext ~= "" then
					imgui.TextWrapped(""..changecmdtext)
				end
				imgui.PushItemWidth(90)
				imgui.InputTextWithHint('##Введите3', config.MAIN.command, cmdbuffer, ffi.sizeof(cmdbuffer) - 1, imgui.InputTextFlags.AutoSelectAll)
				imgui.Hint('text_tooltip', config.MAIN.language == "RU" and 'Чтобы изменить активацию введите команду без "/"' or 'To change the activation, enter the command without "/"', nil, false)
				imgui.PopItemWidth()

				imgui.SameLine(nil, 0)
				if imgui.DegradeButton(config.MAIN.language == "RU" and 'Сохранить комманду' or 'Save command', imgui.ImVec2(130, 0)) then
					sampUnregisterChatCommand(config.MAIN.command)
					config.MAIN.command = str(cmdbuffer)
					sampRegisterChatCommand(config.MAIN.command, function()
						if limgui then
							main_window[0] = not main_window[0]
						else
							main_window_noi = not main_window_noi
						end
					end)
					sampSetClientCommandDescription(config.MAIN.command, (string.format(u8:decode'Activating/deactivating the window %s, File: %s', thisScript().name, thisScript().filename)))
					savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
					if str(cmdbuffer) == nil or str(cmdbuffer) == '' or str(cmdbuffer) == ' ' or str(cmdbuffer):find('/.+') then
						changecmdtext = config.MAIN.language == "RU" and 'Поле ввода пустое или содержит символ "/"\nВведите команду без "/"' or 'Input field is empty or contains the char "/"\nEnter without "/"'
						config.MAIN.command = 'aic'
						savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
					else
						changecmdtext = ''
					end
				end
			else
				imgui.Separator()
				if changecmdtext ~= "" then
					imgui.TextWrapped(""..changecmdtext)
				end
				imgui.PushItemWidth(90)
				imgui.InputTextWithHint('##Введите4', config.MAIN.cheatcode, cmdbuffer, ffi.sizeof(cmdbuffer) - 1, imgui.InputTextFlags.AutoSelectAll)
					if imgui.IsItemHovered() then
						imgui.BeginTooltip()
						imgui.PushTextWrapPos(600)
							imgui.TextUnformatted(config.MAIN.language == "RU" and 'Чтобы изменить активацию введите команду без "/"' or 'To change the activation, enter the command without "/"')
						imgui.PopTextWrapPos()
						imgui.EndTooltip()
					end
				imgui.PopItemWidth()

				imgui.SameLine(nil, 0)
				if imgui.DegradeButton(config.MAIN.language == "RU" and 'Сохранить чит-код' or 'Save cheat-code', imgui.ImVec2(130, 0)) then

					config.MAIN.cheatcode = str(cmdbuffer)

					savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
					if str(cmdbuffer) == nil or str(cmdbuffer) == '' or str(cmdbuffer) == ' ' or str(cmdbuffer):find('/.+') then
						changecmdtext = config.MAIN.language == "RU" and 'Поле ввода пустое или содержит символ "/"\nВведите чит-код' or 'Input field is empty or contains the char "/"'
						config.MAIN.cheatcode = 'aic'
						savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
					else
						changecmdtext = ''
					end
				end
			end
			imgui.End()
		end
	)

	function imgui.Hint(str_id, hint_text, color, no_center) -- by Cosmo
		color = color or imgui.GetStyle().Colors[imgui.Col.PopupBg]
		local p_orig = imgui.GetCursorPos()
		local hovered = imgui.IsItemHovered()
		imgui.SameLine(nil, 0)

		local animTime = 0.2
		local show = true

		if not POOL_HINTS then POOL_HINTS = {} end
		if not POOL_HINTS[str_id] then POOL_HINTS[str_id] = {status = false, timer = 0} end

		if hovered then
			for k, v in pairs(POOL_HINTS) do
				if k ~= str_id and os.clock() - v.timer <= animTime  then show = false end
			end
		end

		if show and POOL_HINTS[str_id].status ~= hovered then
			POOL_HINTS[str_id].status = hovered
			POOL_HINTS[str_id].timer = os.clock()
		end

		local getContrastColor = function(col)
			local luminance = 1 - (0.299 * col.x + 0.587 * col.y + 0.114 * col.z)
			return luminance < 0.5 and imgui.ImVec4(0, 0, 0, 1) or imgui.ImVec4(1, 1, 1, 1)
		end

		local rend_window = function(alpha)
			local size = imgui.GetItemRectSize()
			local scrPos = imgui.GetCursorScreenPos()
			local DL = imgui.GetWindowDrawList()
			local center = imgui.ImVec2( scrPos.x - (size.x / 2), scrPos.y + (size.y / 2) - (alpha * 4) + 10 )
			local a = imgui.ImVec2( center.x - 7, center.y - size.y - 3 )
			local b = imgui.ImVec2( center.x + 7, center.y - size.y - 3)
			local c = imgui.ImVec2( center.x, center.y - size.y + 3 )
			local col = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(color.x, color.y, color.z, alpha))

			DL:AddTriangleFilled(a, b, c, col)
			imgui.SetNextWindowPos(imgui.ImVec2(center.x, center.y - size.y - 3), imgui.Cond.Always, imgui.ImVec2(0.5, 1.0))
			imgui.PushStyleColor(imgui.Col.PopupBg, color)
			imgui.PushStyleColor(imgui.Col.Border, color)
			imgui.PushStyleColor(imgui.Col.Text, getContrastColor(color))
			imgui.PushStyleVarVec2(imgui.StyleVar.WindowPadding, imgui.ImVec2(8, 8))
			imgui.PushStyleVarFloat(imgui.StyleVar.WindowRounding, 6)
			imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, alpha)

			local max_width = function(text)
				local result = 0
				for line in text:gmatch('[^\n]+') do
					local len = imgui.CalcTextSize(line).x
					if len > result then result = len end
				end
				return result
			end

			local hint_width = max_width(hint_text) + (imgui.GetStyle().WindowPadding.x * 2)
			imgui.SetNextWindowSize(imgui.ImVec2(hint_width, -1), imgui.Cond.Always)
			imgui.Begin('##' .. str_id, _, imgui.WindowFlags.Tooltip + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar)
				for line in hint_text:gmatch('[^\n]+') do
					if no_center then
						imgui.Text(line)
					else
						imgui.SetCursorPosX((hint_width - imgui.CalcTextSize(line).x) / 2)
						imgui.Text(line)
					end
				end
			imgui.End()

			imgui.PopStyleVar(3)
			imgui.PopStyleColor(3)
		end

		if show then
			local between = os.clock() - POOL_HINTS[str_id].timer
			if between <= animTime then
				local s = function(f)
					return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
				end
				local alpha = hovered and s(between / animTime) or s(1.00 - between / animTime)
				rend_window(alpha)
			elseif hovered then rend_window(1.00) end
		end
		imgui.SetCursorPos(p_orig)
	end

	function imgui.DegradeButton(label, size) -- by Cosmo
		local duration = {0.7, 0.2}

		local cols = {default = imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.Button]),
			hovered = imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.ButtonHovered]),
			active  = imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.ButtonActive])}

		if not FBUTPOOL then FBUTPOOL = {} end
		if not FBUTPOOL[label] then FBUTPOOL[label] = {color = cols.default, clicked = { nil, nil }, hovered = {cur = false, old = false, clock = nil,}} end

		local degrade = function(before, after, start_time, duration)
			local result_vec4 = before
			local timer = os.clock() - start_time
			if timer >= 0.00 then
				local offs = {x = after.x - before.x, y = after.y - before.y, z = after.z - before.z, w = after.w - before.w}

				result_vec4.x = result_vec4.x + ( (offs.x / duration) * timer )
				result_vec4.y = result_vec4.y + ( (offs.y / duration) * timer )
				result_vec4.z = result_vec4.z + ( (offs.z / duration) * timer )
				result_vec4.w = result_vec4.w + ( (offs.w / duration) * timer )
			end
			return result_vec4
		end

		if FBUTPOOL[label]['clicked'][1] and FBUTPOOL[label]['clicked'][2] then
			if os.clock() - FBUTPOOL[label]['clicked'][1] <= duration[2] then
				FBUTPOOL[label]['color'] = degrade(FBUTPOOL[label]['color'], cols.active, FBUTPOOL[label]['clicked'][1], duration[2])
				goto no_hovered
			end

			if os.clock() - FBUTPOOL[label]['clicked'][2] <= duration[2] then
				FBUTPOOL[label]['color'] = degrade( FBUTPOOL[label]['color'], FBUTPOOL[label]['hovered']['cur'] and cols.hovered or cols.default,FBUTPOOL[label]['clicked'][2], duration[2])
				goto no_hovered
			end
		end

		if FBUTPOOL[label]['hovered']['clock'] ~= nil then
			if os.clock() - FBUTPOOL[label]['hovered']['clock'] <= duration[1] then
				FBUTPOOL[label]['color'] = degrade( FBUTPOOL[label]['color'], FBUTPOOL[label]['hovered']['cur'] and cols.hovered or cols.default, FBUTPOOL[label]['hovered']['clock'], duration[1])
			else
				FBUTPOOL[label]['color'] = FBUTPOOL[label]['hovered']['cur'] and cols.hovered or cols.default
			end
		end

		::no_hovered::

		imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(FBUTPOOL[label]['color']))
		imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(FBUTPOOL[label]['color']))
		imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(FBUTPOOL[label]['color']))
		local result = imgui.Button(label, size or imgui.ImVec2(0, 0))
		imgui.PopStyleColor(3)

		if result then
			FBUTPOOL[label]['clicked'] = {os.clock(), os.clock() + duration[2]}
		end

		FBUTPOOL[label]['hovered']['cur'] = imgui.IsItemHovered()
		if FBUTPOOL[label]['hovered']['old'] ~= FBUTPOOL[label]['hovered']['cur'] then
			FBUTPOOL[label]['hovered']['old'] = FBUTPOOL[label]['hovered']['cur']
			FBUTPOOL[label]['hovered']['clock'] = os.clock()
		end

		return result
	end
else
	item_list = {"outline_anim"}
	offset_list = {'0.1', '0.2', '0.3', '0.4', '0.5', '1.0', '2.0', '4.0', '6.0', '8.0'}
end

function main()
	repeat wait(0) until memory.read(0xC8D4C0, 4, false) == 9

	assert(lvkeys, 'Library \'vkeys\' not found.')
	assert(lffi, 'Library \'ffi\' not found.')
	assert(lmemory, 'Library \'memory\' not found.')
	assert(lmad, 'Library \'MoonAdditions\' not found. Download: https://github.com/THE-FYP/MoonAdditions .')
	if not limgui then
		printString("Library ~y~\'mimgui\' ~r~not found.~n~~w~Download: ~y~ https://github.com/THE-FYP/mimgui.~n~~r~Copy link in~y~ moonloader.log.~n~~w~Lite menu active.", 5000)
	end
	assert(lwm, 'Library \'windows.message\' not found.')
	assert(lencoding, 'Library \'encoding\' not found.')

	samp, hud_test = 0, true

	if isSampLoaded() then samp = 1 end
	if isSampLoaded() and isSampfuncsLoaded() then samp = 2 end
	if samp == 2 then
		while not isSampAvailable() do wait(1000) end

		sampRegisterChatCommand(config.MAIN.command, function()
			if limgui then
				main_window[0] = not main_window[0]
			else
				main_window_noi = not main_window_noi
			end
		end)
		sampSetClientCommandDescription(config.MAIN.command, (string.format(u8:decode'Activating/deactivating the window %s, File: %s', thisScript().name, thisScript().filename)))
	end


	active_gun = {[0] = {["name"] ="fist_anim", ["active"] = false, ["frames"] = {}},[1] = {["name"] ="brassknuckle_anim", ["active"] = false, ["frames"] = {}}, [2] = {["name"] ="golfclub_anim", ["active"] = false, ["frames"] = {}}, [3] = {["name"] ="nitestick_anim", ["active"] = false, ["frames"] = {}}, [4] = {["name"] ="knifecur_anim", ["active"] = false, ["frames"] = {}}, [5] = {["name"] ="bat_anim", ["active"] = false, ["frames"] = {}}, [6] = {["name"] ="shovel_anim", ["active"] = false, ["frames"] = {}}, [7] = {["name"] ="poolcue_anim", ["active"] = false, ["frames"] = {}}, [8] = {["name"] ="katana_anim", ["active"] = false, ["frames"] = {}}, [9] = {["name"] ="chnsaw_anim", ["active"] = false, ["frames"] = {}}, [10] = {["name"] ="gun_dildo1_anim", ["active"] = false, ["frames"] = {}}, [11] = {["name"] ="gun_dildo2_anim", ["active"] = false, ["frames"] = {}}, [12] = {["name"] ="gun_vibe1_anim", ["active"] = false, ["frames"] = {}}, [13] = {["name"] ="gun_vibe2_anim", ["active"] = false, ["frames"] = {}}, [14] = {["name"] ="flowera_anim", ["active"] = false, ["frames"] = {}}, [15] = {["name"] ="gun_cane_anim", ["active"] = false, ["frames"] = {}}, [16] = {["name"] ="grenade_anim", ["active"] = false, ["frames"] = {}}, [17] = {["name"] ="teargas_anim", ["active"] = false, ["frames"] = {}}, [18] = {["name"] ="molotov_anim", ["active"] = false, ["frames"] = {}}, [22] = {["name"] ="colt45_anim", ["active"] = false, ["frames"] = {}}, [23] = {["name"] ="silenced_anim", ["active"] = false, ["frames"] = {}}, [24] = {["name"] ="desert_eagle_anim", ["active"] = false, ["frames"] = {}}, [25] = {["name"] ="chromegun_anim", ["active"] = false, ["frames"] = {}}, [26] = {["name"] ="sawnoff_anim", ["active"] = false, ["frames"] = {}}, [27] = {["name"] ="shotgspa_anim", ["active"] = false, ["frames"] = {}}, [28] = {["name"] ="micro_uzi_anim", ["active"] = false, ["frames"] = {}}, [29] = {["name"] ="mp5lng_anim", ["active"] = false, ["frames"] = {}}, [30] = {["name"] ="ak47_anim", ["active"] = false, ["frames"] = {}}, [31] = {["name"] ="m4_anim", ["active"] = false, ["frames"] = {}}, [32] = {["name"] ="tec9_anim", ["active"] = false, ["frames"] = {}}, [33] = {["name"] ="cuntgun_anim", ["active"] = false, ["frames"] = {}}, [34] = {["name"] ="sniper_anim", ["active"] = false, ["frames"] = {}}, [35] = {["name"] ="rocketla_anim", ["active"] = false, ["frames"] = {}}, [36] = {["name"] ="heatseek_anim", ["active"] = false, ["frames"] = {}}, [37] = {["name"] ="flame_anim", ["active"] = false, ["frames"] = {}}, [38] = {["name"] ="minigun_anim", ["active"] = false, ["frames"] = {}}, [39] = {["name"] ="satchel_anim", ["active"] = false, ["frames"] = {}}, [40] = {["name"] ="bomb_anim", ["active"] = false, ["frames"] = {}}, [41] = {["name"] ="spraycan_anim", ["active"] = false, ["frames"] = {}}, [42] = {["name"] ="fire_ex_anim", ["active"] = false, ["frames"] = {}}, [43] = {["name"] ="camera_anim", ["active"] = false, ["frames"] = {}}, [44] = {["name"] ="nvgoggles_anim", ["active"] = false, ["frames"] = {}}, [45] = {["name"] ="irgoggles_anim", ["active"] = false, ["frames"] = {}}, [46] = {["name"] ="gun_para_anim", ["active"] = false, ["frames"] = {}}}

	id_gun = {["fist_anim"] = 0, ["brassknuckle_anim"] = 1, ["golfclub_anim"] = 2, ["nitestick_anim"] = 3, ["knifecur_anim"] = 4, ["bat_anim"] = 5, ["shovel_anim"] = 6, ["poolcue_anim"] = 7, ["katana_anim"] = 8, ["chnsaw_anim"] = 9, ["gun_dildo1_anim"] = 10, ["gun_dildo2_anim"] = 11, ["gun_vibe1_anim"] = 12, ["gun_vibe2_anim"] = 13, ["flowera_anim"] = 14, ["gun_cane_anim"] = 15, ["grenade_anim"] = 16, ["teargas_anim"] = 17, ["molotov_anim"] = 18, ["colt45_anim"] = 22, ["silenced_anim"] = 23, ["desert_eagle_anim"] = 24, ["chromegun_anim"] = 25, ["sawnoff_anim"] = 26, ["shotgspa_anim"] = 27, ["micro_uzi_anim"] = 28, ["mp5lng_anim"] = 29, ["ak47_anim"] = 30, ["m4_anim"] = 31, ["tec9_anim"] = 32, ["cuntgun_anim"] = 33, ["sniper_anim"] = 34, ["rocketla_anim"] = 35, ["heatseek_anim"] = 36, ["flame_anim"] = 37, ["minigun_anim"] = 38, ["satchel_anim"] = 39, ["bomb_anim"] = 40, ["spraycan_anim"] = 41, ["fire_ex_anim"] = 42, ["camera_anim"] = 43, ["nvgoggles_anim"] = 44, ["irgoggles_anim"] = 45, ["gun_para_anim"] = 46}

	-----------txd_outline_anim----------txd_outline_anim--------------
	outline_anim = {}

	if doesFileExist("moonloader/AnimatedIconcs/Bzone/outline_anim.txd") then
		if mad.get_txd('txd_outline_anim') ~= nil then
			txd_outline_anim = mad.get_txd('txd_outline_anim')
		else
			txd_outline_anim = mad.load_txd(getWorkingDirectory() .. '//AnimatedIconcs//Bzone//outline_anim.txd', 'txd_outline_anim')
		end

		local i_texture_outline_anim = 0
		repeat
			texture_from_txd_outline_anim = txd_outline_anim:get_texture(i_texture_outline_anim)
			outline_anim[i_texture_outline_anim] = texture_from_txd_outline_anim
			i_texture_outline_anim = i_texture_outline_anim + 1
		until texture_from_txd_outline_anim == nil
		config.outline_anim.outline = true
	else
		config.outline_anim.outline = false
	end
	-----------txd_outline_anim----------txd_outline_anim---------------

	---------------------txd_anim--------------------txd_anim----------
	local mask = getWorkingDirectory() .. "//AnimatedIconcs//Bzone//*.txd"

	local handle, file = findFirstFile(mask)

	while handle and file do
		if file ~= "." and file ~= ".." and file ~= "outline_anim.txd" then

			local tdx_gsub = file:gsub(".txd", "")

			if doesFileExist("moonloader/AnimatedIconcs/Bzone/"..file) and checktable(id_gun, tdx_gsub) then
				if mad.get_txd(tdx_gsub) ~= nil then -- Проверяет наличие txd в памяти, костыль на случай перезапуска скрипта(ов)
					txd_file = mad.get_txd(tdx_gsub)
				else
					txd_file = mad.load_txd(getWorkingDirectory() .. '//AnimatedIconcs//Bzone//'..file, tdx_gsub)
				end

				local i_texture = 0
				repeat
					no_tdx = txd_file:get_texture(i_texture)
					active_gun[id_gun[tdx_gsub]].frames[i_texture] = no_tdx
					i_texture = i_texture + 1
				until no_tdx == nil

				active_gun[id_gun[tdx_gsub]].active = true
				item_list[#item_list+1] = tdx_gsub
				if limgui then
					ImItems = new['const char*'][#item_list](item_list)
				end
			else
				active_gun[id_gun[tdx_gsub]].active = false
			end
		end
		file = findNextFile(handle)
	end
	---------------------txd_anim--------------------txd_anim----------

	lua_thread.create(function() -- отдельный поток для прогона кадров обводки, если в обычный запихнуть, то будет мигать.
		i_outline_anim = 0
		while true do
			i_outline_anim = i_outline_anim + 1
			if i_outline_anim >= #outline_anim then
				wait(config.outline_anim.delay_replay_end)
				i_outline_anim = 0
				wait(config.outline_anim.delay_replay)
			end
			wait(config.outline_anim.delay)
		end
    end)

	thread_icons = lua_thread.create(function() -- отдельный поток для прогона кадров иконок
		i_delay, i_delay_replay, i_delay_replay_end, i_frames_max, i_frames = 0, 0, 0, 0, 0
		while true do
			if i_frames_max ~= 0 then
				wait(i_delay)
				i_frames = i_frames + 1
				if i_frames == i_frames_max then
					wait(i_delay_replay_end)
					i_frames = 0
					wait(i_delay_replay)
				end
			else
				i_frames = 0
				wait(i_delay)
			end

		end
    end)
	
	lua_thread.create(function() -- ещё один поток отвечающий за перезапуск потоко с прогоном кадров иконок, нужен для того чтобы не завершенное ожидание сбрасывалось при смене оружия, иначе прогон кадров ждал завершения wait от предыдущего оружия
		gCCW = 0
		while true do wait(0)
			if getCurrentCharWeapon(PLAYER_PED) ~= gCCW then
				i_delay, i_delay_replay, i_delay_replay_end, i_frames_max, i_frames = 0, 0, 0, 0, 0
				gCCW = getCurrentCharWeapon(PLAYER_PED)
				thread_icons:run()
			end
		end
	end)

	lua_thread.create(function() -- отдельный поток для скрытия иконок
		while true do
			local currentGun = getCurrentCharWeapon(PLAYER_PED)
			if not config.MAIN.standard_icons and active_gun[currentGun].active and config.MAIN.main_active then
				memory.fill(0x58D7D0, 0xC3, 1, false) -- Выключить иконки.
			else
				memory.fill(0x58D7D0, 0xA1, 1, false) -- Включить иконки.
			end
			wait(0)
		end
    end)

	pos_active_thread = lua_thread.create_suspended(function() -- отдельный поток настройки позиции обводки/иконки
		posx_mouse, posy_mouse = 325.0, 225.0
		while true do wait(0)
			if pos_active then
				posx_mouse_Pc, posy_mouse_PC = getPcMouseMovement()
				posx_mouse = posx_mouse + posx_mouse_Pc
				posy_mouse = posy_mouse + -posy_mouse_PC
				if posx_mouse > 640.0 then posx_mouse= 600.0 end
				if -50.0 > posx_mouse then posx_mouse = 0.0 end
				if posy_mouse > 448.0 then posy_mouse = 408.0 end
				if -50.0 > posy_mouse then posy_mouse = 0.0 end

				setPlayerControl(PLAYER_HANDLE, false)

				printStringNow("Press ~y~ENTER ~w~to save~n~Press ~y~ARROW ~w~edit size~n~Scroll ~y~WheelMouse ~w~total size.", 0)

				local currentGun = getCurrentCharWeapon(PLAYER_PED)

				config.outline_anim.posX, config.outline_anim.posY = posx_mouse, posy_mouse
				config[''..active_gun[currentGun].name].posX, config[''..active_gun[currentGun].name].posY = posx_mouse, posy_mouse
				local delta = getMousewheelDelta()
				config.outline_anim.posW, config.outline_anim.posH = (config.outline_anim.posW + (delta)), (config.outline_anim.posH + (delta))
				config[''..active_gun[currentGun].name].posW, config[''..active_gun[currentGun].name].posH = (config[''..active_gun[currentGun].name].posW + (delta)), (config[''..active_gun[currentGun].name].posH + (delta))
				if isKeyDown(vkeys.VK_LEFT) then
					config.outline_anim.posW = config.outline_anim.posW - 0.1
					config[''..active_gun[currentGun].name].posW = config[''..active_gun[currentGun].name].posW - 0.1
				end
				if isKeyDown(vkeys.VK_UP) then
					config.outline_anim.posH = config.outline_anim.posH - 0.1
					config[''..active_gun[currentGun].name].posH = config[''..active_gun[currentGun].name].posH - 0.1
				end
				if isKeyDown(vkeys.VK_RIGHT) then
					config.outline_anim.posW = config.outline_anim.posW + 0.1
					config[''..active_gun[currentGun].name].posW = config[''..active_gun[currentGun].name].posW + 0.1
				end
				if isKeyDown(vkeys.VK_DOWN) then
					config.outline_anim.posH = config.outline_anim.posH + 0.1
					config[''..active_gun[currentGun].name].posH = config[''..active_gun[currentGun].name].posH + 0.1
				end
				if isKeyDown(vkeys.VK_RETURN) then
					if samp == 2 then
						sampAddChatMessage(u8:decode"Сохранено.", -1)
					else
						printString("~y~SAVED", 1000)
					end
					for k, v in pairs(config) do
						if k ~= "MAIN" then
							v.posX = config.outline_anim.posX
							v.posY = config.outline_anim.posY
							v.posW = config.outline_anim.posW
							v.posH = config.outline_anim.posH
						end
					end
					savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
					setPlayerControl(PLAYER_HANDLE, true)
					if limgui then main_window[0] = true else main_window_noi = true end
					pos_active = false
					pos_active_thread:terminate()
				end
			end
		end
	end)

	if not limgui then
		lua_thread.create(function() -- отдельный поток для мышки и настроек, если нету mimgui

			mouse = renderLoadTextureFromFileInMemory(memory.strptr(_mouse), #_mouse)
			logo_test = renderLoadTextureFromFileInMemory(memory.strptr(_logo), #_logo)
			sizeX_logo, sizeY_logo = renderGetTextureSize(logo_test)
			x_mouse, y_mouse = 325.0, 225.0

			test1, test3, keyslist = 1, 6, ""
			test2, test4 = item_list[test1], offset_list[test3]

			while true do wait(0)
				if main_window_noi and not isPauseMenuActive() then

					setPlayerControl(PLAYER_HANDLE, false)

					x_mouse_Pc, y_mouse_PC = getPcMouseMovement()
					x_mouse = x_mouse + x_mouse_Pc
					y_mouse = y_mouse + -y_mouse_PC
					if x_mouse > 640.0 then	x_mouse= 640.0 end
					if 0.0 > x_mouse then x_mouse = 0.0 end
					if y_mouse > 448.0 then y_mouse = 448.0 end
					if 0.0 > y_mouse then y_mouse = 0.0 end

					renderDrawTexture(mouse, convert(x_mouse)[1], convert(y_mouse)[2], 32, 32, 0, -1)

					mad.draw_rect(convert(500)[1], convert(135)[2], convert(600)[1], convert(305)[2], 64, 64, 64, 174)

					if drawClickableText(config.MAIN.language == "RU" and "~h~RU / ~w~EN" or "~w~RU / ~h~EN", 517, 151, 0.5, 1.0, 255, 255,  20, 8) then
						if config.MAIN.language == "RU" then config.MAIN.language = "EN" else config.MAIN.language = "RU" end
						savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
					end

					if drawClickableText("X", 596, 135, 1.0, 1.0, 64, 255, 5, 8) then
						main_window_noi = false
						clearThisPrintBigNow(4)
						setPlayerControl(PLAYER_HANDLE, true)
					end

					renderDrawTexture(logo_test, convert(507.5)[1], convert(135)[2], sizeX_logo, sizeY_logo, 0, -1)

					if drawClickableText("<-", 520, 165, _, _, 155, 255, 5, 5) then
						test1 = test1 - 1
						test2 = item_list[test1]
						if test1 <= 0 then
							test1 = #item_list
							test2 = item_list[test1]
						end
						if hasCharGotWeapon(PLAYER_PED, id_gun[test2]) then setCurrentCharWeapon(PLAYER_PED, id_gun[test2]) end
					end
					if drawClickableText(""..test2:gsub("_anim", ""), 550, 165, _, _, 155, 255, 10, 5) then
						-- local text = ""
						-- for i, v in pairs(item_list) do
							-- text = text..""..v:gsub("_anim", "").."~n~"
						-- end
						-- printStyledString(text, 2000, 4)
					end
					if drawClickableText("->", 580, 165, _, _, 155, 255, 5, 5) then
						test1 = test1 + 1
						test2 = item_list[test1]
						if test1 >= #item_list + 1 then
							test1 = 1
							test2 = item_list[test1]
						end
						if hasCharGotWeapon(PLAYER_PED, id_gun[test2]) then setCurrentCharWeapon(PLAYER_PED, id_gun[test2]) end
					end

					if drawClickableText("-", 507, 178, 0.8, 0.8, 155, 255, 5, 5) then
						test3 = test3 - 1
						test4 = offset_list[test3]
						if test3 <= 0 then
							test3 = #offset_list
							test4 = offset_list[test3]
						end
					end
					if drawClickableText(test4.."~n~"..(config.MAIN.language == "RU" and RusToGame(u8:decode'Смещение') or 'Offset'), 520, 176, 0.4, 0.8, 155, 255, 5, 8) then
						local text = ""
						for i, v in pairs(offset_list) do
							text = text..""..v.."~n~"
						end
						printStyledString(text, 1000, 4)

					end
					if drawClickableText("+", 533, 178, 0.8, 0.8, 155, 255, 5, 5) then
						test3 = test3 + 1
						test4 = offset_list[test3]
						if test3 >= #offset_list + 1 then
							test3 = 1
							test4 = offset_list[test3]
						end
					end

					if drawClickableText((config[''..test2].outline and (config.MAIN.language == "RU" and RusToGame(u8:decode'Обводка~n~ON') or 'Outline~n~ON') or (config.MAIN.language == "RU" and RusToGame(u8:decode'Обводка~n~OFF') or 'Outline~n~OFF')), 550, 176, 0.4, 0.8, 155, 255, 15, 10) then
						config[''..test2].outline = not config[''..test2].outline
						savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
					end

					if drawClickableText((config[''..test2].foreground and (config.MAIN.language == "RU" and RusToGame(u8:decode'Поверх~n~обводки~n~ON') or 'Foreground~n~ON') or (config.MAIN.language == "RU" and RusToGame(u8:decode'Поверх~n~обводки~n~OFF') or 'Foreground~n~OFF')), 578, 176, (config.MAIN.language == "RU" and 0.4 or 0.4), (config.MAIN.language == "RU" and 0.6 or 0.8), 155, 255, 15, 10) then
						config[''..test2].foreground = not config[''..test2].foreground
						savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
					end

					if drawClickableText("X1+", 520, 190, _, _, 155, 255, 10, 5, true, 1, test2) then
						config[''..test2].customX1 = config[''..test2].customX1 + offset_list[test3]
					end
					if drawClickableText("X2+", 540, 190, _, _, 155, 255, 10, 8, true, 2, test2) then
						config[''..test2].customX2 = config[''..test2].customX2 + offset_list[test3]
					end
					if drawClickableText("Y1+", 560, 190, _, _, 155, 255, 10, 8, true, 3, test2) then
						config[''..test2].customY1 = config[''..test2].customY1 + offset_list[test3]
					end
					if drawClickableText("Y2+", 580, 190, _, _, 155, 255, 10, 8, true, 4, test2) then
						config[''..test2].customY2 = config[''..test2].customY2 + offset_list[test3]
					end

					if drawClickableText("X1-", 520, 200, _, _, 155, 255, 10, 8, true, 5, test2) then
						config[''..test2].customX1 = config[''..test2].customX1 - offset_list[test3]
					end
					if drawClickableText("X2-", 540, 200, _, _, 155, 255, 10, 8, true, 6, test2) then
						config[''..test2].customX2 = config[''..test2].customX2 - offset_list[test3]
					end
					if drawClickableText("Y1-", 560, 200, _, _, 155, 255, 10, 8, true, 7, test2) then
						config[''..test2].customY1 = config[''..test2].customY1 - offset_list[test3]
					end
					if drawClickableText("Y2-", 580, 200, _, _, 155, 255, 10, 8, true, 8, test2) then
						config[''..test2].customY2 = config[''..test2].customY2 - offset_list[test3]
					end

					mad.draw_rect(convert(507)[1], convert(212)[2], convert(532)[1], convert(223)[2], 10, 10, 10, 155)
					if not draw_delay then
						if drawClickableText(""..config[''..test2].delay, 519, 214, 0.4, 0.8, 155, 255, 10, 8) then
							draw_delay = true
							draw_delay_replay = false
							draw_delay_replay_end = false
						end
					end

					mad.draw_rect(convert(537)[1], convert(212)[2], convert(562)[1], convert(223)[2], 10, 10, 10, 155)
					if not draw_delay_replay then
						if drawClickableText(""..config[''..test2].delay_replay, 549.5, 214, 0.4, 0.8, 155, 255, 10, 8) then
							draw_delay = false
							draw_delay_replay = true
							draw_delay_replay_end = false
						end
					end

					mad.draw_rect(convert(567)[1], convert(212)[2], convert(592)[1], convert(223)[2], 10, 10, 10, 155)
					if not draw_delay_replay_end then
						if drawClickableText(""..config[''..test2].delay_replay_end, 579.5, 214, 0.4, 0.8, 155, 255, 10, 8) then
							draw_delay = false
							draw_delay_replay = false
							draw_delay_replay_end = true
						end
					end

					if draw_delay or draw_delay_replay or draw_delay_replay_end then
					for k, v in pairs(vkeys) do
							if wasKeyPressed(v) then
								if v == vkeys.VK_1 or v == vkeys.VK_2 or v == vkeys.VK_3 or v == vkeys.VK_4 or v == vkeys.VK_5 or v == vkeys.VK_6 or v == vkeys.VK_7 or v == vkeys.VK_8 or v == vkeys.VK_9 or v == vkeys.VK_0 or
								v == vkeys.VK_NUMPAD0 or v == vkeys.VK_NUMPAD1 or v == vkeys.VK_NUMPAD2 or v == vkeys.VK_NUMPAD3 or v == vkeys.VK_NUMPAD4 or v == vkeys.VK_NUMPAD5 or v == vkeys.VK_NUMPAD6 or v == vkeys.VK_NUMPAD7 or v == vkeys.VK_NUMPAD8 or v == vkeys.VK_NUMPAD9 then
									keyslist = keyslist .. "" .. vkeys.id_to_name(v):gsub("Numpad ", "")
								end
							end
						end

						if wasKeyPressed(vkeys.VK_RETURN) then
							if keyslist == nil or keyslist == "" then
								if draw_delay then
									config[''..test2].delay = 0
								elseif draw_delay_replay then
									config[''..test2].delay_replay = 0
								elseif draw_delay_replay_end then
									config[''..test2].delay_replay = 0
								end
							else
								if draw_delay then
									config[''..test2].delay = tonumber(keyslist)
								elseif draw_delay_replay then
									config[''..test2].delay_replay = tonumber(keyslist)
								elseif draw_delay_replay_end then
									config[''..test2].delay_replay_end = tonumber(keyslist)
								end
							end
							keyslist = ""
							draw_delay = false
							draw_delay_replay = false
							draw_delay_replay_end = false
						end
						if wasKeyPressed(vkeys.VK_ESC) then
							keyslist = ""
							draw_delay = false
							draw_delay_replay = false
							draw_delay_replay_end = false
						end
						if draw_delay then
							printStringNow_text = config.MAIN.language == "RU" and RusToGame(u8:decode'~n~ ~y~Активно: ~w~Задержка между кадрами') or '~n~ ~y~ACTIVE: ~w~Delay between frames'
						elseif draw_delay_replay then
							printStringNow_text = config.MAIN.language == "RU" and RusToGame(u8:decode'~n~ ~y~Активно: ~w~Задержка перед началом анимации') or '~n~ ~y~ACTIVE: ~w~Delay before animation starts'
						elseif draw_delay_replay_end then
							printStringNow_text = config.MAIN.language == "RU" and RusToGame(u8:decode'~n~ ~y~Активно: ~w~Задержка по окончанию анимации') or '~n~ ~y~ACTIVE: ~w~Delay at end animation'
						end
						printStringNow((config.MAIN.language == "RU" and RusToGame(u8:decode'Нажмите ~y~ENTER~w~, чтобы сохранить значение ~n~Нажмите ~y~ESC~w~, чтобы отменить ввод.') or 'Press ~y~ENTER ~w~to save the value~n~Press ~y~ESC ~w~to cancel the input.') .. printStringNow_text, 0)

						if wasKeyPressed(vkeys.VK_BACK) then
							keyslist = keyslist:sub(1, -2)
						end
						if draw_delay then
							drawClickableText(""..keyslist, 519, 214, 0.4, 0.8, 155, 255, 10, 8)
						elseif draw_delay_replay then
							drawClickableText(""..keyslist, 549.5, 214, 0.4, 0.8, 155, 255, 10, 8)
						elseif draw_delay_replay_end then
							drawClickableText(""..keyslist, 579.5, 214, 0.4, 0.8, 155, 255, 10, 8)
						end
					end

					if drawClickableText(config.MAIN.language == "RU" and RusToGame(u8:decode'Сохранить') or 'Save', 530, 226.5,0.6, 1.2, 155, 255,  10, 8) then
						savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
					end
					if drawClickableText(config.MAIN.language == "RU" and RusToGame(u8:decode'Сброс') or 'Reset', 570, 226.5, 0.6, 1.2, 155, 255, 10, 8) then
						config[''..test2].customX1 = 0
						config[''..test2].customX2 = 0
						config[''..test2].customY1 = 0
						config[''..test2].customY2 = 0
						config[''..test2].delay = 0
						config[''..test2].delay_replay = 0
						config[''..test2].delay_replay_end = 0
					end

					mad.draw_rect(convert(502)[1], convert(240)[2], convert(598)[1], convert(284.5)[2], 47, 47, 47, 147)

					drawClickableText(config.MAIN.language == "RU" and RusToGame(u8:decode'~w~Настройки положения') or '~w~Position Settings', 550, 237, 0.4, 0.8, 147, 147,  20, 8)

					if drawClickableText(config.MAIN.language == "RU" and RusToGame(u8:decode'~h~Ручная позиция') or '~h~Manual position', 550, 245, 0.47, 1.0, 255, 200, 20, 8) then
						main_window_noi = false
						pos_active = true
						pos_active_thread:run()
					end

					if drawClickableText(config.MAIN.language == "RU" and RusToGame(u8:decode'~h~Стандартная позиция') or '~h~Standard position', 550, 254, 0.47, 1.0, 255, 200, 20, 8) then
						for k, v in pairs(config) do
							if k ~= "MAIN" then
								v.posX = currentXYWH("standard").x
								v.posY = currentXYWH("standard").y
								v.posW = currentXYWH("standard").w
								v.posH = currentXYWH("standard").h
							end
						end
						savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
					end

					if drawClickableText("~w~sa_widescreenfix_lite.asi/ThirteenAG", 550, 264, 0.47, 1.0, 255, 200, 20, 8) then
						for k, v in pairs(config) do
							if k ~= "MAIN" then
								v.posX = currentXYWH("widescreen").x
								v.posY = currentXYWH("widescreen").y
								v.posW = currentXYWH("widescreen").w
								v.posH = currentXYWH("widescreen").h
							end
						end
						savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
					end

					if drawClickableText("~w~Widescreen ThirteenAG + Wesser", 550, 274, 0.4, 1.1, 255, 200, 20, 8) then
						for k, v in pairs(config) do
							if k ~= "MAIN" then
								v.posX = currentXYWH("widescreen_Wesser").x
								v.posY = currentXYWH("widescreen_Wesser").y
								v.posW = currentXYWH("widescreen_Wesser").w
								v.posH = currentXYWH("widescreen_Wesser").h
							end
						end
						savejson(convertTableToJsonString(config), "moonloader/AnimatedIconcs/Bzone/AnimatedIconcs.json")
					end

					if drawClickableText(config.MAIN.language == "RU" and RusToGame(u8:decode'Стандартные иконки: '..tostring(config.MAIN.standard_icons)) or 'Standard icons: '..tostring(config.MAIN.standard_icons), 550, 285, 0.5, 1.0, (config.MAIN.standard_icons and 255 or 64), (config.MAIN.standard_icons and 255 or 64), 25, 8) then config.MAIN.standard_icons = not config.MAIN.standard_icons end

					if drawClickableText(config.MAIN.language == "RU" and RusToGame(u8:decode'Анимированные иконки: '..tostring(config.MAIN.main_active)) or 'Animated icons: '..tostring(config.MAIN.main_active), 550, 294, 0.47, 1.0, (config.MAIN.main_active and 255 or 64), (config.MAIN.main_active and 255 or 64),  20, 8) then config.MAIN.main_active = not config.MAIN.main_active end
				else
					x_mouse = 325.0
					y_mouse = 225.0
				end
			end
		end)
	end
	files = {}
	local time = get_file_modify_time(string.format("%s/AnimatedIconcs/Bzone/AnimatedIconcs.json",getWorkingDirectory()))
	if time ~= nil then
	  files[string.format("%s/AnimatedIconcs/Bzone/AnimatedIconcs.json",getWorkingDirectory())] = time
	end
	lua_thread.create(function() -- отдельный поток для проверки изменений конфига
		files_check_window = true
		while true do wait(274)
			if limgui then files_check_window = main_window[0] else files_check_window = main_window_noi end
			if files ~= nil and not files_check_window and not pos_active then  -- by FYP
				for fpath, saved_time in pairs(files) do
					local file_time = get_file_modify_time(fpath)
					if file_time ~= nil and (file_time[1] ~= saved_time[1] or file_time[2] ~= saved_time[2]) then
						print('Reloading "' .. thisScript().name .. '"...')
						thisScript():reload()
						files[fpath] = file_time -- update time
					end
				end
			end
		end
	end)

	while true do -- main
		if samp == 0 or samp == 1 then
			if testCheat(config.MAIN.cheatcode) then
				if limgui then main_window[0] = not main_window[0] else main_window_noi = not main_window_noi end
			end

			if samp == 1 then hud_test = fixed_camera_to_skin() end -- test

			if samp == 0 and hasCutsceneLoaded() then active = false else active = true end
		end

		if samp == 2 then
			if sampGetGamestate() == 3 then active = true else active = false end
			hud_test = fixed_camera_to_skin()
		end

		local radar = memory.getint8(0xBA6769)
		local radar2 = memory.getint8(0xBAA3FB)
		local hud = memory.getint8(0xA444A0)

		if config.MAIN.main_active and active and hud == 1 and hud_test and radar == 1 and not isPauseMenuActive() and radar2 == 0 then

			local currentGun = getCurrentCharWeapon(PLAYER_PED)

			if config.outline_anim.outline and active_gun[currentGun].active and config[''..active_gun[currentGun].name].foreground and config[''..active_gun[currentGun].name].outline then
				display_texture(outline_anim[i_outline_anim], convert(config.outline_anim.posX + config.outline_anim.customX1)[1], convert(config.outline_anim.posY + config.outline_anim.customY1)[2], convert((config.outline_anim.posX + config.outline_anim.posW) + config.outline_anim.customX2)[1], convert((config.outline_anim.posY + config.outline_anim.posH) + config.outline_anim.customY2)[2]) -- обводка
			end

			if active_gun[currentGun].active then
				i_frames_max = #active_gun[currentGun].frames
				i_delay = config[''..active_gun[currentGun].name].delay
				i_delay_replay = config[''..active_gun[currentGun].name].delay_replay
				i_delay_replay_end = config[''..active_gun[currentGun].name].delay_replay_end

				display_texture(active_gun[currentGun].frames[i_frames], convert(config[''..active_gun[currentGun].name].posX + config[''..active_gun[currentGun].name].customX1)[1], convert(config[''..active_gun[currentGun].name].posY + config[''..active_gun[currentGun].name].customY1)[2], convert((config[''..active_gun[currentGun].name].posX + config[''..active_gun[currentGun].name].posW) + config[''..active_gun[currentGun].name].customX2)[1], convert((config[''..active_gun[currentGun].name].posY + config[''..active_gun[currentGun].name].posH) + config[''..active_gun[currentGun].name].customY2)[2])
			end
			if config.outline_anim.outline and active_gun[currentGun].active and not config[''..active_gun[currentGun].name].foreground and config[''..active_gun[currentGun].name].outline then
				display_texture(outline_anim[i_outline_anim], convert(config.outline_anim.posX + config.outline_anim.customX1)[1], convert(config.outline_anim.posY + config.outline_anim.customY1)[2], convert((config.outline_anim.posX + config.outline_anim.posW) + config.outline_anim.customX2)[1], convert((config.outline_anim.posY + config.outline_anim.posH) + config.outline_anim.customY2)[2]) -- обводка
			end
		else
			memory.fill(0x58D7D0, 0xA1, 1, true)
		end
		wait(0)
	end
end

function fixed_camera_to_skin() -- проверка на приклепление камеры к скину
	return (memory.read(getModuleHandle('gta_sa.exe') + 0x76F053, 1, false) >= 1 and true or false)
end

function checktable(t, str)
	for k, v in pairs(t) do
		if k == str then return true end
	end
	return false
end

function get_file_modify_time(path) -- by FYP
	local handle = ffi.C.CreateFileA(path,
		0x80000000, -- GENERIC_READ
		0x00000001 + 0x00000002, -- FILE_SHARE_READ | FILE_SHARE_WRITE
		nil,
		3, -- OPEN_EXISTING
		0x00000080, -- FILE_ATTRIBUTE_NORMAL
		nil)
	local filetime = ffi.new('FILETIME[3]')
	if handle ~= -1 then
		local result = ffi.C.GetFileTime(handle, filetime, filetime + 1, filetime + 2)
		ffi.C.CloseHandle(handle)
		if result ~= 0 then
			return {tonumber(filetime[2].dwLowDateTime), tonumber(filetime[2].dwHighDateTime)}
		end
	end
	return nil
end

function display_texture(tex, x, y, x2, y2, r, g, b, a, angle)
	if tex ~= nil then
		tex:draw(x, y, x2, y2, r, g, b, a, angle)
	else
		i_frames = 0
	end
end

function draw_text(str, x, y)
	mad.draw_text(str, x, y, mad.font_style.MENU, 0.47, 0.47 * 2, mad.font_align.CENTER, 100, true, true, 255, 255, 255, 255, 1, 0, 30, 30, 30, false, 0, 0, 0, 0)
end

function drawClickableText(text, posX, posY, sizeX, sizeY, a1, a2, offsetX, offsetY, bool, int, int2)
	if bool ~= true then bool = false end
	if sizeX ~= tonumber("%d+") or sizeY ~= tonumber("%d+") then
		local sizeX = 0.47
		local sizeY = 0.47 * 2
	end
	if a1 ~= tonumber("%d+") or a2 ~= tonumber("%d+") then
		local a1 = 155
		local a2 = 255
	end
	if x_mouse >= posX - offsetX and x_mouse <= posX + offsetX and y_mouse >= posY and y_mouse <= posY + offsetY then
	mad.draw_text(text, convert(posX)[1], convert(posY)[2], mad.font_style.SUBTITLES, sizeX, sizeY, mad.font_align.CENTER, 1000, true, true, 255, 255, 255, a1, 1, 0, 30, 30, 30, false, 0, 0, 0, 0)

	if bool then
		if int == 1 then
			draw_text("X1+ "..config[''..int2].customX1, convert(config[''..int2].posX + config[''..int2].customX1 - 12)[1], convert((config[''..int2].posY + config[''..int2].customY1 / 2) + config[''..int2].posY + config[''..int2].customY1)[2])
		end
		if int == 2 then
			draw_text("X2+ "..config[''..int2].customX2, convert(14 + (config[''..int2].posX + config[''..int2].posW) + config[''..int2].customX2)[1], convert((config[''..int2].posY + config[''..int2].customY1 / 2) + config[''..int2].posY + config[''..int2].customY1)[2])
		end
		if int == 3 then
			draw_text("Y1+ "..config[''..int2].customY1, convert(config[''..int2].posX + config[''..int2].customX1 + (config[''..int2].posW / 2))[1], convert(config[''..int2].posY + config[''..int2].customY1 - 7)[2])
		end
		if int == 4 then
			draw_text("Y2+ "..config[''..int2].customY2, convert(config[''..int2].posX + config[''..int2].customX1 + (config[''..int2].posW / 2))[1], convert((config[''..int2].posY + config[''..int2].posH) + config[''..int2].customY2)[2])
		end
		if int == 5 then
			draw_text("X1- "..config[''..int2].customX1, convert(config[''..int2].posX + config[''..int2].customX1 - 12)[1], convert((config[''..int2].posY + config[''..int2].customY1 / 2) + config[''..int2].posY + config[''..int2].customY1)[2])
		end
		if int == 6 then
			draw_text("X2- "..config[''..int2].customX2, convert(14 + (config[''..int2].posX + config[''..int2].posW) + config[''..int2].customX2)[1], convert((config[''..int2].posY + config[''..int2].customY1 / 2) + config[''..int2].posY + config[''..int2].customY1)[2])
		end
		if int == 7 then
			draw_text("Y1- "..config[''..int2].customY1, convert(config[''..int2].posX + config[''..int2].customX1 + (config[''..int2].posW / 2))[1], convert(config[''..int2].posY + config[''..int2].customY1 - 8)[2])
		end
		if int == 8 then
			draw_text("Y2- "..config[''..int2].customY2, convert(config[''..int2].posX + config[''..int2].customX1 + (config[''..int2].posW / 2))[1], convert((config[''..int2].posY + config[''..int2].posH) + config[''..int2].customY2)[2])
		end
	end

		if wasKeyPressed(1) then
			mad.draw_text(text, convert(posX)[1], convert(posY)[2], mad.font_style.SUBTITLES, sizeX, sizeY, mad.font_align.CENTER, 1000, true, true, 255, 255, 255, a2, 1, 0, 30, 30, 30, false, 0, 0, 0, 0)
			return true
		end
	else
		mad.draw_text(text, convert(posX)[1], convert(posY)[2], mad.font_style.SUBTITLES, sizeX, sizeY, mad.font_align.CENTER, 1000, true, true, 255, 255, 255, a2, 1, 0, 30, 30, 30, false, 0, 0, 0, 0)
	end
end

function RusToGame(text)
    local convtbl = {[230]=155,[231]=159,[247]=164,[234]=107,[250]=144,[251]=168,[254]=171,[253]=170,[255]=172,[224]=97,[240]=112,[241]=99,[226]=162,[228]=154,[225]=151,[227]=153,[248]=165,[243]=121,[184]=101,[235]=158,[238]=111,[245]=120,[233]=157,[242]=166,[239]=163,[244]=63,[237]=174,[229]=101,[246]=160,[236]=175,[232]=156,[249]=161,[252]=169,[215]=141,[202]=75,[204]=77,[220]=146,[221]=147,[222]=148,[192]=65,[193]=128,[209]=67,[194]=139,[195]=130,[197]=69,[206]=79,[213]=88,[168]=69,[223]=149,[207]=140,[203]=135,[201]=133,[199]=136,[196]=131,[208]=80,[200]=133,[198]=132,[210]=143,[211]=89,[216]=142,[212]=129,[214]=137,[205]=72,[217]=138,[218]=167,[219]=145}
    local result = {}
    for i = 1, #text do
        local c = text:byte(i)
        result[i] = string.char(convtbl[c] or c)
    end
    return table.concat(result)
end

function convert(xy)
	local gposX, gposY = convertGameScreenCoordsToWindowScreenCoords(xy, xy)
	return {gposX, gposY}
end

function currentXYWH(arg)
	if arg == "widescreen" then  -- ffi by kin4stat
		ccitable = {}
		ccitable["x"] = 640 - (ffi.cast("float**", 0x58F925 + 2)[0][0] + 63.5)
		ccitable["y"] = (ffi.cast("float**", 0x58F911 + 2)[0][0] - 5)
		ccitable["w"] = ffi.cast("float**", 0x58D933 + 2)[0][0] - 15.5
		ccitable["h"] = ffi.cast("float**", 0x58D94B + 2)[0][0] - 12.5
		return ccitable
	elseif arg == "widescreen_Wesser" then
		ccitable = {}
		ccitable["x"] = 640 - (ffi.cast("float**", 0x58F925 + 2)[0][0] - 51)
		ccitable["y"] = (ffi.cast("float**", 0x58F911 + 2)[0][0] - 4.5)
		ccitable["w"] = ffi.cast("float**", 0x58D933 + 2)[0][0] - 16.7
		ccitable["h"] = ffi.cast("float**", 0x58D94B + 2)[0][0] - 11.5
		return ccitable
	elseif arg == "standard" then
		ccitable = {}
		ccitable["x"] = 640 - (ffi.cast("float**", 0x58F925 + 2)[0][0] + 111)
		ccitable["y"] = (ffi.cast("float**", 0x58F911 + 2)[0][0])
		ccitable["w"] = ffi.cast("float**", 0x58D933 + 2)[0][0]
		ccitable["h"] = ffi.cast("float**", 0x58D94B + 2)[0][0]
		return ccitable
	end
end

function onWindowMessage(msg, wparam, lparam)
	if limgui then
		if msg == wm.WM_KEYDOWN and wparam == 0x1B and main_window[0] then
			main_window[0] = false
			consumeWindowMessage(true, false)
		end
	else
		if msg == wm.WM_KEYDOWN and wparam == 0x1B and main_window_noi and not draw_delay and not draw_delay_replay and not draw_delay_replay_end then
			main_window_noi = false
			setPlayerControl(PLAYER_HANDLE, true)
			consumeWindowMessage(true, false)
		end
		if msg == wm.WM_KEYDOWN and wparam == 0x1B and main_window_noi and (draw_delay or draw_delay_replay or draw_delay_replay_end) then
			draw_delay = false
			draw_delay_replay = false
			draw_delay_replay_end = false
			keyslist = ""
			consumeWindowMessage(true, false)
		end
	end
end

function onScriptTerminate(LuaScript, quitGame)
    if LuaScript == thisScript() and not quitGame then
		if not lmad then
			printString("Library ~y~\'MoonAdditions\' ~r~not found.~n~~w~Download: ~y~ https://github.com/THE-FYP/MoonAdditions.~n~~r~Copy link in~y~ moonloader.log", 5000)
		end
		setPlayerControl(PLAYER_HANDLE, true)
		memory.fill(0x58D7D0, 0xA1, 1, true)
	end
end

_close ="\x89\x50\x4E\x47\x0D\x0A\x1A\x0A\x00\x00\x00\x0D\x49\x48\x44\x52\x00\x00\x00\x21\x00\x00\x00\x21\x08\x06\x00\x00\x00\x57\xE4\xC2\x6F\x00\x00\x00\x09\x70\x48\x59\x73\x00\x00\x06\xEC\x00\x00\x06\xEC\x01\x1E\x75\x38\x35\x00\x00\x04\xE8\x69\x54\x58\x74\x58\x4D\x4C\x3A\x63\x6F\x6D\x2E\x61\x64\x6F\x62\x65\x2E\x78\x6D\x70\x00\x00\x00\x00\x00\x3C\x3F\x78\x70\x61\x63\x6B\x65\x74\x20\x62\x65\x67\x69\x6E\x3D\x22\xEF\xBB\xBF\x22\x20\x69\x64\x3D\x22\x57\x35\x4D\x30\x4D\x70\x43\x65\x68\x69\x48\x7A\x72\x65\x53\x7A\x4E\x54\x63\x7A\x6B\x63\x39\x64\x22\x3F\x3E\x20\x3C\x78\x3A\x78\x6D\x70\x6D\x65\x74\x61\x20\x78\x6D\x6C\x6E\x73\x3A\x78\x3D\x22\x61\x64\x6F\x62\x65\x3A\x6E\x73\x3A\x6D\x65\x74\x61\x2F\x22\x20\x78\x3A\x78\x6D\x70\x74\x6B\x3D\x22\x41\x64\x6F\x62\x65\x20\x58\x4D\x50\x20\x43\x6F\x72\x65\x20\x36\x2E\x30\x2D\x63\x30\x30\x36\x20\x37\x39\x2E\x64\x61\x62\x61\x63\x62\x62\x2C\x20\x32\x30\x32\x31\x2F\x30\x34\x2F\x31\x34\x2D\x30\x30\x3A\x33\x39\x3A\x34\x34\x20\x20\x20\x20\x20\x20\x20\x20\x22\x3E\x20\x3C\x72\x64\x66\x3A\x52\x44\x46\x20\x78\x6D\x6C\x6E\x73\x3A\x72\x64\x66\x3D\x22\x68\x74\x74\x70\x3A\x2F\x2F\x77\x77\x77\x2E\x77\x33\x2E\x6F\x72\x67\x2F\x31\x39\x39\x39\x2F\x30\x32\x2F\x32\x32\x2D\x72\x64\x66\x2D\x73\x79\x6E\x74\x61\x78\x2D\x6E\x73\x23\x22\x3E\x20\x3C\x72\x64\x66\x3A\x44\x65\x73\x63\x72\x69\x70\x74\x69\x6F\x6E\x20\x72\x64\x66\x3A\x61\x62\x6F\x75\x74\x3D\x22\x22\x20\x78\x6D\x6C\x6E\x73\x3A\x78\x6D\x70\x3D\x22\x68\x74\x74\x70\x3A\x2F\x2F\x6E\x73\x2E\x61\x64\x6F\x62\x65\x2E\x63\x6F\x6D\x2F\x78\x61\x70\x2F\x31\x2E\x30\x2F\x22\x20\x78\x6D\x6C\x6E\x73\x3A\x64\x63\x3D\x22\x68\x74\x74\x70\x3A\x2F\x2F\x70\x75\x72\x6C\x2E\x6F\x72\x67\x2F\x64\x63\x2F\x65\x6C\x65\x6D\x65\x6E\x74\x73\x2F\x31\x2E\x31\x2F\x22\x20\x78\x6D\x6C\x6E\x73\x3A\x70\x68\x6F\x74\x6F\x73\x68\x6F\x70\x3D\x22\x68\x74\x74\x70\x3A\x2F\x2F\x6E\x73\x2E\x61\x64\x6F\x62\x65\x2E\x63\x6F\x6D\x2F\x70\x68\x6F\x74\x6F\x73\x68\x6F\x70\x2F\x31\x2E\x30\x2F\x22\x20\x78\x6D\x6C\x6E\x73\x3A\x78\x6D\x70\x4D\x4D\x3D\x22\x68\x74\x74\x70\x3A\x2F\x2F\x6E\x73\x2E\x61\x64\x6F\x62\x65\x2E\x63\x6F\x6D\x2F\x78\x61\x70\x2F\x31\x2E\x30\x2F\x6D\x6D\x2F\x22\x20\x78\x6D\x6C\x6E\x73\x3A\x73\x74\x45\x76\x74\x3D\x22\x68\x74\x74\x70\x3A\x2F\x2F\x6E\x73\x2E\x61\x64\x6F\x62\x65\x2E\x63\x6F\x6D\x2F\x78\x61\x70\x2F\x31\x2E\x30\x2F\x73\x54\x79\x70\x65\x2F\x52\x65\x73\x6F\x75\x72\x63\x65\x45\x76\x65\x6E\x74\x23\x22\x20\x78\x6D\x70\x3A\x43\x72\x65\x61\x74\x6F\x72\x54\x6F\x6F\x6C\x3D\x22\x41\x64\x6F\x62\x65\x20\x50\x68\x6F\x74\x6F\x73\x68\x6F\x70\x20\x32\x32\x2E\x34\x20\x28\x57\x69\x6E\x64\x6F\x77\x73\x29\x22\x20\x78\x6D\x70\x3A\x43\x72\x65\x61\x74\x65\x44\x61\x74\x65\x3D\x22\x32\x30\x32\x31\x2D\x30\x38\x2D\x31\x33\x54\x31\x39\x3A\x30\x30\x3A\x34\x30\x2B\x30\x33\x3A\x30\x30\x22\x20\x78\x6D\x70\x3A\x4D\x6F\x64\x69\x66\x79\x44\x61\x74\x65\x3D\x22\x32\x30\x32\x31\x2D\x30\x38\x2D\x31\x33\x54\x31\x39\x3A\x30\x37\x2B\x30\x33\x3A\x30\x30\x22\x20\x78\x6D\x70\x3A\x4D\x65\x74\x61\x64\x61\x74\x61\x44\x61\x74\x65\x3D\x22\x32\x30\x32\x31\x2D\x30\x38\x2D\x31\x33\x54\x31\x39\x3A\x30\x37\x2B\x30\x33\x3A\x30\x30\x22\x20\x64\x63\x3A\x66\x6F\x72\x6D\x61\x74\x3D\x22\x69\x6D\x61\x67\x65\x2F\x70\x6E\x67\x22\x20\x70\x68\x6F\x74\x6F\x73\x68\x6F\x70\x3A\x43\x6F\x6C\x6F\x72\x4D\x6F\x64\x65\x3D\x22\x33\x22\x20\x78\x6D\x70\x4D\x4D\x3A\x49\x6E\x73\x74\x61\x6E\x63\x65\x49\x44\x3D\x22\x78\x6D\x70\x2E\x69\x69\x64\x3A\x32\x31\x36\x36\x32\x61\x65\x62\x2D\x64\x66\x61\x32\x2D\x62\x35\x34\x31\x2D\x62\x30\x64\x37\x2D\x63\x66\x32\x39\x35\x34\x32\x34\x66\x37\x32\x35\x22\x20\x78\x6D\x70\x4D\x4D\x3A\x44\x6F\x63\x75\x6D\x65\x6E\x74\x49\x44\x3D\x22\x78\x6D\x70\x2E\x64\x69\x64\x3A\x32\x31\x36\x36\x32\x61\x65\x62\x2D\x64\x66\x61\x32\x2D\x62\x35\x34\x31\x2D\x62\x30\x64\x37\x2D\x63\x66\x32\x39\x35\x34\x32\x34\x66\x37\x32\x35\x22\x20\x78\x6D\x70\x4D\x4D\x3A\x4F\x72\x69\x67\x69\x6E\x61\x6C\x44\x6F\x63\x75\x6D\x65\x6E\x74\x49\x44\x3D\x22\x78\x6D\x70\x2E\x64\x69\x64\x3A\x32\x31\x36\x36\x32\x61\x65\x62\x2D\x64\x66\x61\x32\x2D\x62\x35\x34\x31\x2D\x62\x30\x64\x37\x2D\x63\x66\x32\x39\x35\x34\x32\x34\x66\x37\x32\x35\x22\x3E\x20\x3C\x78\x6D\x70\x4D\x4D\x3A\x48\x69\x73\x74\x6F\x72\x79\x3E\x20\x3C\x72\x64\x66\x3A\x53\x65\x71\x3E\x20\x3C\x72\x64\x66\x3A\x6C\x69\x20\x73\x74\x45\x76\x74\x3A\x61\x63\x74\x69\x6F\x6E\x3D\x22\x63\x72\x65\x61\x74\x65\x64\x22\x20\x73\x74\x45\x76\x74\x3A\x69\x6E\x73\x74\x61\x6E\x63\x65\x49\x44\x3D\x22\x78\x6D\x70\x2E\x69\x69\x64\x3A\x32\x31\x36\x36\x32\x61\x65\x62\x2D\x64\x66\x61\x32\x2D\x62\x35\x34\x31\x2D\x62\x30\x64\x37\x2D\x63\x66\x32\x39\x35\x34\x32\x34\x66\x37\x32\x35\x22\x20\x73\x74\x45\x76\x74\x3A\x77\x68\x65\x6E\x3D\x22\x32\x30\x32\x31\x2D\x30\x38\x2D\x31\x33\x54\x31\x39\x3A\x30\x30\x3A\x34\x30\x2B\x30\x33\x3A\x30\x30\x22\x20\x73\x74\x45\x76\x74\x3A\x73\x6F\x66\x74\x77\x61\x72\x65\x41\x67\x65\x6E\x74\x3D\x22\x41\x64\x6F\x62\x65\x20\x50\x68\x6F\x74\x6F\x73\x68\x6F\x70\x20\x32\x32\x2E\x34\x20\x28\x57\x69\x6E\x64\x6F\x77\x73\x29\x22\x2F\x3E\x20\x3C\x2F\x72\x64\x66\x3A\x53\x65\x71\x3E\x20\x3C\x2F\x78\x6D\x70\x4D\x4D\x3A\x48\x69\x73\x74\x6F\x72\x79\x3E\x20\x3C\x2F\x72\x64\x66\x3A\x44\x65\x73\x63\x72\x69\x70\x74\x69\x6F\x6E\x3E\x20\x3C\x2F\x72\x64\x66\x3A\x52\x44\x46\x3E\x20\x3C\x2F\x78\x3A\x78\x6D\x70\x6D\x65\x74\x61\x3E\x20\x3C\x3F\x78\x70\x61\x63\x6B\x65\x74\x20\x65\x6E\x64\x3D\x22\x72\x22\x3F\x3E\xCF\x38\xDC\x53\x00\x00\x04\x73\x49\x44\x41\x54\x58\x85\xC5\x97\x4B\x6F\x1B\x55\x14\xC7\x03\x02\x04\xE2\x0B\xC0\x9E\x25\xAB\x0A\xE8\x86\x45\x58\x20\x40\x15\x12\xB1\x33\x1E\x3F\xE2\x47\xD3\xD4\x6E\x43\x1B\x52\x1A\xE2\xF8\x3D\x63\x8F\x5F\xB1\xF3\x7E\xB6\x85\x0F\xC5\x82\x47\x85\xC4\x02\x54\x21\xB1\x8A\xED\x48\x14\x55\xE8\x72\xFE\xD7\x3E\xCE\x9D\x71\xC6\x8F\xA4\x6A\x17\x47\xE3\x99\xB9\x73\xCE\xCF\xFF\x7B\xEE\x39\xF7\x4E\x09\x21\xA6\x5E\xB6\xBD\x74\x00\x57\x08\x5D\xF7\x5C\xF1\xF9\xBD\x4B\x9A\xDF\x73\x4D\xD3\xB4\xB7\x2E\x1B\x04\x3E\x66\xF5\xD9\x2F\x66\x75\xCF\x5D\xF8\x9E\x9A\x9A\x7A\xC5\x15\x82\x06\xBF\xE3\x0F\xCE\xFE\x19\x8A\x06\x4E\x6E\x7F\x9D\x78\x1A\x9B\x8F\xB6\xF5\x80\xF6\x17\x3D\xFF\xE8\xA2\x00\xBA\x3E\xF3\xBE\x1E\xF0\xFD\x11\x9D\x8F\xB4\x6F\x2D\xDE\x7C\x1A\x0A\x07\x5B\xE4\xF3\x89\x67\xCE\xF3\xEE\x00\x04\x05\x7A\xC3\x1F\xD0\x7E\x5C\x5A\xBE\xF3\xAC\x52\x2B\x09\x58\xB5\x6E\x89\x54\x66\x55\xD0\x47\x1D\x7A\xFF\xF1\xE4\x00\x9E\x2B\xFE\x80\xAF\x95\x4C\x7F\x27\x6A\xEB\x65\xE9\x0F\x7E\x97\xBF\xBD\xFB\x8C\x62\xFD\x12\x8B\xC5\xDE\xB4\x43\x04\x66\x3E\x0D\x47\x82\x1D\x15\x00\x1F\xD6\x1B\x15\x91\x2F\x64\x84\x3F\x38\x19\x08\x03\x64\xF3\x29\xB1\xDE\xAC\x4A\x3F\x2A\x48\x24\x36\xD7\xA6\x98\x9F\xDB\x21\xFC\x9E\x60\x3C\x71\xA3\x0F\xC1\x00\x70\xD0\xD8\xA8\x89\x82\x99\x1B\x1B\x84\x01\x72\x46\x5A\x34\x37\xEB\xF2\x7B\x15\x04\xFE\xE3\xB7\x16\x3A\x14\x33\xE6\x84\xB8\x16\xB9\x3E\xD7\x56\x55\x60\x00\x38\xDA\xD8\x5A\x17\x66\x31\x4F\x20\xBE\xA1\x20\x0C\x50\x30\x33\x62\x73\xBB\x21\xBF\x53\x41\x58\x0D\x52\xA2\xE5\xF3\x79\xBF\xB2\x41\x20\x63\xF5\x90\xF6\x53\x72\x6D\xC5\xA6\x02\x03\xC0\xE1\xD6\x4E\x53\x14\x2D\xC3\x15\x84\x01\x8C\x62\x4E\x6C\xEF\x6E\xC8\xF1\x2A\x08\xAB\x91\x4C\xAF\x50\x9E\xF9\x7E\xE6\x55\x62\x73\xE2\xF5\x7B\x3F\xD0\x83\x5A\x3B\xD3\x9B\x47\x56\x81\x01\xE0\x78\x67\x6F\x53\x58\x65\x73\x00\x84\x01\x4C\x2B\x2F\x76\xF7\xB7\xE4\x38\x15\x84\xD5\xC8\x19\x19\x81\x18\x88\xE5\x5A\x27\xE0\x18\x83\x30\x58\x55\x81\x01\x10\x60\xEF\x60\x5B\x94\xAB\xA5\x3E\x88\x04\x08\xFA\x5A\xA5\xB2\x21\xF6\x0F\x77\xE4\x7B\x15\x84\xD5\x28\x98\x59\x09\xE0\x54\xD1\xAD\xB8\x48\x90\x82\x91\xB5\xA9\xC0\x00\x08\x74\x70\xB4\x2B\xAA\x35\x4B\x82\x00\xC0\xAA\x9A\xE2\xF0\x78\x4F\x3E\x57\x41\x58\x0D\x4C\xD1\x79\x00\xAE\x10\x7D\x90\x80\xAF\x63\x98\x79\xE9\x84\x55\x60\x00\x04\x3C\x7E\x78\x40\x12\x93\xCC\xCD\x9A\xFC\x0D\x53\x41\x58\x0D\x24\x34\x7C\xB9\x25\xF4\xA8\x72\x2B\x41\xCC\x52\x41\x3A\x53\x55\x38\x7A\xB0\x2F\x83\x3E\xFC\xFE\xA8\x6F\xB8\xC7\x73\x80\xB0\x1A\x48\xE4\x61\x00\x23\x21\x54\x90\xA2\x55\xE8\x43\x20\x08\x82\x3D\x78\x74\x28\x83\x3F\xFA\xE1\x58\x5E\x71\xAF\x42\x94\x2A\xE6\x48\x80\xB1\x20\xCE\x72\xC4\xD7\x29\x59\xC6\x80\x12\x0C\x82\x2B\x2B\x81\xF7\x56\x65\x70\x05\x5D\x0A\x82\x41\x68\x09\x9E\xA2\xD0\x40\x11\xCE\x7C\xCC\x3B\x82\xAA\x53\x51\xA7\x3A\x83\xB1\xE3\x96\xF9\x89\x21\x72\xF9\x34\x2D\xCF\xA2\xB0\x60\xF4\x6F\x61\xB8\x07\x1C\x6A\x0B\x0C\x4B\xF1\xB9\x43\x30\x40\x3A\x97\x94\x75\xBF\x0C\xA3\xC0\xA8\x15\xB8\xDA\x9A\x5E\xBD\x2C\x2B\x6E\x36\x97\x12\xFA\xF3\x9A\x0E\x06\xC8\xE4\xD6\x7A\x1D\xD0\x92\x57\xE7\xEF\x6E\x4F\x00\x40\x45\x96\x66\x58\x96\x54\xBB\x74\x62\xF6\x01\xF2\x5D\x80\xEA\x7A\xF7\x5F\x9E\x05\x54\xED\x2C\x78\xD7\xBA\x7D\x22\x97\xCF\x5C\x7C\x89\xAA\x00\x1C\x88\x03\xD4\x7A\x57\xCC\x3F\xEA\x00\x8C\xF3\x41\x5A\xA3\x6A\xBB\x1F\x05\x32\x04\x40\x93\x53\xA0\xFE\x3B\xEE\x82\xD2\x39\xF6\x18\x45\xEC\x31\xF4\x53\x82\xED\x14\xA8\xD7\xA0\x41\xB1\x71\x03\x64\xCB\x15\xD2\xE3\x97\xED\x1E\x40\x27\x95\x5D\xB5\xB5\x74\xB6\xC6\x46\xD7\xB9\xD1\x03\xC0\xEE\x88\x0B\x5A\x9E\x56\x45\x83\x9A\x5E\xB3\x67\x2A\x10\xFC\xA0\x3B\x8F\x6C\x60\xD4\x5E\xAF\xEA\x3D\x00\x75\x87\x35\xB0\xCB\x52\x00\x6C\x05\x0D\x20\xD4\xF4\x9C\xC1\xCF\xF2\xC8\x12\xE9\xEC\x9A\x7B\x2B\xC7\xB6\x9C\x5E\x3E\x49\xA6\x56\xFA\x00\xE7\xED\x37\xD1\xE2\xA9\x12\xDA\x00\x9C\x20\xC8\x81\x7E\xFE\x28\xFB\x4A\xB6\x55\x8A\x41\xCB\xF7\xF7\x78\x3C\xFE\xBA\x0D\x82\xB6\x5A\x9F\xC5\xE6\x23\x27\x4E\x00\x15\xA4\x3B\xAF\xE7\x03\x38\x41\x50\x27\xCE\x03\x60\xA3\x58\x2D\x3A\x8B\x68\x36\x08\x7A\x90\x48\x2C\xDE\xFC\xC7\x0D\x42\xCE\x67\x60\x38\x80\x0D\x84\x24\x87\xF4\x6E\xFE\x12\x8B\x0B\xA7\x14\x73\xC1\xA1\x84\xE7\x93\x70\x34\xD4\xBA\x2C\xC0\xB8\x20\xB4\xA9\xEE\x90\xFA\x5E\x1B\x04\xE6\x87\x92\xF2\xF1\xBD\xFB\x4B\xFF\xA9\x83\xD3\x99\xE4\xC4\x00\x4E\x10\x67\x9E\xDD\xBB\xBF\x2C\xFC\x21\xED\x37\xC3\x30\x5E\x1D\x58\x1D\xF4\xD1\x7B\x34\xE7\xBF\x86\x69\x3B\x7E\xFB\x4E\xE2\xDF\xF9\x1B\xD1\x13\x02\xFB\x1B\x2A\x4D\x0A\xC0\x46\xFB\xCF\x0F\x91\x84\xD1\xEB\x91\x16\xCE\x1A\x38\xF4\xD0\xF9\xE5\x31\x8E\x87\xAE\x75\x62\x7A\x7A\xFA\x35\x24\xA9\xA6\x7B\xBF\xA1\xB3\xC8\x4C\x38\x1C\x7E\xFB\xA2\x00\x0E\x9F\x5E\x1C\x76\xE8\xFA\x25\x2B\x30\xB4\x62\xBE\x68\xFB\x1F\xF7\x5C\xF7\xCB\x56\x46\x99\xC0\x00\x00\x00\x00\x49\x45\x4E\x44\xAE\x42\x60\x82"

_logo ="\x89\x50\x4E\x47\x0D\x0A\x1A\x0A\x00\x00\x00\x0D\x49\x48\x44\x52\x00\x00\x01\x00\x00\x00\x00\x3C\x08\x06\x00\x00\x00\x89\xBD\x64\x04\x00\x00\x00\x09\x70\x48\x59\x73\x00\x00\x0B\x13\x00\x00\x0B\x13\x01\x00\x9A\x9C\x18\x00\x00\x06\xB3\x69\x54\x58\x74\x58\x4D\x4C\x3A\x63\x6F\x6D\x2E\x61\x64\x6F\x62\x65\x2E\x78\x6D\x70\x00\x00\x00\x00\x00\x3C\x3F\x78\x70\x61\x63\x6B\x65\x74\x20\x62\x65\x67\x69\x6E\x3D\x22\xEF\xBB\xBF\x22\x20\x69\x64\x3D\x22\x57\x35\x4D\x30\x4D\x70\x43\x65\x68\x69\x48\x7A\x72\x65\x53\x7A\x4E\x54\x63\x7A\x6B\x63\x39\x64\x22\x3F\x3E\x20\x3C\x78\x3A\x78\x6D\x70\x6D\x65\x74\x61\x20\x78\x6D\x6C\x6E\x73\x3A\x78\x3D\x22\x61\x64\x6F\x62\x65\x3A\x6E\x73\x3A\x6D\x65\x74\x61\x2F\x22\x20\x78\x3A\x78\x6D\x70\x74\x6B\x3D\x22\x41\x64\x6F\x62\x65\x20\x58\x4D\x50\x20\x43\x6F\x72\x65\x20\x36\x2E\x30\x2D\x63\x30\x30\x36\x20\x37\x39\x2E\x64\x61\x62\x61\x63\x62\x62\x2C\x20\x32\x30\x32\x31\x2F\x30\x34\x2F\x31\x34\x2D\x30\x30\x3A\x33\x39\x3A\x34\x34\x20\x20\x20\x20\x20\x20\x20\x20\x22\x3E\x20\x3C\x72\x64\x66\x3A\x52\x44\x46\x20\x78\x6D\x6C\x6E\x73\x3A\x72\x64\x66\x3D\x22\x68\x74\x74\x70\x3A\x2F\x2F\x77\x77\x77\x2E\x77\x33\x2E\x6F\x72\x67\x2F\x31\x39\x39\x39\x2F\x30\x32\x2F\x32\x32\x2D\x72\x64\x66\x2D\x73\x79\x6E\x74\x61\x78\x2D\x6E\x73\x23\x22\x3E\x20\x3C\x72\x64\x66\x3A\x44\x65\x73\x63\x72\x69\x70\x74\x69\x6F\x6E\x20\x72\x64\x66\x3A\x61\x62\x6F\x75\x74\x3D\x22\x22\x20\x78\x6D\x6C\x6E\x73\x3A\x78\x6D\x70\x3D\x22\x68\x74\x74\x70\x3A\x2F\x2F\x6E\x73\x2E\x61\x64\x6F\x62\x65\x2E\x63\x6F\x6D\x2F\x78\x61\x70\x2F\x31\x2E\x30\x2F\x22\x20\x78\x6D\x6C\x6E\x73\x3A\x78\x6D\x70\x4D\x4D\x3D\x22\x68\x74\x74\x70\x3A\x2F\x2F\x6E\x73\x2E\x61\x64\x6F\x62\x65\x2E\x63\x6F\x6D\x2F\x78\x61\x70\x2F\x31\x2E\x30\x2F\x6D\x6D\x2F\x22\x20\x78\x6D\x6C\x6E\x73\x3A\x73\x74\x45\x76\x74\x3D\x22\x68\x74\x74\x70\x3A\x2F\x2F\x6E\x73\x2E\x61\x64\x6F\x62\x65\x2E\x63\x6F\x6D\x2F\x78\x61\x70\x2F\x31\x2E\x30\x2F\x73\x54\x79\x70\x65\x2F\x52\x65\x73\x6F\x75\x72\x63\x65\x45\x76\x65\x6E\x74\x23\x22\x20\x78\x6D\x6C\x6E\x73\x3A\x70\x68\x6F\x74\x6F\x73\x68\x6F\x70\x3D\x22\x68\x74\x74\x70\x3A\x2F\x2F\x6E\x73\x2E\x61\x64\x6F\x62\x65\x2E\x63\x6F\x6D\x2F\x70\x68\x6F\x74\x6F\x73\x68\x6F\x70\x2F\x31\x2E\x30\x2F\x22\x20\x78\x6D\x6C\x6E\x73\x3A\x64\x63\x3D\x22\x68\x74\x74\x70\x3A\x2F\x2F\x70\x75\x72\x6C\x2E\x6F\x72\x67\x2F\x64\x63\x2F\x65\x6C\x65\x6D\x65\x6E\x74\x73\x2F\x31\x2E\x31\x2F\x22\x20\x78\x6D\x70\x3A\x43\x72\x65\x61\x74\x6F\x72\x54\x6F\x6F\x6C\x3D\x22\x41\x64\x6F\x62\x65\x20\x50\x68\x6F\x74\x6F\x73\x68\x6F\x70\x20\x32\x32\x2E\x34\x20\x28\x57\x69\x6E\x64\x6F\x77\x73\x29\x22\x20\x78\x6D\x70\x3A\x43\x72\x65\x61\x74\x65\x44\x61\x74\x65\x3D\x22\x32\x30\x32\x31\x2D\x30\x38\x2D\x32\x32\x54\x31\x31\x3A\x31\x32\x3A\x30\x33\x2B\x30\x33\x3A\x30\x30\x22\x20\x78\x6D\x70\x3A\x4D\x65\x74\x61\x64\x61\x74\x61\x44\x61\x74\x65\x3D\x22\x32\x30\x32\x31\x2D\x30\x38\x2D\x32\x32\x54\x31\x31\x3A\x31\x32\x3A\x30\x33\x2B\x30\x33\x3A\x30\x30\x22\x20\x78\x6D\x70\x3A\x4D\x6F\x64\x69\x66\x79\x44\x61\x74\x65\x3D\x22\x32\x30\x32\x31\x2D\x30\x38\x2D\x32\x32\x54\x31\x31\x3A\x31\x32\x3A\x30\x33\x2B\x30\x33\x3A\x30\x30\x22\x20\x78\x6D\x70\x4D\x4D\x3A\x49\x6E\x73\x74\x61\x6E\x63\x65\x49\x44\x3D\x22\x78\x6D\x70\x2E\x69\x69\x64\x3A\x61\x33\x36\x37\x38\x33\x65\x35\x2D\x37\x34\x63\x66\x2D\x66\x32\x34\x62\x2D\x61\x62\x36\x63\x2D\x38\x30\x32\x31\x66\x39\x33\x37\x64\x62\x66\x34\x22\x20\x78\x6D\x70\x4D\x4D\x3A\x44\x6F\x63\x75\x6D\x65\x6E\x74\x49\x44\x3D\x22\x61\x64\x6F\x62\x65\x3A\x64\x6F\x63\x69\x64\x3A\x70\x68\x6F\x74\x6F\x73\x68\x6F\x70\x3A\x63\x63\x38\x66\x64\x39\x62\x63\x2D\x61\x31\x39\x33\x2D\x39\x35\x34\x38\x2D\x38\x66\x36\x64\x2D\x30\x34\x61\x38\x61\x65\x30\x66\x37\x30\x64\x31\x22\x20\x78\x6D\x70\x4D\x4D\x3A\x4F\x72\x69\x67\x69\x6E\x61\x6C\x44\x6F\x63\x75\x6D\x65\x6E\x74\x49\x44\x3D\x22\x78\x6D\x70\x2E\x64\x69\x64\x3A\x62\x34\x33\x64\x35\x64\x66\x66\x2D\x38\x66\x62\x64\x2D\x61\x61\x34\x61\x2D\x61\x35\x32\x31\x2D\x61\x32\x63\x61\x36\x63\x31\x32\x65\x34\x39\x37\x22\x20\x70\x68\x6F\x74\x6F\x73\x68\x6F\x70\x3A\x43\x6F\x6C\x6F\x72\x4D\x6F\x64\x65\x3D\x22\x33\x22\x20\x64\x63\x3A\x66\x6F\x72\x6D\x61\x74\x3D\x22\x69\x6D\x61\x67\x65\x2F\x70\x6E\x67\x22\x3E\x20\x3C\x78\x6D\x70\x4D\x4D\x3A\x48\x69\x73\x74\x6F\x72\x79\x3E\x20\x3C\x72\x64\x66\x3A\x53\x65\x71\x3E\x20\x3C\x72\x64\x66\x3A\x6C\x69\x20\x73\x74\x45\x76\x74\x3A\x61\x63\x74\x69\x6F\x6E\x3D\x22\x63\x72\x65\x61\x74\x65\x64\x22\x20\x73\x74\x45\x76\x74\x3A\x69\x6E\x73\x74\x61\x6E\x63\x65\x49\x44\x3D\x22\x78\x6D\x70\x2E\x69\x69\x64\x3A\x62\x34\x33\x64\x35\x64\x66\x66\x2D\x38\x66\x62\x64\x2D\x61\x61\x34\x61\x2D\x61\x35\x32\x31\x2D\x61\x32\x63\x61\x36\x63\x31\x32\x65\x34\x39\x37\x22\x20\x73\x74\x45\x76\x74\x3A\x77\x68\x65\x6E\x3D\x22\x32\x30\x32\x31\x2D\x30\x38\x2D\x32\x32\x54\x31\x31\x3A\x31\x32\x3A\x30\x33\x2B\x30\x33\x3A\x30\x30\x22\x20\x73\x74\x45\x76\x74\x3A\x73\x6F\x66\x74\x77\x61\x72\x65\x41\x67\x65\x6E\x74\x3D\x22\x41\x64\x6F\x62\x65\x20\x50\x68\x6F\x74\x6F\x73\x68\x6F\x70\x20\x32\x32\x2E\x34\x20\x28\x57\x69\x6E\x64\x6F\x77\x73\x29\x22\x2F\x3E\x20\x3C\x72\x64\x66\x3A\x6C\x69\x20\x73\x74\x45\x76\x74\x3A\x61\x63\x74\x69\x6F\x6E\x3D\x22\x73\x61\x76\x65\x64\x22\x20\x73\x74\x45\x76\x74\x3A\x69\x6E\x73\x74\x61\x6E\x63\x65\x49\x44\x3D\x22\x78\x6D\x70\x2E\x69\x69\x64\x3A\x61\x33\x36\x37\x38\x33\x65\x35\x2D\x37\x34\x63\x66\x2D\x66\x32\x34\x62\x2D\x61\x62\x36\x63\x2D\x38\x30\x32\x31\x66\x39\x33\x37\x64\x62\x66\x34\x22\x20\x73\x74\x45\x76\x74\x3A\x77\x68\x65\x6E\x3D\x22\x32\x30\x32\x31\x2D\x30\x38\x2D\x32\x32\x54\x31\x31\x3A\x31\x32\x3A\x30\x33\x2B\x30\x33\x3A\x30\x30\x22\x20\x73\x74\x45\x76\x74\x3A\x73\x6F\x66\x74\x77\x61\x72\x65\x41\x67\x65\x6E\x74\x3D\x22\x41\x64\x6F\x62\x65\x20\x50\x68\x6F\x74\x6F\x73\x68\x6F\x70\x20\x32\x32\x2E\x34\x20\x28\x57\x69\x6E\x64\x6F\x77\x73\x29\x22\x20\x73\x74\x45\x76\x74\x3A\x63\x68\x61\x6E\x67\x65\x64\x3D\x22\x2F\x22\x2F\x3E\x20\x3C\x2F\x72\x64\x66\x3A\x53\x65\x71\x3E\x20\x3C\x2F\x78\x6D\x70\x4D\x4D\x3A\x48\x69\x73\x74\x6F\x72\x79\x3E\x20\x3C\x70\x68\x6F\x74\x6F\x73\x68\x6F\x70\x3A\x54\x65\x78\x74\x4C\x61\x79\x65\x72\x73\x3E\x20\x3C\x72\x64\x66\x3A\x42\x61\x67\x3E\x20\x3C\x72\x64\x66\x3A\x6C\x69\x20\x70\x68\x6F\x74\x6F\x73\x68\x6F\x70\x3A\x4C\x61\x79\x65\x72\x4E\x61\x6D\x65\x3D\x22\x41\x6E\x69\x6D\x61\x74\x65\x64\x20\x49\x63\x6F\x6E\x63\x73\x22\x20\x70\x68\x6F\x74\x6F\x73\x68\x6F\x70\x3A\x4C\x61\x79\x65\x72\x54\x65\x78\x74\x3D\x22\x41\x6E\x69\x6D\x61\x74\x65\x64\x20\x49\x63\x6F\x6E\x63\x73\x22\x2F\x3E\x20\x3C\x72\x64\x66\x3A\x6C\x69\x20\x70\x68\x6F\x74\x6F\x73\x68\x6F\x70\x3A\x4C\x61\x79\x65\x72\x4E\x61\x6D\x65\x3D\x22\x64\x6D\x69\x74\x72\x69\x79\x65\x77\x69\x63\x68\x22\x20\x70\x68\x6F\x74\x6F\x73\x68\x6F\x70\x3A\x4C\x61\x79\x65\x72\x54\x65\x78\x74\x3D\x22\x64\x6D\x69\x74\x72\x69\x79\x65\x77\x69\x63\x68\x22\x2F\x3E\x20\x3C\x2F\x72\x64\x66\x3A\x42\x61\x67\x3E\x20\x3C\x2F\x70\x68\x6F\x74\x6F\x73\x68\x6F\x70\x3A\x54\x65\x78\x74\x4C\x61\x79\x65\x72\x73\x3E\x20\x3C\x2F\x72\x64\x66\x3A\x44\x65\x73\x63\x72\x69\x70\x74\x69\x6F\x6E\x3E\x20\x3C\x2F\x72\x64\x66\x3A\x52\x44\x46\x3E\x20\x3C\x2F\x78\x3A\x78\x6D\x70\x6D\x65\x74\x61\x3E\x20\x3C\x3F\x78\x70\x61\x63\x6B\x65\x74\x20\x65\x6E\x64\x3D\x22\x72\x22\x3F\x3E\xBE\xC6\x78\xC6\x00\x00\x1E\x9F\x49\x44\x41\x54\x78\xDA\xED\x5D\x09\x90\x5C\xE5\x71\xDE\x6B\x66\x67\xE7\xBE\x76\xF6\xD4\x4A\x42\x06\x3B\xB1\xCB\x57\xE2\xA3\x1C\x6C\x72\xF8\xC4\x36\x4E\xE2\xC4\xB1\x63\x27\x24\x71\x62\x3B\x09\xA6\x08\xD8\x4E\x08\x11\x56\x1C\x01\x0A\x84\x80\x62\x82\x6C\x82\x12\x2A\x32\x81\x08\x2C\xAA\x64\x85\x40\x24\x50\x21\x2C\x90\x25\x0E\x21\x09\x89\x5B\xAC\x84\xA4\x92\x28\xDD\x42\x02\x71\x6C\xFE\xEF\xD1\xFD\xE8\xE9\xED\xFF\xCD\xCC\xEA\x00\xE1\xF7\xAA\xBA\x66\xE7\xCD\x3B\xFE\xEE\xBF\xFB\xEB\xFE\xBB\xFB\xBD\x6D\x1B\x1B\x1B\x6B\x8B\x29\xA6\x98\x7E\x3E\x29\x16\x42\x4C\x31\xC5\x00\x10\x53\x4C\x31\xC5\x00\x10\x53\x4C\x31\xC5\x00\x10\x53\x4C\x31\xC5\x00\x10\x53\x4C\x31\xC5\x00\x10\x53\x4C\x31\xC5\x00\x10\x53\x4C\x31\xBD\xF9\x00\xA0\x89\xAD\xBD\x09\x8A\xB7\x23\xDF\xDE\x2C\xB2\x3D\x12\x3D\x89\x75\xEC\x0D\x3A\x99\x1D\x44\x9D\x8A\x78\x7F\x3C\x49\x47\xCF\x60\xB4\x4C\x4F\x14\xD9\xFA\xF8\x68\x86\x17\xEB\x9C\x0E\xCF\x35\xE2\xED\x38\x4E\x28\x1B\x7D\x97\xA3\xC4\x8B\x2F\xBE\x78\xDE\xEA\xD5\xAB\x6B\xBB\x77\xEF\x7E\xDF\x73\xCF\x3D\xF7\x51\xEC\x33\x80\x20\xDE\x26\x66\x34\x81\x0C\x5F\x78\xE1\x85\xF7\xBE\xF2\xCA\x2B\x77\x9D\x80\x00\x5B\xC7\xC7\xDE\xBD\x7B\xA7\x39\x3E\x1E\xC2\x67\x03\x3E\xB4\x83\xE9\x3A\x7C\xF8\xF0\x57\xA1\x5B\x4E\x16\x9F\x7F\xF2\xC9\x27\xAB\xB1\x8E\xBD\xBE\xC6\x0F\x23\x4F\xEE\xDC\xB9\xF3\xFD\x6E\xCD\x30\xE6\x26\xE5\x22\x37\xB1\x6B\x1C\xED\x5D\xB9\x72\x65\x1F\x7E\x53\x40\x10\x4F\x50\xEB\x72\x0E\x95\xFF\xA5\x97\x5E\xFA\xDE\xD8\xAB\x8B\xB3\x2E\x15\x69\xB5\x9F\x20\xC6\x1F\xF0\x01\x07\x01\x3E\xC8\x51\x74\x29\x3E\xDA\xD5\x79\xA1\x93\x71\xFA\xF5\x2D\x9C\xE7\x80\xE3\xE3\xEE\x63\x8F\x73\x3A\xFF\x40\xFA\xC5\xD7\x88\x23\x81\xE3\x34\xA1\x6C\xFC\xDD\x8E\xD2\x6E\x22\x7E\x44\x13\xF3\xE7\x63\xB4\x3D\xFF\xFC\xF3\x17\xBB\xDF\x7A\xE8\x18\x39\x41\xF1\x36\x41\xA0\x85\xC2\x13\x00\x24\x95\xE2\xBF\x91\x41\x60\x5C\xB4\xA8\x00\xC0\xC7\x07\x9F\xD7\x45\xFC\xA6\xE0\x60\x70\x9E\x73\x38\x9F\x64\x87\x83\xFD\xF4\x7B\x57\xEC\x64\x8E\xDF\x64\x76\xB1\xF1\x2F\x58\xB0\x60\x12\x3C\xBE\xF3\x4E\xEB\x0E\x1D\x3A\x74\x23\x26\xC6\x7D\xDF\x04\x72\xBF\xE7\x08\x04\xE2\x09\x6A\x7D\xAB\x33\x7E\x28\xBA\x0B\x7F\x67\x12\x00\xA4\x48\xFE\x89\x13\x40\xAE\xD2\x8B\x83\x8F\x6E\xB7\x4C\xFC\x04\xF8\xC0\x27\xF1\x91\x34\xBC\xB8\xE4\x1F\xFC\x66\x9C\x7E\x5D\x82\xF3\xB6\x6C\xD9\xF2\x19\x7C\xE2\x3B\xF6\x0B\x10\x60\x10\x89\xB7\x63\x3C\x99\x49\x32\xEC\xDC\xAE\x5D\xBB\xFE\x92\x50\xF9\x42\x67\xF4\xFB\x1C\x2A\xDF\x8B\xBF\xB1\x6F\xFB\xF6\xED\x5F\x21\x10\x48\x89\xA5\x40\x0C\x00\xAD\x01\x6D\x92\xE4\xD7\xC3\x1E\x10\xC0\xAB\x40\xE0\x8D\x2C\xD7\x0E\x15\x31\xF6\xB0\x07\xC7\xA7\x88\x12\xF5\x52\xB1\xCE\xD1\x38\xCA\xBB\x88\x61\x16\xCE\xDB\xB8\x71\xE3\xE7\x28\x82\x98\x85\xFD\xF4\x7B\x77\xEC\x64\x8E\x8F\x52\x32\x22\x67\x1D\x95\xE0\xF9\x61\xF8\xCE\xD8\xFF\x1E\x93\xB2\x69\xD3\xA6\x6F\xCD\x9C\x39\xF3\x1D\x14\xA2\xFD\xAF\x3B\xA6\x10\x4F\xD0\x11\x2F\xB3\x60\x24\x19\x2C\xAB\x08\x00\xB2\x02\x04\x92\x27\x00\x00\x48\x20\x4B\x3B\x5D\x39\x9D\x1C\xC4\xE9\x8A\x8F\x2E\x05\x00\xAC\x6B\x70\x22\xA5\xFD\xFB\xF7\x5F\x8A\xF3\x1E\x7B\xEC\xB1\xDF\xC6\x27\xBE\xBB\xFD\x45\x92\x07\x3B\x99\x58\xBF\x8E\x93\xF7\xCF\xAF\x5B\xB7\xEE\x57\x09\x89\x6F\x72\xEB\xD3\xF5\x00\x82\x0B\x2E\xB8\xE0\x3D\xEE\xB7\xA9\xD8\x87\xDF\x96\x2F\x5F\xFE\x6E\x15\x05\xC4\x13\xD4\x1A\x00\xA4\xC8\x48\xB2\x1C\x02\x93\x3C\x33\xC6\xF2\xEA\x8D\xEC\x34\x18\xC8\xB2\x0A\x00\xB2\x2A\x0A\xE8\xB0\x74\xCD\x51\x79\xDF\xBE\x7D\x97\xE1\xBC\xF5\xEB\xD7\xFF\x0E\x3E\xF1\x1D\xFB\xE9\xF7\x9E\x38\xCA\x3C\x3E\x48\xDE\x4D\xCA\x57\xE4\x35\xFF\x5D\x77\xDD\x75\xBA\x5B\x9F\x6E\x78\xF6\xD9\x67\xFF\xC5\xED\x3F\xD9\xD1\x49\x6B\xD6\xAC\xF9\x3D\x81\xD2\x1C\xA6\x35\xF2\x56\xBE\x46\x0F\x5F\xDD\xB7\x7D\x02\xD7\x3A\x96\xD4\xC8\x18\x9A\xAD\x85\x4B\x03\x48\x91\xBC\xC3\x10\x98\xA2\xAA\x9C\xB1\xFE\x6D\x25\x0B\x7E\x24\xB5\xF9\x56\xAE\xD7\x25\x0C\x19\xE3\xCD\x6D\xDB\xB6\xED\xD3\xE0\x03\x9F\xC4\x47\xDA\x70\x10\xCC\x7F\x9A\xF8\xAD\xEE\xDD\xBB\xF7\x9F\x70\xDE\xC3\x0F\x3F\xFC\xBB\xCE\xE1\x3C\xBC\x79\xF3\xE6\x3F\x72\xFB\x2B\x1E\x00\x38\x52\xFE\x8E\x96\x7C\x8E\x96\x3E\x1F\xAD\xF1\x4D\x48\x8F\xC7\x85\x64\xD7\x5D\x77\xDD\x54\x24\xFF\x30\x11\xF0\xF8\x8E\xDE\x42\xC6\x8F\xCF\x93\x1C\x4D\x7E\xF9\xE5\x97\x37\x83\x28\x4C\xCB\x18\x28\x1F\xC5\x44\xA7\x48\x1E\x75\xD1\x79\x09\xF1\xBD\xB3\x81\x01\x75\x34\x41\xFA\x1E\x9A\x3A\x0D\xB2\x7E\xB7\xC6\xD1\xE6\x19\x8F\xE6\xC9\x77\xAD\x3A\xAF\x09\x23\x38\x70\xE0\xC0\x3F\x12\x00\x94\x04\x08\x68\xE3\xE9\x68\x52\xB1\x7D\x32\xB6\xC6\xD3\x8C\x32\xF9\xAE\xD7\x2D\x8D\x1F\xE3\x76\x86\xFB\x59\x4E\xE6\x19\x3C\x74\x2A\x00\xC8\x90\xFE\xF4\xEE\xDE\xBD\xFB\x72\x9C\xB7\x76\xED\xDA\x2F\xB8\xEF\xC3\x8E\xFA\x15\x00\x24\x95\x0C\xA3\xE6\xB7\x19\xFD\x99\x88\x7C\x8E\xA6\x3E\xB7\xB5\x28\xEF\x66\xF4\xD2\xD7\xB8\x17\x79\x7F\x8D\xC8\xF9\x9D\x3B\x77\x9E\x45\x93\x78\x2E\x01\xC0\x34\x32\xFE\x69\xF4\x7D\xC4\x45\x04\xDF\xC5\x31\x48\x14\xAA\x8A\x80\x16\x5C\x30\x20\x34\x86\xB8\xF0\xAE\x57\x64\xBE\xA1\x3C\xDD\xE8\x29\x40\xED\x17\x84\x9E\x03\x91\x39\x4E\x18\xC2\x0B\x99\x93\xD7\x73\xE7\xBD\x45\x08\x3D\x20\x17\x82\x9E\xCC\xF7\x80\x02\x8E\x8E\x8E\xBE\x55\xDD\xC3\x24\xC7\xF3\x29\x2E\xB2\xF9\x18\x1A\x9F\xDA\xFC\x25\xB9\x71\xF5\x6F\xC9\x17\xEE\xC1\x3C\x51\xCF\x84\xE6\x29\x29\xC2\x7F\xC8\xAE\x28\x00\xA0\xF2\xC8\x23\x8F\x7C\x04\x1E\xD4\xC9\xF8\x53\xC8\xA6\x13\x2F\x51\x4D\x31\x91\xE3\xE1\xB1\x18\xE3\xE9\x6A\xA0\xE8\xE6\xF5\x20\x1F\x5C\xCB\x8D\xF1\x83\x04\x60\x79\x32\xE4\x92\x93\xF3\x19\xE0\x03\x40\x40\xFB\xAD\x48\xA6\x53\x46\x9B\x12\x00\x10\x01\xB8\xEF\x43\x8E\xFA\xD4\x12\x40\xCA\x2F\x1C\x8B\xA1\x3F\x51\xBA\x13\xC9\x0F\x3E\x9B\xD0\xBF\xE0\x1A\x4E\x4F\x2A\xD4\xAC\xE4\xD5\x67\x50\xC4\xF5\xA2\xE4\xDD\x0A\x7F\x9A\x02\xFD\x87\xFE\xA2\x14\x4B\xBA\xE3\x2D\x2B\x5B\xC9\xBF\x22\x27\xFF\x90\xF0\x73\xDF\xA7\x90\xD7\x9F\x46\x9F\xF8\x3E\x32\x6B\xD6\xAC\x5F\xC4\x84\xB9\x28\x61\x39\x79\xAC\x8C\x91\xF1\x0D\x85\xED\xA2\x85\x65\xEE\xBA\xF3\x68\x32\xD3\x4E\xE1\xBF\x8E\xC6\xA2\x31\xB5\x51\xE4\xF1\xA3\xE5\xCB\x97\xF7\x1B\xC2\x63\x03\x4F\xBA\xE3\x46\xDD\x35\x17\x52\x03\xC9\x1E\x1A\x7F\x40\x38\x17\xBF\xE3\x1E\x74\x9F\x51\x75\x8F\x51\xB7\xC4\xF9\x0E\x8D\x39\xBD\x74\xE9\xD2\x01\x77\xCF\xAB\x70\x6F\x79\x1C\xC6\xAC\x84\xDE\x69\xF1\x86\x71\x3A\x65\x78\x1B\xC6\xAD\xAF\x41\xF7\x5B\xE3\x26\xE3\x6B\x82\x9F\x94\xF0\x9C\x81\xF1\x70\x12\xEC\x9A\x6B\xAE\x99\x66\x5C\x63\x8F\x91\x49\x8F\x52\x9E\x00\x84\x9C\xBC\x7F\x32\x66\x6C\x6E\xFF\xDD\x54\xA6\x4B\x19\x40\x60\x19\x4A\x00\x22\x98\x3F\x6B\xBE\xDC\x1C\xFC\x17\xE5\x83\xAA\x4E\x0E\xBF\x29\x00\xA0\x20\x92\x78\x51\x00\x10\x2E\x01\x90\x03\x70\xDF\x07\x1C\xD5\x28\x1A\xCA\x89\x3C\x02\x1B\x5A\x0A\xF2\x04\x1F\xD6\x78\x30\x4E\xA1\xF8\x3A\xC2\x93\xFC\xF8\xE4\xF3\x13\x61\xBC\xDA\x9B\xB3\x3E\xFF\x27\xF4\x8F\xE7\x12\xE3\x89\xD2\x67\xE8\x87\x51\xDE\xD5\xF2\x0E\xCB\xC2\x51\xD7\x73\xE3\xFB\x3E\x39\xA8\x84\x8A\x3A\x92\x00\x0C\xE8\xAD\xD2\xE3\x85\x04\xFC\x09\x5D\x4E\x1D\x57\xFA\x73\x13\x70\x1A\x25\xFF\xE6\xBB\xEF\x93\x10\xEE\x93\xD1\x33\x4D\xA6\xFD\xC3\x07\x0F\x1E\xFC\x6F\x1C\xBB\x62\xC5\x8A\x77\xB5\x8D\xEF\x0B\x90\x28\x9B\x62\xC5\x5B\xB8\x70\xE1\xB0\xFB\x5C\x2B\x95\x07\xEB\x5F\x78\x40\x7C\xA2\xC7\x80\x7F\x53\xA5\xA4\xD0\x9B\x63\x1F\x5F\x4F\x65\xCF\xB3\x32\x11\xC5\x86\x84\x4F\x67\xF0\x3F\xC0\x3D\xDC\xE7\x1C\xDE\x8F\x7B\xCF\x9F\x3F\x7F\x84\xC7\x83\xEB\x21\x19\x07\x72\x93\xB6\x88\x05\xE8\x8C\xF3\x0B\x0A\x8C\x12\x22\x04\x4E\x11\xC8\xEC\xA5\x6B\xAC\x05\x1F\x4C\xB8\x87\x54\x2C\x02\xB6\x34\x29\x7F\x96\x8C\x24\xCC\x82\xC3\x1B\x6E\xDD\xBA\xF5\x0F\x59\x1E\xE0\x6F\xC7\x8E\x1D\x1F\x68\xE0\xB1\xCD\xA6\x1A\x02\xE8\xFF\x61\xF9\x82\xF0\x9D\x7F\x73\xC7\xFD\xAB\x4A\xD2\x75\x69\x0F\x29\x15\x0A\x3C\x1E\x3E\x7C\xF8\x7A\x77\x9D\xBF\x71\x73\xF3\xFB\x7A\xBE\x9C\x57\x3C\xF3\xF1\xC7\x1F\xFF\x2D\x2E\xE7\x89\x2C\x7E\x4F\x04\x00\x80\xFF\x0A\x27\x01\x5D\xF4\xF3\x79\xF2\xFE\x55\x3A\x9F\xF5\x2A\x98\x77\x02\xEB\x45\x5A\x7F\x40\x98\x37\x36\x1A\x72\x36\x7A\xBE\x02\xF9\x00\xEC\x85\x7C\x16\xF1\x9C\xEB\x79\x47\x6F\x86\x28\xC9\x26\x25\x00\x91\x43\xBB\x1B\xFC\x41\x26\x96\x3E\x83\xA4\xAE\x43\x4F\x54\x34\x33\x0E\x98\xC0\x1F\x03\x9B\xC1\xDF\x1C\x96\x37\x8D\x6D\xDC\xB8\x98\x7F\x80\x8E\x93\xE9\x37\x98\x1F\xE8\x9E\x72\xD0\xE3\x92\x7F\x41\x42\xC6\x29\xDC\x0D\x8C\xC4\xCE\x4B\xFC\x33\xC8\x4D\xF6\x15\x4C\xBC\x0F\xE4\x8E\xBD\x8D\x9A\x36\x7E\x20\xA2\x80\x94\x60\x30\x4C\x74\xB1\x71\xB0\x40\x70\x9F\x39\x73\xE6\x20\x74\xAF\x21\xE1\xE3\x18\xBA\x07\xA5\x45\xA7\xEC\x67\xBB\xD0\xF7\x9B\x6C\x50\x94\x4D\xCE\xD0\xF8\xD8\x70\x72\x74\xBD\x9F\x8A\xE4\x59\x91\xC3\x50\x5E\x87\xD2\x31\xEB\x6E\xBB\xED\xB6\xF7\x01\xAC\x70\xFD\xC5\x8B\x17\xFF\xF2\x55\x57\x5D\x75\x32\xF6\x73\x63\x13\x3E\x31\x59\xB4\xE6\x2C\x13\x95\x10\x86\x63\x1C\x20\x4C\x8C\x50\x06\x06\xA2\x34\x84\xCC\x93\x05\xEF\x07\x72\xD7\xBA\x06\xFC\x38\x94\xFE\x75\x28\x32\x72\x2A\x6C\x78\x98\x20\x80\x20\x29\x36\x87\xCE\x61\x16\x9C\x94\xBF\x46\x06\x50\x52\xB5\x70\xAB\x9E\x5E\x67\xFC\xAC\xDC\x90\x33\xC0\x1C\xD7\x01\xBF\xE0\x1D\x63\xC2\xD8\x30\x46\xE6\x1F\xCA\xAB\xCA\x75\xA1\x42\x51\x24\xB5\x86\x8F\x03\x58\xB2\x8C\x89\xAA\x3C\x7F\x3C\x5F\xEC\x14\x70\x0F\xE5\xC1\x2D\x00\x48\xEB\x2A\x00\x00\x04\x20\x48\x73\x50\x10\x65\xD1\xA0\x5A\xC2\xFA\xE3\xC6\x73\x2B\xE4\x8B\xF3\xC0\x9B\xD3\x83\x1F\xD2\x39\x45\x07\x3E\xBF\x62\xCC\x57\x90\xAF\xE0\xCE\x56\x5C\xC7\x81\xDB\x3B\x05\x2F\x65\xFE\x1B\xFB\xF9\x3E\x38\x9E\xEE\xDD\xC3\xD1\x2B\x74\x10\x46\x0A\xFD\x63\x80\xC7\x78\x58\x9F\x31\x2E\xC8\x1A\xE4\x6C\x66\x3A\x64\xC1\xF2\x81\xBE\xA8\x88\x86\x29\xE5\x74\x73\x50\xDA\x47\x14\x7F\x62\xCE\x98\xC2\x1E\x0C\x00\x85\xB0\x87\x22\x03\x8A\x72\xD0\xE3\xC3\xFF\x1B\x6E\xB8\x61\x32\x77\xFE\x39\xAF\xFE\x71\x2C\x03\xC6\x9A\xD8\x70\x0E\x09\x2F\x2B\xD0\x5A\x26\x88\x0A\xF2\x78\x84\x7B\x14\xE6\x0D\x62\xBD\xF7\xD4\x53\x4F\x7D\x15\x4D\x46\x02\x95\x1F\x46\x3D\x98\x8D\x0F\xE3\x22\x45\xC9\xB3\xC7\xE4\xE5\x87\xF4\x9C\x44\x35\xF6\x42\xD8\xEE\xB9\xE7\x9E\x4F\x38\x7E\x9E\x21\xC1\xDC\x7E\xF1\xC5\x17\xBF\x1D\xD1\xCB\x65\x97\x5D\xF6\x0B\xCC\x1F\x26\x8A\x0C\xAF\x4F\x18\x20\xAE\x55\x41\xC3\x13\x45\x44\x7F\xAD\x80\x28\xEB\x26\xE8\x1D\x3C\x46\x8C\x17\xE3\xE6\xFB\x22\x82\x82\x0C\x45\x38\x5B\x65\x65\xA1\x09\x2A\x08\x63\xAA\x2A\x00\xE8\xE3\xFB\xAB\x5A\x78\xD2\x08\x1F\x43\xE3\xDF\xB3\x67\xCF\x17\x59\xB9\xB1\x94\xA0\xFB\xF6\x83\x57\xC8\x97\xF9\xC5\x27\x3C\x2D\x83\x00\xDA\xBC\xC5\xDC\x85\x8A\xCE\xDE\x83\x9A\x72\xD8\x48\xAA\x44\xBD\x34\x4E\x44\x34\x83\x5A\x5F\x5A\x05\x00\x9E\x47\x3A\xAF\x22\xC0\x2F\x47\x63\xCB\x41\x6E\x0C\x32\x0E\x9C\xCF\x91\xFC\x90\x4E\xD5\x84\xCC\x72\xDA\x70\xA5\x7C\x00\xCA\x74\x6C\x55\xE8\x4E\x2F\x7D\xAF\xE0\x77\x36\xC6\x5D\xBB\x76\x7D\x89\xAE\xC7\xA0\x5D\x80\xF1\x33\xAF\x18\x0F\xC9\x01\x73\x3D\x04\xE7\xA9\xF5\xF9\x81\x07\x1E\xF8\x0D\xD6\x15\xE8\x8D\x28\xF5\xCA\x52\x70\x1D\x7F\xC2\xBE\xF6\xA1\x01\x4F\xF0\xA7\x81\xB1\xAE\x94\x4C\xD1\x57\xC8\x0F\x3B\xC4\x4D\x9B\x36\x7D\x48\xE8\xD1\xF8\x7A\x2C\x77\xFE\xE1\xE6\x94\x88\x89\x22\x78\xB1\x61\x95\x0C\xCC\x0B\x23\x91\x6B\xDC\xB2\x78\x8E\xE0\x36\x3E\x97\x96\x12\x20\x78\x96\xC9\x33\x66\xCC\x78\xA7\x53\x84\x9B\x29\x3C\xBD\xF7\xE9\xA7\x9F\xFE\x13\x52\xC0\x1F\x0A\xCF\x0C\x01\xF4\xB2\xE1\xF2\xDA\x91\x84\x1F\x80\x0A\x12\x49\x74\x8D\x15\x4E\xD8\x5F\xA4\xD6\xD4\xFF\x10\x39\x0C\x00\xCA\x88\x3B\x77\x2E\x7E\x03\x00\x11\x18\xF1\x35\xFA\x05\x08\x54\x09\x14\x7F\x2A\x40\x28\xF0\xDC\x1C\x2D\xE1\x7C\x36\x7E\xDC\x13\xA5\x53\xE2\x69\x12\xC9\x6A\x80\xC3\x5A\x56\x2A\x5A\x33\x87\xFC\x18\x11\x80\xF4\x82\x56\x7E\x65\x5C\x3B\x2D\xB5\x69\x23\x5A\x79\x2F\x5D\x67\x80\xE4\x3C\xC2\xB9\x9C\xD1\xD1\xD1\x6F\x43\xA1\x40\x90\x13\x29\xE5\x26\x32\x9A\x3C\x2F\xA3\xE0\x65\x38\xCA\x32\x0C\xBF\x57\x00\xC0\x00\xF1\x38\xE9\x89\x27\x9E\xF8\x33\x9E\x67\x00\xA2\x91\xC4\xF3\x01\x40\x49\x01\x40\x99\xC6\x53\x60\x79\xC3\x2B\x73\x44\x07\x79\x0B\xC3\xB8\x92\x72\x55\x43\x34\x6F\x55\xC5\x4B\x86\xA3\x46\x96\xCF\xDC\xB9\x73\x4F\x52\xBC\xD4\x14\x5F\xC1\xBC\x63\x8E\x94\x7C\x18\xB0\x2B\x70\x3E\x6C\xDC\xEC\xC8\x84\x4E\x87\xFA\x8C\xF1\xD1\x71\xEB\x59\x9F\xA1\x37\xA2\xD2\x13\x80\x1B\xF3\x07\x9D\x76\x4B\xC0\xBF\xF2\xF0\xA7\x97\x46\x19\xB1\x94\xCC\xB3\xA1\x23\xEA\xD0\xBA\x2C\x92\xB2\x1C\x4D\x8E\xAB\xFD\x17\x28\xF9\xB7\xF7\x8A\x2B\xAE\x78\xAB\x30\x74\x69\x18\x03\x9A\x59\x78\x17\x91\x0C\x2C\x0A\xA6\xB2\x9C\xE1\xC6\xA0\x59\x31\xA8\xCC\x33\x49\xD1\x08\x19\x65\x90\x6C\x74\x02\xFA\x19\x8E\x85\x42\xA1\xD4\x48\x11\x46\x8D\x28\xF0\x3A\x0C\x12\x58\x8A\x90\xE1\x4C\xE2\x31\xE1\x1E\xD8\xE7\xC0\x69\xB6\x8B\x1E\x3E\x02\xE1\x5F\x7F\xFD\xF5\xA7\xA9\x44\xE6\x64\x2C\x69\xC4\x98\x86\x7C\x00\x00\xDE\xC8\x10\xC2\x70\x11\x1E\x96\x12\x2C\x9B\xF9\x3A\xB8\x1F\x5D\x7F\xAA\xC8\x95\x48\x00\xA8\x61\x7D\x1F\x64\xF5\xF6\xEC\xB9\x40\x28\x61\x4D\x00\x59\x9F\xF0\x44\x25\xD5\x67\xA1\x13\xAC\xE1\x43\x5B\x6C\xB0\x04\x96\x7D\x34\x4F\xD2\xF8\xA7\x51\x29\xF7\x14\xA7\x6C\x5F\xA1\xDC\xC6\xCD\x2C\x3F\x8C\x8B\xEE\x17\x18\x1E\x7B\x23\x64\xF5\x85\xF1\x33\xB1\xE7\xAC\x91\xAC\x86\x38\x5F\x04\x59\x8B\xB5\x7C\xD5\xD3\x27\x22\x01\xA0\xAE\x13\x90\xBC\x57\x49\x00\x40\x10\x29\x41\x5E\x0C\xB6\x88\xE8\x60\x1C\x98\x5B\x21\x6B\x59\x39\x28\x68\x3D\x44\xCE\x42\xF4\xAE\xF4\x1A\x5E\x5F\x53\xB0\x9F\xC7\xC5\xCB\x29\x9E\x2F\x18\xAA\x70\x1E\x43\xCA\xA9\xB1\x3E\x63\x6C\x27\xB1\x3E\xA3\xA3\x96\x23\x03\x01\x72\x01\xA8\x60\xDE\x08\x00\xFF\x94\x01\x7A\xFA\xF4\xE9\xEF\xF6\xF0\x97\x17\x11\x80\xCC\x25\x95\xA1\x8F\xE4\xF0\x2E\x47\x24\x72\xEB\xAD\xB7\xBE\x5F\x00\x87\x5C\xA6\x87\x0A\x14\xD4\xA2\x5D\xD8\xFC\x61\x11\xCE\x0C\x08\xC3\xEF\x27\xEA\x13\x61\x8E\x04\x81\x21\x95\x0C\xCC\x8B\x70\xA9\x40\x03\xAE\x11\x7A\x3F\x23\x8C\x7E\x58\xD1\x08\x97\x1C\x57\xAD\x5A\xF5\x65\x32\x92\x7F\x67\x2F\xBD\x68\xD1\xA2\x0F\xC8\x7B\x33\x00\x70\x9B\x32\x9D\x1F\x08\x9E\xBD\xBE\x30\xC8\x69\x82\x58\xA0\x21\x00\x50\xE9\x69\x50\xF1\x1A\x2A\x08\x00\x80\x00\x2E\x0C\x19\x45\xCB\xEA\xCD\xDC\x29\x29\x4A\xA5\x53\x94\xF1\xF7\x0B\xCF\x5E\x13\xAD\xD4\x21\xA8\x19\x00\x50\x51\x49\xB0\xA4\x2A\xFD\xC8\x26\x9C\xAC\x1B\xC7\xF9\x62\x0D\x3D\x20\x94\x71\xB2\xE8\xE5\x38\xC5\x11\xB2\xD1\x6F\x73\x0A\xB7\x04\x63\xBE\xF1\xC6\x1B\x3F\x2C\x96\x65\x7C\xDF\x32\xF8\x25\xE0\x95\x46\x5F\x16\x20\xC8\x39\x00\x06\x9B\x49\x52\xA6\x02\x00\x0A\x4D\x00\x40\x58\x05\x21\xC0\x29\x29\x8F\x5B\x66\x8F\xCB\x4D\x68\x4E\xC1\xAF\x93\x65\x69\xE2\xB9\x57\x80\xA6\x74\x42\x05\xCE\x15\x51\x5E\xA6\x26\x01\x5E\xF1\x55\x16\xF3\x1C\x56\x35\xA8\x33\x91\x1D\xD0\x80\x30\xE4\x61\x4F\x74\x1C\x02\xEF\x92\x25\x4B\x3E\xCB\xBA\xC2\xF2\xA1\x48\x27\x04\x1B\x00\x0A\xE6\x83\x75\x77\xCB\x96\x2D\x33\x3D\xFC\xC9\xE5\x4D\x18\xFE\xB3\xAD\x61\xA9\xC1\x20\x20\xF3\x60\x4E\x6E\xBF\xA6\x96\x93\xF5\x0F\x63\xF0\xFA\x14\x17\x50\x0A\xDB\x2B\x14\xA0\x22\x42\x26\x06\x83\x01\x36\x06\x4A\x06\xD6\x21\x37\x9D\xD3\xC7\x06\x2B\x0C\x43\x03\xCC\x90\x04\x01\xA0\x26\xC2\x69\x0E\xA1\x44\x83\x48\xA0\xD8\x1C\x6E\x43\xC8\xEE\xFE\x5F\x63\xA3\x36\x00\x60\xAA\x20\x59\xC5\x18\xE1\xC9\xA0\xD2\x93\xC5\x73\x95\x23\x00\x02\x80\x90\x77\x6E\x59\x45\x48\x4D\x61\xDD\xCF\xD4\x84\x0D\x8A\x48\x42\x86\x98\x35\x4E\x10\x09\x50\xED\xE7\x3A\xF8\xEC\xD9\xB3\x4F\xC1\x84\x91\x21\xE8\x5E\x78\x5D\x82\x0C\xE7\x8F\xFB\x08\x80\xF8\x32\x17\xD1\xEC\x86\xFB\xD3\x58\x7A\x15\xCF\x55\x65\x24\x05\x41\x65\xE2\x6D\x00\xED\xE1\x00\x6B\x3C\x2F\x72\x14\x00\x40\x1B\x64\x60\x20\xB4\x96\xFE\x12\x8E\x83\x93\xE0\xA6\x34\xD2\x9D\x9A\xF2\x8E\x19\xD9\xA3\xC0\xD7\x47\x42\x18\xF2\x45\x32\x58\x2C\xB3\xB4\xCE\x4A\x10\xA8\x09\x80\x0C\x1D\x20\x74\x99\xC2\x7F\x4B\x97\xFB\x69\x5F\x08\x02\xEE\xFE\x3F\x86\x03\x64\x00\x13\xD5\x8E\x40\x07\x70\x3D\xA9\xEF\x1E\xFE\x64\x44\xD8\x23\xCA\xC9\x59\x31\x1F\x7D\xBC\x0C\xDE\xB1\x63\xC7\x0C\xE4\xA2\x78\x8E\x69\x19\xC0\x0E\xE5\xB5\xB5\x23\xB2\xBB\x9C\xFC\x53\x0A\x5B\x31\xC2\xB1\x92\x00\x82\x30\x71\x26\x42\xF5\x92\x44\x6E\xF6\x12\x02\x00\x64\x48\x2C\x43\xB0\x9A\x14\xDA\x9D\x77\xDE\xF9\x99\x47\x1F\x7D\xF4\xEB\x3C\xE1\x04\x00\xEC\xE5\x47\x04\x00\x4C\x16\x86\x1D\x10\x0B\x19\xC2\x94\xE7\x88\xC8\x23\x40\x6A\x0E\x7F\xC5\x64\xF4\x2A\x6F\x57\xE6\xF5\x9E\x32\xD8\x21\x5E\x66\x60\x8C\x1B\x36\x6C\xF8\x06\x48\x19\x7F\x4D\x01\x67\x18\x3E\x42\x56\x74\xBD\x70\x59\xC5\x00\x00\x05\x55\x0F\xC3\xE4\x3C\x00\x90\x10\xAD\xC4\x05\x56\x70\x17\xDE\x7F\x0C\x13\x6F\x54\x70\xAE\x04\x20\xBA\x88\xE9\xFB\x92\xB0\x0F\xBF\xB9\xF5\xEE\x27\xE5\x52\x45\x81\x5E\x45\x18\xBF\x8C\xF0\x4A\xF4\x3B\x4A\x57\xCF\x48\x05\xF6\x00\x40\x47\x0B\x00\x50\x16\xFA\x13\x80\x26\xEE\x71\xE1\x85\x17\xBE\x0B\xF9\x1C\x0A\x8F\x27\xD3\x7C\xCA\xD0\x38\xA3\x3C\x63\x5D\x8E\xE1\xBE\xFB\xEE\xFB\xA8\x88\x74\x7B\xD5\x92\xA1\xAE\x32\x83\x7B\xDF\x71\xC7\x1D\xBF\x64\x25\xAE\xC9\x60\xEF\x95\x32\x53\x8E\xA3\x26\x22\xA3\x29\x58\xAE\x40\x57\xD8\x39\x89\xA8\x73\x40\x5C\x6F\x05\xF8\x6A\xC0\x5F\x5A\x55\x37\xEA\x72\x6D\x6A\xF9\x17\x10\x74\x42\xE4\x32\xF8\x1A\xAF\xD5\xFE\xDD\x0D\xFF\x82\x3C\xE6\x37\x55\x58\x54\x14\x13\x9E\x91\x21\x95\x98\x9C\x40\xA9\xDD\x35\xFE\x4E\x24\x03\xCB\x0A\x45\x25\x00\x0C\x08\xE3\x28\xAB\x50\xAF\x97\x7E\x0F\xFB\x0F\x58\x60\x30\x6A\x19\xE6\x0B\x00\xE0\xF5\x16\x1B\x78\x98\x03\x80\xE2\x0B\x84\x1E\x54\xE1\x78\xE8\x75\x29\x61\xD5\x2B\x4B\x80\x62\x5C\x65\x01\x00\xEC\x01\x86\x61\x30\x2A\xB9\xA8\x8D\x5F\xF2\x36\x4E\xA1\x48\x16\xE1\x52\x0A\x5D\x97\x64\x00\x7F\x8C\xE5\x01\xB5\x59\x97\xD5\x1A\x5A\x2E\x01\x92\x02\xFD\x8B\x98\x3B\xB1\x26\x1D\xF6\xE4\x59\xA6\x8A\x5C\x40\x5D\x6B\x37\x9D\x13\xCA\x07\x63\xA0\x10\x57\xEB\x42\x56\x50\xD0\xC5\x07\x63\xE7\x10\x97\x93\xB8\xB4\x64\x6B\x19\x00\x28\x07\x50\x97\xF0\xC5\x78\xD8\x93\x21\xB1\x26\x96\x71\xBA\x65\x38\x6D\x54\xA0\x02\xC3\x40\x62\x8C\xE5\x43\x6B\xEC\xBD\x28\x8F\xAA\xA8\x41\xEA\x77\xE0\xE8\xD0\xDB\x40\xB6\xF1\x5D\x31\x5F\x12\x00\xFA\x3C\xCE\xD2\xD2\xE7\xD0\x39\x89\xBC\xD3\x10\xF5\xD4\xFC\x1F\xF6\x03\xE0\x1A\xF0\xD7\x6D\x95\xD9\x15\x00\x0C\x29\x1D\x18\xE2\x25\x26\x3D\xA3\x81\xE3\x5F\x0B\x1F\x91\x99\x86\x40\xA8\x8E\xA9\x27\x5C\x96\x2B\x52\x1A\x59\x79\x92\x70\xAE\x48\x06\x8E\xF3\x7A\xA2\xDC\x56\xF3\x64\x6A\x43\x85\x22\xA6\xEB\x12\x7A\x0A\x00\x46\x84\x11\xC9\x3C\xC2\x10\x97\x61\x44\x58\xDB\x67\xAC\xF9\x82\x71\xB1\x50\x8C\xCC\x73\x41\x96\x1C\x2D\x00\xC0\x18\xE0\x91\x28\xAF\x31\x85\xC6\x65\x85\xA2\x52\xA1\xC2\x72\x9F\x88\x86\x02\x3E\x17\x2C\x58\xF0\x21\xDE\xCF\x95\x15\xCA\x16\xEB\x65\x40\x97\x5A\xFF\x07\x9E\x58\x01\xCB\x24\x23\xD7\x32\x49\x56\x03\x54\x45\x44\x27\x2B\xFB\xD0\x8F\x41\x20\x7A\x96\x91\x58\xE3\xDE\xFF\x12\x8C\x88\x97\x1C\x58\x8A\xC1\xB8\x48\x26\x03\x02\x00\x7A\x26\x08\x00\x61\xB9\x91\xCB\x62\x04\xEA\xD2\x38\x24\xC8\x74\xAB\x26\x2D\x7E\xD8\xA8\xC2\x91\x15\x96\x2A\x1C\xF9\x51\x14\x20\xCB\x6A\x19\xD5\xDA\x1C\xE6\x1E\x08\xD0\x06\x65\x04\x40\x3A\xD1\x6B\xC8\x27\x2D\xF4\xB9\x2A\x13\xA5\xAC\xCF\x7A\x49\xEB\xC2\xF3\xF3\x28\x4C\x3F\xAF\x09\xFE\x3A\xD5\xF3\x18\x69\x94\x72\xA1\x2F\xD0\x03\x8C\x6B\xE1\xC2\x85\x1F\x94\x76\xC1\x20\xED\x8E\xFB\x5B\x1A\xE7\xAB\xB5\x7F\xA7\xFC\xA7\x0A\x65\x93\xC6\x9F\x53\x0D\x22\xB2\x9B\xAA\xAE\x8D\x95\x8D\x9D\xCB\x62\xCB\x96\x2D\x7B\x8F\x2E\xB3\x08\x00\x90\xD9\xED\x8C\x68\x8A\x48\x29\xA1\x05\xC9\x16\x2E\xE9\xE9\xEA\x81\xF2\xA2\x75\x95\x0A\xCE\x49\xE8\xC4\x96\x5A\x5B\x86\xDD\x67\xA2\x6B\x4D\x87\xB8\x81\x72\xAA\x25\x40\x58\xF6\xE2\x1C\x02\x14\x4A\x4D\x58\x51\x19\x4A\x00\x00\x48\xC4\x88\x2E\xC4\x7B\x75\xD6\x18\x11\x0D\xF3\xCA\x46\x45\xBD\x0E\xE7\xE3\xB9\x00\xD5\xAC\x93\x92\x65\x34\xC8\x98\xBD\xA4\x88\x02\x86\x55\x04\xA4\x3D\xC3\xB0\x90\x9D\x0C\x63\x7B\x61\xD8\x5C\xB7\xA6\x9A\xB9\x8C\x06\x83\xA7\xFE\x90\x99\xE7\x84\x13\x42\x7F\xAC\x73\x85\x12\x0F\x18\x4F\xF3\x4D\x34\x02\x08\xF2\x0C\xB4\xCC\xDC\x47\xCA\x6D\xB5\x0B\x27\x3D\x00\x50\x95\x89\x3B\x38\x13\xAE\x56\x40\xBE\xE8\xF5\xA0\xE6\x9A\x9C\x04\x7E\xC7\xE3\x1F\x08\xBD\xAD\xD3\x31\x91\xC7\xA9\x18\x0F\x6F\x79\xF5\x99\x9D\x93\x78\xE6\x21\x98\x13\x94\xFA\x38\xFB\x8F\x36\xFB\x08\xFE\xBA\x54\x12\x38\x88\x00\xD0\x9D\x49\xC9\xC3\x33\xB9\x3A\x25\x6C\x66\x58\x01\x00\x78\x7C\x55\xF8\x9C\xFC\xC3\xF3\xFF\xAA\x01\x23\x6D\xAC\x3D\xAD\xF5\x67\x18\x09\xF0\xDB\x5C\x8C\x52\x4B\x4D\x44\x07\xB2\xC3\xAB\x47\xA1\xB6\x16\x5A\x8D\x07\x4E\x02\x0B\xBD\xBD\x30\x22\x99\xB9\x0F\x88\x1B\x81\xC4\x33\xE5\x32\x14\x2F\xE8\xF6\x5B\x91\x70\x93\xC6\x1F\x7A\x6F\xB1\x1E\xEE\x13\x09\x9E\xC0\x90\xD8\x50\xA9\x77\xA2\x4F\x29\x44\xE8\x4D\x00\x8A\xA2\xFB\x70\x9F\x05\x00\xF3\xE7\xCF\x3F\x95\x95\x00\x25\x50\x7E\xEF\x02\x6F\xA2\x03\xAC\x47\x81\x70\x10\x6E\x22\x01\xC8\xE7\x8B\xF2\xD4\x80\xAA\xE2\x48\xD2\x51\x51\x5D\xE4\xC6\x51\x00\xC6\x4D\x20\x50\xA2\x92\xD5\x2C\xD9\xA4\x02\x83\x67\xE3\x17\xCB\xB2\x7E\x92\x7D\xCE\xF3\x38\x70\x2B\x39\x80\x20\x0A\xE0\x3A\x3A\x64\x0E\x8F\x2E\xB2\xFE\x39\xA3\xBB\x2E\x25\x5A\x8D\x03\x00\x40\x94\xC5\xF2\xC1\xD2\x92\x2B\x4C\xBC\xE1\x21\x2C\xE6\x11\x09\x33\x06\x40\x2A\xA5\xD5\x25\xF9\x28\x29\xB9\x5C\x39\x33\xED\x2C\xA5\x3E\x57\x64\xF5\x88\x72\x24\x03\xD6\x32\x10\xFC\x21\x19\xEC\xE1\x4F\xB7\xA2\x07\xCB\x40\xD9\x47\xE0\xF4\xFE\x5A\xE6\x09\x3C\x43\xC7\xB8\x6B\x97\xCA\x99\xAF\x02\x80\x7C\xE7\x9F\x4A\xF4\x64\xDB\xFC\xAF\xFA\x6A\x37\xD6\xA0\xE1\x9A\x09\x89\x06\x5A\xBF\xD6\xD5\x5A\x05\x00\x68\x81\x25\x8C\x75\x2D\xF7\x0F\x94\xB9\x0C\x43\x99\xFA\xB0\xD4\xA2\x96\x14\x75\x8D\x1C\x7C\x0E\x01\x91\x4C\x5E\xD5\x35\xF2\x70\xE6\x5C\x3C\xB8\x92\x53\xF5\xE3\x2C\x77\x7D\xE9\x2A\x00\x47\x02\xF0\x46\xEC\x05\xB1\x6E\x26\x01\x33\x98\xE4\xD1\xC5\x88\xBC\x08\x7B\x7E\x00\x85\x58\x3F\x8E\x0B\xCF\x97\x2E\x5D\xFA\x69\xEE\x70\x83\x57\x05\x8A\xE3\x1C\xE4\x58\x70\x5D\xF7\xFD\xED\xE8\xF5\xA7\xBE\x72\x19\xAE\x06\xA1\x26\x92\x5C\x7C\xBE\xE3\xFF\xDF\x44\x1D\x38\x90\x11\x9A\x84\x20\x17\x11\xDA\x17\x8D\x2C\x38\x97\xF8\x7A\xD9\x30\xE9\xD9\x8C\xB3\xD0\xFF\x80\xE5\x1E\xD6\xD4\xE8\xFE\xBB\xFB\xEE\xBB\x3F\xC5\x91\x0B\xBC\x2A\xAD\xD1\x87\xE9\x7E\x1C\x09\xF1\x1B\xA3\xDA\x7D\x00\xA0\xE6\xA2\x64\x94\xE5\x82\xA5\x21\x2F\x05\x78\x3C\xF3\xE6\xCD\x9B\x22\x1D\x16\x3D\x04\x35\x8F\x9E\x9F\x08\x9F\x35\xA0\x39\x9B\x84\x26\x2D\x4B\xBE\xD4\x3C\xD3\x0B\xA0\x96\x3C\x53\xD9\xB0\x5F\x97\x72\x85\x53\x90\xD1\x72\x77\xB3\xFA\x4C\xE5\xDA\x71\xA5\x75\x5E\x96\x32\x7F\x02\x00\xEA\xF8\xA3\x87\xD4\xEA\xD6\xFF\xEC\x60\x10\x91\xA2\x3C\xCE\xD5\x31\x76\x24\x2A\x62\x69\xCB\xF0\x9B\x7E\x45\xE2\x4E\x33\x63\xBD\xE6\x4B\xBF\x09\x26\x2D\x18\x2C\xF1\xA3\xC4\xD4\x58\x62\x01\x80\x25\xB0\x0E\xE3\xB9\x84\x1C\xF5\x3D\x7F\x4E\x24\xEA\x42\x04\x56\x4B\x0A\xE9\xBD\x2A\xFC\x48\x2A\xF5\xF7\x17\x54\x48\x1F\xF6\x28\x28\xA5\xCB\x2B\xE3\x0F\xD7\x83\x02\x00\xAC\x36\xD8\x7E\xA0\x35\x37\x86\xF0\xF3\x05\x38\x47\xB6\x8B\x62\x42\x91\xE0\x53\x09\xA4\x21\xE1\x01\xC2\xC4\x27\x2A\x20\x1C\xA2\xB2\x47\xA0\x2C\xF8\x3A\xF9\x44\x9F\xCA\x31\x54\x18\x9C\x00\x02\xB2\x14\x08\x80\xA2\x66\x26\x79\xFE\x5A\x83\x67\x33\xC9\x2B\x9F\xCD\x60\xB9\x63\xFC\xDC\x62\x4D\x60\xF3\x63\x91\xB9\x1E\x8C\x28\x01\x9A\x0E\x44\xCD\x85\x05\x48\xCC\x5F\x9F\x7C\xF6\x80\xBB\x15\x21\x0F\xF9\xD4\x27\x9E\x89\x30\x92\x63\x00\xA6\xC9\x86\x7C\xD7\x13\x3F\xEB\x8C\xDA\x79\x4D\x2F\x8F\x54\x73\x58\x5E\x3D\xF0\xD4\x15\xA1\xCF\xE1\xFB\x12\x28\xEF\x24\x3B\x11\x59\x9F\x82\xFC\x4B\x23\xFE\x9C\x47\xFF\xB6\xEA\x01\xA8\xE8\x1E\x00\x00\x33\x83\x9D\x88\x2A\x78\x59\xD6\x96\x41\x77\x14\x2E\x4E\x28\x5A\x34\x98\xE9\x8C\x78\x79\x41\xA7\x27\x1F\x50\x46\x2E\x80\x96\x14\x61\x2D\x1D\xEB\x45\x02\x1A\x1D\xFE\x77\x45\xBC\x29\x27\x87\xE6\x22\x78\x56\xCA\xD8\xB2\xB7\xAF\xE1\xA1\x16\x81\x90\xE3\x08\x4B\x1B\x34\x37\x19\x99\x6B\xA6\x3C\x7E\xC7\x43\x3A\xF4\xAC\x41\x4E\xB5\x8E\x86\x0F\x1E\xA1\x4A\x42\x63\x2F\x19\xA1\x69\x38\x26\x4C\x2A\x78\x67\xE5\x00\xE1\x21\x11\x4C\x28\x09\x7F\x90\xCB\x8F\x68\xF7\x54\xE1\xB8\x6E\xDB\x9D\xE6\xC0\xEF\x3B\x30\x2C\x4C\x24\x27\x9D\x70\x7D\xCC\x9B\x5A\xA6\xE4\xE5\xC3\x39\xAC\x4C\x30\x14\x24\xBA\x38\x5C\x05\xE1\x7C\x67\xD0\x5F\x56\xDD\x64\x3D\xEA\x61\x97\x9C\xAC\x5C\xE0\x9A\x18\x3F\xBC\x24\x1B\x3F\x97\xAD\x50\x05\x11\x5D\x96\x53\x44\xD9\xAA\xE4\x09\xFF\xCD\x37\x22\xA9\xB9\xC8\x5B\x11\x9B\xCC\x09\x20\x0A\x81\x4E\x49\x59\xC3\x48\xF0\x84\x23\x3D\xEA\x9C\x16\x39\x18\x8E\x90\x38\x23\x6F\xCA\x17\x04\x79\xD1\xDB\x88\xFA\xAC\x67\x04\x78\xFE\xA1\x0F\xD0\x0B\x23\x57\xD6\xE9\xE1\x33\x90\x2B\x4A\xEE\x98\x03\x5A\x52\x59\xB9\x8E\x86\xFC\xD1\x7B\x18\x34\x7F\x41\xBF\x0D\x3A\x73\x91\x9B\x22\x9E\x56\xA0\x99\x8E\x4A\xBC\x43\x62\x59\xF6\x5A\x0E\x40\x65\xBD\xB3\x86\x67\x6E\x6F\xF6\x7D\x70\xAA\x86\x6A\x51\xB1\x81\xC0\x3A\x8C\x37\xCD\xE4\x85\x90\xE4\x1A\xB5\x2A\xF2\x09\x16\x15\x3D\x0F\x4D\xE8\xEE\xA9\xA2\xE2\x5D\x1B\x44\x46\x24\x86\xB4\x57\x2A\x47\x3C\x50\x52\xB5\x9A\xA6\x44\x42\xAE\x5F\x54\x44\x64\x5B\xED\xA0\x50\xD2\xA9\x46\x49\xA8\x6A\x94\xE4\x72\x46\x8F\x46\xCD\x7A\xB8\xC9\xF3\xC6\xA1\xBA\x67\xED\x15\x08\x54\x54\xC4\x33\xA4\x2A\x0A\xBE\x31\xEA\x16\xE0\x0E\xE5\x3C\x64\x04\xA9\xE7\x42\x83\x71\xD6\x00\x25\x6D\x98\x25\xA3\x52\x91\x51\x15\xAB\x9A\x02\x01\xD9\x20\x36\x22\x92\xA2\xFD\xAA\x8F\xA3\x6C\xF4\xC3\x14\x8C\x44\x76\xA2\x09\x7D\xCE\x79\x74\xD5\xA7\x4F\xBA\x09\xCB\x8A\xD8\x8A\x22\x42\x1A\x94\x65\x47\xC1\x97\x4C\x2A\xE2\xBC\xBA\x01\xC9\xF2\x45\xB3\xEF\x61\xEF\x50\x08\x27\x41\xA0\xA0\x12\x6F\x45\xA3\xAC\x68\xBD\xF6\x7A\xDC\x6B\xA6\x95\x72\x14\x55\xDF\x80\x2F\xBC\xD7\x3C\xF5\x18\x94\xF6\x1C\x97\xD2\x8F\x59\x1A\xD1\x83\x6C\x75\x96\x21\x6A\xD5\xE8\x33\xEF\x53\x09\x38\xFD\xB0\x4F\xD1\x08\x73\x65\x34\x30\x22\x4A\x8C\xFD\x46\xBB\x6B\xDA\x2A\x5F\x79\x40\xA9\xEC\x89\xF4\xF4\x9B\x76\x64\x85\x41\x2A\x57\x5D\x02\x54\x35\x58\x0D\xA9\xB2\x55\xC6\xE3\x48\xAC\xD7\xA2\xA7\x9B\x98\xB3\x8C\x02\x01\x29\x6F\x9F\x91\xA4\x8D\xB2\x75\xAF\x47\xBE\x93\x84\xA1\xF4\x19\x5D\x82\x56\x82\x58\x3E\xFD\x6A\xFD\x7F\x0C\x4B\x9F\xD3\x1E\x7D\xCA\xAB\x4E\x44\xFD\x6C\x82\x0F\x04\x72\xAA\xEF\x40\x82\xB4\x2C\xEF\xD6\x54\x5F\x49\xA8\xDC\x69\xA5\xFC\xCD\xFE\xA3\x0F\x3D\x91\x12\xE5\xB2\x1E\x83\xCC\xA8\x6C\x6D\x97\xA1\x1C\x9D\xC6\x35\xB3\x0D\x0C\x3C\x8A\x52\x9E\xD7\x7F\xA5\x0C\xDE\xBB\xAD\xE7\xB4\x23\x00\x24\xA3\xBA\xC7\x4A\x2A\x5A\xA9\x7A\xBC\x55\xD9\xF0\x76\x75\xFD\x02\xA2\xE4\x38\xA8\x1E\x50\xD2\xCF\xC9\xF7\xA8\xB9\xB4\xC6\xA3\x3D\x98\xCE\xC1\x58\xCF\x18\xA4\x0C\xA3\xEB\x35\x12\x57\xD6\xD8\x32\x46\x12\xB9\xDD\x70\x1E\x89\x26\xE6\xA2\xDB\x88\x4C\x0A\x46\xA4\x59\x32\xA2\x39\x4B\x36\x45\x23\xE2\xD2\x7C\x54\x3D\xB5\x7D\xFD\x5E\x80\x1E\x95\xF9\xEF\x6C\x42\x9F\x53\x11\xBA\xA4\xF5\x20\x8A\xBF\x8C\xF5\x62\x19\xA1\x3B\xFA\xB9\x16\x3D\x37\x75\x03\x4A\x45\xBC\x27\xAE\x11\x00\x74\x1A\xDE\xA3\xC7\x43\x29\xCF\xFB\xD1\xA2\xAE\xD9\xED\x11\x58\x94\xB2\x74\x2B\x9E\x12\x06\x25\x5B\x3C\xAE\x5B\x85\xCA\xDD\xEA\xD5\x5E\xB9\x06\xD1\x4F\x51\x79\x13\x9F\x92\xEA\x26\xAB\xAA\x27\xCC\xF5\x85\xEF\xD6\x78\xAC\x65\x9E\xEF\x75\x60\x9D\x1E\xEF\xDC\xC8\x3B\x15\x3D\x2F\x01\xF5\xBD\xC3\xB0\x43\xBF\x9B\xAF\xC1\x5C\xE8\x48\x53\xF3\x97\x37\x22\x59\xFD\xC6\x9C\x1E\x25\xDF\xB2\x8A\x22\x2A\x46\x94\x94\x56\x36\xD2\x6D\xE8\x83\x8F\x57\xEF\x7B\x15\x23\x74\x29\xDD\x24\x7F\x5A\x6F\x32\x2A\x02\xAC\x18\xFC\xC8\x52\x65\xDD\x80\x12\x6D\x13\xFB\x7F\x74\xD6\x1B\x4C\x2D\xA3\xB1\x84\xE5\x13\x98\xBE\x66\x42\x4D\xA2\x75\xBD\x28\x8A\x7A\x03\x70\xA2\x89\x97\x2C\x76\xF9\xDE\x0B\x67\x44\x09\x69\x63\x99\xA0\x4B\x8B\x1A\xB8\x92\x86\x11\xA4\x95\x37\xF0\x29\xB8\xF5\xBE\x44\x0D\x04\x59\x55\xD9\xB0\xFE\xF3\x50\x87\xF5\x96\xA1\xC5\x8B\x17\x23\x69\x55\x98\x3B\x77\x6E\x69\xF6\xEC\xD9\x95\x59\xB3\x66\xF5\xCE\x9C\x39\xB3\x36\x63\xC6\x8C\x3E\xD0\xF9\xE7\x9F\x5F\x93\xAD\xE2\x38\x0E\xC7\xE3\xBC\xD5\xAB\x57\x67\xE6\xCD\x9B\x17\x24\x78\xC7\xC6\xC6\x92\x8E\x52\x4C\x3B\x76\xEC\x48\xF1\x7D\x56\xAD\x5A\x95\x5E\xBE\x7C\x79\x16\xE7\x2C\x5C\xB8\x30\x7F\xCE\x39\xE7\xE0\x4D\x44\x78\xD9\x4A\x46\x12\x1F\x83\xEB\x5F\x7B\xED\xB5\x85\x33\xCE\x38\x23\x8B\x31\x5D\x7E\xF9\xE5\x55\x26\x7C\x9F\x33\x67\x4E\xD9\xDD\xB7\x88\xE3\xDC\x27\x78\x4D\xDC\x72\xCB\x2D\x3D\x7C\x7D\xFC\x36\x7D\xFA\xF4\xC2\x45\x17\x5D\x14\xF0\xC3\xBC\x9C\x7A\xEA\xA9\xC1\xB2\xCA\xFD\x1D\x5C\x8B\xAF\x73\xE6\x99\x67\xF6\xDC\x74\xD3\x4D\x39\x9C\x0F\xE2\x71\xC8\xEF\xE0\xE1\xFE\xFB\xEF\xC7\x7B\x21\xD3\x3B\x77\xEE\xEC\x21\x3E\x3B\x36\x6F\xDE\x8C\x7F\xAE\xDB\x83\xFD\x38\x06\xB2\x96\xE7\x2F\x5D\xBA\x34\xC3\x72\xE6\xF1\x61\xDC\xAC\x03\x97\x5E\x7A\x69\x59\xF2\x87\x31\x41\xC6\xCC\x1F\xE6\x9F\xCF\xC1\x3E\xFC\x8E\x79\x3E\xFB\xEC\xB3\xCB\x98\x27\x10\x78\x3C\xF7\xDC\x73\x4B\x06\xE8\xD7\x29\x78\xC3\x57\x07\x47\x00\x80\xF5\x3A\xE2\xAE\xB6\xE8\xD7\x71\x37\xFA\xB7\xD1\xBE\x57\x6D\x6B\x03\xF4\x19\xAD\xEF\x95\xC8\xD6\xAB\x9C\xA3\x8E\xB1\x8E\xED\x68\x00\x7A\xA9\x88\xE8\x47\x1B\x7D\x57\x04\x28\x75\xAB\x68\xC7\x02\x8E\xAE\x08\xC0\xEA\x56\x79\x8C\x1E\xCF\xFD\x7D\xAF\xCF\xEE\xD8\xB6\x6D\x1B\x1A\x57\xFA\xD6\xAD\x5B\xD7\xFF\xE0\x83\x0F\x0E\xAC\x5C\xB9\x72\x10\xE4\x94\x78\x88\xE9\xEA\xAB\xAF\x86\x77\x49\x9D\x76\xDA\x69\x29\x1C\x37\x3A\x3A\x5A\xC3\x79\xBB\x77\xEF\xAE\x42\xF9\x31\xA1\xCE\x18\xF0\x0A\xB7\x32\xD3\x81\x03\x07\x0A\x7C\x8F\xED\xDB\xB7\x17\x70\x3C\xD3\x92\x25\x4B\x52\x38\xD7\x22\x1E\xCF\x8A\x15\x2B\x2A\x57\x5E\x79\x65\x56\x8E\x09\x84\xEF\x20\x8C\x03\xC7\x61\x2C\xCE\x70\xF0\x86\xDC\x0C\x5F\x1F\xFB\x61\x34\xCB\x96\x2D\xAB\x4A\x5E\x2E\xB9\xE4\x12\xF0\x91\xBE\xFD\xF6\xDB\xFB\xE4\x75\x00\x1E\x1B\x37\x6E\x2C\xF2\xF9\x3C\x0E\xF9\x1D\x3C\x80\xD7\x43\x87\x0E\x55\x40\xC4\x67\xC2\x51\x96\xF7\xB9\xDF\x2B\x2C\x53\x26\x9C\x27\xF7\x61\xBC\x18\x1F\xE6\xC7\x19\x74\xBE\x11\x7F\x98\x43\x3E\x87\xE7\x09\xF3\x0B\x30\x90\xE7\xE1\x7B\xDB\xF8\x17\x92\x9A\x8A\xDE\xEA\x3F\x30\x68\x6B\x9B\xD8\x3B\xFB\xA3\xEE\x33\x91\xEB\x35\x7B\xAF\x56\xFF\x81\x87\x3E\xCE\xB7\xBF\xD3\x88\x0A\x34\x59\x11\x89\xE5\x79\x1B\x5D\x2F\x61\x78\xEE\x8E\x16\xC6\x93\xF0\x78\xFE\x71\x91\x98\x36\x3C\x56\x32\x49\x30\x26\xF6\xB2\x6C\x10\xC2\x10\xB2\x04\x00\x25\x09\x00\x20\xBE\xC7\xFE\xFD\xFB\xF3\x38\x96\xEF\x05\x4F\xCA\xE7\x6B\xE2\x63\x36\x6C\xD8\x90\xC3\xFD\xAC\xF1\xB0\xE1\xF3\x58\x70\x3D\x36\x4E\x3E\x1F\x80\xF0\xD0\x43\x0F\x15\xE4\xF9\xC4\x47\x52\x5F\x03\x51\x0C\x0C\xD5\x37\x16\xFC\xBD\x67\xCF\x9E\x0C\xDF\x43\xF0\x08\x00\xC8\xE3\x6F\x3E\x07\xFC\xF2\xB9\xF8\x04\xEF\x72\x1F\x13\x47\x0A\x51\xFC\x39\x82\x57\xEF\x94\x73\x04\xE2\x88\x82\xE7\x0B\x84\xEF\x56\x74\x3F\x91\xFF\x80\xD3\x2A\x18\xB4\x1F\xE1\x7D\xDA\x5F\x47\x8A\x1A\x43\x5B\x03\x30\x68\x14\x85\x34\x73\xFF\x56\xFE\xC9\xC3\xD1\x38\x7F\xDC\xA6\x15\x1E\x86\x80\xF7\xE1\x4B\x2F\x06\x63\xC2\xB5\xA4\xE1\x0A\x23\x28\x22\x14\xD6\xC6\x4F\x14\xDC\x93\x01\x80\x09\x61\x33\xF6\x51\xD4\x50\xD2\x91\x03\x7E\x73\x21\x75\x02\xF7\x93\x8A\xBF\x75\xEB\xD6\x2A\x3C\x35\x3E\xA5\x71\x72\x18\x2E\xEF\x81\xEF\xCE\xC0\x92\xF2\x7C\x9C\x8B\xE8\x83\x81\x03\xB4\x6F\xDF\xBE\x9C\x04\x29\x26\x1E\x07\x13\xF1\x98\x50\xFC\xE9\xEF\x65\x8C\x45\x8F\x43\xCB\x99\x81\x02\xCB\x06\x39\x3E\xC8\x1D\x63\x04\x61\x1E\x1C\x18\xA4\x18\x3C\xD4\xB9\x1D\x7C\x2E\x13\xBE\xB7\x18\xD9\xC7\xDB\x31\x02\xC0\xA3\x79\xBD\x63\x7E\xBE\x54\x5E\x56\x4C\xCB\x98\x68\x9D\x9F\xF2\x18\x7A\xB7\x67\x7F\xC2\x5A\x1E\xF0\xFE\x46\xBF\x69\x63\x62\x6F\xCA\xC6\xAA\x0C\x51\x8F\x2D\xC8\x82\xC3\x90\xF9\xFC\x83\x07\x0F\x96\x8D\x30\x3E\xD9\x68\x1C\x62\xAC\x89\x26\xF8\xEE\xB6\xC6\x61\x44\x47\x6D\x3E\x39\xEB\xF9\x6B\xE6\x5C\xBE\x4F\xBC\xC5\x5B\x4B\x9B\xA5\x5C\x3E\x63\x8A\x00\x80\xE2\xB1\x00\x00\xC3\xE0\x72\xBE\x73\x22\xC6\xDC\x1D\x31\xD6\x62\xC4\x38\x2C\xB9\xB4\xEB\x7B\x18\xC7\xEA\x7D\xC9\x56\xE5\xDC\x68\x8E\x3C\x14\x03\x40\xBC\x1D\x73\x00\xC8\x35\xA9\x8C\x8D\xCE\x9B\x28\x00\xF8\x28\x0A\x00\xDA\xAD\xFC\x84\x36\x9A\x66\x00\xC0\x90\x57\xB1\x09\x30\x4C\xC4\x00\x10\x6F\x6F\x46\x00\xC8\x78\x94\x3F\xF7\x3A\x00\x40\x47\x94\x31\xB9\xBF\xD3\x51\x39\x8A\x16\x01\xA0\xD8\x22\x08\x76\xC4\x00\x10\x6F\x6F\x16\x00\x28\x35\x08\x7F\x73\xCA\x90\xB2\xC7\x01\x00\x52\x8D\x8C\xC9\x93\xA4\xCC\x28\x39\xE4\x8C\x50\x3E\xC1\xD4\x00\x28\x20\x97\x6C\x0B\x91\xC3\x91\x02\x40\xC2\x00\xE0\x18\x00\xE2\xED\xC8\x01\x20\x4A\xB9\x0C\x03\xC9\x35\xD8\x97\x3B\xDA\x39\x00\x63\x4D\x9F\x69\xC6\x98\xB8\x5C\xA7\xD7\xE6\xCD\x02\x80\xA3\x2E\x3A\x2E\xE3\x01\x3E\x0B\x10\x4B\x2D\x02\x40\x46\xDD\xF3\x88\x97\x0F\xF1\x16\x6F\xAD\x02\x40\xD9\x93\xD8\xEA\x30\xF6\x65\x8D\x0C\x78\x4E\x27\xD9\x8E\x32\x00\x58\xDE\xBC\xBD\x09\x00\x88\xCC\xF2\x37\x91\xDF\xC8\x45\x24\x42\x53\x9E\x68\x25\xD7\x22\x00\xF8\x92\x8F\x31\x00\xC4\xDB\xEB\x0E\x00\x09\x63\x5F\xCA\x88\x1E\x72\x86\xB2\x1E\xED\x2A\x40\xBE\x89\xB1\x1C\x4F\x00\x48\x1A\x15\x82\x70\x09\x14\x03\x40\xBC\x9D\xC8\x00\x50\xF4\x34\xC1\xA4\x48\xF1\xB5\x27\x3E\x1E\x00\x90\x7E\x1D\x01\x20\x11\x91\xE8\x2B\x45\xE4\x21\x2C\x23\xEE\x68\x94\x54\x3C\x22\x00\xC0\x2B\xDF\x63\x8A\x29\xA6\x9F\x4F\x8A\x85\x10\x53\x4C\x31\x00\xC4\x14\x53\x4C\x31\x00\xC4\x14\x53\x4C\x31\x00\xC4\x14\x53\x4C\x31\x00\xC4\x14\x53\x4C\x31\x00\xC4\x14\x53\x4C\x6F\x56\xFA\x7F\xA7\xD7\xDB\x72\x23\x95\xE4\xF1\x00\x00\x00\x00\x49\x45\x4E\x44\xAE\x42\x60\x82"

_mouse ="\x89\x50\x4E\x47\x0D\x0A\x1A\x0A\x00\x00\x00\x0D\x49\x48\x44\x52\x00\x00\x00\x20\x00\x00\x00\x20\x08\x06\x00\x00\x00\x73\x7A\x7A\xF4\x00\x00\x00\x09\x70\x48\x59\x73\x00\x00\x0B\x12\x00\x00\x0B\x12\x01\xD2\xDD\x7E\xFC\x00\x00\x06\x93\x49\x44\x41\x54\x58\x85\xAD\x97\x5D\x6C\x54\xC7\x15\xC7\xFF\x73\xCE\xDC\xDD\x15\xB6\x77\x37\xAE\xCA\x4B\xDB\x00\x2E\x0F\x3C\x90\x44\x25\x52\xA8\xE4\x42\x1C\x45\x6A\xD2\x58\xD0\x4A\x4D\x53\x70\x85\xFA\xA1\xA4\x0A\x34\x52\x53\x25\xE0\xD2\x86\x36\x90\x26\x34\x21\xC1\x20\xAA\x26\x46\xAA\x21\x28\x01\xA5\x69\x48\xE4\xE0\x04\x48\xC0\x90\x58\x6D\x51\x4B\xD5\x9A\x90\x54\x0A\x14\xF9\x03\x7B\x77\x6D\xEC\xF5\xDA\xFB\xE1\xBD\x77\xE6\xF4\x61\xEF\xDD\x18\xEA\x2F\x5C\x8E\x34\x0F\x3B\x77\x76\xE6\x77\xCF\x9C\xFF\x7F\xE6\xAA\x96\x3F\xB4\x60\x7F\xCB\xCB\x0F\x57\x55\x55\xDE\x0D\xA5\x9E\xB5\xC6\xFE\x1D\x0A\x1A\x80\x87\x39\x06\x11\x21\x97\xCB\xA1\x69\x77\x13\x6E\xBB\xED\x56\x58\x6B\x41\x44\x93\x8E\xD5\xDD\x5D\xDD\xDF\x3E\x73\xE6\xCC\x8B\xD1\x68\x15\xB2\xD9\xDC\x3D\x15\x15\x95\x6B\x8D\xE7\xB5\xF9\x10\x06\x80\xCC\x05\x60\x74\x74\x14\x99\x91\x0C\x00\x40\x64\xEA\x29\xB4\xE3\x38\x0B\x22\x91\x08\x0E\xBC\x72\x60\x7C\xFB\xF6\xDF\x56\x9E\xFD\xDB\xD9\xB7\xE7\xCF\x9F\xBF\xC1\x75\xDD\x97\x80\xB9\x41\x10\x11\xAC\xB5\x60\x9E\xFC\xAD\xAF\x1A\xCB\xCC\x9F\x8E\x8C\xA5\x51\x51\x51\x11\x3A\x71\xF2\x7D\x59\x71\xE7\x0A\xDB\xDF\xDF\xFF\x22\x33\x3F\x65\xAD\xF5\xAC\xB5\xE4\x37\x5C\x6F\x9B\x0D\x35\x29\xA5\x2E\x03\xF0\x2E\x5E\xBC\xA8\xB4\xD6\xF4\xC6\xE1\x3F\xD1\xDA\x86\x35\x5E\x22\x91\x78\x42\x6B\xBD\x5F\x29\xA5\xFC\x0C\xF0\xF5\x64\x61\xB6\x41\x00\xFA\x00\x64\xFA\x2E\xF7\x01\x80\x68\xAD\x55\xCB\xFE\x16\xDD\xB8\xB9\xD1\x4D\x26\x12\xDF\x57\x50\x6D\x44\x14\x45\x69\x2B\x6E\x38\x04\x09\x30\x04\x60\xA0\xBB\xA7\x07\x00\x84\x88\x60\x8C\xC1\xD6\x6D\x4F\x3A\x4D\x7B\x9A\xBC\x74\x26\xFD\x75\xE3\x99\x0F\x99\x79\xA1\x0F\xA1\x6F\x2C\x80\x48\x91\xC0\x89\xFE\xBE\x52\x06\x98\x19\x44\x04\xCF\xF3\xB0\x7E\xFD\x7A\x7D\xF0\xD0\xAB\x5E\xD1\x2B\xDE\x92\xCF\x17\x3A\xB4\xD6\xB7\xA3\x24\xCF\x1B\x06\x41\x22\x02\xCD\xBA\x27\x99\x4C\xA1\x58\x2C\x4A\x69\xCB\x01\xAD\x35\x3C\xCF\xC3\xAA\xD5\xAB\xF4\x3B\xEF\xB6\x99\x58\x3C\xFA\x85\x4C\x26\x73\x5A\x3B\xBA\x7E\x02\x84\xBA\x31\x00\x5A\x77\x0F\x5D\x19\x42\x3A\x9D\xBE\xEA\x61\x00\x71\xC7\xF2\x3B\xF8\xF8\xFB\xC7\x6C\xCD\x97\x6B\xE6\x5D\x19\x1C\x6A\x75\x1C\xE7\xC7\x3E\x04\xFF\xBF\x10\x84\x52\x06\xBA\x46\x47\x47\x91\x4A\xA5\x00\x5C\x6D\x1C\x5A\x6B\x18\x63\x50\x53\x53\x43\xEF\x9D\x38\x2E\x77\xD6\xAD\x94\x64\x32\xD9\xEC\x38\xCE\x36\x1F\x82\xFC\x36\x47\x00\x00\xC4\xD4\x9D\xCF\xE7\xD1\xDF\x9F\x50\xD7\x02\x00\x00\x33\xC3\x18\x83\xEA\xEA\x6A\x3A\xFC\xD6\x61\x5A\xD3\xB0\xC6\x4B\x24\xFA\xB7\x68\xAD\xF7\xF9\x5B\x36\x67\x99\x12\x00\x28\xA8\x7E\x63\x0C\x7A\x7B\x7A\x78\x32\x80\x00\xC2\x5A\x0B\xC7\xD1\x6A\xDF\xFE\x16\xBD\xE9\xE7\x9B\xBC\x64\x32\xF1\x03\xA5\x54\x1B\x11\x55\x62\x8E\x32\x2D\xA5\x4E\x21\x21\x22\x63\xBD\xBD\x97\x83\xB7\x99\x7C\x30\x11\x94\x52\x30\xC6\x60\xDB\x53\xDB\xF4\xCE\xDD\x3B\xBD\xF4\x48\xFA\x1E\x63\x4C\x07\x33\x2F\xC0\x1C\x64\x4A\x00\x20\x22\xC3\xCC\x3C\xD0\xE3\x7B\x41\xA0\x84\xC9\x42\x29\x55\x96\xE9\x86\x0D\x1B\xF4\xAB\x07\x5F\xF1\x8A\x6E\xF1\x56\x5F\xA6\xCB\x70\x9D\x32\x25\x00\x4A\x44\x8A\xCC\xDC\x1F\xB8\xE1\x54\x47\xE7\x44\x88\x40\x21\xAB\xBF\xB9\x5A\xB7\xBD\x73\xC4\xC4\x62\x55\x5F\xCC\x64\x32\xA7\x1D\xC7\x99\x28\xD3\x59\x01\x90\x88\xC0\x71\x9C\x9E\x54\x2A\x09\xD7\x75\x45\x29\x35\xED\x11\x0A\x00\xC6\x18\x90\x22\x14\x8B\x45\x2C\xFF\xEA\x72\x3E\xFA\xDE\x51\xBB\x68\xD1\xC2\x8A\xC1\xC1\xC1\x56\xC7\x71\x1E\x12\x91\x40\x21\x33\x67\x00\x00\xB4\xD6\x5D\x57\x26\xF1\x82\xA9\x82\x99\x41\x4C\x08\x85\x42\x10\x11\x2C\x5E\xBC\x98\x4E\x9C\x3A\x21\x77\xDD\x7D\x97\x0C\x0C\x0C\xEC\x65\xD6\xBF\x82\x88\x9D\x09\x22\xA8\x81\xB2\x17\x24\x93\x49\x04\x7D\xFF\x13\x7E\x57\x76\x2C\x8B\xF6\x93\xED\x38\x7B\xF6\x1F\x38\xFF\xD1\x79\xB9\x74\xE9\x92\xD7\xD3\xD3\xEB\x45\x22\x11\xFB\xC7\xD7\x5F\xB3\xAB\xBF\xB5\xCA\x1D\x1B\x1B\xDD\xCA\xCC\x5F\x01\x30\x2D\x84\x0E\xA6\x25\xA6\xAE\x7C\xAE\x80\x64\x22\xA9\x96\x2E\x5D\x7A\x15\x80\xB5\x16\x41\x61\x2A\x28\x84\x23\x61\x6C\xDA\xD4\x88\x73\x9D\xE7\x10\x8F\xC7\x15\x11\xE9\x70\x28\x0C\xED\x38\x88\xC7\xA3\xC2\xAC\x55\x38\x14\x2E\x5A\x6B\xF3\x33\x65\xB2\x5C\x28\x4A\xA9\xCB\xC6\x78\xE8\xB9\xC6\x0B\x44\xA4\x7C\xA7\x0B\x4E\x4A\xAD\x35\x9E\xDC\xFA\x6B\xBB\xF6\x81\x06\x0A\x87\xC2\x47\x5D\xD7\x3D\x5C\x28\x14\x16\xD8\x5C\xAE\x62\x78\x68\xA8\x92\x99\x63\xAC\xF9\x90\x88\xFC\x1B\xA5\x2D\xB6\x33\x66\x00\x40\x42\x44\x46\x7B\x7B\x7B\xAB\xFC\x3E\x15\x2C\xFC\xC8\x4F\x1E\xC1\xBA\x75\xEB\x50\xFB\xB5\x5A\x04\x05\x5A\x5F\x5F\x8F\x95\x75\x2B\xD1\x71\xBA\x63\x49\x34\x16\x7D\xDD\x5A\x9B\x66\x66\xE5\x38\x8E\x10\x11\x8A\xE3\x45\xE0\xB3\xCB\xCC\x94\x41\xC1\x80\xB2\x17\x74\x97\xBC\x20\x58\xFC\xF8\xB1\xE3\x68\xDE\xDB\x6C\x9B\x5F\x6A\x2E\x4F\x64\xAD\x05\x00\x7A\x7C\xE3\x63\x06\x4A\x16\x02\x68\x14\x11\x88\x48\x58\x44\x58\x44\x18\x0A\x3C\xD3\xE2\x13\x01\x14\x80\x71\x66\x4E\xF4\xF9\xF7\x82\x50\x28\x84\x5C\x2E\x87\x2D\x4F\x6C\x91\xCF\xDF\x34\x5F\x8E\x1C\x69\x93\x0F\x4E\x7F\x50\xBE\x5E\x5B\x6B\x51\x57\x57\x47\xF7\xD5\xD7\x63\x78\x78\x78\x3D\x33\x2F\x02\x50\xF0\xE7\x33\x7E\x9B\x31\x82\xEA\x2C\x7B\x41\x32\x99\x42\x3E\x9F\x17\x00\xD8\xD5\xB4\x5B\x3A\xFF\x79\x4E\x55\x45\x2B\x1F\x35\xAE\xB9\xB8\x63\xC7\xF3\x00\x20\x4A\x95\x8B\x5A\x3D\xBE\xF1\x31\x13\x8E\x84\x63\xD6\xDA\x8D\x41\xDF\x6C\x16\xBE\x16\x40\xF9\xF7\x82\xAE\xC1\x81\x41\xB8\xAE\x8B\x0B\x17\x2E\x98\x3D\xBB\xF7\xA8\xEA\xCF\x55\xB7\x15\x0A\xE3\xBF\x8B\xC5\x63\xFB\xDB\x4F\xB6\xA3\xAD\xAD\xCD\x10\x95\xEA\xC0\x18\x83\x65\xB7\x2F\xA3\xFB\xBF\x73\x3F\x86\x87\x87\x7F\xA4\xB5\xBE\xC5\x7F\xF3\x59\x1F\xCF\xE5\x81\x22\x02\x66\xEE\x1A\x1D\x1B\x45\x2A\x95\x92\xA7\x7F\xF3\x0C\x67\x32\x99\xAC\xD6\xBA\xD1\x7F\xFE\x7B\x47\x3B\xFF\x79\x61\xC7\x0B\xDA\x5A\x6B\x99\x39\x90\xA6\x7A\xF4\x67\x3F\x35\xD1\x58\x34\xEC\xBA\xEE\xE6\xE9\xCE\x91\xE9\x00\x82\x62\xE9\x76\xB4\x83\x67\x9E\xDE\x6E\x8F\xBD\x7B\x0C\xF1\xF8\x4D\xCF\x79\x9E\x77\x1E\x40\xD8\x5A\x9B\x8E\x46\xA3\xCF\xFD\xF5\x2F\x67\x70\xE8\xE0\x21\x01\x00\xCF\xF3\xE0\xBA\x2E\x96\x2C\x59\xC2\x0F\x3E\xF4\xA0\x1D\x19\x19\x79\x80\x99\x97\x62\x06\xF3\x99\x0C\x20\xD0\xE9\x87\x4A\xA9\xCE\x37\xDF\x78\x33\x4C\x44\x7F\x06\xE4\x79\xBF\xBF\x08\x00\xD6\xDA\x7D\xF3\xE6\xCD\xFB\xD7\xAE\xA6\x5D\x9C\xCF\xE7\x6D\x28\x14\x02\x33\xDB\xD6\xD6\x56\xEF\x54\xFB\x29\xAA\xAC\xA8\x74\x8D\x31\xE3\xD7\x95\x01\xFF\x78\x15\x22\x52\x44\x34\x42\x44\x75\xD1\x68\x74\x85\x52\xEA\x5E\x22\xCA\xF9\xFD\x42\x44\x0C\xA0\x58\x55\x55\xB5\xFD\xFC\x47\x1F\xE3\xC0\xCB\x07\x4C\x67\x67\xA7\xF9\xC6\xBD\xF7\xA9\x86\xEF\x7E\x4F\x7F\xF2\xF1\x27\x5D\xE1\x48\xB8\x41\x29\xF5\x29\x95\xC2\xCE\x66\x33\x74\xD1\x75\x91\xCD\x66\x11\x0A\x85\xC4\x18\xA3\x00\xA4\x01\x74\xA0\x54\xCD\x13\x8D\xC4\xF8\xBF\x5F\x8B\x44\x22\x0F\xFF\x62\xF3\x2F\xEB\x0A\x85\x02\x3C\xD7\xEB\x8F\xC7\xE2\xCF\x1A\x6B\xF6\x66\xB3\xD9\x3C\x00\x45\x44\x36\x9B\xCD\xC2\x98\x29\x0D\xF0\x33\x80\x9B\x6F\xFE\x12\x6A\x6B\x6B\x51\x59\x55\x09\x6B\x6D\xE0\x09\x8C\xD2\xB6\x4C\x6A\x24\x0A\xF8\xA1\x15\xD9\x4A\x44\xBD\x44\xB4\xD3\x78\xE6\x0A\x14\xC8\xFF\x9F\x09\x3E\xCF\xA3\xB1\x68\x69\xFC\x34\x85\xF9\x5F\x33\x11\x75\x53\x4F\xAF\xB5\x25\x00\x00\x00\x00\x49\x45\x4E\x44\xAE\x42\x60\x82"

-- Licensed under the MIT License
-- Copyright (c) 2021, dmitriyewich <https://github.com/dmitriyewich/AnimatedIconcs>