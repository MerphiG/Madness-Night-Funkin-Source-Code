package;

#if desktop
import Discord.DiscordClient;
import sys.thread.Thread;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
//import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;

using StringTools;

class TitleState extends MusicBeatState
{
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];

	static var initialized:Bool = false;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var logoSpr:FlxSprite;
	var bgbg:FlxSprite;

	var curWacky:Array<String> = [];

	var wackyImage:FlxSprite;

	var easterEggEnabled:Bool = true; //Disable this to hide the easter egg
	var easterEggKeyCombination:Array<FlxKey> = [FlxKey.B, FlxKey.B]; //bb stands for bbpanzu cuz he wanted this lmao
	var lastKeysPressed:Array<FlxKey> = [];

	override public function create():Void
	{
		#if (polymod && !html5)
		if (sys.FileSystem.exists('mods/')) {
			var folders:Array<String> = [];
			for (file in sys.FileSystem.readDirectory('mods/')) {
				var path = haxe.io.Path.join(['mods/', file]);
				if (sys.FileSystem.isDirectory(path)) {
					folders.push(file);
				}
			}
			if(folders.length > 0) {
				polymod.Polymod.init({modRoot: "mods", dirs: folders});
			}
		}

		//Gonna finish this later, probably
		#end
		FlxG.game.focusLostFramerate = 60;
		FlxG.sound.muteKeys = muteKeys;
		FlxG.sound.volumeDownKeys = volumeDownKeys;
		FlxG.sound.volumeUpKeys = volumeUpKeys;

		PlayerSettings.init();

		curWacky = FlxG.random.getObject(getIntroTextShit());

		// DEBUG BULLSHIT

		swagShader = new ColorSwap();
		super.create();

		FlxG.save.bind('funkin', 'ninjamuffin99');
		ClientPrefs.loadPrefs();

		Highscore.load();

		if (FlxG.save.data.weekCompleted != null)
		{
			StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		}

		FlxG.mouse.visible = false;
		#if FREEPLAY
		MusicBeatState.switchState(new FreeplayChoice());
		#elseif CHARTING
		MusicBeatState.switchState(new ChartingState());
		#else
		if(FlxG.save.data.flashing == null && !FlashingState.leftState) {
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new FlashingState());
		} else {
			#if desktop
			DiscordClient.initialize();
			Application.current.onExit.add (function (exitCode) {
				DiscordClient.shutdown();
			});
			#end
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				startIntro();
			});
		}
		#end
	}

	var thing1:FlxSprite;
	var thing2:FlxSprite;
	var logoBl:FlxSprite;
	var titleText:FlxSprite;
	var swagShader:ColorSwap = null;

	function startIntro()
	{
		if (!initialized)
		{
			/*var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-300, -300, FlxG.width * 1.8, FlxG.height * 1.8));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-300, -300, FlxG.width * 1.8, FlxG.height * 1.8));
				
			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;*/

			// HAD TO MODIFY SOME BACKEND SHIT
			// IF THIS PR IS HERE IF ITS ACCEPTED UR GOOD TO GO
			// https://github.com/HaxeFlixel/flixel-addons/pull/348

			// var music:FlxSound = new FlxSound();
			// music.loadStream(Paths.music('freakyMenu'));
			// FlxG.sound.list.add(music);
			// music.play();

			if(FlxG.sound.music == null) {
				FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);

				FlxG.sound.music.fadeIn(4, 0, 0.7);
			}
		}

		Conductor.changeBPM(96);
		persistentUpdate = true;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		// bg.antialiasing = ClientPrefs.globalAntialiasing;
		// bg.setGraphicSize(Std.int(bg.width * 0.6));
		// bg.updateHitbox();
		add(bg);

		bgbg = new FlxSprite(0, 0).loadGraphic(Paths.image('bgbg'));
		bgbg.setGraphicSize(Std.int(bg.width * 1));
		bgbg.updateHitbox();
		bgbg.screenCenter();
		bgbg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bgbg);
		
		thing1 = new FlxSprite(-1400, -150);
		thing1.frames = Paths.getSparrowAtlas('thing');
		thing1.animation.addByPrefix('idle', "Thing", 24);
		thing1.antialiasing = ClientPrefs.globalAntialiasing;
		thing1.animation.play('idle');
		thing1.updateHitbox();
		add(thing1);
		
		thing2 = new FlxSprite(-1400, 625);
		thing2.frames = Paths.getSparrowAtlas('thing2');
		thing2.animation.addByPrefix('idle', "Thing2", 24);
		thing2.antialiasing = ClientPrefs.globalAntialiasing;
		thing2.animation.play('idle');
		thing2.updateHitbox();
		add(thing2);
		
		logoBl = new FlxSprite(300, 10);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		logoBl.antialiasing = ClientPrefs.globalAntialiasing;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24);
		logoBl.animation.play('bump');
		logoBl.updateHitbox();
		// logoBl.screenCenter();
		// logoBl.color = FlxColor.BLACK;

		swagShader = new ColorSwap();
		
		add(logoBl);
		//logoBl.shader = swagShader.shader;

		titleText = new FlxSprite(235, 230);
		titleText.frames = Paths.getSparrowAtlas('titleEnter');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.antialiasing = ClientPrefs.globalAntialiasing;
		titleText.animation.play('idle');
		titleText.updateHitbox();
		// titleText.screenCenter(X);
		add(titleText);

		FlxTween.tween(logoBl, {y: 30},2, {
			ease: FlxEase.quadOut,
			startDelay: 0.2,
		});
		
		FlxTween.tween(titleText, {y: 210},2, {
			ease: FlxEase.quadOut,
			startDelay: 0.2,
		});
		
		FlxTween.tween(thing1, {y: -130},2, {
			ease: FlxEase.quadOut,
			startDelay: 0.5,
		});
		
		FlxTween.tween(thing2, {y: 645},2, {
			ease: FlxEase.quadOut,
			startDelay: 0.5,
		});

		var logo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('logo'));
		logo.screenCenter();
		logo.antialiasing = ClientPrefs.globalAntialiasing;
		// add(logo);

		// FlxTween.tween(logoBl, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
		// FlxTween.tween(logo, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		credTextShit = new Alphabet(0, 0, "", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		logoSpr = new FlxSprite(0, FlxG.height * 0.4).loadGraphic(Paths.image('titlelogo'));
		add(logoSpr);
		logoSpr.visible = false;
		logoSpr.setGraphicSize(Std.int(logoSpr.width * 0.55));
		logoSpr.updateHitbox();
		logoSpr.screenCenter(X);
		logoSpr.antialiasing = ClientPrefs.globalAntialiasing;

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		if (initialized)
			skipIntro();
		else
			initialized = true;

		// credGroup.add(credTextShit);
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}

		// EASTER EGG

		if (!transitioning && skippedIntro)
		{
			if(pressedEnter)
			{
				leave();
				if(titleText != null) titleText.animation.play('press');

				FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

				transitioning = true;
				// FlxG.sound.music.stop();

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					MusicBeatState.switchState(new MainMenuState());
					closedState = true;
				});
				// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
			}
			else if(easterEggEnabled)
			{
				var finalKey:FlxKey = FlxG.keys.firstJustPressed();
				if(finalKey != FlxKey.NONE) {
					lastKeysPressed.push(finalKey); //Convert int to FlxKey
					if(lastKeysPressed.length > easterEggKeyCombination.length)
					{
						lastKeysPressed.shift();
					}
					
					if(lastKeysPressed.length == easterEggKeyCombination.length)
					{
						var isDifferent:Bool = false;
						for (i in 0...lastKeysPressed.length) {
							if(lastKeysPressed[i] != easterEggKeyCombination[i]) {
								isDifferent = true;
								break;
							}
						}
					}
				}
			}
		}

		if (pressedEnter && !skippedIntro)
		{
			skipIntro();
		}

		if(swagShader != null)
		{
			if(controls.UI_LEFT) swagShader.hue -= elapsed * 0.1;
			if(controls.UI_RIGHT) swagShader.hue += elapsed * 0.1;
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>, ?offset:Float = 0)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true, false);
			money.screenCenter(X);
			money.y += (i * 60) + 200 + offset;
			credGroup.add(money);
			textGroup.add(money);
		}
	}

	function addMoreText(text:String, ?offset:Float = 0)
	{
		if(textGroup != null) {
			var coolText:Alphabet = new Alphabet(0, 0, text, true, false);
			coolText.screenCenter(X);
			coolText.y += (textGroup.length * 60) + 200 + offset;
			credGroup.add(coolText);
			textGroup.add(coolText);
		}
	}

	function leave() {
		FlxTween.tween(logoBl, {y: 10, alpha: 0.70},1.5, {
			ease: FlxEase.quadOut,
			startDelay: 0.2,
		});
		
		FlxTween.tween(titleText, {y: 230, alpha: 0.70},1.5, {
			ease: FlxEase.quadOut,
			startDelay: 0.2,
		});
		
		FlxTween.tween(thing1, {y: -150, alpha: 0.70},1.5, {
			ease: FlxEase.quadOut,
			startDelay: 0.5,
		});
		
		FlxTween.tween(thing2, {y: 625, alpha: 0.70},1.5, {
			ease: FlxEase.quadOut,
			startDelay: 0.5,
		});
		FlxTween.tween(FlxG.camera, {zoom: 1.1}, 1.5);
		FlxTween.tween(bgbg, {alpha: 0.70}, 1.5, {
			ease: FlxEase.quadOut,
		});

}
	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	private static var closedState:Bool = false;
	override function beatHit()
	{
		super.beatHit();

		if(logoBl != null) 
			logoBl.animation.play('bump');

		if(!closedState) {
			switch (curBeat)
			{
				case 1:
					createCoolText(['Best Mod Ever By:'], 45);
				case 3:
					addMoreText('Madness', 45);
					addMoreText('Team', 45);
				case 4:
					deleteCoolText();
				case 5:
					createCoolText(['OMG'], -60);
				case 7:
					addMoreText('Mod Update', -60);
					logoSpr.visible = true;
				case 8:
					deleteCoolText();
					logoSpr.visible = false;
				case 9:
					createCoolText([curWacky[0]]);
				case 11:
					addMoreText(curWacky[1]);
				case 12:
					deleteCoolText();
				case 13:
					addMoreText('Madness');
				case 14:
					addMoreText('Night');
				case 15:
					addMoreText('Funkin'); // credTextShit.text += '\nFunkin';
				case 16:
					skipIntro();
			}
		}
	}

	var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			remove(logoSpr);

			FlxG.camera.flash(FlxColor.BLACK, 3);
			remove(credGroup);
			skippedIntro = true;
		}
	}
}
