package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class FeaturesSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Mod Features';
		rpcTitle = 'Mod Features Menu'; //for Discord Rich Presence

		var option:Option = new Option('Disable GPU Effects',
			'if checked, disables gpu effects (shaders).',
			'disableGPUEff',
			'bool',
			false);
		addOption(option);
		
		var option:Option = new Option('Photosensitive Mode',
			'Disables hard flashing lights.',
			'photosensitive',
			'bool',
			false);
		addOption(option);
		
		var option:Option = new Option('Easy Mode',
			'Disable mechanic on scrapped song.',
			'easyMode',
			'bool',
			false);
		addOption(option);

		super();
	}
}