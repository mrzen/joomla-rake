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
      parser = Less::Parser.new(
                                filenames: definition["inputs"],
                                compress:  definition["compress"],
                                optimize:  definition["optimize"]
                                )
      
      css = parser.parse.to_css

      File.open(definition, definition['output']) do |f|
        f.write(css)
        f.flush
      end
    end
  end
  

end
