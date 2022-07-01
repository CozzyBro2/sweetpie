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

    ping_response = "Pong!",

    help_response = [[
        Here's some help stuff, no embed cause im poor

        **Voice**
            `pie vc join`
            `pie vc leave`

        **Audio**:
            `pie audio play YOUTUBE-URL`
            `pie audio remove NUMBER`
            `pie audio pause`
            `pie audio resume`
            `pie audio skip`
            `pie audio list (probably doesnt work)`

        **Misc**:
            `pie ping`
            `pie help`
            `pie host`
    ]],

    audio_malformed_argument = [[

        Invalid `audio` argument. 
        Proper `audio` arguments are as follows:
    
        `play`,
        `pause`,
        `resume`,
        `skip`,
        `remove`,
        `list`,
    
        i.e; `pie audio play https://someyoutubeurl`
    
    ]],

    audio_no_url = "%s, you did not specify a valid youtube URL.",
    audio_error = "%s, could not play audio because: %s",

    audio_list_format = [[

        List of things in the queue:
        %s

    ]],
    audio_list_seperator = [[,
    ]],

    audio_removed_success = "%s, removed **%d** from the queue.",
    audio_removed_error = "%s, failed to remove **%s** from the queue because: %s",

    audio_removed_error_template = "%s isn't a valid member of the queue",
    audio_queue_ended = "End of queue reached.",

    audio_feedback = "Fetching audio.",
    audio_fetched = "Added audio to position **%d** in queue. Audio fetched in %.2fs",

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

}