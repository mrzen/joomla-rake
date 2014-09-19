=begin rdoc

Helpers for working with LESS files
Requires nodejs to operate

=end

require_relative './helpers'


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
      sources = definition['inputs'].join(' ')
      flags = []
      
      if definition['optimize']
        case definition['optimize']
          when TrueClass then
          flags << '-O2'
          else
          flags << '-O' + definition['optimize']
        end
      end

      if definition['compress']
        flags << '-x'
      end

      sh %{#{lessc} #{flags.join(' ')} #{sources} #{definition['output']} }

    end
  end
end
