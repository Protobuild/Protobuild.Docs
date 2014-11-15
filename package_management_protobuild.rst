Package Management with Protobuild
====================================

Protobuild provides a powerful, cross-platform package management system.  It is
intended to fix some of the shortcomings of NuGet, while also providing greater
flexibility for developers.

Primarily the features of Protobuild's package management system over NuGet are:

  * Full support for cross-platform projects, in particular those that need
    to make native calls (such as P/Invoke).
  * Automatic fallback to source code repositories if binary versions are
    not available for the platform.
  * The ability to swap source and binary versions of packages, reducing
    the work required to diagnose issues in a package's functionality.
  * Support for project templates as packages.

Finding packages
-------------------

The primary package repository is located on the Protobuild website.  This
is known as the `Protobuild Package Index`_.

.. _Protobuild Package Index: http://protobuild.org/index

You can use the search functionality on the Protobuild Package Index to find
packages to install.  The Protobuild Package Index also instructs you on what
command to run to add packages.

Adding packages
-----------------

You can add a package with the following command:

::

    $ Protobuild.exe --add <URI>

For example, to add the MonoGame package to your module, you can use the
following command:

::

    $ Protobuild.exe --add http://protobuild.org/MonoGame/MonoGame

.. tip::
    You'll notice that when adding MonoGame that Protobuild will clone the
    MonoGame Git repository.  This is because (as at the time of writing),
    MonoGame does not ship binary Protobuild packages.

Packages can ship binary or source versions, or both.  By default, when a binary
version is not available for the desired platform, Protobuild will automatically
fall back to cloning the source repository (if the package has one).

.. note::
    Protobuild will automatically add the folder containing the package to your
    ``.gitignore`` file, if your module is being tracked in a Git repository.

Switching a package to source format
-------------------------------------

If you have added a package, and it's currently in binary format, you can
get Protobuild to switch the package to a source format with:

::

    $ Protobuild.exe --swap-to-source <URI>

The URI is the URI of the package.  If you don't remember it, you can view
``Build\Module.xml``, which contains all of the packages added to your
project, and their URIs.

.. note::
    This will only work if the package has a Git repository URL configured.

Switching a package to binary format
-------------------------------------

If you have added a package, and it's currently in source format, you can
get Protobuild to switch the package to a binary format with:

::

    $ Protobuild.exe --swap-to-binary <URI>

The URI is the URI of the package.  If you don't remember it, you can view
``Build\Module.xml``, which contains all of the packages added to your
project, and their URIs.

.. note::
    This will only work if there is a binary version of the package available
    for the desired commit and platform.

Removing packages
--------------------

At the moment, to remove a package you'll need to open ``Build\Module.xml``
with a text editor, and remove the section for package you want to remove.

For example, in the module shown below, to remove the Protogame package,
you'd remove the highlighted lines.

.. literalinclude:: example/module_remove_package.xml
    :language: xml
    :emphasize-lines: 9-13

You'll then need to delete the folder that contains the package.

Creating a package
---------------------

If you want to create and publish a package for your own library on the
Protobuild index, refer to the :doc:`creating_packages` documentation.