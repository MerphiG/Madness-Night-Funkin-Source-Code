package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import flixel.util.FlxTimer;

using StringTools;

class FreeplayChoice extends MusicBeatState
{
	var curSelected:Int = 0;
	var menuItems:FlxTypedGroup<FlxSprite>;
	var optionShit:Array<String> = ['story', 'additional'];
	var BG:FlxSprite;
	var logoBl:FlxSprite;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Freeplay Choice", null);
		#end
		
		FlxG.mouse.visible = false;

		persistentUpdate = persistentDraw = true;

		BG = new FlxSprite().loadGraphic(Paths.image('FreeplayChoiceBG'));
		BG.setGraphicSize(Std.int(BG.width * 1.1));
		BG.updateHitbox();
		BG.screenCenter();
		BG.antialiasing = ClientPrefs.globalAntialiasing;
		add(BG);

		logoBl = new FlxSprite(0, 0);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		logoBl.antialiasing = ClientPrefs.globalAntialiasing;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24);
		logoBl.animation.play('bump');
		logoBl.updateHitbox();
		logoBl.screenCenter();
		logoBl.scrollFactor.set();
		add(logoBl);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for(i in 0...optionShit.length) {
			var testButton:FlxSprite = new FlxSprite(0, 130);
			testButton.ID = i;
			testButton.frames = Paths.getSparrowAtlas('FreeplayChoiseButtons');
			testButton.animation.addByPrefix('idle', optionShit[i] + 'Idle', 24, true);
			testButton.animation.addByPrefix('hover', optionShit[i] + 'Hover', 24, true);
			testButton.animation.play('idle');
			testButton.setGraphicSize(Std.int(testButton.width * 0.6));
			testButton.antialiasing = true;
			testButton.updateHitbox();
			testButton.screenCenter(X);
			testButton.scrollFactor.set();
			switch(i) {
				case 0:
					testButton.setPosition(-300, 0);
				case 1:
					testButton.setPosition(800, 600);
			}
			menuItems.add(testButton);
		}	

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (!selectedSomethin)
		{
			if (controls.UI_LEFT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_RIGHT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}
			if (controls.ACCEPT)
			{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					menuItems.forEach(function(spr:FlxSprite)
					{
						{
							var daChoice:String = optionShit[curSelected];
							switch (daChoice)
							{
								case 'story':
									MusicBeatState.switchState(new FreeplayStory());
								case 'additional':
									MusicBeatState.switchState(new FreeplayAdditional());
							}
						}
					});
				}
			}
		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('hover');
			}
		});
	}
}