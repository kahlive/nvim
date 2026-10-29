-- ================================================================================================
-- TITLE : yamlls (YAML Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/redhat-developer/yaml-language-server
-- ================================================================================================

--- @return table server configuration overrides
return function()
	return {
		settings = {
			yaml = {
				schemas = {
					["https://json.schemastore.org/composer.json"] = "composer.json",
					["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
						"docker-compose*.yml",
						"docker-compose*.yaml",
						"compose.yml",
						"compose.yaml",
					},
				},
				validate = true,
				format = {
					enable = true,
				},
			},
		},
		filetypes = { "yaml" },
	}
end
