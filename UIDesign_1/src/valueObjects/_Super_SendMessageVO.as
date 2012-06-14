/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - SendMessageVO.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;
import valueObjects.PhoneVO;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_SendMessageVO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("com.m.send.SendMessageVO") == null)
            {
                flash.net.registerClassAlias("com.m.send.SendMessageVO", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("com.m.send.SendMessageVO", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
        valueObjects.PhoneVO.initRemoteClassAliasSingleChild();
    }

    model_internal var _dminternal_model : _SendMessageVOEntityMetadata;
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
    private var _internal_message : String;
    private var _internal_al : ArrayCollection;
    model_internal var _internal_al_leaf:valueObjects.PhoneVO;
    private var _internal_itMinute : int;
    private var _internal_bMerge : Boolean;
    private var _internal_imagePath : String;
    private var _internal_itCount : int;
    private var _internal_returnPhone : String;
    private var _internal_bReservation : Boolean;
    private var _internal_bInterval : Boolean;
    private var _internal_reservationDate : String;
    private var _internal_reqIP : String;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_SendMessageVO()
    {
        _model = new _SendMessageVOEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get message() : String
    {
        return _internal_message;
    }

    [Bindable(event="propertyChange")]
    public function get al() : ArrayCollection
    {
        return _internal_al;
    }

    [Bindable(event="propertyChange")]
    public function get itMinute() : int
    {
        return _internal_itMinute;
    }

    [Bindable(event="propertyChange")]
    public function get bMerge() : Boolean
    {
        return _internal_bMerge;
    }

    [Bindable(event="propertyChange")]
    public function get imagePath() : String
    {
        return _internal_imagePath;
    }

    [Bindable(event="propertyChange")]
    public function get itCount() : int
    {
        return _internal_itCount;
    }

    [Bindable(event="propertyChange")]
    public function get returnPhone() : String
    {
        return _internal_returnPhone;
    }

    [Bindable(event="propertyChange")]
    public function get bReservation() : Boolean
    {
        return _internal_bReservation;
    }

    [Bindable(event="propertyChange")]
    public function get bInterval() : Boolean
    {
        return _internal_bInterval;
    }

    [Bindable(event="propertyChange")]
    public function get reservationDate() : String
    {
        return _internal_reservationDate;
    }

    [Bindable(event="propertyChange")]
    public function get reqIP() : String
    {
        return _internal_reqIP;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set message(value:String) : void
    {
        var oldValue:String = _internal_message;
        if (oldValue !== value)
        {
            _internal_message = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "message", oldValue, _internal_message));
        }
    }

    public function set al(value:*) : void
    {
        var oldValue:ArrayCollection = _internal_al;
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_al = value;
            }
            else if (value is Array)
            {
                _internal_al = new ArrayCollection(value);
            }
            else if (value == null)
            {
                _internal_al = null;
            }
            else
            {
                throw new Error("value of al must be a collection");
            }
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "al", oldValue, _internal_al));
        }
    }

    public function set itMinute(value:int) : void
    {
        var oldValue:int = _internal_itMinute;
        if (oldValue !== value)
        {
            _internal_itMinute = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "itMinute", oldValue, _internal_itMinute));
        }
    }

    public function set bMerge(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_bMerge;
        if (oldValue !== value)
        {
            _internal_bMerge = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "bMerge", oldValue, _internal_bMerge));
        }
    }

    public function set imagePath(value:String) : void
    {
        var oldValue:String = _internal_imagePath;
        if (oldValue !== value)
        {
            _internal_imagePath = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imagePath", oldValue, _internal_imagePath));
        }
    }

    public function set itCount(value:int) : void
    {
        var oldValue:int = _internal_itCount;
        if (oldValue !== value)
        {
            _internal_itCount = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "itCount", oldValue, _internal_itCount));
        }
    }

    public function set returnPhone(value:String) : void
    {
        var oldValue:String = _internal_returnPhone;
        if (oldValue !== value)
        {
            _internal_returnPhone = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "returnPhone", oldValue, _internal_returnPhone));
        }
    }

    public function set bReservation(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_bReservation;
        if (oldValue !== value)
        {
            _internal_bReservation = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "bReservation", oldValue, _internal_bReservation));
        }
    }

    public function set bInterval(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_bInterval;
        if (oldValue !== value)
        {
            _internal_bInterval = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "bInterval", oldValue, _internal_bInterval));
        }
    }

    public function set reservationDate(value:String) : void
    {
        var oldValue:String = _internal_reservationDate;
        if (oldValue !== value)
        {
            _internal_reservationDate = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "reservationDate", oldValue, _internal_reservationDate));
        }
    }

    public function set reqIP(value:String) : void
    {
        var oldValue:String = _internal_reqIP;
        if (oldValue !== value)
        {
            _internal_reqIP = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "reqIP", oldValue, _internal_reqIP));
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
    public function get _model() : _SendMessageVOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _SendMessageVOEntityMetadata) : void
    {
        var oldValue : _SendMessageVOEntityMetadata = model_internal::_dminternal_model;
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
