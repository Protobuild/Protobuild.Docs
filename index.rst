Welcome to Protobuild
======================================

`Protobuild`_ is a project generation system for C#.  It aims to make
cross-platform development in C# easier, by generating your projects in the
appropriate format for each platform.

Protobuild is fully open source and available under an MIT license.

.. _Protobuild: http://protobuild.org/

This documentation is organised into two sections:

 * :ref:`user-docs`
 * :ref:`user-guides`

.. _user-docs:
 
User Documentation
--------------------

This documentation is for developers interested in using Protobuild in their
own projects.

.. toctree::
    :maxdepth: 2
    :caption: General Information

    faq
    support
    contributing
    
.. toctree::
    :maxdepth: 2
    :caption: Graphical Interface

    getting_started_gui

.. toctree::
    :maxdepth: 2
    :caption: Command-Line Interface

    getting_started_cmd
    application_projects
    console_projects
    library_projects
    content_projects
    include_projects
    external_projects
    project_migration
    project_properties
    module_options
    including_submodules
    package_management_protobuild
    package_management_nuget
    creating_packages
    ios_codesign
    web_platform
    service_dependencies
    customizing_protobuild

.. _user-guides:

End User Guides
----------------------------

This documentation is for end users; that is, people consuming projects that
already use Protobuild.  If you're a developer interested in using Protobuild
in your own projects, refer to the :ref:`user-docs` instead.

When documenting how to generate your projects, it is recommended you refer
your users to the guides listed below.

.. toctree::
    :maxdepth: 2

    enduser_generating_projects