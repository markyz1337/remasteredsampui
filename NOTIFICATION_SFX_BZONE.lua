local sampev = require 'lib.samp.events'
local sound_state = require "moonloader".audiostream_state
local active = true
 
function main()
    while not isSampAvailable() do wait(0) end
    if not doesFileExist('moonloader/resource/audio/onGivePlayerMoney.mp3') then
        sampAddChatMessage('{ab0062}[onGivePlayerMoney notification]: {ffffff}????: "moonloader/resource/audio/onGivePlayerMoney.mp3" ???, ?????.', -1)
        print('{ffffff}????: "moonloader/resource/audio/onGivePlayerMoney.mp3" ???, ?????.')
        thisScript():unload()
    end
    AudioStream = loadAudioStream('moonloader/resource/audio/GameSounds/sentmessage.mp3')
	AudioStream1 = loadAudioStream('moonloader/resource/audio/GameSounds/ringtone.mp3')
	AudioStream2 = loadAudioStream('moonloader/resource/audio/GameSounds/notification.mp3')
	AudioStream3 = loadAudioStream('moonloader/resource/audio/GameSounds/start_engine.mp3')
	AudioStream4 = loadAudioStream('moonloader/resource/audio/GameSounds/bank.mp3')
	AudioStream5 = loadAudioStream('moonloader/resource/audio/GameSounds/giftbox.mp3')
	AudioStream6 = loadAudioStream('moonloader/resource/audio/GameSounds/taxi.mp3')
    while true do
        wait(0)
        if wasKeyPressed(8) and not sampIsChatInputActive() then
            setAudioStreamState(AudioStream, sound_state.STOP)
        end
    end
end
 
 
function sampev.onSendCommand(text)
   if text:match('^/sms (.+)') or text:match('^/re(b?) (.+)') or text:match('^/t(b?) (.+)') then
   setAudioStreamState(AudioStream, sound_state.PLAY)
   end
   if text:match('/getgift') then
   setAudioStreamState(AudioStream5, sound_state.PLAY)
   end
   if text:match('/service taxi') then
   setAudioStreamState(AudioStream6, sound_state.PLAY)
   end
if text:match('/p') then
   setAudioStreamState(AudioStream4, sound_state.PLAY)
   end
end
 
function sampev.onServerMessage(color, text)
   if text:match('is calling you') then
   setAudioStreamState(AudioStream1, sound_state.PLAY)
   end
   if text:match('SMS from') then
   setAudioStreamState(AudioStream2, sound_state.PLAY)
   end
   if text:match('starts the engine') then
   setAudioStreamState(AudioStream3, sound_state.PLAY)
   end
   if text:match('stops the engine') then
   setAudioStreamState(AudioStream3, sound_state.STOP)
   end
   if text:match('Ai transferat') or text:match('Ai primit') or text:match('I-ai trimis') or text:match('ve paid') or text:match('Castig de baza:') then
   setAudioStreamState(AudioStream4, sound_state.PLAY)
   end
   if text:match('a inchis.') or text:match('Ai inchis.') or text:match('Ai raspuns la telefon.') then
   setAudioStreamState(AudioStream1, sound_state.STOP)
   end
end
