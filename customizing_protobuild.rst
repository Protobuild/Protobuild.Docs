Customizing Protobuild
===========================

You can customize Protobuild's project generation by overriding the project
generation templates that it uses.

.. warning::
    Customizing the project generation templates is a very advanced feature
    of Protobuild.  It is highly recommended that you're well versed in
    creating Protobuild projects before customizing the project templates.

Specifying additional transforms
----------------------------------

You can specify additional XSLT transforms to take place without overriding
the whole project generation template.  This can be used if you need to support
additional steps in your build process.

To specify additional XSLT transforms during project generation, create an
XSLT file at ``Build\AdditionalProjectTransforms.xslt``.  An example
of this file's contents is shown below (this example allows projects to
have protocol buffers precompiled with `protobuf-net`_).

.. _protobuf-net: https://code.google.com/p/protobuf-net/

.. literalinclude:: example/additional_project_transforms.xslt
    :language: xslt

This file is copied as-is into the project generation templates before they
are used to generate the projects.

.. tip::

    For more information about what is supported inside
    additional project transforms, extract the full templates as described
    below.  The additional project transforms document has access to all of
    the functionality that the full generation templates do.
    
Extracting the XSLT templates
--------------------------------

You can instruct Protobuild to extract the templates by running:

::

    $ Protobuild.exe --extract-xslt

This will place the extracted templates under the ``Build\``.  When the
templates are files in this location, they are used instead of the versions
embedded into the Protobuild executable.

Modifying Protobuild
----------------------

If you need additional functionality within the Protobuild executable, you can
build your own version of Protobuild and ship it within your repository.

You can build a modified version of Protobuild by following the instructions
in the FAQ: :ref:`build-protobuild`