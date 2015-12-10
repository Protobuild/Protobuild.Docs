Contributing
================

To contribute to Protobuild, we need you to follow a few important things.  Most importantly, make
sure you're familiar with two of the core principles of Protobuild:

  * **Zero maintainance** - We ensure that you never need to maintain or update your project
    definitions when new versions of Protobuild are released, because Protobuild ships as a 
    single executable in your repository.  There's nothing for you or your users to install in order to generate projects.                                     
  * **Guaranteed backwards and forwards compatibility** - When you include a third-party
    that's also using Protobuild, we guarentee that the version of Protobuild in your repository 
    will be able to invoke the third-party library's copy of Protobuild, even when they're different versions.

These principles place some restrictions on the way that features are developed.  Here's are some
restrictions to note:

  * Any changes to how project GUIDs are generated, loaded or written out is extremely sensitive.
    We rely on the project GUIDs to be generated in the same way across submodules, and submodules
    may ship different, older or newer versions of Protobuild.
  * The invocation of Protobuild in submodules must be checked using feature queries.  We use a
    command ``--query-features`` so that Protobuild can find out what command-line features
    instances of Protobuild have in submodules.  This means that if you're changing or adding
    new command-line arguments that are passed to submodules, you must add a feature check so
    that newer versions of Protobuild do not invoke older versions of Protobuild incorrectly.

Copyright licensing / agreement
----------------------------------

We are currently in the process of submitting Protobuild to the .NET Foundation.  Until this 
is finalized, we can't accept any more PRs as we may require signing of a CLA in the near
future.

Check the issue list
----------------------

We plan feature implementations using the `GitHub issue tracker`_.  Before you go and
implement something, check the issue tracker to see if there is already a similar feature
planned.  If there is, you'll need to develop your contribution in alignment with the
design already outlined in those feature issues; we can't accept contributions that may
act in conflict with a planned design.

.. _GitHub issue tracker: https://github.com/hach-que/Protobuild/issues

We use pull requests
----------------------

Once you've read and followed the instructions in the rest of this document, you'll need to
submit a `pull request on GitHub`_ to have your contribution accepted.

.. _pull request on GitHub: https://github.com/hach-que/Protobuild/pulls

You must write functional tests
----------------------------------

You **must** write functional tests that cover the new feature you have developed.  Pull
requests that are missing functional tests won't be accepted or merged.

The Protobuild project currently has at least 71 functional tests that cover the behaviour
of the Protobuild executable in various situations.  We want to continue extending this
functional test suite to cover all of the various invocations of Protobuild in all
circumstances to ensure that we do not have regressions in the software.

Run the automated build before submitting
--------------------------------------------------

Before your submit your pull request, you must run ``Protobuild.exe --automated-build``.
This not only produces a compressed executable, but also runs the unit and functional
test suites that must pass in order for your contribution to be accepted.

We'll rebase your changes
----------------------------

We **do not** use merges in our Git history.  This is because we are storing a binary
version of Protobuild in the repository, which also acts as the version of Protobuild
that users download.

Once your pull request has been accepted by an owner, that person will clone your
change locally, run ``Protobuild.exe --automated-build`` themselves (to ensure the
integrity of the compressed executable), amend the commit, and then rebase and push
it onto ``master``.

Adhere to the style guide
---------------------------

Protobuild has been organically developed over several years, so you may notice inconsistent
naming conventions in the codebase.  We intend on bringing these instances in alignment
with the style guide, but this is an ongoing process.

Our style conventions are currently:

  * Private fields should use camel case with an underscore prefix, e.g. ``_somePrivateField``.
  * Don't use ``this.`` prefix unless it's required
  * Use sensible C# conventions for class naming, etc.

You must follow the style guide for your contribution to be accepted.  We intend on
automating style checking at some point in the future, but in the meantime, the person
reviewing your code on GitHub may highlight style issues which you will need to fix.

Summary
----------

If you're ready to submit your change for code review, create a `pull request on GitHub`_.
Thank you for contributing to Protobuild.