import luxe.Input;
import luxe.resource.Resource.JSONResource;
import luxe.Resources;
import luxe.Timer;
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
import sprites.PipeWorks;
import states.StateManager;

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
                { id: 'assets/bodies/rat_king.png' },
                { id: 'assets/static/pipe_works_banner1.png' },
                { id: 'assets/static/pipe_works_banner2.jpg' }
            ],
            shaders: [
                //{ id: 'invert', frag_id: 'assets/shaders/invert.glsl', vert_id: 'default' },
                //{ id: 'underwater', frag_id: 'assets/shaders/underwater.glsl', vert_id: 'default' },
                //{ id: 'pixelate', frag_id: 'assets/shaders/pixelate.glsl', vert_id: 'default' },
                { id: 'gameboy', frag_id: 'assets/shaders/gameboy.glsl', vert_id: 'default' },
                //{ id: 'scanlines', frag_id: 'assets/shaders/scanlines.glsl', vert_id: 'default' },
                { id: 'all', frag_id: 'assets/shaders/all.glsl', vert_id: 'default' }
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
        new PipeWorks();
        
        _shader = Luxe.resources.shader('all');
        
        _view = new Sprite({
            centered: false,
            pos: new Vector(0, 0),
            size: Luxe.screen.size,
            texture: _output,
            shader: _shader,
            batcher: _batch
        });
        
        _screen = Luxe.screen.size;
        
        _shader.set_vector2('_resolution', _resolution);
        _shader.set_vector2('_screen', _screen);
        _shader.set_float('_opacity', _opacity);
        _shader.set_float('_time', 1.0);
        _shader.set_int('_curve', _curve);
        _shader.set_int('_pixelate', _pixelate);
        _shader.set_int('_swap', _swap);
        _shader.set_int('_vignette', _vignette);
        _shader.set_int('_vscan', _vscan);
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
            _shader.set_float('_time', Luxe.time);
        }
    }
    
    override function onkeydown(E : KeyEvent)
    {
        if (E.keycode == Key.key_a)
        {
            _pixelate = (_pixelate == 1 ? 0 : 1);
            _shader.set_int('_pixelate', _pixelate);
        }
        
        if (E.keycode == Key.key_s)
        {
            _swap = (_swap == 1 ? 0 : 1);
            _shader.set_int('_swap', _swap);
        }
        
        if (E.keycode == Key.key_d)
        {
            _vscan = (_vscan == 1 ? 0 : 1);
            _shader.set_int('_vscan', _vscan);
        }
        
        if (E.keycode == Key.key_f)
        {
            _curve = (_curve == 1 ? 0 : 1);
            _shader.set_int('_curve', _curve);
        }
        
        if (E.keycode == Key.key_g)
        {
            _vignette = (_vignette == 1 ? 0 : 1);
            _shader.set_int('_vignette', _vignette);
        }
    }
    
    // Add pixelisation?
    private var _pixelate : Int = 0;
    // Do palette swap?
    private var _swap : Int = 0;
    // Add vertical scanlines?
    private var _vscan : Int = 0;
    private var _curve : Int = 0;
    private var _vignette : Int = 0;
    // Scanline opacity
    private var _opacity : Float = 0.05;
    // Resolution to scale up
    private var _resolution : Vector = new Vector(320.0, 240.0);
    // Game screen size
    private var _screen : Vector;
}