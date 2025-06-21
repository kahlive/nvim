return {
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
			cargo = {
				allFeatures = true,
			},
			inlayHints = {
				bindingModeHints = {
					-- Whether to show inlay type hints for binding modes.
					enable = false,
				},
				chainingHints = {
					-- Whether to show inlay type hints for method chains.
					enable = false,
				},
				closingBraceHints = {
					-- Whether to show inlay hints after a closing } to indicate what item it belongs to.
					enable = true,
					-- Minimum number of lines required before the } until the hint is shown (set to 0 or 1 to always show them).
					minLines = 25,
				},
				closureCaptureHints = {
					-- Whether to show inlay hints for closure captures.
					enable = false,
				},
				closureReturnTypeHints = {
					-- Whether to show inlay type hints for return types of closures.
					enable = "never",
				},
				-- Closure notation in type and chaining inlay hints.
				closureStype = "impl_fn",
				discriminantHints = {
					-- Whether to show enum variant discriminant hints.
					enable = "never",
				},
				expressionAdjustmentHints = {
					-- Whether to show inlay hints for type adjustments.
					enable = "never",
					-- Whether to hide inlay hints for type adjustments outside of unsafe blocks.
					hideOutsideUnsafe = true,
					-- Whether to show inlay hints as postfix ops (. instead of , etc).
					mode = "prefix",
				},
				implicitDrops = {
					-- Whether to show implicit drop hints.
					enable = false,
				},
				lifetimeElisionHints = {
					-- Whether to show inlay type hints for elided lifetimes in function signatures.
					enable = false,
					-- Whether to prefer using parameter names as the name for elided lifetime hints if possible.
					useParameterNames = false,
				},
				-- Maximum length for inlay hints. Set to null to have an unlimited length.
				maxLength = 25,
				parameterHints = {
					-- Whether to show function parameter name inlay hints at the call site.
					enable = false,
				},
				rangeExclusiveHints = {
					-- Whether to show exclusive range inlay hints.
					enable = false,
				},
				reborrowHints = {
					-- Whether to show inlay hints for compiler inserted reborrows. This setting is deprecated in favor of rust-analyzer.inlayHints.expressionAdjustmentHints.enable.
					enable = "never",
				},
				-- Whether to render leading colons for type hints, and trailing colons for parameter hints.
				renderColons = true,
				typeHints = {
					-- Whether to show inlay type hints for variables.
					enable = false,
					-- Whether to hide inlay type hints for let statements that initialize to a closure. Only applies to closures with blocks, same as rust-analyzer.inlayHints.closureReturnTypeHints.enable.
					hideClosureInitialization = false,
					-- Whether to hide inlay type hints for constructors.
					hideNamedConstructor = false,
				},
			},
		},
	},
}
