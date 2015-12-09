Getting Started
===================

This guide will help you install the graphical tool known as the
Protobuild Manager on your computer.  The graphical tool provides
a friendly interface for opening and creating new projects.

If you prefer working from the command-line, you can create projects
using the command-line interface at :doc:`getting_started_cmd`.

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

Install the Protobuild Manager
--------------------------------

Double-click the Protobuild executable that you downloaded, or if you're
running on Mac OS or Linux, run the following command from the terminal:

::

    $ mono Protobuild.exe

This will automatically download and install the Protobuild Manager
(graphical interface) suitable for your platform.

Run Protobuild Manager
---------------------------

On Windows
~~~~~~~~~~~~~

.. If you are on Windows, you'll find a shortcut to the Protobuild Manager in
.. your start-menu.  Use this link to open or create new projects managed
.. by Protobuild.

If you are on Windows, just double-click Protobuild in a directory that
does not contain a project in order to start the Protobuild Manager.

On Mac OS
~~~~~~~~~~~~~~

You can start the Protobuild Manager on Mac OS by running:

::

    $ mono Protobuild.exe --execute Protobuild.Manager
    
from a directory that contains ``Protobuild.exe``.

.. If you are on Mac OS, you'll find the Protobuild Manager installed into
.. your local applications.  You can start the Protobuild Manager from
.. Spotlight.

On Linux
~~~~~~~~~~~

You can start the Protobuild Manager on Linux by running:

::

    $ mono Protobuild.exe --execute Protobuild.Manager
    
from a directory that contains ``Protobuild.exe``.