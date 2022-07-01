# Sweetpie

Discordia discord bot written in luvit, forked from [Musicord](https://github.com/truemedian/musicord).
Designed mainly for music, and a few text-based commands.

# Features
### (buzzword compilation)

* Modular module-based command handler
* You can disable any commands
* Shell script to start the bot
* Somewhat flexible file-based token approach
* Actually very configurable
* Voice chat support, joining, leaving, moving, etc.
* Audio playback support, stopping, playing, skipping, pausing, resuming, etc.
* Audio queue (made together with bandaids and ducktape)

That's about it for now

### Drawbacks / Limitations

* Non-flexible prefixes, all prefixes must be seperated by a space to work, meaning no `!vc join`, etc.
* Queue system is working by a miracle, to say the least
* Audio system demands a billion system depencies, probably quite hard to containerize
* Opting for luvit means you can't compile this into machine code, which will slow this down some
* I've done my best to optimize it, but the audio fetching can be slow on some devices (i.e my x86_64 desktop can fetch a video in 2 seconds, whereas my aarch64 pi 400 takes 5-10 sec)
* The audio fetching has little safety and may break with the passage of time upon some variance in `youtube-dl` output.
* No keyring support by default, only file reading. You'll need to patch this in yourself if you need it

## Commands

### audio
* `pie audio play YOUTUBE-URL`
* `pie audio remove NUMBER`
* `pie audio pause`
* `pie audio resume`
* `pie audio skip`
* `pie audio list` (currently not functional)

### voice
* `pie vc join`
* `pie vc leave`

### misc
* `pie ping`
* `pie help`
* `pie host`

# Setting it up

You can use this bot yourself, if you want. I've only really tailored it around my use cases, but good luck:

* Make sure you have luvit, luvi, and lit all installed and in your $PATH, or otherwise accesible.

* Clone this repository, i.e: `git clone https://github.com/CozzyBro2/sweetpie`
* `cd sweetpie`, then `lit install` to get all the dependencies.

* create a file named `.SECRET` and make it a single line with your token on it.

* If you want to use voice / audio stuff, make sure you have:
    * `libsodium`
    * `libopus` 
    * `ffmpeg` 
    * `youtube-dl` 

* The steps to get those working here vary a lot depending on your platform, so here's someone elses documentation of them: 
    * [#1](https://github.com/SinisterRectus/Discordia/wiki/Voice#acquiring-audio-libraries), 
    * [#2](https://github.com/truemedian/musicord/blob/master/README.md)

* Finally, to run the bot just run `luvit src/main.lua` in the working directory, or use the `start.sh` file included. (Make sure the file has execute permissions)
