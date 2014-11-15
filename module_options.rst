Changing Module Properties
===========================

You can change the default behaviour of Protobuild within your module by
modifying the ``Build\Module.xml`` file.  This file contains a number of
settings which control Protobuild's default behaviour, and what operations
are permitted.  These settings do not change how projects are generated.

An example of the MonoGame module configuration is:

.. literalinclude:: example/module_config.xml
    :language: xml

The following module properties are available:

DefaultAction
----------------

This can be either "Resync" (default), "Generate" or "Sync".  This changes
the mode that Protobuild runs in when it is executed with no arguments.

DefaultWindowsPlatforms
--------------------------

When Windows is the current executing platform, and no arguments have been
given on the command line, then Protobuild will generate for all of the
specified platforms (synchronising with the Windows projects).

DefaultMacOSPlatforms
----------------------

When Mac OS is the current executing platform, and no arguments have been
given on the command line, then Protobuild will generate for all of the
specified platforms (synchronising with the Mac OS projects).

DefaultLinuxPlatforms
-----------------------

When Linux is the current executing platform, and no arguments have been
given on the command line, then Protobuild will generate for all of the
specified platforms (synchronising with the Linux projects).

SupportedPlatforms
-----------------------

A comma-seperated list of supported platform names.  If this is not specified,
then users can generate for any platform they want (any input string).  Known
platforms are checked for casing and normalized as appropriate.

If this is specified, then the user will only be able to supply platform
names in this list (case insensitive).  The specified platforms are checked on
input for casing and normalized as appropriate (so specifying "Windows,Linux"
in this list will cause an input of "linux" or "LiNuX" to be normalized to
"Linux").

DefaultStartupProject
-----------------------

Defines the default startup project for the solution.  For example, if you 
have a project in your module called "ConsoleA", and you want it to be the
default for people opening your solution for the first type, 
specify ``<DefaultStartupProject>ConsoleA</DefaultStartupProject>`` in
Module.xml.

GenerateNuGetRepositories
---------------------------

If this option is "True", then Protobuild will automatically generate a
``repositories.config`` file based on the ``packages.config`` files in the
repository.

If you have this option enabled, you should exclude ``repositories.config``
from source control.

DisableSynchronisation
------------------------

If this option is "True", Protobuild will never synchronise C# projects back
to the project definition files.  There is almost never any reason to enable
this functionality, other than for stylistic reasons.
