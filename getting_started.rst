Getting Started
===================

This document will show you how to get up and running with Protobuild in
5 minutes.  For this guide we'll assume you're interested in creating a project.

If instead you're looking to migrate an existing project, we recommend
following this guide to get acquainted with the way that Protobuild works, and
then refer to :doc:`project_migration` for performing a project migration.

Download Protobuild
--------------------

First you'll need to download Protobuild itself.  Download the executable from
`the GitHub repository`_ and place it in an empty directory where you want to
create your project.

.. _the GitHub repository: https://github.com/hach-que/Protobuild/raw/master/Protobuild.exe

Start with a Template
------------------------

Starting with an existing project template is the easiest way to create a new
project in Protobuild.

Open a terminal or command prompt, and navigate to the directory where you
placed Protobuild.  You can start with a new template by running:

::

    $ Protobuild.exe --start http://protobuild.org/Protogame/Template.Blank

If you are running Mac OS X or Linux, you'll need to prefix the above command
with ``mono`` (as with all commands in this documentation that execute Protobuild).
    
This will create a Protobuild module using the template at the specified URL.
You can find more templates by searching the `Protobuild package index`_.
Common starting templates (including library templates and console
applications) can be found under `the commons organisation`_ on the Protobuild
index.

.. _Protobuild package index: http://protobuild.org/index
.. _the commons organisation: http://protobuild.org/commons
