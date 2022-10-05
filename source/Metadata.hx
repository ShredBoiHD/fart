package;

import CoolUtil;

using StringTools;

class Metadata {
    public static function loadFile(song:String):Array<String> {
        if (sys.FileSystem.exists('assets/metadata/' + song + '.txt')) {
            var file:String = sys.io.File.getContent('assets/metadata/' + song + '.txt');
            return file.split(':');
        }
        return [null, null, null];
    }
    public static function getAuthor(song:String):String {
        var file = loadFile(song);
        return file[0];
    }
    public static function getSounds(song:String):String {
        var file = loadFile(song);
        return file[1];
    }
    public static function getSprites(song:String):String {
        var file = loadFile(song);
        return file[2];
    }
}