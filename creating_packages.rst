Creating Packages for Protobuild
====================================

For an overview of the Protobuild package management system, refer to
:doc:`package_management_protobuild`.

There's a few important things to take note of when creating a package for
Protobuild:

  * The binary version of your package should include all projects that your
    source repository offers.
  * For the binary version of your package, you will be declaring external 
    project versions that are consumed by other projects.

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
      outlined later in this document.
      
  * Specify the full URL to your Git repository if applicable.  If you set this,
    then your binary package versions need to offer all projects that your 
    source repository does.
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

Package structure
-----------------

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

Defining projects
---------------------

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
----------------------------------
      
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

You will most likely have different filter files for each platform you are
providing binaries for, as different platforms will require different files
to be included.

include
~~~~~~~~~

Specifies that files whose paths match the regular expression should be
included in the package.

exclude
~~~~~~~~~

Specifies that any files currently in the package that match the regular
expression should be excluded.

rewrite
~~~~~~~~~

Rewrites the paths of files in the package matching the regular expression
to the target expression.  This effectively allows you to move files around
inside the package when creating it, rather than creating the appropriate
directory structure before packaging.

Creating a package file
----------------------------

To create a package file ready for upload, you'll need to run the following
command:

::
    
    $ Protobuild.exe --pack . MyPackage.tar.lzma Build/Filter.Linux.txt

In this example, the current directory ``.`` will be packaged into a file
called ``MyPackage.tar.lzma``, using the filter file located at
``Build/Filter.Linux.txt``.  The filter file prevents the created package (or
any other files in the current directory that don't match), from being included
in the package if you run multiple ``--pack`` operations.

The filter file can be omitted, but the directory specified must exactly match
the package structure.

If you want to upload your package via the Protobuild index web interface, 
you'll need to pack it into ``.tar.gz`` format instead, as the web interface
does not support uploading ``.tar.lzma`` files (although they provide a much
greater compression ratio).  You can package as ``.tar.gz`` using the following
command:

::
    
    $ Protobuild.exe --pack . MyPackage.tar.gz Build/Filter.Linux.txt --format tar/gzip

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

