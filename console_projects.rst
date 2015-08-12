Defining Console Projects
==========================

Console projects define a project which will run underneath a terminal or
command prompt.  Protobuild itself is an example of a console application.

Generated projects
--------------------

Console projects should be used when you don't have a graphical interface to
present to the user, or you want to show console output on Windows.

For Windows, Mac OS X and Linux, these projects are generated as Console
Applications (as shown in Visual Studio under the project properties).

For iOS and Android, these projects are generated as Xamarin iOS and Xamarin
Android applications respectively.  For Ouya, we generate these projects as 
an Android application.  Since console applications are unlikely to have the
required files to work on these platforms when built, you most likely need to
limit the platforms that your console applications are generated for (refer to
:ref:`limiting-platforms`).

For Windows8, WindowsPhone and WindowsPhone81 we generate the appropriate
project types as specified by Microsoft for these platforms.  Since console
applications are unlikely to have the required files to work on these
platforms when built, you most likely need to limit the platforms that your
console applications are generated for (refer to :ref:`limiting-platforms`).

For the Web, these projects will have a post-build step that runs `JSIL`_, which
in turn produces Javascript and HTML documents to run the application in a web
browser.

.. _JSIL: http://jsil.org/

Basic structure
----------------

The smallest definition for an console project you can have is shown below.

.. literalinclude:: example/console_minimal.xml
    :language: xml
    :emphasize-lines: 2
   
The presence of ``Type="Console"`` ensures this project is an console project.

.. include:: common/project_definition_location.rst
   
Common sections
-----------------
   
All of the sections for console projects are identical to those found in
application projects.  Refer to the following sections under the
:doc:`application_projects` documentation:

  * :ref:`declaring-references`
  * :ref:`declaring-files`