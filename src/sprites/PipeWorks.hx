package sprites;

import luxe.Events;
import luxe.Vector;
import luxe.components.sprite.SpriteAnimation;
import luxe.Sprite;
import phoenix.Texture;

/**
 * ...
 * @author Domagoj Štrekelj
 */
class PipeWorks extends Sprite
{
    public function new() 
    {
        var texture = Luxe.resources.texture('assets/static/pipe_works_banner1.png');
        //texture.filter_mag = texture.filter_min = FilterType.nearest;
        
        var width = Luxe.screen.w;
        var height = (width / texture.width) * texture.height;
        
        super({
            name: 'pipe_works_banner',
            texture: texture,
            size: new Vector(width, height),
            centered: false,
            pos: new Vector(0, Std.int((Luxe.screen.h - height) / 2))
        });
    }
}