package source;

import haxe.Crypto;
import haxe.Format;
import haxe.Io;
import lime.graphics;

var imageHashes:Map = ["test.png" => "90d39dc13f1f7b7fd0e0ee3b15cacef7"]; //keys are file names, values are predetermined hashes

for (var thisImage:String in imagehashes.keys)
{
    //load image from storage

    var future = Image.loadFromFile (thisImage); //load file
    future.onComplete (function (imageHandle) { //when file is done loading
        trace ("Image Loaded"); //temporary, check if image loading went alright
        var imageString:String = //someething imageHandle? placeholder, idk how to program this
        for (imageByte in imageHandle.data) //gets each byte in the image's raw data
        {
            imageString += toString(imageByte); //converts byte to character, concatenates character to string
        }
            var imageHash:String = haxe.Crypto.Md5.encode(imageString);     //generate MD5 checksum using haxe.crypto
            trace(haxe.Crypto.Md5.encode("Hello"));     //temporary trace to test MD5 function
            if (imageHash != imageHashes[thisImage])
            {
                //image has been changed, activate protocol Selever
            }
    });
    future.onError (function (error) { 
        trace (error); //image is missing, nightmare fuel mode activate  
    });
}
trace ("All files verified");

// for image in files:
//  convert image to binary/hexadecimal
//  generate MD5 checksum using haxe.crypto
//  compare MD5 checksum w/ precalculated checksum
//      if no match, then activate protocol Selever
//      if missing, then (nightmare fuel??????)
// to do:
//  - figure out how to load image
//  - figure out how to convert image to string
//  - figure out how to run this at game startup
//  - update imagehashes to include all necessary files