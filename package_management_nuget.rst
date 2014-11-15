Package Management with NuGet
====================================

Although we recommend using Protobuild's package management system, there are
many package binaries and libraries available through `NuGet`_.

.. _NuGet: http://nuget.org/

Protobuild supports using NuGet packages with Protobuild projects, and indeed,
references to NuGet libraries are automatically determined when generating
projects, based on the presence of the NuGet ``packages.config`` in the 
project's folder.

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

You can add NuGet packages to your project the same way you currently do;
through your IDE.  By following your existing process, NuGet will update the
``packages.config`` to reference to the version of package you are using.

Restoring NuGet packages
-------------------------

When Protobuild generates projects, it looks at all the packages defined in
``packages.config`` (if present), and adds references to the libraries in
your projects, based on what files it finds in the ``packages`` folder.

This means that restoring NuGet packages is a two-stage process.  First you
must generate your projects (which will be missing references due to the fact
that NuGet has not restored the DLLs yet), and then restore the NuGet packages.
Your IDE may do this automatically for you.  Once the NuGet packages are
restored, you then need to generate your projects again, at which point
Protobuild will be able to find the correct DLLs to reference in your project.

Specifying platform-specific configurations
------------------------------------------------

If you find that one or more of your referenced NuGet libraries are not
available on a given platform, you can create suffixed ``packages.config``
files instead, which will be automatically copied by Protobuild based on the
platform you are generating projects for.

For example, to specify different packages for Windows and Linux, your project
folder would look similar to the following:

::

    * MyProject
      * Program.cs
      * packages.Windows.config
      * packages.Linux.config
      
In this case, when generating for Windows, Protobuild will automatically make
a copy of ``packages.Windows.config`` as ``packages.config``.  Your IDE should
then restore the correct packages for the platform.