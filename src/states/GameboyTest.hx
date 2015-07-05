package states;
import luxe.States.State;
import luxe.Vector;
import sprites.PipeWorks;

/**
 * ...
 * @author Domagoj Štrekelj
 */
class GameboyTest extends State
{
    public function new(Root : StateManager) 
    {
        super({ name: 'gameboytest' });
        
        _root = Root;
    }
    
    override function onenter<T>(Ignored : T)
    {
        new PipeWorks();
        
        Luxe.camera.center = new Vector();
    }
    
    private var _root : StateManager;
}