import Blog
import Center
import Debug


port title : String
port title = "Elm 0.12"


main =
  Blog.blog
    "Elm 0.12"
    "Interactive UI"
    Blog.evan
    (Blog.Date 2014 3 24)
    [ Center.markdown "600px" content1
    , exampleBlock
    , Center.markdown "600px" content2
    ]


content1 = """

The past few months have focused on making Elm great for industrial use. You
can see this in recent releases like the [REPL](/blog/announce/repl), the
[package manager](/blog/announce/package-manager), and the [drastically
improved JS interop](/blog/announce/0.11). But working with input elements
has long been pretty tricky in Elm. After [conferences](/Learn.elm#conference-videos)
I always get questions along the lines of, &ldquo;that
[Mario](/examples/mario) example is really cool, but can
I use this approach for the forms, widgets, and dashboards I write every day at
work?&rdquo; As of today, the answer is a definite yes! Elm 0.12 makes it easy
to create interactive UI elements in a purely functional way, from buttons and
fields to clickable and hoverable elements.

"""


exampleBlock =
  Debug.crash "need to show examples"
    [ "TextReverse", "Calculator", "Form", "Plot" ]


content2 = """

Normally Elm release notes dive into the new features. In this case, the new
APIs are important enough that [the tutorial on interactive UI
elements](/learn/Interactive-UI-Elements.elm) made it as an entire post on the
[Learn](/Learn.elm) page.
That post has tons of [interactive examples](/learn/Interactive-UI-Elements.elm#tons-of-examples)
ranging from creation of text fields and drop downs to validated forms,
calculators, and todo lists. Definitely check it out to see how you can start
making "traditional web apps" with Elm.

The key insight behind these changes comes from [Spiros
Eliopoulos](https://github.com/seliopou) and his work on
[elm-d3](https://github.com/seliopou/elm-d3). From there [Jeff
Smits](https://github.com/Apanatshka) suggestions inspired and improved the
final API. Huge thank you to you both!

## Other Changes and Improvements

This release also comes with a bunch of changes and improvements. The most
important among them is the new [`Trampoline`][trampoline] library which
is really cool and deserves a post of its own, but to keep things brief I am
just going to list all of the new stuff:

 [gi]: http://package.elm-lang.org/packages/elm-lang/core/latest/Graphics-Input
 [gif]: http://package.elm-lang.org/packages/elm-lang/core/latest/Graphics-Input-Field
 [text]: http://package.elm-lang.org/packages/elm-lang/core/latest/Text
 [regex]: http://package.elm-lang.org/packages/elm-lang/core/latest/Regex
 [trampoline]: http://package.elm-lang.org/packages/elm-lang/core/latest/Trampoline

#### Breaking Changes:

  * Overhaul the [`Graphics.Input`][gi] library, making interactive UI elements
    easy as described [here](/learn/Interactive-UI-Elements.elm).
    <span style="opacity:0.3;">
    Inspired by [Spiros Eliopoulos](http://github.com/seliopou) and
    [Jeff Smits](https://github.com/Apanatshka).
    </span>

  * Overhaul the [`Text`][text] library to make the API more consistent overall
    and accomodate the new [`Graphics.Input.Field`][gif] library.

  * Simplify the [`Regex`][regex] library.
    <span style="opacity:0.3;">
    Inspired by [Attila Gazso](https://github.com/agazso).
    </span>

  * Change syntax for `import open List` to `import List (..)`

  * Improved JSON format for types generated by `elm-doc`

  * Revise the semantics of `keepWhen` and `dropWhen` to only update when
    the filtered signal change. Remove problematic `Mouse.isClicked` signal.
    <span style="opacity:0.3;">
    Thanks to [Janis Voigtländer](https://github.com/jvoigtlaender) and
    [Max New](https://github.com/maxsnew) for raising and correcting these
    issues.
    </span>

#### Improvements:

  * Add the [`Graphics.Input.Field`][gif] for customizable text fields.

  * Add the [`Trampoline`][trampoline] library which helps you get around
    JavaScript's lack of tail call elimination in a fully general way.
    <span style="opacity:0.3;">
    Thanks to [Tim Hobbs](https://github.com/timthelion) for making a strong
    case for this library and to [Max New](http://github.com/maxsnew) for
    the great design and implementation!
    </span>

  * Add [`Debug`](http://package.elm-lang.org/packages/elm-lang/core/latest/Debug)
    library which lets you log values to the developer console. This is intended
    specifically for debugging!
    <span style="opacity:0.3;">
    Inspired by [Tim Hobbs](https://github.com/timthelion).
    </span>

  * Drastically improved performance on markdown parsing.
    <span style="opacity:0.3;">
    Thanks to [Daniël Heres](https://github.com/Dandandan) for discovering that
    we were appending lists in the wrong direction!
    </span>

  * Add `Date.fromTime` function.

  * Use pointer-events to detect hovers on layered elements.
    <span style="opacity:0.3;">
    Thanks to [@Xashili](https://github.com/xashili).
    </span>

  * Fix bugs in `Bitwise` the library.
    <span style="opacity:0.3;">
    Thanks to [John P. Mayer Jr.](https://github.com/johnpmayer).
    </span>

  * Fix bug when exporting records of `Maybe` values through ports.
    <span style="opacity:0.3;">
    Thanks to [Max New](https://github.com/maxsnew).
    </span>

## Motivation behind the Breaking Changes

Changing the APIs of the [`Graphics.Input`][gi] and [`Text`][text] libraries
were absolutely essential for industrial users, but not all of the changes have
such an immediately clear motivation. Here is why `open` has been replaced and
the types produced by `elm-doc` are different:

#### Replacing `open`

The `open` keyword is gone now. If you want to import everything from the `List`
module into local scope you use this syntax:

```elm
import List (..)
```

The `open` syntax did not look great. It was indended to discourage importing
everything into local scope by imposing a &ldquo;syntactic tax&rdquo;. People
don't want ugly code! Ultimately the idea of a &ldquo;syntactic tax&rdquo; did
not feel like a successful experiment.

So there is nicer syntax, but this is still the least prefered way to import of
[the four possiblities](/docs/syntax#modules). It is convenient for quickly
prototyping or hacking something together, but it does not scale well. Imagine
you do [26 imports like this][imports], bringing tons of functions into local
scope. When I want to find the definition of [`isFunPtrTy`][function] I have no
easy way to know which of those 26 modules it came from!

 [imports]: https://github.com/ghc/ghc/blob/master/compiler/typecheck/TcForeign.lhs#L33-L60
 [function]: https://github.com/ghc/ghc/blob/master/compiler/typecheck/TcForeign.lhs#L326

So use this new syntax with care. I hope the ellipsis in `import List (..)` will
entice you to fill in the particular values you are using. As IDE support for
Elm improves, it will become possible to automate this dependency finding, so
perhaps `import List (..)` can be removed entirely someday.

#### Machine-readable types

All libraries uploaded to [package.elm-lang.org](http://package.elm-lang.org/)
generate a JSON file filled with types, documentation, and precedence/associativity
for all exported values ([like
this](http://package.elm-lang.org/packages/elm-lang/core/1.0.0/documentation.json)). The goals
is to make it really easy to work with library metadata to create tools like
Elmoogle and auto-complete in IDEs. This release improves the format for types,
making them much easier to work with.

Here is a sample of the documentation for `unzip` with some sections elided:

```json
{ "name": "unzip"
, "comment": "Decompose a list of tuples."
, "raw": "unzip : [(a,b)] -> ([a],[b])"
, "type":
    { "tag": "function"
    , "args": [ ... ]
    , "result":
        { "tag": "adt"
        , "name": "_Tuple2"
        , "args": [ ... ]
        }
    }
}
```

Notice that every type has a `tag` that describes its structure. A `function`
always has a list of `args` and a `result`. An `adt` always has a `name` and a
list of `args`. A `variable` always has a `name`. The reasons for this design
are discussed [in this thread](https://groups.google.com/forum/#!searchin/elm-discuss/types$20json/elm-discuss/pjNJRPaXKBo/dTOZJ2hVgr8J).

## Thank you!

Huge thank you to everyone on the list who reviewed, tested, and commented on
the new APIs and changes here! I cannot say enough how much I love talking
through ideas with you all! And again, thank you to everyone who worked on
this release in particular, whether it was sharing/refining ideas, opening
issues, submitting pull requests, or just pointing out that something seems
confusing. This is why I love the Elm community and why I am really excited
about what we can do!

"""
