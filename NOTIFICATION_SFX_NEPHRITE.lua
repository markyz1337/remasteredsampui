local sampev = require 'lib.samp.events'
local sound_state = require "moonloader".audiostream_state
local active = true

function main()
    while not isSampAvailable() do wait(0) end
    if not doesFileExist('moonloader/resource/audio/onGivePlayerMoney.mp3') then
        sampAddChatMessage('{ab0062}[onGivePlayerMoney notification]: {ffffff}«вуковой файл: "moonloader/resource/audio/onGivePlayerMoney.mp3" не найден, выгружаюсь...', -1)
        print('{ffffff}«вуковой файл: "moonloader/resource/audio/onGivePlayerMoney.mp3" не найден, выгружаюсь...')
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
   if text:match('^/sms (.+)') or text:match('^/re(b?) (.+)') or text:match('^/pm(b?) (.+)') then
   setAudioStreamState(AudioStream, sound_state.PLAY)
   end
   if text:match('/getgift') then
   setAudioStreamState(AudioStream5, sound_state.PLAY)
   end
   if text:match('/service taxi') then
   setAudioStreamState(AudioStream6, sound_state.PLAY)
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
   if text:match('You have transfered') or text:match('You have received') or text:match('You received') or text:match('ve paid') or text:match('You earned') then
   setAudioStreamState(AudioStream4, sound_state.PLAY)
   end
   if text:match('Your call has been terminated by the other party.') or text:match('You hung up.') or text:match('You have answered your phone.') then
   setAudioStreamState(AudioStream1, sound_state.STOP)
   end
end