Customizing Projects with Properties
====================================

Protobuild has many additional properties that you can set on projects to
customize how they are generated.  You can declare properties in the
optional ``<Properties>`` section of your project, as demonstrated below.

.. code-block:: xml
    :emphasize-lines: 3-6

    <?xml version="1.0" encoding="utf-8"?>
    <Project Name="MyApplication" Path="MyApplication" Type="App">
      <Properties>
        <Property Name="RootNamespace" Value="Microsoft.Xna.Framework" />
        <Property Name="RemoveXnaAssembliesOnWP8" Value="false" />
      </Properties>
      <References>
        <Reference Include="System" />
        <Reference Include="System.Core" />
      </References>
      <Files>
        <Compile Include="Program.cs" />
      </Files>
    </Project>

A full list of properties is detailed below:

AssemblyName
-----------------

**Applies to:** All platforms and project types

**Value type:** Platform mapping **or** string

**Default:** The project name

A set of platform mappings that change the assembly name for the project, based
on the current platform.

An example of this property in use is:

.. code-block:: xml

    <Properties>
      <AssemblyName>
        <Platform Name="Android">MyProject.Android</Platform>
        <Platform Name="iOS">MyProject.iOS</Platform>
        <Platform Name="Linux">MyProject.Linux</Platform>
        <!-- etc. -->
      </AssemblyName>
    </Properties>

The following is also valid:

.. code-block:: xml

    <Properties>
      <Property Name="AssemblyName" Value="MyProject.XYZ" />
    </Properties>

FrameworkVersions
--------------------

**Applies to:** All platforms and project types

**Value type:** Platform mapping

**Default:** Equivalent to .NET framework 4.0 (Full Profile)

A set of platform mappings that change the framework version and profile for
the assembly, based on the current platform.

An example of this property in use is:

.. code-block:: xml

    <Properties>
      <FrameworkVersions>
        <Platform Name="Android">
          <Version>4.2</Version>
        </Platform>
        <Platform Name="Windows">
          <Version>4.0</Version>
          <Profile>ClientOnly</Profile>
        </Platform>
        <Platform Name="Linux">
          <Version>4.5</Version>
        </Platform>
        <!-- etc. -->
      </AssemblyName>
    </Properties>

PlatformSpecificOutputFolder
------------------------------

**Applies to:** All platforms and project types

**Value type:** "True" or "False"

**Default:** "True"

Determines whether the output paths for binary and object files during
compilation should reside in "bin\\$(Configuration)" and 
"obj\\$(Configuration)", or whether the platform name should be used in
the path (the default).  When the platform name is included in the path, the 
binary folder becomes "bin\\$(Platform)\\$(Arch)\\$(Configuration)" and the 
object folder becomes "obj\\$(Platform)\\$(Arch)\\$(Configuration)" (where 
Arch is the .NET concept of platforms, e.g. ``AnyCPU``).

.. note::

    In previous versions of Protobuild, this defaulted to False.

ProjectSpecificOutputFolder
------------------------------

**Applies to:** All platforms and project types

**Value type:** "True" or "False"

**Default:** "False"

Determines whether the output paths for binary and object files should include
the project name.  The option implies ``PlatformSpecificOutputFolder``.

When this option is active, the binary and object paths become 
"bin\\$(Project)\\$(Platform)\\$(Arch)\\$(Configuration)" and 
"obj\\$(Project)\\$(Platform)\\$(Arch)\\$(Configuration)" (where Arch is the 
.NET concept of platforms, e.g. ``AnyCPU``).

You only need to enable this option if you are targeting Android and you have 
more than one project residing in the same directory.  Xamarin Studio for 
Android exhibits a bug where multiple projects having the same object 
directory will cause issues when linking against native libraries, and 
this option allows you to work around the issue by ensuring the object 
folder is unique per project.

.. _custom-definitions:

CustomDefinitions
---------------------

**Applies to:** All platforms and project types

**Value type:** Platform mapping

**Default:** See below

A set of platform mappings that change the compile-time constants that are
present when compiling C# code.

An example of this property in use is:

.. code-block:: xml

    <Properties>
      <CustomDefinitions>
        <Platform Name="Android">TRACE;ANDROID;GLES;OPENGL</Platform>
        <Platform Name="iOS">IOS;GLES;OPENGL</Platform>
        <Platform Name="Linux">TRACE;LINUX;OPENGL</Platform>
        <Platform Name="MacOS">MONOMAC;OPENGL</Platform>
        <Platform Name="Ouya">TRACE;ANDROID;GLES;OPENGL;OUYA</Platform>
        <Platform Name="PSMobile">PSM</Platform>
        <Platform Name="Windows">TRACE;WINDOWS;DIRECTX;WINDOWS_MEDIA_SESSION</Platform>
        <Platform Name="Windows8">TRACE;NETFX_CORE;WINRT;WINDOWS_STOREAPP;DIRECTX;DIRECTX11_1;WINDOWS_MEDIA_ENGINE</Platform>
        <Platform Name="WindowsGL">TRACE;WINDOWS;OPENGL</Platform>
        <Platform Name="WindowsPhone">TRACE;SILVERLIGHT;WINDOWS_PHONE;WINRT;DIRECTX</Platform>
      </CustomDefinitions>
    </Properties>

The defaults for this option are equivalent to:

.. code-block:: xml

    <Properties>
      <CustomDefinitions>
        <Platform Name="Android">PLATFORM_ANDROID</Platform>
        <Platform Name="iOS">PLATFORM_IOS</Platform>
        <Platform Name="Linux">PLATFORM_LINUX</Platform>
        <Platform Name="MacOS">PLATFORM_MACOS</Platform>
        <Platform Name="Ouya">PLATFORM_OUYA</Platform>
        <Platform Name="PSMobile">PLATFORM_PSMOBILE</Platform>
        <Platform Name="Windows">PLATFORM_WINDOWS</Platform>
        <Platform Name="Windows8">PLATFORM_WINDOWS8</Platform>
        <Platform Name="WindowsGL">PLATFORM_WINDOWSGL</Platform>
        <Platform Name="WindowsPhone">PLATFORM_WINDOWSPHONE</Platform>
      </CustomDefinitions>
    </Properties>

The ``DEBUG`` constant is always added when the project is a Debug build.

ForceArchitecture
--------------------

**Applies to:** All platforms and project types

**Value type:** String

**Default:** Any CPU for desktop, varies for mobile

Changes the specified architecture for a project to the given value, even
when the project's platform is exposed as Any CPU.

This does not change the C# target platform from Any CPU when exposed at a
solution configuration level, it simply forces the architecture of the
resulting DLL.

This can be used when you need an assembly to execute in 32-bit mode due
to native dependencies.

RootNamespace
----------------

**Applies to:** All platforms and project types

**Value type:** String

**Default:** The project name

Changes the root namespace for the assembly.

NoWarn
----------------

**Applies to:** All platforms and project types

**Value type:** String

**Default:** None

A comma separated list of compiler warning numbers to disable 
when compiling the project.

.. code-block:: xml

    <Properties>    
      <NoWarn>1591,0436</NoWarn>
    </Properties>

ManifestPrefix
-----------------

**Applies to:** Android and Silverlight platforms

**Value type:** String

**Default:** Empty string

Specifies a prefix to be applied to the ``Properties\AndroidManifest.xml`` and
``Properties\AppManifest.xml`` paths used by the Android and Silverlight
platforms.

RazorGeneratorTargetsPath
----------------------------

**Applies to:** Only website projects

**Value type:** String

**Default:** No effect

Sets the path to the RazorGenerator ``.targets`` file.  When this is specified
the ``PrecompileRazorFiles`` target is called before the build executes.

RemoveXnaAssembliesOnWP8
--------------------------

**Applies to:** Only Windows Phone 8

**Value type:** "True" or "False"

**Default:** "False"

Determines if XNA assemblies should be removed on Windows Phone 8.  Set this
value to "True" if you are building a MonoGame-based project for Windows
Phone 8.

WindowsApplicationIcon
-------------------------

**Applies to:** Windows platform

**Value type:** String

**Default:** Not set

Specify the ``.ico`` file to use when compiling the application.  This sets
the icon for the resulting executable.

This option only affects binaries when they are viewed on Windows.  Mac OS
icons are controlled ``separately`` by the Info.plist file, and Linux does not
directly associate icons with binaries.

iOSUseArmv7
--------------------------

**Applies to:** Only iOS

**Value type:** "True" or "False"

**Default:** "False"

Sets the ``MtouchUseArmv7`` property.  Changing this property may 
result in incompatibility with included libraries.

iOSUseLlvm
--------------------------

**Applies to:** Only iOS

**Value type:** "True" or "False"

Sets the ``MtouchUseLlvm`` property.  Changing this property may 
result in incompatibility with included libraries.

iOSUseSGen
--------------------------

**Applies to:** Only iOS

**Value type:** "True" or "False"

Sets the ``MtouchUseSGen`` property.  Changing this property may 
result in incompatibility with included libraries.

iOSUseRefCounting
--------------------------

**Applies to:** Only iOS

**Value type:** "True" or "False"

Sets the ``MtouchUseRefCounting`` property.  Changing this property 
may result in incompatibility with included libraries.

iOSI18n
--------------------------

**Applies to:** Only iOS

**Value type:** "True" or "False"

Sets the ``MtouchI18n`` property.  Changing this property may result
in incompatibility with included libraries.

iOSArch
--------------------------

**Applies to:** Only iOS

**Value type:** Comma-separated list of architectures.

Sets the ``MtouchArch`` property.  Changing this property may 
result in incompatibility with included libraries.

SignAssembly
--------------------------

**Applies to:** Only iOS

**Value type:** "True" or "False"

Sets the ``SignAssembly`` property, which presumably causes
the assembly to be signed.

IncludeMonoRuntimeOnMac
--------------------------

**Applies to:** Only Mac OS with Xamarin Mac

**Value type:** "True" or "False"

**Default:** "False"

Sets whether or not the Mono runtime should be included when building on Mac.
If the current Mac does not have Xamarin Mac installed, then the resulting
project always has this option turned off, regardless of this setting.

MonoMacRuntimeLinkMode
--------------------------

**Applies to:** Only Mac OS with Xamarin Mac

**Value type:** "", "SdkOnly" or "Full"

**Default:** ""

Sets the type of linking mode when the Mono runtime is included on a Mac.
If the current Mac does not have Xamarin Mac installed, then the resulting
project always has this option turned off, regardless of this setting.

MonoDevelopPoliciesFile
--------------------------

**Applies to:** All platforms and project types

**Value type:** String

**Default:** No effect

Reads the specified file (relative to the module root) and places the contents
of this file under the MonoDevelop policies node.

The file contents should be that of applied policies; **not** a policy file
exported from MonoDevelop (the formats are different).  To retrieve a set
of applied policies, you must create a blank C# project in MonoDevelop, apply
your policy file and then copy the `<Policies>` node into a seperate file.

.. danger::
    The applied policies file is **not** an XML file.  Do not
    place the XML header (``<?xml ...?>``) in this
    file as it will be copied literally into the C# project.

When this is complete, the contents of the file should look similar to:

.. literalinclude:: example/monodevelop_policy.xml
    :language: xml
