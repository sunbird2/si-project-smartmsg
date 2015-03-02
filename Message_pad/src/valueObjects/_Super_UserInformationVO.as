/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - UserInformationVO.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_UserInformationVO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("com.m.member.UserInformationVO") == null)
            {
                flash.net.registerClassAlias("com.m.member.UserInformationVO", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("com.m.member.UserInformationVO", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _UserInformationVOEntityMetadata;
    model_internal var _changedObjects:mx.collections.ArrayCollection = new ArrayCollection();

    public function getChangedObjects() : Array
    {
        _changedObjects.addItemAt(this,0);
        return _changedObjects.source;
    }

    public function clearChangedObjects() : void
    {
        _changedObjects.removeAll();
    }

    /**
     * properties
     */
    private var _internal_point : String;
    private var _internal_hp : String;
    private var _internal_levaeYN : String;
    private var _internal_unit_cost : int;
    private var _internal_line : String;
    private var _internal_user_id : String;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_UserInformationVO()
    {
        _model = new _UserInformationVOEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get point() : String
    {
        return _internal_point;
    }

    [Bindable(event="propertyChange")]
    public function get hp() : String
    {
        return _internal_hp;
    }

    [Bindable(event="propertyChange")]
    public function get levaeYN() : String
    {
        return _internal_levaeYN;
    }

    [Bindable(event="propertyChange")]
    public function get unit_cost() : int
    {
        return _internal_unit_cost;
    }

    [Bindable(event="propertyChange")]
    public function get line() : String
    {
        return _internal_line;
    }

    [Bindable(event="propertyChange")]
    public function get user_id() : String
    {
        return _internal_user_id;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set point(value:String) : void
    {
        var oldValue:String = _internal_point;
        if (oldValue !== value)
        {
            _internal_point = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "point", oldValue, _internal_point));
        }
    }

    public function set hp(value:String) : void
    {
        var oldValue:String = _internal_hp;
        if (oldValue !== value)
        {
            _internal_hp = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "hp", oldValue, _internal_hp));
        }
    }

    public function set levaeYN(value:String) : void
    {
        var oldValue:String = _internal_levaeYN;
        if (oldValue !== value)
        {
            _internal_levaeYN = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "levaeYN", oldValue, _internal_levaeYN));
        }
    }

    public function set unit_cost(value:int) : void
    {
        var oldValue:int = _internal_unit_cost;
        if (oldValue !== value)
        {
            _internal_unit_cost = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "unit_cost", oldValue, _internal_unit_cost));
        }
    }

    public function set line(value:String) : void
    {
        var oldValue:String = _internal_line;
        if (oldValue !== value)
        {
            _internal_line = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "line", oldValue, _internal_line));
        }
    }

    public function set user_id(value:String) : void
    {
        var oldValue:String = _internal_user_id;
        if (oldValue !== value)
        {
            _internal_user_id = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "user_id", oldValue, _internal_user_id));
        }
    }

    /**
     * Data/source property setter listeners
     *
     * Each data property whose value affects other properties or the validity of the entity
     * needs to invalidate all previously calculated artifacts. These include:
     *  - any derived properties or constraints that reference the given data property.
     *  - any availability guards (variant expressions) that reference the given data property.
     *  - any style validations, message tokens or guards that reference the given data property.
     *  - the validity of the property (and the containing entity) if the given data property has a length restriction.
     *  - the validity of the property (and the containing entity) if the given data property is required.
     */


    /**
     * valid related derived properties
     */
    model_internal var _isValid : Boolean;
    model_internal var _invalidConstraints:Array = new Array();
    model_internal var _validationFailureMessages:Array = new Array();

    /**
     * derived property calculators
     */

    /**
     * isValid calculator
     */
    model_internal function calculateIsValid():Boolean
    {
        var violatedConsts:Array = new Array();
        var validationFailureMessages:Array = new Array();

        var propertyValidity:Boolean = true;

        model_internal::_cacheInitialized_isValid = true;
        model_internal::invalidConstraints_der = violatedConsts;
        model_internal::validationFailureMessages_der = validationFailureMessages;
        return violatedConsts.length == 0 && propertyValidity;
    }

    /**
     * derived property setters
     */

    model_internal function set isValid_der(value:Boolean) : void
    {
        var oldValue:Boolean = model_internal::_isValid;
        if (oldValue !== value)
        {
            model_internal::_isValid = value;
            _model.model_internal::fireChangeEvent("isValid", oldValue, model_internal::_isValid);
        }
    }

    /**
     * derived property getters
     */

    [Transient]
    [Bindable(event="propertyChange")]
    public function get _model() : _UserInformationVOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _UserInformationVOEntityMetadata) : void
    {
        var oldValue : _UserInformationVOEntityMetadata = model_internal::_dminternal_model;
        if (oldValue !== value)
        {
            model_internal::_dminternal_model = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_model", oldValue, model_internal::_dminternal_model));
        }
    }

    /**
     * methods
     */


    /**
     *  services
     */
    private var _managingService:com.adobe.fiber.services.IFiberManagingService;

    public function set managingService(managingService:com.adobe.fiber.services.IFiberManagingService):void
    {
        _managingService = managingService;
    }

    model_internal function set invalidConstraints_der(value:Array) : void
    {
        var oldValue:Array = model_internal::_invalidConstraints;
        // avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_invalidConstraints = value;
            _model.model_internal::fireChangeEvent("invalidConstraints", oldValue, model_internal::_invalidConstraints);
        }
    }

    model_internal function set validationFailureMessages_der(value:Array) : void
    {
        var oldValue:Array = model_internal::_validationFailureMessages;
        // avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_validationFailureMessages = value;
            _model.model_internal::fireChangeEvent("validationFailureMessages", oldValue, model_internal::_validationFailureMessages);
        }
    }


}

}
