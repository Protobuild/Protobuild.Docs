Package Management with NuGet
====================================

Although we recommend using Protobuild's package management system, there are
many package binaries and libraries available through `NuGet`_.

.. _NuGet: http://nuget.org/

Protobuild supports using NuGet packages with Protobuild projects, with support
for package URLs of the form ``https-nuget://repository.org/|PackageName@PackageVersion``.

.. warning::
    NuGet does not offer proper seperation of platforms for binaries.  You may
    find that installed NuGet packages work when targeting Windows, but fail
    when targeting other desktop or mobile platforms.  These will most often
    manifest themselves as runtime failures or crashes (especially when
    running under Mono where assumed APIs may not be available).
    
    Also be aware that (as of writing), Portable Class Libraries do not work
    on Mono under Linux.  As such, even if the NuGet package provides a PCL
    version, it may not work on all platforms.
    
    We highly recommend you ensure that the NuGet packages you have selected
    work on other platforms as early in the development process as possible.

Adding NuGet packages
-----------------------

You can add a NuGet package with the following command:

::

    $ Protobuild.exe --add <URI>

You'll need to know the repository URL, package name and package version that
you want to add.  For example, to add the Ninject package from nuget.org at
version 3.2.2.0, you would use the following command:

::

    $ Protobuild.exe --add "https-nuget://www.nuget.org/api/v2/|Ninject@3.2.2.0"

.. note::
    You will need to quote the URL as it contains a pipe character for seperating
    the URL and package name.  This is because on most systems, the pipe character
    is used to pipe one command into another.
    
Referencing NuGet packages
-------------------------

With Protobuild's support for NuGet packages, you can reference a NuGet package
like any other.  In the project definition file which you want to reference the
NuGet package in, add it to the ``References`` section, like so:

.. literalinclude:: example/application_nuget.xml
    :language: xml
    :emphasize-lines: 6
    
The reference name is the same as the package name you provided during `--add`.

.. note::
    NuGet packages imported through this mechanism always have a single external
    project available for reference, even if the package has multiple DLLs.  When
    a NuGet package contains multiple DLLs, the external project reference will
    add a reference to all of them.
