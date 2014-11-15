Targeting the Web Platform
=============================

Protobuild supports targeting C# code for the Web via `JSIL`_, a CIL to 
Javascript compiler. Protobuild configures projects to use the JSIL compiler
as a post-build step transparently, so you don't need to perform any
configuration to take advantage of JSIL.

.. _JSIL: http://jsil.org/

Usage
----------

The JSIL compiler is invoked on application projects.

To generate for the Web platform, use the following command:

::

    $ Protobuild.exe --generate Web

When your project builds, the JSIL compiler will be invoked and the 
resulting Javascript files will reside inside the standard bin 
directory. You can then use the compiled Javascript according to 
the documentation found on the `JSIL wiki`_.

.. _JSIL wiki: https://github.com/sq/JSIL/wiki#using-the-compiled-javascript-in-a-webpage

JSIL Download
---------------

The first time you target the Web platform, Protobuild will automatically 
download and build JSIL into the Application Data directory on your machine. 
You must have both Git and either xbuild or msbuild in your PATH for this 
process to work.

You **don't** need to include JSIL as a submodule in your repository, nor do 
you need to ship binary versions of JSIL alongside your application code. 
Each machine that targets the web platform under Protobuild will 
automatically have the latest version of JSIL installed for usage.