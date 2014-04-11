 Joomla Rake
=============
_Build Joomla Extensions with Rake_


 About
-------
Joomla Rake is a set of `rake` tasks for building Joomla extensions using `rake`,
a build processor written in Ruby.


 Installation
--------------
To keep the tasks up-to-date, it is best to add Joomla Rake as a git submodule in your project,
at `$project_root/rakelib` , this will allow the rake tasks to be loaded automatically.

Create an empty file called `Rakefile` in your project root too.


 Configuration
---------------

Configuration is done by a YAML file called `package.yml` in the project root.
Here is an example

```yaml
name: my-package-name
package:
  name: My Package
  description: My Package does some stuff
  update_site: http://example.com/updates/my-package
  version: 1
  author: Me

contents:
  components:
    - mycomponent
    - myothercomponent

  plugins:
    system:
      - mysystemcomponent
    content:
      - mycontentplugin
  libraries:
    - mylib
    - mydependency
```
