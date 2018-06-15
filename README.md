# Java 10 Feature Demo

Demonstrates the features that will be available in Java 10.
The links below take you to the demo in this project, the JEP responsible for introducing the feature, and to other sources if available.

Putting everything here will take a while, so you have to be patient.
If you can't, check out the [JDK 10 page](http://openjdk.java.net/projects/jdk/10/) and look through the JEPs.
You can read more from me on [codefx.org](http://codefx.org) ([Java 10 tag](https://blog.codefx.org/tag/java-10/)) and follow me [on Twitter](https://twitter.com/nipafx) (and even on [G+](https://plus.google.com/+NicolaiParlog), I guess).

## Setup

* download [OpenJDK 10](http://jdk.java.net/10/) (not Oracle JDK!) and unpack it
* to use with Maven simply set `target` and `release` to `10` (see [`pom.xml`](pom.xml#L13-L14))
* to use with IntelliJ:
    * install [2017.3 EAP](https://www.jetbrains.com/idea/nextversion/) or later
    * go to an occurrence of `var`, hit _ALT + Enter_, and "Enable support for beta java version"
    * in project and module settings, make sure that language level _X_ is selected

## Language Changes

* [local-variable type inference with `var`](src/main/java/org/codefx/demo/java10/lang/var/VariableTypeInference.java) ([blog post](http://blog.codefx.org/java/java-10-var-type-inference/), [video](https://www.youtube.com/watch?v=Le1DbpRZdRQ), [JEP 286](http://openjdk.java.net/jeps/286))
	* experiments with [intersection types](src/main/java/org/codefx/demo/java10/lang/var/IntersectionTypes.java) ([blog post](http://blog.codefx.org/java/intersection-types-var))
	* experiments with ad-hoc [fields](src/main/java/org/codefx/demo/java10/lang/var/AdHocFields.java) and [methods](src/main/java/org/codefx/demo/java10/lang/var/AdHocMethods.java) ([blog post](http://blog.codefx.org/java/tricks-var-anonymous-classes/))
	* experiments with [traits](src/main/java/org/codefx/demo/java10/lang/var/Traits.java) ([blog post](http://blog.codefx.org/java/traits-var))

## JVM Capabilities

* [application class-dara sharing](app-cds.sh) ([blog post](http://blog.codefx.org/java/application-class-data-sharing/), [JEP 310](http://openjdk.java.net/jeps/310))
