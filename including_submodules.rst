Including Submodules
========================

When generating projects, Protobuild loads all of the project definitions
recursively.  That is, it not only loads project definitions from your
module's ``Build\Projects`` folder, but also projects from any submodules
that are present.

.. note::

    It is recommended that you use :doc:`package_management_protobuild` instead
    of this process.
    
Adding a submodule
-------------------

For example, if you have the following project structure that is version 
controlled by Git:

::
    
    * Build
      * Projects
        * MyProject.definition
      * Module.xml
    * MyProject
      * Program.cs
    * Protobuild.exe

If you want to add MonoGame as a submodule so that you can reference the
MonoGame framework, all you need to do is (in the root of your module):

::

    $ git submodule add https://github.com/mono/MonoGame.git MonoGame

After this command runs you'll end up with:

::
    
    * Build
      * Projects
        * MyProject.definition
      * Module.xml
    * MonoGame
      * ...
    * MyProject
      * Program.cs
    * Protobuild.exe

You can now reference MonoGame by adding:

.. code-block:: xml

  <Reference Include="MonoGame.Framework" />

in your project definition.

Recursive behaviour
----------------------

When you run Protobuild in your module, it will be recursively executed in 
submodules with the same arguments. That is in the example above, if you run
"Protobuild.exe --generate Windows" in your module, then 
"Protobuild.exe --generate Windows" will be called in the MonoGame submodule
(and so-on so-forth for it's submodules).

This ensures that all the project files are available when resyncing 
or generating your module.