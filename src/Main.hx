import luxe.Input;
import luxe.resource.Resource.JSONResource;
import luxe.Resources;
import luxe.Vector;
import luxe.Color;
import luxe.components.sprite.SpriteAnimation;
import luxe.Input.KeyEvent;
import luxe.Parcel;
import luxe.ParcelProgress;
import luxe.Sprite;
import phoenix.Batcher;
import phoenix.RenderTexture;
import phoenix.Shader;
import phoenix.Texture;

class Main extends luxe.Game
{
    private var _batch : Batcher;
    private var _output : RenderTexture;
    private var _shader : Shader;
    private var _view : Sprite;
    
    override public function ready()
    {
        var parcel = new Parcel({
            jsons: [
                { id: 'assets/bodies/jim.json' },
                { id: 'assets/bodies/rat.json' },
                { id: 'assets/bodies/rat_king.json' }
            ],
            textures: [
                { id: 'assets/bodies/jim.png' },
                { id: 'assets/bodies/rat.png' },
                { id: 'assets/bodies/rat_king.png' }
            ],
            shaders: [
                { id: 'invert', frag_id: 'assets/shaders/invert.glsl', vert_id: 'default' },
                { id: 'underwater', frag_id: 'assets/shaders/underwater.glsl', vert_id: 'default' },
                { id: 'pixelate', frag_id: 'assets/shaders/pixelate.glsl', vert_id: 'default' },
                { id: 'gameboy', frag_id: 'assets/shaders/gameboy.glsl', vert_id: 'default' }
            ]
        });
        
        new ParcelProgress({
            parcel: parcel,
            background: new Color(1, 1, 1, 0.5),
            oncomplete: loadAssets
        });
        
        parcel.load();
        
        _output = new RenderTexture({
            id: 'sample-rtt',
            width: Luxe.screen.w,
            height: Luxe.screen.h
        });
        
        _batch = Luxe.renderer.create_batcher({ no_add: true });
        
        //Luxe.renderer.clear_color.rgb(0x121212);
    }
    
    private function loadAssets(P : Parcel)
    {
        new Jim();
        new Rat();
        new RatKing();
        
        //_shader = Luxe.resources.shader('pixelate');
        _shader = Luxe.resources.shader('gameboy');
        
        _view = new Sprite({
            centered: false,
            pos: new Vector(0, 0),
            size: Luxe.screen.size,
            texture: _output,
            shader: _shader,
            batcher: _batch
        });
        
        _resolution = new Vector(160.0, 144.0);
        _pixelate = false;
        _swap = false;
        
        _shader.set_int('pixelate', 0);
        _shader.set_int('swap', 0);
        _shader.set_vector2('resolution', _resolution);
        _shader.set_vector2('screen', Luxe.screen.size);
    }
    
    override function onprerender()
    {
        Luxe.renderer.target = _output;
        //Luxe.renderer.clear(new Color(0, 1, 0, 1));
    }
    
    override function onpostrender()
    {
        Luxe.renderer.target = null;
        //Luxe.renderer.clear(new Color(1, 0, 0, 1));
        Luxe.renderer.blend_mode(BlendMode.src_alpha, BlendMode.zero);
        _batch.draw();
        Luxe.renderer.blend_mode();
    }
    
    override public function update(Delta : Float)
    {
        if (_shader != null)
        {
            //_shader.set_float('resolution', 64.0);
        }
    }
    
    override function onkeydown(E : KeyEvent)
    {
        if (E.keycode == Key.key_1)
        {
            _resolution.x += 10.0;
            _resolution.y += 10.0;
            _shader.set_vector2('resolution', _resolution);
        }
        if (E.keycode == Key.key_q)
        {
            _resolution.x -= 10.0;
            _resolution.y -= 10.0;
            _shader.set_vector2('resolution', _resolution);
        }
        if (E.keycode == Key.key_a)
        {
            _pixelate = !_pixelate;
            _shader.set_int('pixelate', _pixelate ? 1 : 0);
        }
        if (E.keycode == Key.key_s)
        {
            _swap = !_swap;
            _shader.set_int('swap', _swap ? 1 : 0);
        }
    }
    
    private var _resolution : Vector;
    private var _pixelate : Bool;
    private var _swap : Bool;
}