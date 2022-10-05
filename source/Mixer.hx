import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import lime.utils.Assets;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import flixel.ui.FlxBar;

using StringTools;

class Mixer extends MusicBeatSubstate {
    public var icon:HealthIcon;
    public var mainField:FlxSprite;
    public var aroundField:FlxSprite;
    public var selectionJingle:FlxSprite;
    public var taskName:FlxText;
    public var progressBar:FlxBar;
    public var progress:Int = 100;

    public function new() {
        super();
        // Generate all assets

        aroundField = new FlxSprite(0, 0).makeGraphic(510, 140, FlxColor.WHITE);

        mainField = new FlxSprite(0, 0).makeGraphic(500, 130, FlxColor.BLACK);
        mainField.x = FlxG.width - mainField.width - 20;
        mainField.y = FlxG.height - mainField.height - 40;
        aroundField.x = mainField.x - 5;
        aroundField.y = mainField.y - 5;
        //add(aroundField);
        add(mainField);
        add(aroundField);

        icon = new HealthIcon('face');
        icon.x = mainField.x;
        icon.y = mainField.y;
        icon.antialiasing = true;
        add(icon);

        taskName = new FlxText(icon.x + icon.width / 1.5, icon.y + 10, 0, 'Currently Playing: None', 12);
        taskName.setFormat(Paths.font('quicksand_bold.otf'), 30);
        add(taskName);

        progressBar = new FlxBar(0, 0, LEFT_TO_RIGHT, 450, 5, this, 'progress', 0, 200);
        progressBar.createFilledBar(FlxColor.fromRGB(100, 100, 100, 255), FlxColor.RED);
        progressBar.x = mainField.x + mainField.width / 2 - 450 / 2;
        progressBar.y = taskName.y + taskName.height + 65;
        add(progressBar);
    }
    override function update(elapsed:Float) {
        if (aroundField != null && mainField != null) {
            aroundField.x = mainField.x - 5;
            aroundField.y = mainField.y - 5;
            //aroundField.scale.set(mainField.scale.x, mainField.scale.y);
            //aroundField.setGraphicSize(Std.int(mainField.width * 1.1) * , Std.int(mainField.height * 1.1));
        }
        super.update(elapsed);
    }
    public function shiftMode(full:Bool) {
        if (full) {FlxTween.tween(mainField, {x: 390, y: 295, 'scale.x': 2.5, 'scale.y': 5.0}, 0.4, {ease: FlxEase.quadInOut});
            
            FlxTween.tween(aroundField, {'scale.x': 2.0, 'scale.y': 4.0}, 0.4, {ease: FlxEase.quadInOut});
            FlxTween.tween(icon, {x: 20, y: 40}, 0.4, {ease: FlxEase.quadInOut});
            FlxTween.tween(taskName, {x: 20 + icon.width / 1.5, y: 40 + 10}, 0.4, {ease: FlxEase.quadInOut});
        }
    }
}