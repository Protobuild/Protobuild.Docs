Defining External Projects
===========================

External projects allow you to reference existing C# projects, prebuilt .NET
assemblies, native libraries and group multiple project references.

External projects also allow you to toggle these references based on the platform
that is being generated.

Project structure
-------------------

A simple example of an external project definition, which demonstrates all of
the available reference types, is shown below.

.. literalinclude:: example/external_demo.xml
    :language: xml

.. include:: common/project_definition_location.rst

Referencing GAC assemblies
-----------------------------

You can reference assemblies in the GAC, or assemblies that are otherwise
natively provided by the build system, by using the ``<Reference>`` tag.  If
the included assembly isn't known as a Protobuild reference, it is assumed to
be an assembly provided by the build system.

.. code-block:: xml

  <Reference Include="System.Core" />

Referencing Protobuild projects
--------------------------------

You can reference other Protobuild projects by using the ``<Reference>`` tag.
This allows you to add multiple references to other Protobuild projects with
a single external project, or to make references on other Protobuild projects
dependent on the platform.

.. code-block:: xml

  <Reference Include="MyLibrary" />
  
.. warning::

    You can reference other external projects from an external project, but
    only at the top-level or under a ``<Plaform>`` tag.  You can't reference
    another external project from within a ``<Service>`` section.

Referencing .NET assemblies on-disk
-------------------------------------

You can reference .NET assemblies that are stored within your repository (as
binaries), by using the ``<Binary>`` tag.  This tag requires the name of the
.NET assembly, and the path to it *from the root of your module*.

.. code-block:: xml

  <Binary
    Name="ExternalLib"
    Path="ThirdParty/ExternalLib.dll" />

Referencing native binaries on-disk
-------------------------------------

You can reference native binaries that are stored within your repository, 
by using the ``<NativeBinary>`` tag.  This tag requires the path to the
native binary, relative *from the root of your module*.

.. code-block:: xml

  <NativeBinary Path="ThirdParty/NativeLib.so" />

This will cause the native binary to be added as a file with type None,
copy-on-build semantics, and as a link in the root of any project that
references this external project.  This ensures the native library is copied
to the output directory (so that it can be loaded or P/Invoke'd at runtime).

You will almost certainly want to make these references platform specific;
refer to :ref:`external-platform-specific` on how to do this.

Referencing other C# projects
-------------------------------------

You can reference external C# projects by using the ``<Project>`` tag.  This
tag requires the name of the project, it's GUID and the path to it
*from the root of your module*.

.. code-block:: xml

  <Project
    Name="ExternalProj"
    Guid="758CB33D-6EBD-41EA-BB0C-55B1C97A325F"
    Path="ThirdParty/ExternalProj/ExternalProj.csproj" />

.. warning::
    If the GUID does not exactly match the GUID specified in the ``.csproj``
    file, you will get strange errors when attempting to build your code under
    MSBuild or Visual Studio.

If you want to add an external C# project to the solution, but not reference it
in any project, you can define an external project as shown below, and simply
not add a ``<Reference>`` to it from any Protobuild project:

.. literalinclude:: example/external_noref.xml
    :language: xml

Since Protobuild loads all definitions from the ``Build\Projects`` folder, the
external C# project will still be shown and built in the solution.

.. _external-platform-specific:

Platform specific references
-------------------------------

You can make a group of references specific to one platform by using the
``<Platform>`` tag to surround them.  An example of platform specific
references is shown below.

.. literalinclude:: example/external_platform.xml
    :language: xml
    
Adding an external reference
------------------------------

Referencing a external project is done in the same way that any other project is;
to reference a external project, add the appropriate ``<Reference>`` tag as
shown below.

.. literalinclude:: example/external_reference.xml
    :language: xml
    :emphasize-lines: 6
