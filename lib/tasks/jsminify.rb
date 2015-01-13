##
# Helpers to produce minified javascripts
#

##
# Compile JS into minified sources
#
# Compiles JS sources defined in +definitions+
def compile_js_sources(base_dir, definitions)
  chdir(base_dir) do
    definitions.each do |definition|

      jscompressor = :uglifyjs

      sources = definition['inputs'].join(' ')

      sh %{cat #{sources} > #{definition['output']}.tmp}
      sh %{#{jscompressor} #{definition['output']}.tmp > #{definition['output']}}
      rm definition['output'] + '.tmp'
    end
  end
end
