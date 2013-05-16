/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - StatusVO.as.
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
public class _Super_StatusVO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("com.m.admin.vo.StatusVO") == null)
            {
                flash.net.registerClassAlias("com.m.admin.vo.StatusVO", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("com.m.admin.vo.StatusVO", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _StatusVOEntityMetadata;
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
    private var _internal_dt : String;
    private var _internal_start : String;
    private var _internal_mms : int;
    private var _internal_sms : int;
    private var _internal_lms : int;
    private var _internal_end : String;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_StatusVO()
    {
        _model = new _StatusVOEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get dt() : String
    {
        return _internal_dt;
    }

    [Bindable(event="propertyChange")]
    public function get start() : String
    {
        return _internal_start;
    }

    [Bindable(event="propertyChange")]
    public function get mms() : int
    {
        return _internal_mms;
    }

    [Bindable(event="propertyChange")]
    public function get sms() : int
    {
        return _internal_sms;
    }

    [Bindable(event="propertyChange")]
    public function get lms() : int
    {
        return _internal_lms;
    }

    [Bindable(event="propertyChange")]
    public function get end() : String
    {
        return _internal_end;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set dt(value:String) : void
    {
        var oldValue:String = _internal_dt;
        if (oldValue !== value)
        {
            _internal_dt = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "dt", oldValue, _internal_dt));
        }
    }

    public function set start(value:String) : void
    {
        var oldValue:String = _internal_start;
        if (oldValue !== value)
        {
            _internal_start = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "start", oldValue, _internal_start));
        }
    }

    public function set mms(value:int) : void
    {
        var oldValue:int = _internal_mms;
        if (oldValue !== value)
        {
            _internal_mms = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "mms", oldValue, _internal_mms));
        }
    }

    public function set sms(value:int) : void
    {
        var oldValue:int = _internal_sms;
        if (oldValue !== value)
        {
            _internal_sms = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sms", oldValue, _internal_sms));
        }
    }

    public function set lms(value:int) : void
    {
        var oldValue:int = _internal_lms;
        if (oldValue !== value)
        {
            _internal_lms = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "lms", oldValue, _internal_lms));
        }
    }

    public function set end(value:String) : void
    {
        var oldValue:String = _internal_end;
        if (oldValue !== value)
        {
            _internal_end = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "end", oldValue, _internal_end));
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
    public function get _model() : _StatusVOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _StatusVOEntityMetadata) : void
    {
        var oldValue : _StatusVOEntityMetadata = model_internal::_dminternal_model;
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
