package;

import luxe.Events;
import luxe.Vector;
import luxe.components.sprite.SpriteAnimation;
import luxe.Sprite;
import phoenix.Texture;

/**
 * ...
 * @author Domagoj Štrekelj
 */
class Jim extends Sprite
{
    public function new() 
    {
        var texture = Luxe.resources.texture('assets/bodies/jim.png');
        texture.filter_mag = texture.filter_min = FilterType.nearest;
        
        var frameWidth = 48;
        var height = Luxe.screen.h / 4;
        var ratio = height / texture.height;
        var width = ratio * frameWidth;
        
        super({
            name: 'Jim',
            texture: texture,
            pos: new Vector(Luxe.screen.mid.x + 3 * frameWidth, Luxe.screen.mid.y),
            size: new Vector(width, height)
        });
        
        var animationJSON = Luxe.resources.json('assets/bodies/jim.json');
        var animation = add(new SpriteAnimation({ name: 'animation' }));
        animation.add_from_json_object(animationJSON.asset.json);
        animation.animation = 'walk';
        animation.play();
        /*
        var shader = Luxe.resources.shader('invert');
        this.shader = shader;
        */
    }
}