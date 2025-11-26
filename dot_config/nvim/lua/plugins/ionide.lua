return {
	"ionide/Ionide-vim",
	config = function()
		local ionide = require("ionide")
		ionide.setup({
      backend = "disable"
    })

	end,
}
