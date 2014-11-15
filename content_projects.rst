Defining Content Projects
=======================

Content projects allow you to include content into your projects in a
cross-platform manner.  These are frequently used in conjunction with
MonoGame-based projects, but are suitable for including content under any
system.

Content projects work differently to other types of projects in that there
is no ``.csproj`` produced for them.  Instead, projects that reference
content projects (in their ``<References>`` section) will have the files of
the content project included with "Copy-on-build" semantics, such that the
files are copied into a Content folder on build.

Basic structure
----------------

The smallest definition for an content project you can have is shown below.

.. literalinclude:: example/content_minimal.xml
    :language: xml
    
When Protobuild loads a content project, it will scan recursively for all of
the files that match the expression, under the ``Include`` folder.

Project definition location
-----------------------------

All project definitions for your module should be placed under the 
``Build\Module`` directory and have a ``.definition`` extension.  The name of
the project should match the name of the file as well; for a project called
"MyContent", the project definition should reside at 
``Build\Module\MyContent.definition``.

.. tip::
    This is the location for all project definitions, including application,
    console, library, content and external projects.

File scanning
---------------

To understand the semantics of file scanning, we'll use the following
example content project:

.. literalinclude:: example/content_scanning.xml
    :language: xml

We'll also assume that your module layout looks like the following:

.. code-block:: text

    - Protobuild.exe
    - Build
      - Module.xml
      - Projects
        - MyApplication.definition
        - ExampleContent.definition
    - MyApplication
      - Program.cs
    - ExampleContent
      - image1.png
      - image2.jpg
      - text1.txt
      - binary1.bin
      - subfolder
        - image3.png
        - image4.jpg
        - text2.txt
        - binary2.bin

If you were to generate projects under this configuration, you'd find that
the application project might look similar to the following in Visual Studio
(or your IDE):

.. code-block:: text

  - MyApplication (C# project)
    - Content
      - image1.png
      - image2.jpg
      - binary2.bin
      - subfolder
        - image3.png
        - image4.jpg
    - Program.cs

All of the files under the Content folder in your project will be set to
copy on build and be of the ``<Content>`` tag type (if you were to view the
generated MyApplication ``.csproj`` file in a text editor).
    
.. note::
    The ``.bin`` file was placed at the root of the Content folder because
    for matching ``.bin`` files, the include path includes the subfolder.

Referencing content projects
------------------------------

Referencing a content project is done in the same way that any other project is;
to reference a content project, add the appropriate ``<Reference>`` tag as
shown below.

.. literalinclude:: example/content_reference.xml
    :language: xml
    :emphasize-lines: 6

Setting the primary source directory
--------------------------------------

If you need your application to know the location where it's content is sourced
from, you can add the ``Primary="true"`` tag to one of the sources declared
in your content project.

An example where this might be applicable is when you have a tool for editing
game content.  The tool itself will be copied to it's output directory (along
with a copy of the game content), however when using the tool you'll want to
be editing the files from their source.

When this attribute is added, a ``.source`` file will be created in the include
folder, and will be specified as "Copy-on-build" for projects that reference
the content project.  Thus to find the absolute path to the content, your
application should attempt to read the ``Content\.source`` file (if it exists).
This file contains the full, absolute path to the source folder on the current
machine, and hence, it should be ignored by your source control system (i.e.
you should add ``.source`` to your ``.gitignore`` file).

An example of setting a primary source directory is shown below.

.. literalinclude:: example/content_primary.xml
    :language: xml
    :emphasize-lines: 3

Including platform-specific folders
-------------------------------------

Often content will be compiled for a specific platform.  You can use 
``$(Platform)`` in the include path to replace it with the name of the platform
being generated for.

An example of including a platform-specific directory is shown below.

.. literalinclude:: example/content_platform.xml
    :language: xml
    :emphasize-lines: 4