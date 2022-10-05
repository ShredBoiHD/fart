package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import lime.utils.Assets;
import flixel.system.FlxSound;
//import openfl.utils.Assets as OpenFlAssets;
import flixel.util.FlxTimer;
import flixel.graphics.FlxGraphic;
#if MODS_ALLOWED
import sys.FileSystem;
#end

import Paths;

using StringTools;

class FreeplayCategories extends MusicBeatState {

    public var freeplayList:Array<String>;

    public var buttonGroup:FlxSpriteGroup;

    public static var curSelected:Int = 0;

    public var theText:Alphabet;

    public var theText2:Alphabet;

    public var lerpVal:Float;

    public var categoryNames:Array<String> = [];

    public static var bg:FlxSprite;

    public function new() {
        super();

        buttonGroup = new FlxSpriteGroup();

        freeplayList = CoolUtil.coolTextFile(Paths.txt('categories'));

        bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
        bg.antialiasing = ClientPrefs.globalAntialiasing;

        add(bg);

        add(buttonGroup);

        theText = new Alphabet(0, 30, '', true);
        theText.screenCenter(X);
        //FlxTween.tween(theText, {y: 30}, 1, {ease: FlxEase.quadInOut});

        theText2 = new Alphabet(0, FlxG.height - 10, freeplayList[curSelected].split(':')[3], true, false, 0.05, 0.5);
        theText2.screenCenter(X);
        //theText2.scale.set(0.5, 0.5);
        theText2.y -= theText2.height;

        add(theText);
        add(theText2);

        var it:Int = -1;

        //var data:String = '';

        for (i in freeplayList) {
            //data = i.split(':')[0];
            it += 1;
            var sprite:FlxSprite = new FlxSprite(0, FlxG.width).loadGraphic(Paths.image('categories/'+i.split(':')[0]));
            //trace('categories/'+i.split(':')[0]);
            sprite.ID = it;
            sprite.antialiasing = ClientPrefs.globalAntialiasing;
            categoryNames.push(i.split(':')[0]);
            buttonGroup.add(sprite);
        }
        bg.color = FlxColor.fromString(freeplayList[curSelected].split(':')[2]);
        changeSelection(0);
    }
    public function changeSelection(ampl:Int) {
        curSelected += ampl;

        // Std.parseInt(bgColor);

        if (curSelected > buttonGroup.length - 1) {
            curSelected = 0;
        }
        if (curSelected < 0) {
            curSelected = buttonGroup.length - 1;
        }
        theText.changeText(categoryNames[curSelected]);
        theText.screenCenter(X);
        theText2.changeText(freeplayList[curSelected].split(':')[3]);
        theText2.screenCenter(X);
        if (ampl != 0)
            FlxTween.color(bg, 0.1, bg.color, FlxColor.fromString(freeplayList[curSelected].split(':')[2]));
        trace(freeplayList[curSelected].split(':')[2]);
        trace(bg.color);
    }
    override function update(elapsed:Float) {

        var rightP = controls.UI_RIGHT_P;
		var leftP = controls.UI_LEFT_P;
		var accepted = controls.ACCEPT;
		var space = FlxG.keys.justPressed.SPACE;
		var ctrl = FlxG.keys.justPressed.CONTROL;

        if (rightP)
			{
				changeSelection(1);
			}
		if (leftP)
			{
				changeSelection(-1);
			}
        if (controls.BACK)
                {
                    persistentUpdate = false;
                    FlxG.sound.play(Paths.sound('cancelMenu'));
                    MusicBeatState.switchState(new MainMenuState());
                }
        if (accepted) {
            FlxTween.tween(theText, {x: -theText.width}, 0.5, {ease: FlxEase.quadIn});
            FlxTween.tween(theText2, {x: FlxG.width + 300}, 0.5, {ease: FlxEase.quadIn});
            FlxTween.tween(buttonGroup.members[curSelected], {y: FlxG.height}, 0.5, {ease: FlxEase.quadIn, onComplete: function (twn:FlxTween) {
                FlxTransitionableState.skipNextTransIn = true;
                FlxTransitionableState.skipNextTransOut = true;
                trace(curSelected);
                MusicBeatState.switchState(new FreeplayState());
            }});
        }


        lerpVal = CoolUtil.boundTo(elapsed * 9.6, 0, 1);
        for (item in buttonGroup.members) {
            item.x = FlxMath.lerp(item.x, (FlxG.width / 2 - item.width / 2) + ((item.ID - curSelected) * FlxG.width), lerpVal);
            item.y = FlxMath.lerp(item.y, (FlxG.height / 2 - item.width / 2) + (Math.abs((item.ID - curSelected) * (item.ID - curSelected) / 2) * 700), lerpVal);
            if (item.ID != curSelected) {
                item.alpha = FlxMath.lerp(item.alpha, 0.1, lerpVal);
            } else {
                item.alpha = FlxMath.lerp(item.alpha, 1, lerpVal);
            }
        }
        super.update(elapsed);
    }
}