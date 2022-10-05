package;

import openfl.system.System;
import flixel.math.FlxMath;
import Song.SwagSong;
import Math;

// inspired and somewhat copied from kade engine thank you kade


// TODO: Death Note recognition, health drain amplifier, scroll speed perfection fix to fit ranges from 1.0 to 2.5 as "perfect" and whatever else i can come up with

class NdeCalcRating {

    public static function calcRating(song:SwagSong):Float {

        var noteAmount:Int = 0;

        var amplifiers:Array<Float> = new Array<Float>();

        var length:Float = 0;

        // var optimalScroll:Float = 2.5; //scroll speed that is considered the most readable (TO BE DEBATED)

        var optimalScroll:Array<Float> = [1.0, 2.5]; //scroll speeds that are considered readable, anything differing from these values will increase the scroll speed difficulty factor

        for (i in song.notes) // sections
        {
            for (ii in i.sectionNotes) // notes
            {
                var gottaHitNote:Bool = i.mustHitSection; // if the camera is focused on bf or not 

                if ((ii[1] > 3 && !gottaHitNote || ii[1] < 4 && gottaHitNote) && ii[1] != null) { // i[1] is notedata, and since the left section in the chart menu is for the focused entity it checks to see if bf is focused and therefore changes the conditions

                    if (ii[0] > length) {
                        length = ii[0]; //iterates over notes and in the end the length variable will be the time in milliseconds from the start of the songs that the last note is placed on (dumb solution will fix later)
                    }
                    noteAmount += 1; // adds to total note amount that bf has to press
                }
            }
        }

        //trace('length: ' + length);

        amplifiers.push(noteAmount / (length / 1000)); // turns length into seconds instead of milliseconds and divides noteAmount by the seconds to get the overall nps

        //trace(amplifiers);

        var ampscroll = 0.0;

        if (song.speed < optimalScroll[0]) {
            ampscroll = song.speed - optimalScroll[0]; // checks if speed is less than the lowest ideal scroll speed and if so measures the difference 
        }
        if (song.speed > optimalScroll[1]) {
            ampscroll = song.speed - optimalScroll[1]; // checks if speed is more than the highest ideal scroll speed and if so measures the difference 
        }

        amplifiers.push(Math.abs(ampscroll) / 2); // scroll difference from the "ideal" scroll speed, divided by 2 to have less impact because its not as important as the chart

        amplifiers.push((length / 60000) * 0.4); // 0.4 multiplier for each minute to simulate tiredness (needs to be perfected later as it would fit better under the category of an exponential formula)

        var result:Float = 0;

        for (i in amplifiers) {
            result += i;
        }

        //trace(amplifiers, result);

        length = 0;
        noteAmount = 0;

        Paths.clearUnusedMemory(); // clean up the absolute mess we made


        return result;



    }

    public static function getFace(rating:Int = 0):String {
        if (rating < 0) 
            return 'easiest';
        
        if (rating <= 12 && rating >= 0)
            return 'easiest';

        if (rating <= 24 && rating >= 13)
            return 'veryeasy';

        if (rating <= 30 && rating >= 25)
            return 'normal';

        if (rating <= 45 && rating >= 31)
            return 'hard';

        if (rating <= 55 && rating >= 46)
            return 'harder';

        if (rating >= 56)
            return 'insane';

        return 'easiest';
    }

}