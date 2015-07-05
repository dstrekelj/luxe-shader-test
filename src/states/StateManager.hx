package states;

import luxe.States;
import Luxe.Ev;

/**
 * Manages all the project states.
 */
class StateManager
{
    // Contains all state manager states
    public var states : States;

    public function new() 
    {
        states = new States({ name: 'statemanager' });
        states.add(new GameboyTest(this));
        
        // Wait until `init` event to call this
        Luxe.on(Ev.init, function(_) {
            // Set active base state
            states.set('gameboytest');
        });
    }
}