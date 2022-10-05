package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;
import flixel.math.FlxMath;

import openfl.utils.Assets;
import lime.utils.Assets as LimeAssets;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import flixel.FlxSubState;

class LoadingSubstate extends FlxSubstate {
    public var bg:FlxSprite;

    override function create() {
        instance = this;
        super.create();
    }
    override function new() {
        super();
        bg = new FlxSprite(0, 0).loadGraphic(Paths.image('funkay'));
        add(bg);
    }
}