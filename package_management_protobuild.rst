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
  * Packages are LZMA compressed and deduplicated to significantly
    reduce their size.
  * Support for module templates as packages.

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
    MonoGame Git repository.  This is because (as of the time of writing),
    MonoGame does not ship binary Protobuild packages.

Packages can ship binary or source versions, or both.  By default, when a binary
version is not available for the desired platform, Protobuild will automatically
fall back to cloning the source repository (if the package has one).

.. note::
    Protobuild will automatically add the folder containing the package to your
    ``.gitignore`` file, if your module is being tracked in a Git repository.

If you want to add a package using a specific branch, you can use
the following command:

::

    $ Protobuild.exe --add http://protobuild.org/MonoGame/MonoGame@develop

If you want to add a package using a specific Git commit, you can use:

::

    $ Protobuild.exe --add http://protobuild.org/MonoGame/MonoGame@81bdf42b88acd5e859d856bc0f7fa18004ff977e

Switching a package to source format
-------------------------------------

If you have added a package, and it's currently in binary format, you can
get Protobuild to switch the package to a source format with:

::

    $ Protobuild.exe --swap-to-source <URI>

The URI is the URI of the package.  If you don't remember it, you can view
``Build\Module.xml``, which contains all of the packages added to your
module, and their URIs.

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
module, and their URIs.

.. note::
    This will only work if there is a binary version of the package available
    for the desired commit and platform.

Upgrading a package
--------------------

If you have added a package which is tracking a branch (the default), then you
can upgrade a package to the latest version of that branch by using the
``--upgrade`` option, like so:

::

    $ Protobuild.exe --upgrade <URI>

By default packages usually track the ``master`` branch of a package.  If the
package is in binary format, and you want to upgrade a specific platform, you
can do so with:

::

    $ Protobuild.exe --upgrade <URI> <platform>

.. warning::
    If the package is in source format, this command will undo any local
    modifications you have made.  It works by deleting the package's folder
    and replacing it with a newer version.

.. note::
    You will need to run Protobuild with ``--generate`` to generate projects
    in the upgraded packages.

Upgrading all packages
------------------------

You can upgrade all packages in a module like so:

::

    $ Protobuild.exe --upgrade-all

If you want to upgrade packages for a specific platform, you can do so with:

::

    $ Protobuild.exe --upgrade-all <platform>

.. warning::
    This command will undo local modifications to any packages that are in
    source format.  It works by deleting all package folders and replacing them
    with the latest versions.

.. note::
    You will need to run Protobuild with ``--generate`` to generate projects
    in the upgraded packages.

Redirecting package URLs
--------------------------

You can redirect package URLs for packages to use alternate or modified
versions.  You can configure package URL redirections at a user level, or 
transiently with command arguments.

To redirect a package URL for a single invocation of Protobuild, use the
``--redirect`` option like so:

::

    $ Protobuild.exe --redirect http://source/path http://target/newpath

Most often this argument is used in conjunction with either ``--generate`` or
``--upgrade-all``:

::

    $ Protobuild.exe --redirect http://source/path http://target/newpath --upgrade-all

You can also configure this option at a user level, by creating or modifying
a file called ``protobuild-redirects.txt`` which resides in your Application Data
directory (``~/.config/protobuild-redirects.txt`` for Linux and Mac OS).  The format
of this file looks like:

.. literalinclude:: example/redirects.txt
    :language: text

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

Using template packages
-------------------------

You can use template packages to quickly set up new modules.  This is detailed
in the Getting Started guide under :ref:`start-from-template`.