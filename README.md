# musicord
A simple music-bot to stream from YouTube written in Lua with the [Discordia](https://github.com/SinisterRectus/Discordia) and the [youtube-dl](https://rg3.github.io/youtube-dl/) library

## Installation
First, follow the instructions [here](https://github.com/SinisterRectus/Discordia#installation) to install Discordia and [here](https://github.com/SinisterRectus/Discordia/wiki/Voice#acquiring-audio-libraries) to aquire the audio libraries Discordia-Voice needs, [here](https://rg3.github.io/youtube-dl/) you can download youtube-dl for your platform, run ```lit install creationix/coro-split``` in your bash/commandline and finally download main.lua in the folder where you installed everything else. To start the bot, just execute ```luvit main.lua TOKEN```, where TOKEN is your bot's token that you get after creating a discord application online.

## Available commands:
- ``audio.join``          joins the user's current voice channel
- ``audio.leave``         leaves the current voice channel
- ``audio.play URL``      for playing single videos
- ``audio.pause``         to pause the current stream
- ``audio.resume``        to resume the paused stream
- ``audio.skip``          to skip the playing video

## To-Do:
A queue for audio.play
