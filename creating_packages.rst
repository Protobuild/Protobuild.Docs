Creating Packages for Protobuild
====================================

For an overview of the Protobuild package management system, refer to
:doc:`package_management_protobuild`.

When creating a Protobuild package, you can provide your package in source
format, binary format or both.
  
If your library is stored in a publically accessible Git repository, and uses
Protobuild, you can provide the Git URL for cloning when creating your package.
This will allow users to use any version of your library on any platform you
support, without requiring built packages.

If you want to provide built packages to reduce download and build times, or if
your library is not managed by Protobuild, you can provide binary packages.
These result in a significantly smaller download and almost no build time cost,
but you'll need to build the code, package it and push it to the Protobuild
index.  This is particularly useful if your source repository has a large
history, or has large binary files within it.

Creating your package on the index
------------------------------------

To create a package on the `Protobuild Package Index`_, you'll need to login
and create a new package.  Roughly you'll need to follow the steps below:

  * `Login to the index`_.  The package index uses Google accounts for
    authentication.
  * When prompted, set your username for your account.  Although this can be
    changed later, no redirects will be configured if you change it.
  * On your account page, click "New Package".  This will be a URL
    of ``http://protobuild.org/<account name>/new``.
  * Specify the name of your new package.
  * Specify your package type.  The package types available are:
  
    * **Library:** A library consumed by other modules.  These are added to
      a module with ``--add``.
    * **Template:** A module template.  These are used with ``--start`` and are
      outlined under :ref:`template-packages`.
      
  * Specify the full URL to your Git repository if applicable.  If you are
    providing a source version of your package, then you need to have this
    set.
  * Write a short description of your package.  Descriptions don't support
    formatting or styling.
  * Click Save.

.. _Protobuild Package Index: http://protobuild.org/index
.. _Login to the index: http://protobuild.org/login

.. note::
    If your package is a native binary that is not built using Protobuild, or
    if your package otherwise can't be used or referenced directly in source
    format, you should omit the Git URL and only provide binary versions
    of your package.

Automatically creating a package file
---------------------------------------

Protobuild provides an automatic packaging mechanism which can be used to
automate the process of packaging your binaries in most cases.

.. note::
    
    This only applies to Library packages.  Template packages need to follow
    the manual process outlined in the next section.

Because Protobuild uses a declarative syntax, it can determine the output
locations and related files from your build, and automatically include them
in your package.  In addition, it can automatically generate the required
external projects in the binary package required for usage.

To create a package file automatically, you should run the following commands:

::

    $ Protobuild.exe --generate Windows
    $ Protobuild.exe --build Windows
    $ Protobuild.exe --pack . MyPackage-Windows.tar.lzma Windows

The first argument to pack (the dot) indicates the directory path to the
module being packaged, which in the example above is the current directory.

Repeat this process for each platform you want to build and package.

.. warning::
    
    You must build your code before running ``--pack``, or the binaries will not
    have been built for inclusion in the package.
    
The automatic packaging mechanism won't work for all projects; in particular, 
if you have any external C# projects referenced with the ``<Project>`` tag,
you'll receive a warning that the automatic packaging mechanism could not
translate it for that package.  In this case, refer to the manual section below
on how to create and add the required files as additional content to the
automatic packaging mechanism's output.

.. note::

    If the automatic packaging mechanism works for you, skip to 
    :ref:`push-package`.

Manually creating a package file
-----------------------------------

If you are packaging a template, or if the automatic packaging mechanism is
unable to handle your project, you can extend or replace the process using
a "filter file".  A filter file describes what files should be included
during packaging, and can be used to provide files in addition to the
automatic packaging mechanism, or can be used to construct a package from
scratch.

In the next few sections, we cover the package structure, how to define
projects, and how to use filter files.

Package structure
~~~~~~~~~~~~~~~~~~~~

The structure for Protobuild packages (for both Library and Template types), is
very similar to the normal structure of a Protobuild module, with the exception
that you do not need to include the Protobuild executable in your package.

Normally for the binary version of a package, you'll layout the package
similar to the following structure:

::

  * /
    * Build
      * Projects
        * MyLibrary.definition
      * Module.xml
    * MyLibrary
      * MyLibrary.dll
      * NativeLibrary.so

.. note::

    Refer to :ref:`template-packages` for information on filename replacements
    performed on template packages.

Defining projects
~~~~~~~~~~~~~~~~~~~~~

For your Protobuild module, your projects will currently be defined as normal
projects.  However, since your binary package won't contain source code, you'll
need to define external projects that match the files you are providing.

For the example package above, the contents of ``MyLibrary.definition`` would
be:

.. literalinclude:: example/package_external.xml
    :language: xml
    
Refer to the :doc:`external_projects` for more comprehensive documentation on
specifying external projects.
      
Specifying files for inclusion
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      
When building your package from source, it's unlikely to resemble the structure
of a package.  In order to allow the creation of packages without requiring
reorganisation of built files, Protobuild packaging uses a text file known
as a filter file.

An example filter file is shown below.

.. literalinclude:: example/filter.txt
    :language: text

The entries in the filter file are executed in sequence, and the purpose of
each entry is detailed below.  Lines the start with ``#`` are treated as
comments, and blank lines are ignored.

Any instances of the text ``%PLATFORM%`` are replaced with the name of the
platform passed to ``--pack``.  This allows you to use a common filter file
between platforms.

You will most likely have different filter files for each platform you are
providing binaries for, as different platforms will require different files
to be included.

**include**:

Specifies that files whose paths match the regular expression should be
included in the package.

**exclude**:

Specifies that any files currently in the package that match the regular
expression should be excluded.

**rewrite**:

Rewrites the paths of files in the package matching the regular expression
to the target expression.  This effectively allows you to move files around
inside the package when creating it, rather than creating the appropriate
directory structure before packaging.

**autopackage**:

Invokes the automatic packaging mechanism.  If you need to provide additional
external projects (because of warning shown during the automatic packaging
mechanism), you should make the first directive in your filter file to be
``autopackage``, and then follow on with additional ``include`` and ``rewrite``
directives to include the additional binaries and external project definitions
required.

The use of this options requires that the directory passed to ``--pack`` points
to a module.  If you don't use this option, then the first argument to ``-pack``
can point to any directory.

Creating the package file
~~~~~~~~~~~~~~~~~~~~~~~~~~

To create the package file ready for upload, you'll need to run the following
command:

::
    
    $ Protobuild.exe --pack . MyPackage.tar.lzma Linux Build/Filter.Linux.txt

In this example, the current directory ``.`` will be packaged into a file
called ``MyPackage.tar.lzma``, using the filter file located at
``Build/Filter.Linux.txt``.  The platform ``Linux`` is specified, which is
used by both the automatic packaging mechanism (if invoked by ``autopackage``),
and is also used to replace the text ``%PLATFORM%``.

If you want to upload your package via the Protobuild index web interface, 
you'll need to pack it into ``.tar.gz`` format instead, as the web interface
does not support uploading ``.tar.lzma`` files (although they provide a much
greater compression ratio).  You can package as ``.tar.gz`` using the following
command:

::
    
    $ Protobuild.exe --pack . MyPackage.tar.gz Linux Build/Filter.Linux.txt --format tar/gzip

.. _push-package:
    
Publishing a package file
---------------------------

To publish a package file to the Protobuild index, you'll need to retrieve your
API key from `your account page`_ (it is listed at the bottom after all of
your packages).

.. _your account page: http://protobuild.org/login

With your API key, you can now publish the package file as a new version of
your package with the following command:

::
    
    $ Protobuild.exe --push <apikey> MyPackage.tar.lzma http://protobuild.org/MyAccount/MyPackage <githash> <platform>

You need to specify a Git hash that matches the hash that the source code was
built from.  You can retrieve the current Git hash by running:

::
    
    $ git rev-parse HEAD

.. warning::
    Package versions are immutable.  Once you push a file for a specific Git
    hash, you can't upload a new version with the same Git hash, unless you 
    delete it from web interface manually.
    
    If you need an identifier that updates as you release new versions, you
    should update a branch, and direct your users to use the branch as the
    version.
    
You can create and update a branch to point at the pushed version by specifying
a branch name as the last argument.  In the previous example, if you wanted to
update the "master" branch to the newly pushed package, you can use:

::
    
    $ Protobuild.exe --push <apikey> MyPackage.tar.lzma http://protobuild.org/MyAccount/MyPackage <githash> <platform> master

.. _template-packages:
    
Template packages
-------------------

Template packages contain templates for a module.  They are structured in the
exact same way as library packages, except that when the user creates a new
module using a template, the following process happens:

  * As files are extracted into the module directory, file and directory names
    have ``{PROJECT_NAME}`` replaced with the project name the user gave to
    ``--start``.
  * As files are written, ``{PROJECT_NAME}`` is replaced with the project
    name, and ``{PROJECT_XML_NAME}`` is replaced with the project name with
    characters escaped for XML documents.  This process does not apply to
    binary files.

The `Protobuild common templates`_ repository provides a good reference for
creating template packages.

.. _Protobuild common templates: https://github.com/hach-que/Protobuild.Commons
