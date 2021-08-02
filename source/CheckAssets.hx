package source;

import haxe;
import haxe.Crypto;
import haxe.Format;
import haxe.Io;

var imagehashes:Map = ["test.png" => "90d39dc13f1f7b7fd0e0ee3b15cacef7"] //map (dictionary) containing strings corresponding to images as keys and their corresponding hashes as values

for (var image:String in imagehashes.keys)
{
    //load image from storage
    try {
        var imagehandle:Image = //some IO thing? placeholder, idk how to program this
        //load image from storage
    }
    catch (e) {
        //image is missing, nightmare fuel mode activate
    }
    //convert image to string format
    var imagestring:String = //some function? placeholder, idk how to program this

    var imagehash:String = haxe.Crypto.Md5.encode(imagestring);     //generate MD5 checksum using haxe.crypto
    trace(haxe.Crypto.Md5.encode("Hello"));     //temporary trace to test MD5 function
    if (imagehash != imagehashes[image])
    {
        //image has been changed, activate protocol Selever
    }
}



// for image in files:
//  convert image to binary/hexadecimal
//  generate MD5 checksum using haxe.crypto
//  compare MD5 checksum w/ precalculated checksum
//      if no match, then activate protocol Selever
//      if missing, then (nightmare fuel??????)
// to do:
//  - figure out how to convert image to string
//  - figure out how to load this at game startup
//  - update imagehashes to use everything else.