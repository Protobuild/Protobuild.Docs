Defining Library Projects
===========================

Library projects define a project which contains common functionality you want
to share between multiple projects.

Generated projects
--------------------

Library projects always generate appropriate projects such that other executable
projects on the platform can refer and use them.

The appropriate information to reference library projects on any platform is
automatically determined by Protobuild, so you don't need to provide any
additional information other than the library name when referencing it.

Basic structure
----------------

The smallest definition for an library project you can have is shown below.

.. literalinclude:: example/library_minimal.xml
    :language: xml
    :emphasize-lines: 2
   
The presence of ``Type="Library"`` ensures this project is an library project.

Project definition location
-----------------------------

All project definitions for your module should be placed under the 
``Build\Module`` directory and have a ``.definition`` extension.  The name of
the project should match the name of the file as well; for a project called
"MyLibrary", the project definition should reside at 
``Build\Module\MyLibrary.definition``.

.. tip::
    This is the location for all project definitions, including application,
    console, library, content and external projects.
   
Common sections
-----------------
   
All of the sections for library projects are identical to those found in
application projects.  Refer to the following sections under the
:doc:`application_projects` documentation:

  * :ref:`declaring-references`
  * :ref:`declaring-files`