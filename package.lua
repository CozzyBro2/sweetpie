  return {
    name = "truemedian/musicord",
    version = "1.0.0",
    description = "A port of xieve/musicord for discordia 2.x",
    tags = { "lua", "discord" },
    license = "Unlicense",
    author = { name = "Nameless", email = "truemedian@gmail.com" },
    homepage = "https://github.com/truemedian/musicord",
    dependencies = {
        "SinisterRectus/discordia@2.6.0",
        "creationix/coro-split@2.0.0",
        "creationix/coro-spawn@3.0.1",
    },
    files = {
        "**.lua",
    }
}
  