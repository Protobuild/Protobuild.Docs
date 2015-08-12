Defining Include Projects
===========================

Include projects allow you to specify a set of C# files and / or other resources
which should be included in projects that reference the include project.  This
allows libraries to include additional code or resources into executables that use
them.

For example, a library may provide a default main entry point for programs using that
library, so that the developer does not have to manually configure application
start up (unless they want to).  The library can define an include project which
is then pulled in by the application so that the main entry point class is defined
in the correct (executable) assembly.

Project structure
----------------

A simple example of an include project definition is shown below.

.. literalinclude:: example/include_demo.xml
    :language: xml

.. include:: common/project_definition_location.rst

Including files
-----------------------------

Declaring files for inclusion in an include project uses the exact same
structure used in application, console and library projects, including the
ability to declare files for specific platforms or services.

See :ref:`declaring-files` for documentation on how to declare files in
a project.

Referencing include projects
------------------------------

Referencing include projects works like any other Protobuild project,
either from an application, console or library project:

.. literalinclude:: example/include_reference.xml
    :language: xml
    :emphasize-lines: 6
    
or from an external project:

.. literalinclude:: example/include_externalreference.xml
    :language: xml
    :emphasize-lines: 5
    