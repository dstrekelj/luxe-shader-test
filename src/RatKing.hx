package;

import luxe.Vector;
import luxe.components.sprite.SpriteAnimation;
import luxe.resource.Resource.JSONResource;
import luxe.Sprite;
import phoenix.Texture;

/**
 * ...
 * @author Domagoj Štrekelj
 */
class RatKing extends Sprite
{
    public function new() 
    {
        var texture : Texture = Luxe.resources.texture('assets/bodies/rat_king.png');
        texture.filter_mag = texture.filter_min = FilterType.nearest;
        
        var frameWidth = 48;
        var height = Luxe.screen.h / 4;
        var ratio = height / texture.height;
        var width = ratio * frameWidth;
        
        super({
            name: 'Rat King',
            texture: texture,
            pos: new Vector(Luxe.screen.mid.x - 6 * frameWidth, Luxe.screen.mid.y),
            size: new Vector(width, height)
        });
        
        var animationJSON : JSONResource = Luxe.resources.json('assets/bodies/rat_king.json');
        var animation : SpriteAnimation = add(new SpriteAnimation({ name: 'animation' }));
        animation.add_from_json_object(animationJSON.asset.json);
        animation.animation = 'walk';
        animation.play();
    }
}