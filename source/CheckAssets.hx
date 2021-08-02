package source;

import Haxe;
import haxe.Crypto;
import haxe.Format;
import haxe.Io;

var imagehashes = ["test.png" => "90d39dc13f1f7b7fd0e0ee3b15cacef7"] //map (dictionary) containing strings corresponding to images as keys and their corresponding hashes as values

for 
trace(haxe.crypto.md5.encode("Hello"));


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