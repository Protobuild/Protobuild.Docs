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
    