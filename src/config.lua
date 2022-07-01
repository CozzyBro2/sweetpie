return {

    no_token_message = "Invalid token, make sure you have a file named .SECRET with a single line and your token on it in the current directory. ",


    token_format = "Bot %s",
    ready_format = "'%s' logged in",

    secret_file = ".SECRET",

    client_config = {

        bitrate = 96000,

    },

    command_prefix = "pie",
    argument_match = "%S+",

    ping_generic_response = "Pong!",

    audio_malformed_argument = [[

        Invalid `audio` argument. 
        Proper `audio` arguments are as follows:
    
        `play`,
        `stop`
    
        i.e; `pie audio play`
    
    ]],

    audio_no_url = "%s, you did not specify a valid youtube URL.",
    audio_error = "%s, could not play audio because: %s",

    vc_malformed_argument = [[

    Invalid `vc` command. 
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