local imgui = require 'imgui'
local encoding = require 'encoding'
local key = require 'vkeys'
encoding.default = 'CP1251'
u8 = encoding.UTF8
png = {}
png_render = {}
menu = false
edit = false

slider = imgui.ImInt(1)
slider_posx_player = imgui.ImInt(1)
slider_posy_player = imgui.ImInt(1)
slider_rotation = imgui.ImInt(0)
slider_floatx = imgui.ImInt(1)
slider_floaty = imgui.ImInt(1)
check = imgui.ImBool(false)
check_player = imgui.ImBool(false)

imgui.GetStyle().WindowRounding = 1.5


function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
    if not doesDirectoryExist("moonloader/config") then createDirectory("moonloader/config") end
    if not doesDirectoryExist("moonloader/picturehud/bhood") then createDirectory("moonloader/picturehud/bhood") end
    if doesFileExist('moonloader/config/picturehud/bhood/picturehud.json') then
        local f = io.open('moonloader/config/picturehud/bhood/picturehud.json')
        ini_png = decodeJson(f:read('*a'))
        f:close()
    else
        local f = io.open('moonloader/config/picturehud/bhood/picturehud.json', 'w')
        f:write(encodeJson({}))
        f:close()
        ini_png = {}
    end
    sampRegisterChatCommand("pihud", function() menu = not menu end)
    local handleFile, nameFile = findFirstFile("moonloader/picturehud/bhood/*.png")
    font = renderCreateFont("Arial", 10, 13) 
    while true do
    wait(0)

    if handleFile then
        if not nameFile then
            findClose(handleFile)
        else 

            if not ini_png[nameFile] then 
                ini_png[nameFile] = {[1] = {posx = 0,posy = 0,player = false,player_posx = 0,player_posy = 0, rotation = 0, enable = false, color = 4294967295,x = 0,y = 0}}
            end

            png[nameFile] = renderLoadTextureFromFile("moonloader\\picturehud\\bhood\\"..nameFile)

            nameFile = findNextFile(handleFile)
        end
    end


    imgui.Process = menu

    if edit then
        local int_posX, int_posY = getCursorPos()
        ini_png[select][slider.v].posx,ini_png[select][slider.v].posy = int_posX, int_posY
            if isKeyDown(key.VK_LBUTTON) then
                showCursor(false, false)
                imgui.ShowCursor = true
                edit = false
                menu = true
                sampAddChatMessage("��������� ���������.", -1)
                savejson(ini_png,'moonloader/config/picturehud/bhood/picturehud.json')
            end
    end

    for k, val in pairs(png) do
        if ini_png[k] ~= nil then
            for i, _ in ipairs(ini_png[k]) do
                if ini_png[k][i].enable then
                    if ini_png[k][i].player then
                        local  positionX, positionY, positionZ = getCharCoordinates(PLAYER_PED)
                        x_e,y_e = convert3DCoordsToScreen(positionX, positionY, positionZ)
                        renderDrawTexture(val, x_e + ini_png[k][i].player_posx, y_e + ini_png[k][i].player_posy, ini_png[k][i].x, ini_png[k][i].y, ini_png[k][i].rotation, string.format("0x%s",bit.tohex(ini_png[k][i].color)))
                    else
                        renderDrawTexture(val, ini_png[k][i].posx, ini_png[k][i].posy, ini_png[k][i].x, ini_png[k][i].y, ini_png[k][i].rotation, string.format("0x%s",bit.tohex(ini_png[k][i].color)))
                    end
                    if menu then
                        if ini_png[k][i].player then
                            renderFontDrawText(font,"{FF0000}��������� � ���������\n{FFFFFF}"..k.." � "..i,(x_e + ini_png[k][i].player_posx) + (ini_png[k][i].x / 2), (y_e + ini_png[k][i].player_posy) + (ini_png[k][i].y / 2), "0xFFFFFFFF")
                            renderDrawBoxWithBorder(x_e + ini_png[k][i].player_posx, y_e + ini_png[k][i].player_posy, ini_png[k][i].x, ini_png[k][i].y, "0x00FFFFFF", 1, "0xFFFFFFFF")
                        else
                            renderFontDrawText(font,k.." � "..i,ini_png[k][i].posx + (ini_png[k][i].x / 2), ini_png[k][i].posy + (ini_png[k][i].y / 2), "0xFFFFFFFF", true)
                            renderDrawBoxWithBorder(ini_png[k][i].posx, ini_png[k][i].posy, ini_png[k][i].x, ini_png[k][i].y, "0x00FFFFFF", 1, "0xFFFFFFFF")
                        end
                    end
                end
            end
        end
    end
    end
end



function imgui.OnDrawFrame()
    local x, y = getScreenResolution()
    imgui.Begin(u8'##pic', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoTitleBar)
        imgui.BeginChild("##pich", imgui.ImVec2(100, 299), true)
            for key, _ in pairs(png) do
                if imgui.Selectable(u8(key)) then
                   if ini_png[key] == nil then
                     ini_png[key][1] = {posx = 0,posy = 0,player = false,player_posx = 0,player_posy = 0, rotation = 0, enable = false, color = 0,x = 0,y = 0}
                   end
                    select = key
                    if slider.v > #ini_png[key] then slider.v = 1 end
                    check.v = ini_png[key][slider.v].enable
                    slider_floatx.v = ini_png[key][slider.v].x
                    slider_floaty.v = ini_png[key][slider.v].y
                    check_player.v = ini_png[key][slider.v].player
                    slider_posx_player.v = ini_png[key][slider.v].player_posx
                    slider_posy_player.v = ini_png[key][slider.v].player_posy
                    color = imgui.ImFloat4(imgui.ImColor(ini_png[key][slider.v].color):GetFloat4())
                end
            end
        imgui.EndChild()
        if select ~= nil and png[select] ~= nil then
        imgui.SameLine()
        imgui.BeginChild("##pichu", imgui.ImVec2(500, 299),false)
        imgui.SetWindowFontScale(1.1)
        imgui.Text(u8'�������� '..tostring(select))
        imgui.SetWindowFontScale(1.0)
        if imgui.SliderInt(u8'##slider', slider, 1, #ini_png[select]) then
            check.v = ini_png[select][slider.v].enable
            slider_floatx.v = ini_png[select][slider.v].x
            slider_floaty.v = ini_png[select][slider.v].y
            check_player.v = ini_png[select][slider.v].player
            slider_posx_player.v = ini_png[select][slider.v].player_posx
            slider_posy_player.v = ini_png[select][slider.v].player_posy
            color = imgui.ImFloat4(imgui.ImColor(ini_png[select][slider.v].color):GetFloat4())
        end
        imgui.SameLine()
        imgui.Text(u8"ID ��������")
        imgui.SameLine()
            if imgui.Button(u8"��������") then
                table.insert(ini_png[select],{posx = 0,posy = 0,player = false,player_posx = 0,player_posy = 0, rotation = 0, enable = false, color = 4294967295,x = 0,y = 0})
                savejson(ini_png,'moonloader/config/picturehud/bhood/picturehud.json')
            end
        if imgui.Checkbox(u8"##check_true", check) then
            ini_png[select][slider.v].enable = check.v
            savejson(ini_png,'moonloader/config/picturehud/bhood/picturehud.json')
        end
        imgui.SameLine()
        imgui.Text((check.v and u8"���������" or u8"��������")..u8" ������ ��������")
        if check.v then
        if imgui.Checkbox(u8"##check_player", check_player) then
            ini_png[select][slider.v].player = check_player.v
            savejson(ini_png,'moonloader/config/picturehud/bhood/picturehud.json')
        end
        imgui.SameLine()
        imgui.Text((check_player.v and u8"���������" or u8"����������")..u8" �������� "..(check_player.v and u8"�� ���������" or u8"� ���������"))
        if not check_player.v then
            if imgui.Button(u8"�������� ��������� ��������") then
                menu = false
                sampAddChatMessage("��� ���������� ��������� ������� {ff6666}���{ffffff}.", -1)  
                imgui.ShowCursor = false    
                lua_thread.create(function() wait(10) edit = true showCursor(true, true) end)
            end
        else
            if imgui.SliderInt(u8'##slider_posx_player', slider_posx_player, -x, x) then
                ini_png[select][slider.v].player_posx = slider_posx_player.v
                savejson(ini_png,'moonloader/config/picturehud/bhood/picturehud.json')
            end
            imgui.SameLine()
            imgui.Text(u8"X ���. ���������")
            if imgui.SliderInt(u8'##slider_posy_player', slider_posy_player, -y, y) then
                ini_png[select][slider.v].player_posy = slider_posy_player.v
                savejson(ini_png,'moonloader/config/picturehud/bhood/picturehud.json')
            end
            imgui.SameLine()
            imgui.Text(u8"Y ���. ���������")
        end
        if imgui.SliderInt(u8'##slider_rotation', slider_rotation, 0, 360) then
            ini_png[select][slider.v].rotation = slider_rotation.v
            savejson(ini_png,'moonloader/config/picturehud/bhood/picturehud.json')
        end
        imgui.SameLine()
        imgui.Text(u8"���� �������� ��������")
        if imgui.SliderInt(u8'##slider_floatx', slider_floatx, 0, 5000) then
            ini_png[select][slider.v].x = slider_floatx.v
            savejson(ini_png,'moonloader/config/picturehud/bhood/picturehud.json')
        end
        imgui.SameLine()
        imgui.Text(u8"������ ��������")
        if imgui.SliderInt(u8'##slider_floaty', slider_floaty, 0, 5000) then
            ini_png[select][slider.v].y = slider_floaty.v
            savejson(ini_png,'moonloader/config/picturehud/bhood/picturehud.json')
        end
        imgui.SameLine()
        imgui.Text(u8"����� ��������")
        if imgui.ColorEdit4("##imgColor", color, imgui.ColorEditFlags.AlphaBar) then
            ini_png[select][slider.v].color = imgui.ImColor.FromFloat4(color.v[1], color.v[2], color.v[3], color.v[4]):GetU32()
            print(imgui.ImColor.FromFloat4(color.v[1], color.v[2], color.v[3], color.v[4]):GetU32())
            savejson(ini_png,'moonloader/config/picturehud/bhood/picturehud.json')
        end
        local x_r, y_r = renderGetTextureSize(png[select])
        imgui.Text(u8"������������� ��� ���� ��������: ������ - "..x_r..u8", ����� - "..y_r)
        imgui.SameLine()
        if imgui.Button(u8"����������") then
            ini_png[select][slider.v].x = x_r
            ini_png[select][slider.v].y = y_r
            slider_floaty.v = y_r
            slider_floatx.v = x_r
            savejson(ini_png,'moonloader/config/picturehud/bhood/picturehud.json')
        end
        else
        imgui.Text(u8"��� ��������� ����������, �������� ������ ��������")
        end
        imgui.EndChild()
    
        end
    imgui.End()
end



function savejson(table,path)
    local f = io.open(path, 'w')
    f:write(encodeJson(table))
    f:close()
end