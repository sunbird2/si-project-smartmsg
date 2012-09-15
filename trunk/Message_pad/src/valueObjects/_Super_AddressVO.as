/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - AddressVO.as.
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
public class _Super_AddressVO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("com.m.address.AddressVO") == null)
            {
                flash.net.registerClassAlias("com.m.address.AddressVO", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("com.m.address.AddressVO", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _AddressVOEntityMetadata;
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
    private var _internal_writedate : String;
    private var _internal_grpName : String;
    private var _internal_phone : String;
    private var _internal_grp : int;
    private var _internal_idx : int;
    private var _internal_memo : String;
    private var _internal_name : String;
    private var _internal_user_id : String;
    private var _internal_etcInfo : String;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_AddressVO()
    {
        _model = new _AddressVOEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get writedate() : String
    {
        return _internal_writedate;
    }

    [Bindable(event="propertyChange")]
    public function get grpName() : String
    {
        return _internal_grpName;
    }

    [Bindable(event="propertyChange")]
    public function get phone() : String
    {
        return _internal_phone;
    }

    [Bindable(event="propertyChange")]
    public function get grp() : int
    {
        return _internal_grp;
    }

    [Bindable(event="propertyChange")]
    public function get idx() : int
    {
        return _internal_idx;
    }

    [Bindable(event="propertyChange")]
    public function get memo() : String
    {
        return _internal_memo;
    }

    [Bindable(event="propertyChange")]
    public function get name() : String
    {
        return _internal_name;
    }

    [Bindable(event="propertyChange")]
    public function get user_id() : String
    {
        return _internal_user_id;
    }

    [Bindable(event="propertyChange")]
    public function get etcInfo() : String
    {
        return _internal_etcInfo;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set writedate(value:String) : void
    {
        var oldValue:String = _internal_writedate;
        if (oldValue !== value)
        {
            _internal_writedate = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "writedate", oldValue, _internal_writedate));
        }
    }

    public function set grpName(value:String) : void
    {
        var oldValue:String = _internal_grpName;
        if (oldValue !== value)
        {
            _internal_grpName = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "grpName", oldValue, _internal_grpName));
        }
    }

    public function set phone(value:String) : void
    {
        var oldValue:String = _internal_phone;
        if (oldValue !== value)
        {
            _internal_phone = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "phone", oldValue, _internal_phone));
        }
    }

    public function set grp(value:int) : void
    {
        var oldValue:int = _internal_grp;
        if (oldValue !== value)
        {
            _internal_grp = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "grp", oldValue, _internal_grp));
        }
    }

    public function set idx(value:int) : void
    {
        var oldValue:int = _internal_idx;
        if (oldValue !== value)
        {
            _internal_idx = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "idx", oldValue, _internal_idx));
        }
    }

    public function set memo(value:String) : void
    {
        var oldValue:String = _internal_memo;
        if (oldValue !== value)
        {
            _internal_memo = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "memo", oldValue, _internal_memo));
        }
    }

    public function set name(value:String) : void
    {
        var oldValue:String = _internal_name;
        if (oldValue !== value)
        {
            _internal_name = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "name", oldValue, _internal_name));
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

    public function set etcInfo(value:String) : void
    {
        var oldValue:String = _internal_etcInfo;
        if (oldValue !== value)
        {
            _internal_etcInfo = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "etcInfo", oldValue, _internal_etcInfo));
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
    public function get _model() : _AddressVOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _AddressVOEntityMetadata) : void
    {
        var oldValue : _AddressVOEntityMetadata = model_internal::_dminternal_model;
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
