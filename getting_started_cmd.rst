Getting Started
===================

This document will show you how to get up and running with Protobuild in
5 minutes.  For this guide we'll assume you're interested in creating a project.

If instead you're looking to migrate an existing project, we recommend
following this guide to get acquainted with the way that Protobuild works, and
then refer to :doc:`project_migration` for performing a project migration.

Download Protobuild
--------------------

First you'll need to download Protobuild itself:

.. raw:: html

    <p id="download" >
      <strong>
        <a id="download" href="http://protobuild.org/get">Download Protobuild</a>
      </strong>
    </p>
    <style type="text/css">
      p#download {
        text-align: center; 
        margin-top: 40px; 
        margin-bottom: 40px;
        font-size: 24px;
      }
    
      p#download > strong > a {
        display: block;
        width: 50%; 
        margin: auto; 
        border: 1px solid #CCC;
        padding: 20px;
        background-color: #FFF;
        border-radius: 5px;
        cursor: pointer;
      }
      
      p#download > strong > a:hover {
        background-color: #DDD !important;
      }
    </style>

After you have downloaded Protobuild, place it in an empty directory
where you want to create your project.  Protobuild itself is cross-platform;
the same executable will run on all desktop platforms.

.. note::
    If you are using source control, you should add or track Protobuild.exe
    in your source control system.  For more information, refer to
    :ref:`source-control`

.. _Download Protobuild: 

.. _start-from-template:

Start with a template
------------------------

Starting with an existing project template is the easiest way to create a new
project in Protobuild.

Open a terminal or command prompt, and navigate to the directory where you
placed Protobuild.  You can start with a new template by running:

::

    $ Protobuild.exe --start http://protobuild.org/commons/Console <name>

Replace ``<name>`` with the name you want to give your new project.  This will
be the name used when creating the solution file.
    
If you are running Mac OS X or Linux, you'll need to prefix the above command
with ``mono`` (as with all commands in this documentation that execute 
Protobuild).
    
This will create a Protobuild module using the template at the specified URL.
You can find more templates by searching the `Protobuild package index`_.

.. tip::
    Common starting templates (including templates for libraries) can be
    found under `the commons organisation`_ on the Protobuild index.

.. note::
    The term ``module`` means the directory which contains Protobuild.exe, and
    all of your project definitions collectively.  Protobuild modules can have
    submodules, which are subdirectories that contain their own Protobuild
    executable and project definitions.
    
    Outside of this Getting Started guide, ``project`` refers to an individual
    Protobuild project definition, and not the module as a whole.  We just use
    the term ``project`` here since it's familiar to readers.

.. _Protobuild package index: http://protobuild.org/index
.. _the commons organisation: http://protobuild.org/commons

.. _start-from-scratch:

Start from scratch
--------------------

You can also create an empty Protobuild module if you wish to create project
definitions from scratch.  To do this, just run the Protobuild executable with
no arguments, and it will automatically create the required directories and
module configuration.

If you're creating a module from scratch, you'll need to refer to the
documentation on the various project types and how to create them:

 * :doc:`application_projects`
 * :doc:`console_projects`
 * :doc:`library_projects`
 * :doc:`content_projects`
 * :doc:`external_projects`

Generating projects
---------------------

Once you have created your module, you'll need to generate the C# projects so
that you can build your code.  To generate the C# projects for your module, run
the following command:

::

    $ Protobuild.exe --generate

.. tip::
    By default, this will generate C# projects for the current platform you
    are running Protobuild on.
    
You can specify what platform you want to generate C# projects for by passing
it as an argument to ``--generate``.  For example, to generate projects for
Windows, use:

::

    $ Protobuild.exe --generate Windows

You can also synchronise changes you have made in your C# projects back to the
project definition files by running:

::

    $ Protobuild.exe --resync

.. tip::
    This is the default command, and is triggered when double-clicking
    Protobuild under Windows.

This will synchronise and then regenerate the C# projects.  If you don't wish to
regenerate the C# projects (to avoid the Visual Studio project reload dialog),
you can use the following command instead:

::

    $ Protobuild.exe --sync

If you want to clean up the C# project and solution files generated by 
Protobuild, you can run the following command:

::

    $ Protobuild.exe --clean

.. note::
    All of the above commands accept a platform as an argument.  For more
    detail on what commands are available, try ``--help``.

Building code
---------------------

Once you have generated your C# projects, you can build your code in any of
the standard ways supported via .NET, whether that's using Visual Studio, 
Xamarin Studio, MonoDevelop or ``msbuild`` / ``xbuild`` from the command line.

Project generation will have created a solution file in the same directory as
Protobuild.  You can open this with any of the IDEs to start working on your
project.

When adding or removing files in your C# projects from Visual Studio, Xamarin
Studio or MonoDevelop, remember to save the projects in the IDE and then run
either ``--sync`` or ``--resync`` to save your changes back to your definition
files.

Further reading
-------------------

We recommend reading up on the different available project types (linked above
in :ref:`start-from-scratch`).  You can also refer to the :doc:`faq`.
