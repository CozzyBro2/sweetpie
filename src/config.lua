return {

    -- Message to print when your token cant be found
    no_token_message = "Invalid token, make sure you have a file named .SECRET with a single line and your token on it in the current directory. ",

    -- The string format for the token used to run the bot, not recommended to change
    token_format = "Bot %s",

    -- The greeting message indicating the bot is ready, change to an empty string to hide it
    ready_format = "'%s' logged in",

    -- The file name that will be used to get the token in the active directory.
    secret_file = ".SECRET",

    -- The configuration table passed to the discordia client constructor
    client_config = {

        bitrate = 96000,

    },

    -- The prefix to be used for commands, i.e `pie ping`
    command_prefix = "pie",

    -- The format string to be used by `string.match` for purpose of getting cmd arguments, default is %S+ to get all spaces.
    argument_match = "%S+",
}