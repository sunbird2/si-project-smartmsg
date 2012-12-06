/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - LogVO.as.
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
public class _Super_LogVO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("com.m.send.LogVO") == null)
            {
                flash.net.registerClassAlias("com.m.send.LogVO", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("com.m.send.LogVO", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _LogVOEntityMetadata;
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
    private var _internal_ynDel : String;
    private var _internal_idx : int;
    private var _internal_cnt : int;
    private var _internal_line : String;
    private var _internal_timeSend : String;
    private var _internal_user_ip : String;
    private var _internal_mode : String;
    private var _internal_message : String;
    private var _internal_search : String;
    private var _internal_timeWrite : String;
    private var _internal_method : String;
    private var _internal_user_id : String;
    private var _internal_timeDel : String;
    private var _internal_delType : String;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_LogVO()
    {
        _model = new _LogVOEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get ynDel() : String
    {
        return _internal_ynDel;
    }

    [Bindable(event="propertyChange")]
    public function get idx() : int
    {
        return _internal_idx;
    }

    [Bindable(event="propertyChange")]
    public function get cnt() : int
    {
        return _internal_cnt;
    }

    [Bindable(event="propertyChange")]
    public function get line() : String
    {
        return _internal_line;
    }

    [Bindable(event="propertyChange")]
    public function get timeSend() : String
    {
        return _internal_timeSend;
    }

    [Bindable(event="propertyChange")]
    public function get user_ip() : String
    {
        return _internal_user_ip;
    }

    [Bindable(event="propertyChange")]
    public function get mode() : String
    {
        return _internal_mode;
    }

    [Bindable(event="propertyChange")]
    public function get message() : String
    {
        return _internal_message;
    }

    [Bindable(event="propertyChange")]
    public function get search() : String
    {
        return _internal_search;
    }

    [Bindable(event="propertyChange")]
    public function get timeWrite() : String
    {
        return _internal_timeWrite;
    }

    [Bindable(event="propertyChange")]
    public function get method() : String
    {
        return _internal_method;
    }

    [Bindable(event="propertyChange")]
    public function get user_id() : String
    {
        return _internal_user_id;
    }

    [Bindable(event="propertyChange")]
    public function get timeDel() : String
    {
        return _internal_timeDel;
    }

    [Bindable(event="propertyChange")]
    public function get delType() : String
    {
        return _internal_delType;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set ynDel(value:String) : void
    {
        var oldValue:String = _internal_ynDel;
        if (oldValue !== value)
        {
            _internal_ynDel = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "ynDel", oldValue, _internal_ynDel));
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

    public function set cnt(value:int) : void
    {
        var oldValue:int = _internal_cnt;
        if (oldValue !== value)
        {
            _internal_cnt = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "cnt", oldValue, _internal_cnt));
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

    public function set timeSend(value:String) : void
    {
        var oldValue:String = _internal_timeSend;
        if (oldValue !== value)
        {
            _internal_timeSend = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "timeSend", oldValue, _internal_timeSend));
        }
    }

    public function set user_ip(value:String) : void
    {
        var oldValue:String = _internal_user_ip;
        if (oldValue !== value)
        {
            _internal_user_ip = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "user_ip", oldValue, _internal_user_ip));
        }
    }

    public function set mode(value:String) : void
    {
        var oldValue:String = _internal_mode;
        if (oldValue !== value)
        {
            _internal_mode = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "mode", oldValue, _internal_mode));
        }
    }

    public function set message(value:String) : void
    {
        var oldValue:String = _internal_message;
        if (oldValue !== value)
        {
            _internal_message = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "message", oldValue, _internal_message));
        }
    }

    public function set search(value:String) : void
    {
        var oldValue:String = _internal_search;
        if (oldValue !== value)
        {
            _internal_search = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "search", oldValue, _internal_search));
        }
    }

    public function set timeWrite(value:String) : void
    {
        var oldValue:String = _internal_timeWrite;
        if (oldValue !== value)
        {
            _internal_timeWrite = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "timeWrite", oldValue, _internal_timeWrite));
        }
    }

    public function set method(value:String) : void
    {
        var oldValue:String = _internal_method;
        if (oldValue !== value)
        {
            _internal_method = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "method", oldValue, _internal_method));
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

    public function set timeDel(value:String) : void
    {
        var oldValue:String = _internal_timeDel;
        if (oldValue !== value)
        {
            _internal_timeDel = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "timeDel", oldValue, _internal_timeDel));
        }
    }

    public function set delType(value:String) : void
    {
        var oldValue:String = _internal_delType;
        if (oldValue !== value)
        {
            _internal_delType = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "delType", oldValue, _internal_delType));
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
    public function get _model() : _LogVOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _LogVOEntityMetadata) : void
    {
        var oldValue : _LogVOEntityMetadata = model_internal::_dminternal_model;
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
