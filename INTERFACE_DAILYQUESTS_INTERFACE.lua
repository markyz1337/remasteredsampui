require 'lib.moonloader'
local font = renderCreateFont('Impact', 20, 4)
local imgui = require 'lib.imgui'
img =  imgui.CreateTextureFromFile(getGameDirectory() ..'\\moonloader\\resource\\CFN_HUD\\Untitledq.png')

function main()   
    while true do
        wait(0)
        if isSampAvailable() then
        local resX, resY = getScreenResolution()
		imgui.Process = true
        end
    end
end



function imgui.OnDrawFrame()
        local sw, sh = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(sw / 2.05, sh / 1.55), imgui.Cond.FirstUseEver, imgui.ImVec2(5.2, 0))
        imgui.SetNextWindowSize(imgui.ImVec2(160, 45), imgui.Cond.FirstUseEver)
        imgui.Begin("Dean", true, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize) -- + imgui.WindowFlags.NoResize
        if imgui.IsItemClicked(img) then
		sampSendChat("/quests")
        end
		imgui.ShowCursor = false
        imgui.BeginChild("img")

        imgui.Image(img, imgui.ImVec2(149, 29))
        imgui.EndChild()
        imgui.End()
    end
	
	
	
function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
	style.ButtonTextAlign = imgui.ImVec2(1, 0.5)

    colors[clr.Text]                    = ImVec4(0, 0, 0, 0)
    colors[clr.TextDisabled]            = ImVec4(0, 0, 0, 0)
    colors[clr.WindowBg]                = ImVec4(0, 0, 0, 0)
    colors[clr.ChildWindowBg]           = ImVec4(0, 0, 0, 0)
    colors[clr.PopupBg]                 = ImVec4(0, 0, 0, 0)
    colors[clr.Border]                  = ImVec4(0, 0, 0, 0)
    colors[clr.BorderShadow]            = ImVec4(0, 0, 0, 0)
    colors[clr.FrameBg]                 = ImVec4(0, 0, 0, 0)
    colors[clr.FrameBgHovered]          = ImVec4(0, 0, 0, 0)
    colors[clr.FrameBgActive]           = ImVec4(0, 0, 0, 0)
    colors[clr.TitleBg]                 = ImVec4(0, 0, 0, 0)
    colors[clr.TitleBgActive]           = ImVec4(0, 0, 0, 0)
    colors[clr.TitleBgCollapsed]        = ImVec4(0, 0, 0, 0)
    colors[clr.ScrollbarBg]             = ImVec4(0, 0, 0, 0)
    colors[clr.ScrollbarGrabHovered]    = ImVec4(0, 0, 0, 0)
    colors[clr.ComboBg]                 = ImVec4(0, 0, 0, 0)
    colors[clr.SliderGrab]              = ImVec4(0, 0, 0, 0)
    colors[clr.Button]                  = ImVec4(0, 0, 0, 0)
    colors[clr.ButtonActive]            = ImVec4(0, 0, 0, 0)
    colors[clr.HeaderHovered]           = ImVec4(0, 0, 0, 0)
    colors[clr.Separator]               = ImVec4(0, 0, 0, 0)
    colors[clr.SeparatorActive]         = ImVec4(0, 0, 0, 0)
    colors[clr.ResizeGrip]              = ImVec4(0, 0, 0, 0)
    colors[clr.ResizeGripHovered]       = ImVec4(0, 0, 0, 0)
    colors[clr.ResizeGripActive]        = ImVec4(0, 0, 0, 0)
    colors[clr.CloseButton]             = ImVec4(0, 0, 0, 0)
    colors[clr.CloseButtonHovered]      = ImVec4(0, 0, 0, 0)
    colors[clr.CloseButtonActive]       = ImVec4(0, 0, 0, 0)
    colors[clr.PlotLines]               = ImVec4(0, 0, 0, 0)
    colors[clr.PlotLinesHovered]        = ImVec4(0, 0, 0, 0)
    colors[clr.PlotHistogram]           = ImVec4(0, 0, 0, 0)
    colors[clr.PlotHistogramHovered]    = ImVec4(0, 0, 0, 0)
    colors[clr.TextSelectedBg]          = ImVec4(0, 0, 0, 0)
    colors[clr.ModalWindowDarkening]    = ImVec4(0, 0, 0, 0)

end
apply_custom_style()