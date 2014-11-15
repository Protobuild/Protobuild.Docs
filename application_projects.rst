Defining Application Projects
=======================

Application projects define a project which will run as a graphical application
on an operating system or device.  They share a common definition structure with
library projects and console projects; only the ``Type`` attribute on the
project definition differs.

Generated projects
--------------------

Application projects should be used when you want to produce an executable
program for a platform or device.

For Windows, Mac OS X and Linux, these projects are generated as Windows
Applications (as shown in Visual Studio under the project properties).

If you are on Mac OS X, and have Xamarin Mac installed, we generate the project
as a Mac application instead.

For iOS and Android, these projects are generated as Xamarin iOS and Xamarin
Android applications respectively.  For Ouya, we generate these projects as 
an Android application.

For Windows8, WindowsPhone and WindowsPhone81 we generate the appropriate
project types as specified by Microsoft for these platforms.

For the Web, these projects will have a post-build step that runs `JSIL`_, which
in turn produces Javascript and HTML documents to run the application in a web
browser.

.. _JSIL: http://jsil.org/

Basic structure
----------------

The smallest definition for an application project you can have is shown below.

.. literalinclude:: example/application_minimal.xml
    :language: xml
   
The presence of ``Type="App"`` ensures this project is an application project.
   
Already there are some structures which will look familiar to anyone who has
viewed the XML of a ``.csproj`` file.  While there are most optional sections
than shown in the example above, the two most important (and required) sections
are:

Declaring references
---------------------

The ``<References>``  section lists the references for this project.  These references can
be assemblies in the GAC or other Protobuild projects that have been defined
(either in this module, or any submodule you have in your repository).

.. warning::
    These are Protobuild references, not .NET references.  The only valid tag
    is ``<Reference>``, and the only attribute it accepts is ``Include``.  To
    reference external C# projects or binaries, refer to the
    :doc:`external_projects` documentation, and then add a reference to the
    external project you define.

If you had another project definition for a library, and you wanted your
application project to depend on it, you could add a definition like so:

.. literalinclude:: example/application_library.xml
    :language: xml
    :emphasize-lines: 6
    
Declaring files
-----------------

The ``<Files>`` section lists the files that are included in your project.  Unlike
references, these tags align directly with the types of tags you might see in
a ``.csproj`` file.  Indeed, when your project is generated, these tags are
copied as-is into the project, if the files should be included for the
given platform.

All of the standard C# file tags work here, including ``<Compile>``,
``<Content>``, ``<None>``, ``<EmbeddedResource>`` and more.  They also support
files as links through ``<Link>`` sub-tag.

To restrict what platforms files are included for, you can use the 
``<Platforms>``, ``<IncludePlatforms>`` and ``<ExcludePlatforms>`` sub-tags.
For example, if you want to only include an ``.icns`` file when the project
is being generated for Mac OS X, you could use the following definition:

.. literalinclude:: example/application_platforms_icns.xml
    :language: xml
    :emphasize-lines: 10

Another example is that you might have functionality which is supported on
all platforms, except one or two.  A common example might be functionality
which relies on the ``dynamic`` keyword in C#, which is not available on iOS.
If you wanted to exclude a file entirely based on the platform, you could use:

.. literalinclude:: example/application_platforms_ios.xml
    :language: xml
    :emphasize-lines: 10

When you add files through your IDE, and then synchronise the C# projects
back to the project definitions, the new files won't have either the
``<Platforms>`` nor ``<ExcludePlatforms>`` tags by default.  In order to
limit new files to one or more platforms, you'll need to run Protobuild
with ``--sync`` to save your changes to the project definitions, then edit
the project definition in a text editor to add the ``<Platforms>`` (or 
``<ExcludePlatforms>`` tag), and then run Protobuild with the ``--generate``
option to generate the C# projects again (for your IDE).

Limiting platforms
------------------------

If you have an application project that for one reason or another won't run
on certain platforms, you can use the ``Platforms`` attribute to restrict
what platforms this project is generated for.

Commonly this attribute is used when you are defining projects game development
tools that produce content, where the tools will only run on desktop platforms.

An example of using the ``Platforms`` attribute to restrict when a project
is generated can be seen below.

.. literalinclude:: example/application_exclude_platforms.xml
    :language: xml
    :emphasize-lines: 2
