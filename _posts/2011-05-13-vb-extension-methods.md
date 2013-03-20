---
layout: post
title: VB Extension Methods
slug: vb-extension-methods
author:
    name: Austin McShan
---
Extension methods can be helpful when you want to add custom functionality to existing data types without having to create a new type that derives from a the base type. Extension methods are called similarly to instance methods of the type.

Extension methods provide a  convenient and powerful way to extend an existing type. In writing extension methods here are some points taken from [MSDN](http://msdn.microsoft.com/en-us/library/bb384936.aspx "msdn") to consider:

- If any accessible instance member exists that has a signature that is compatible with the arguments in the calling statement, with no narrowing conversions required from argument to parameter, the instance method will be used in preference to any extension method. Therefore, if an appropriate instance method is added to a class at some point, an existing extension member that you rely on may become inaccessible.
- The author of an extension method cannot prevent other programmers from writing conflicting extension methods that may have precedence over the original extension.
- You can improve robustness by putting extension methods in their own namespace. Consumers of your library can then include a namespace or exclude it, or select among namespaces, separately from the rest of the library.
- It may be safer to extend interfaces than it is to extend classes, especially if you do not own the interface or class. A change in an interface affects every class that implements it. Therefore, the author may be less likely to add or change methods in an interface. However, if a class implements two interfaces that have extension methods with the same signature, neither extension method is visible.
- Extend the most specific type you can. In a hierarchy of types, if you select a type from which many other types are derived, there are layers of possibilities for the introduction of instance methods or other extension methods that might interfere with yours.

<br />

Here is an example of an extension method that strips potentially harmful characters from a string:

<script src="https://gist.github.com/966808.js?file=Helpers.vb"></script>