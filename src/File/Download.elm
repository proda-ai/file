module File.Download exposing
  ( url
  , urlAs
  , string
  , bytes
  )


{-| Commands for downloading files.

**SECURITY NOTE:** Browsers require that all downloads are initiated by a user
event. So rather than allowing malicious sites to put files on your computer
however they please, the user at least have to click a button first. As a
result, the following commands only work when they are triggered by some user
event.

# Download
@docs url, urlAs, string, bytes

-}


import Bytes exposing (Bytes)
import Elm.Kernel.File
import Task



-- DOWNLOAD


{-| Download a file from a URL. So you could download a GIF about math like
[this](https://en.wikipedia.org/wiki/Pythagorean_theorem#/media/File:Pythag_anim.gif)
or [this](https://en.m.wikipedia.org/wiki/Portal:Mathematics/Featured_picture/2009_08#/media/File%3AVillarceau_circles.gif)
with the following code:

    import File.Download as Download

    saveMathGif : Cmd msg
    saveMathGif =
      Download.url "https://example.com/math.gif"

The downloaded file will use whatever name the server suggests. Use
[`urlAs`](#urlAs) if you want to customize the file name.
-}
url : String -> Cmd msg
url href =
  Task.perform never (Elm.Kernel.File.downloadUrlAs "" href)


{-| Download a file from a URL, but say what you want the file to be named:

    import File.Download as Download

    saveTriangle : Cmd msg
    saveTriangle =
      Download.urlAs "triangle.gif" "https://example.com/math.gif"

-}
urlAs : String -> String -> Cmd msg
urlAs name href =
  Task.perform never (Elm.Kernel.File.downloadUrlAs name href)


{-| Download a `String` as a file. Maybe you markdown editor in the browser,
and you want to provide a button to download markdown files:

    import File.Download as Download

    save : String -> Cmd msg
    save markdown =
      Download.string "draft.md" "text/markdown" markdown

So the arguments are file name, MIME type, and then the file content. In this
case is is markdown, but it could be any string information.
-}
string : String -> String -> String -> Cmd msg
string name mime content =
  Task.perform never (Elm.Kernel.File.download name mime content)


{-| Download some `Bytes` as a file. Maybe you are creating custom images,
and you want a button to download them as PNG files. After using
[`elm/bytes`][bytes] to generate the file content, you can download it like
this:

    import Bytes exposing (Bytes)
    import File.Download as Download

    savePng : Bytes -> Cmd msg
    savePng bytes =
      Download.bytes "frog.png" "image/png" bytes

So the arguments are file name, MIME type, and then the file content. With the
ability to build any byte sequence you want with [`elm/bytes`][bytes], you can
create `.zip` files, `.jpg` files, or whatever else you might need!

[bytes]: /packages/elm/bytes/latest
-}
bytes : String -> String -> Bytes -> Cmd msg
bytes name mime content =
  Task.perform never (Elm.Kernel.File.download name mime content)
