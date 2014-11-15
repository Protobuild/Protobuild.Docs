Migrating Existing C# Projects
==============================

If you have an existing project you wish to convert to Protobuild, you'll need
to perform a few steps to convert your current C# projects into project
definition files.

If you haven't used Protobuild before, we recommend reading :doc:`getting_started`
first so you can get acquainted with how Protobuild works first.

If your project uses #ifdef's
------------------------------

If your project purely uses ``#ifdef`` to distinguish between platforms, then
the migration process is easy.

1. Copy file declarations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For the project you want to convert, you'll need to create a project definition
that matches the current type of the project (refer to the relevant
documentation pages for the type of project you need).

After this, copy all of the ``<Compile>``, ``<Content>``, 
``<EmbeddedResource>``, etc. tags from the C# project file into the definition
file, removing the surrounding ``<ItemGroup>`` tags.

2. Migrate external references
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For references to binary or external (unconverted) C# projects, you'll
need to create a new definition of an external project, the format
of which is described in :doc:`external_projects`.  Use this to encapsulate
external references, and then within your new Protobuild project definitions,
reference the external project instead of binaries or C# projects directly.

If your project has multiple C# project files
-------------------------------------------------

If you have multiple C# projects, then the transition is going to be
reasonably harder. You will need to determine the files present in each 
platform-specific project and from there, derive appropriate ``<Platforms>`` 
tags against the files, as demonstrated in :ref:`declaring-files`.

There is an experimental and unsupported shell script that can do this 
conversion enmass (reading all the project files and determining what 
declarations intersect). It is called `find-platform-dependent-files.sh`_
and can act as a good starting point for the conversion.

.. _find-platform-dependent-files.sh: https://github.com/hach-que/MonoGame/blob/42b6adafa714c5151f46429b6b24016340c85f70/MonoGame.Framework/find-platform-dependent-files.sh