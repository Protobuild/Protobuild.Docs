Code Signing for iOS
===========================

As of writing, Xamarin stores the selected iOS Code Signing key in the C# 
project.  This means that without Protobuild, iOS projects can't be moved 
across computers without updating that property in the C# project.

When generating C# projects for iOS, Protobuild will check for the
existence of a ``.codesignkey`` file in your home directory, and will use the
contents of that file for the property. This allows each computer
to have it's own code signing settings, without the project or 
definition file requiring changes.