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

    vc_feedback_response = "Roger.",
    vc_malformed_argument = 
    [[
        Inproper arguments.
        Proper arguments are as follows:

        `pie vc join`,
        `pie vc leave`

    ]],

    vc_user_not_in = "%s, you're not in a vc.",

    vc_not_in = "%s, I'm not in a voice channel.",
    vc_already_in = "%s, I'm already in a voice channel. If you need to move me say `pie vc leave` and have me join you again.",

    vc_joining = "%s, attempting to join your voice channel.",
    vc_leaving = "%s, attempting to leave your voice channel.",

}