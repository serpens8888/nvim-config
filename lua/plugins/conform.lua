return{
    "stevearc/conform.nvim",
    opts = {
        notify_on_error = false,

        formatters = {
            odinfmt = {
                command = "odinfmt",
                args = { "-stdin" },
                stdin = true,
            },

            scalafmt = {
                command = "scalafmt",
                args = { "--stdin" },
                stdin = true,
            }
        },

        formatters_by_ft = {
            odin = { "odinfmt" },
            scala = { "scalafmt" },
            sbt = { "scalafmt" },
        },


    },

}
