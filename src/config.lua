return {

    blacklisted_commands = {}, -- syntax: {help = true, host = true}

    no_token_message = "Invalid token, make sure you have a file named .SECRET with a single line and your token on it in the current directory. ",

    token_format = "Bot %s",
    ready_format = "'%s' logged in",

    secret_file = ".SECRET",

    client_config = {

        bitrate = 96000,

    },

    command_prefix = "pie",
    argument_match = "%S+",

    uptime_shows_uname = true,

    uptime_format = "%s\n%s",
    uptime_host = "%s: **%s**",
    uptime_bot = "This bot \n: **%s**",
    uptime_bot_uptime = "%d days, %d hours, %d minutes",

    ping_response = "Pong!",

    help_response = [[
        Here's some help stuff, no embed cause im poor

        **Voice**
            `pie vc join`
            `pie vc leave`

        **Audio**:
            `pie audio play YOUTUBE-URL`
            `pie audio remove NUMBER`
            `pie audio list`
            `pie audio pause`
            `pie audio resume`
            `pie audio skip`

        **Misc**:
            `pie ping`
            `pie help`
            `pie uptime`
    ]],

    audio_malformed_argument = [[

        Invalid `audio` argument. 
        Proper `audio` arguments are as follows:
    
        `play YOUTUBE-URL`,
        `remove NUMBER`,
        `list`,
        `pause`,
        `resume`,
        `skip`,
        
    
        e.g; `pie audio play https://someyoutubeurl`
    
    ]],

    audio_no_url = "%s, you did not specify a valid youtube URL.",
    audio_fetch_error = "```%s```",
    audio_error = "%s, could not play audio: %s \n",

    audio_removed_success = "%s, removed **%d** from the queue.",
    audio_removed_error = "%s, failed to remove **%s** from the queue because: %s",

    audio_removed_error_template = "%s isn't a valid member of the queue",
    audio_queue_ended = "End of queue reached.",

    audio_feedback = "Fetching audio.",
    audio_fetched = "Added **%s** to position **%d** in queue. Audio fetched in %.2fs",

    vc_malformed_argument = [[

    Invalid `vc` argument. 
    Proper `vc` arguments are as follows:

    `join`,
    `leave`

    i.e; `pie vc join`

    ]],

    vc_user_not_in = "%s, you're not in a vc.",

    vc_not_in = "%s, I'm not in a voice channel.",
    vc_already_in = "%s, I'm already in that voice channel.",

    vc_joining = "%s, attempting to join your voice channel.",
    vc_leaving = "%s, attempting to leave your voice channel.",

    rce_error = "%s, failed to execute that command. I don't know why though",
    rce_unauth = "%s, not authorized",

    audio_list_empty = "%s, the queue is currently empty",
    audio_list_format = "**%d:** %s",
    audio_list_seperator = ", \n",

    kill = function(why)
        return error(why, 0)
    end,

    panic = "i dont know anymore %s",

}