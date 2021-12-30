package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class MNFPause extends MusicBeatState
{
	var yes:FlxSprite;
	var no:FlxSprite;

	var yesSelect:Bool = false;

	public function new():Void
	{
		super();
	}

	override function create()
	{
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.sound('secretdeath'));

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('death/bg'));
		add(bg);

		var deimos:FlxSprite = new FlxSprite(0, 125);
		deimos.frames = Paths.getSparrowAtlas('death/deimos_chill');
		deimos.animation.addByPrefix('smoking', "deimos_chill", 24);
		deimos.animation.play('smoking');
		add(deimos);
		deimos.screenCenter(X);

		yes = new FlxSprite(FlxG.width * 0.28, FlxG.height * 0.7);
		yes.frames = Paths.getSparrowAtlas('death/choice');
		yes.animation.addByPrefix('selected', 'YesOff', 0, false);
		yes.animation.appendByPrefix('selected', 'YesOn');
		yes.animation.play('selected');
		add(yes);

		no = new FlxSprite(FlxG.width * 0.58, yes.y);
		no.frames = Paths.getSparrowAtlas('death/choice');
		no.animation.addByPrefix('selected', 'NoOff', 0, false);
		no.animation.appendByPrefix('selected', 'NoOn');
		no.animation.play('selected');
		add(no);

		changeThing();

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (controls.UI_LEFT_P || controls.UI_RIGHT_P)
			changeThing();

		if (controls.ACCEPT)
		{
			if (yesSelect)
			{
				MusicBeatState.switchState(new PlayState());
			}
			else
			{
				PlayState.usedPractice = false;
				PlayState.changedDifficulty = false;
				PlayState.seenCutscene = false;
				PlayState.deathCounter = 0;
				PlayState.cpuControlled = false;
				MusicBeatState.switchState(new MainMenuState());
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
			}
		}

		super.update(elapsed);
	}

	function changeThing():Void
	{
		yesSelect = !yesSelect;

		if (yesSelect)
		{
			no.animation.curAnim.curFrame = 0;
			yes.animation.curAnim.curFrame = 1;
		}
		else
		{
			no.animation.curAnim.curFrame = 1;
			yes.animation.curAnim.curFrame = 0;
		}
	}
}
