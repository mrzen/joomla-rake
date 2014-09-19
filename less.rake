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
    definitions.each do |defnition|
      
      lessc = 'lessc'

      case definition['inputs']
      when Array then
        sources = definition['inputs'].join(' ')
      when String then
        soruces = definition['inputs'].to_s
      end

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
