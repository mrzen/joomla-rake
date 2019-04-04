##
# Helpers for working with LESS files
# Requires nodejs to operate


##
# Compile less styles
#
# Compiles less styles defined in +definition+
#
# @param [array] definitions file definitions
def compile_less_styles(base_dir, definitions)

  chdir(base_dir) do
    definitions.each do |definition|

      lessc = 'lessc'
      flags = []

      if definition['include']
        flags << "--include-path=" + definition['include'].join(':')
      end

      sources = definition['inputs'].join(' ')

      sh %{#{lessc} #{flags.join(' ')} #{sources} #{definition['output']}}

    end
  end
end
