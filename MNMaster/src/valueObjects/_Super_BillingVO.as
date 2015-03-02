/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - BillingVO.as.
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
public class _Super_BillingVO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("com.m.billing.BillingVO") == null)
            {
                flash.net.registerClassAlias("com.m.billing.BillingVO", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("com.m.billing.BillingVO", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _BillingVOEntityMetadata;
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
    private var _internal_idx : int;
    private var _internal_memo : String;
    private var _internal_unit_cost : String;
    private var _internal_order_no : String;
    private var _internal_timestamp : String;
    private var _internal_amount : int;
    private var _internal_point : int;
    private var _internal_timeWrite : String;
    private var _internal_admin_id : String;
    private var _internal_method : String;
    private var _internal_user_id : String;
    private var _internal_tid : String;
    private var _internal_remain_point : int;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_BillingVO()
    {
        _model = new _BillingVOEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

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
    public function get unit_cost() : String
    {
        return _internal_unit_cost;
    }

    [Bindable(event="propertyChange")]
    public function get order_no() : String
    {
        return _internal_order_no;
    }

    [Bindable(event="propertyChange")]
    public function get timestamp() : String
    {
        return _internal_timestamp;
    }

    [Bindable(event="propertyChange")]
    public function get amount() : int
    {
        return _internal_amount;
    }

    [Bindable(event="propertyChange")]
    public function get point() : int
    {
        return _internal_point;
    }

    [Bindable(event="propertyChange")]
    public function get timeWrite() : String
    {
        return _internal_timeWrite;
    }

    [Bindable(event="propertyChange")]
    public function get admin_id() : String
    {
        return _internal_admin_id;
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
    public function get tid() : String
    {
        return _internal_tid;
    }

    [Bindable(event="propertyChange")]
    public function get remain_point() : int
    {
        return _internal_remain_point;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

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

    public function set unit_cost(value:String) : void
    {
        var oldValue:String = _internal_unit_cost;
        if (oldValue !== value)
        {
            _internal_unit_cost = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "unit_cost", oldValue, _internal_unit_cost));
        }
    }

    public function set order_no(value:String) : void
    {
        var oldValue:String = _internal_order_no;
        if (oldValue !== value)
        {
            _internal_order_no = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "order_no", oldValue, _internal_order_no));
        }
    }

    public function set timestamp(value:String) : void
    {
        var oldValue:String = _internal_timestamp;
        if (oldValue !== value)
        {
            _internal_timestamp = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "timestamp", oldValue, _internal_timestamp));
        }
    }

    public function set amount(value:int) : void
    {
        var oldValue:int = _internal_amount;
        if (oldValue !== value)
        {
            _internal_amount = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "amount", oldValue, _internal_amount));
        }
    }

    public function set point(value:int) : void
    {
        var oldValue:int = _internal_point;
        if (oldValue !== value)
        {
            _internal_point = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "point", oldValue, _internal_point));
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

    public function set admin_id(value:String) : void
    {
        var oldValue:String = _internal_admin_id;
        if (oldValue !== value)
        {
            _internal_admin_id = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "admin_id", oldValue, _internal_admin_id));
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

    public function set tid(value:String) : void
    {
        var oldValue:String = _internal_tid;
        if (oldValue !== value)
        {
            _internal_tid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "tid", oldValue, _internal_tid));
        }
    }

    public function set remain_point(value:int) : void
    {
        var oldValue:int = _internal_remain_point;
        if (oldValue !== value)
        {
            _internal_remain_point = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "remain_point", oldValue, _internal_remain_point));
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
    public function get _model() : _BillingVOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _BillingVOEntityMetadata) : void
    {
        var oldValue : _BillingVOEntityMetadata = model_internal::_dminternal_model;
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
