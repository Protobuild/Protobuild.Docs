Service Dependencies
===========================

Service dependencies allow you to conditionally include submodules and
functionality, based on what the consumers of your library require.  It can
also be used to provide multiple backends for APIs.

.. note::
    Service dependencies are an advanced feature of Protobuild.  It is highly
    recommended that you're well versed in creating Protobuild projects before
    using service dependencies.

What are services in Protobuild?
---------------------------------

Services are declared within projects which are usable by other libraries.  They
allow you to declare functionality in your library optional, or to provide
functionality in multiple ways.

For example, MonoGame on Windows can use one of three graphics backends; it can
use DirectX, OpenGL or ANGLE for providing graphics rendering.

In the case of MonoGame, each of these backends is declared as a service, and
they are all declared such that they conflict with one another (so you can only
have one enabled at a time).  While DirectX is the default graphics backend
for MonoGame on Windows, it can be explicitly changed when generating 
projects by running:

::
    
    $ Protobuild.exe --generate Windows --enable MonoGame.Framework/OpenGLGraphics

Using services
----------------
    
Continuing the MonoGame example, the OpenGL backend can also be enabled by 
depending on it from another project (in this example, it would most likely
be a MonoGame-based game).  This dependency could be represented in the
``<Dependencies>`` section:

.. literalinclude:: example/sd_monogame.xml
    :language: xml
    :emphasize-lines: 7-11

For another example, Protogame optionally ships with support for OpenCL and
optionally provides a physics engine.  By default, these services are not
enabled, because it adds build time (more code and more third party libraries
need to be built).

In order to enable the physics engine in Protogame, a dependent project would
add:

.. literalinclude:: example/sd_protogame.xml
    :language: xml
    :emphasize-lines: 7-9

In the case of Protogame, it uses the Jitter library to provide physics.
Service dependencies are smart enough to recognise when a service-aware project
in a submodule has no references to it; in this scenario the submodule's project
is omitted from the build to reduce build time.  Thus if the Physics service
is not enabled in Protogame, the Jitter project would not be built.

.. note::

    A service-aware project is one that declares services using the
    ``<Services>`` section (see below).

.. tip::
    
    In the examples above, you'll notice that there's no ``<Reference>``
    to either MonoGame or Protogame.  This is because declaring that a
    project uses a service automatically adds a reference to the project
    that provides that service.

An alternative to the ``<Uses>`` tag is the ``<Recommends>`` tag.  Whereas the
Uses tag declares a requirement, the 
Recommends tag enables a service only if it would not conflict with any
other enabled service.
    
Declaring services
------------------------

You can declare services in your own projects using the optional ``<Services>``
section as demonstrated in the example below.

.. literalinclude:: example/sd_declare.xml
    :language: xml
    :emphasize-lines: 20-33

The options available to declared services are:

  * **AddDefine:** A comma seperated list of definitions to add to the project,
    so that code can be enabled / disabled based on the presence of the service.
  * **RemoveDefine:** A comma seperated list of definitions to remove from the
    project, so that code can be enabled / disabled based on the presence of
    the service.
  * **Reference:** Add another Protobuild reference to this project when this
    service is used.
  * **Conflicts:** This service conflicts with another service, and as such they
    can not both be enabled at the same time.
  * **Requires:** This service requires another service to also be enabled, and
    will cause it to be enabled (if conflicts would occur, an error occurs).
  * **InfersReference:** If set to False, then using this service will not
    imply a .NET reference on the project.  This should be set to False when
    tools or executables are providing services for the purposes of having them
    built along side the project.
 
Referencing services
------------------------

Services can be referenced as their local names (in the context of the previous
example, ``PrimaryGraphics``), or as their full names; 
``MyLibrary/PrimaryGraphics``.  This local / full name referencing applies
anywhere service names are used.

Recommending default services for a platform
----------------------------------------------

You can recommend a default service for a platform, while still giving the user
the ability to change to an alternative as demonstrated in the example
below.

.. literalinclude:: example/sd_declare.xml
    :language: xml
    :emphasize-lines: 12-19

In this example, ``SecondaryGraphics`` must be used on Mac OS X and Linux, but
Windows can use either graphics service (and defaults to ``PrimaryGraphics``).

Including and excluding files
-------------------------------

You can include and exclude files in your project based on the presence of
services.  This works in a similar manner as platform-based include /
exclude, except that the tag names are different.

See the example below for a demonstration of including and excluding files.

.. literalinclude:: example/sd_file.xml
    :language: xml
    :emphasize-lines: 2,5

Including external references
-----------------------------------

You can also include and exclude references in external projects based on
the presence of services.  This works in a similar manner to platform-based
inclusion in external projects.

.. literalinclude:: example/external_service.xml
    :language: xml
    :emphasize-lines: 5-11,15-17,21-23

You can also declare services in external projects, which can be used when
creating packages that involve service-aware projects.

.. literalinclude:: example/external_service_declare.xml
    :language: xml
