/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - UrlDataVO.as.
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
public class _Super_UrlDataVO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("com.m.url.UrlDataVO") == null)
            {
                flash.net.registerClassAlias("com.m.url.UrlDataVO", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("com.m.url.UrlDataVO", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _UrlDataVOEntityMetadata;
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
    private var _internal_dt_conn : String;
    private var _internal_input : String;
    private var _internal_html_idx : int;
    private var _internal_timeModify : String;
    private var _internal_sent_idx : int;
    private var _internal_idx : int;
    private var _internal_mileage : String;
    private var _internal_timeWrite : String;
    private var _internal_mearge : String;
    private var _internal_user_id : String;
    private var _internal_coupon : String;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_UrlDataVO()
    {
        _model = new _UrlDataVOEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get dt_conn() : String
    {
        return _internal_dt_conn;
    }

    [Bindable(event="propertyChange")]
    public function get input() : String
    {
        return _internal_input;
    }

    [Bindable(event="propertyChange")]
    public function get html_idx() : int
    {
        return _internal_html_idx;
    }

    [Bindable(event="propertyChange")]
    public function get timeModify() : String
    {
        return _internal_timeModify;
    }

    [Bindable(event="propertyChange")]
    public function get sent_idx() : int
    {
        return _internal_sent_idx;
    }

    [Bindable(event="propertyChange")]
    public function get idx() : int
    {
        return _internal_idx;
    }

    [Bindable(event="propertyChange")]
    public function get mileage() : String
    {
        return _internal_mileage;
    }

    [Bindable(event="propertyChange")]
    public function get timeWrite() : String
    {
        return _internal_timeWrite;
    }

    [Bindable(event="propertyChange")]
    public function get mearge() : String
    {
        return _internal_mearge;
    }

    [Bindable(event="propertyChange")]
    public function get user_id() : String
    {
        return _internal_user_id;
    }

    [Bindable(event="propertyChange")]
    public function get coupon() : String
    {
        return _internal_coupon;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set dt_conn(value:String) : void
    {
        var oldValue:String = _internal_dt_conn;
        if (oldValue !== value)
        {
            _internal_dt_conn = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "dt_conn", oldValue, _internal_dt_conn));
        }
    }

    public function set input(value:String) : void
    {
        var oldValue:String = _internal_input;
        if (oldValue !== value)
        {
            _internal_input = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "input", oldValue, _internal_input));
        }
    }

    public function set html_idx(value:int) : void
    {
        var oldValue:int = _internal_html_idx;
        if (oldValue !== value)
        {
            _internal_html_idx = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "html_idx", oldValue, _internal_html_idx));
        }
    }

    public function set timeModify(value:String) : void
    {
        var oldValue:String = _internal_timeModify;
        if (oldValue !== value)
        {
            _internal_timeModify = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "timeModify", oldValue, _internal_timeModify));
        }
    }

    public function set sent_idx(value:int) : void
    {
        var oldValue:int = _internal_sent_idx;
        if (oldValue !== value)
        {
            _internal_sent_idx = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sent_idx", oldValue, _internal_sent_idx));
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

    public function set mileage(value:String) : void
    {
        var oldValue:String = _internal_mileage;
        if (oldValue !== value)
        {
            _internal_mileage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "mileage", oldValue, _internal_mileage));
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

    public function set mearge(value:String) : void
    {
        var oldValue:String = _internal_mearge;
        if (oldValue !== value)
        {
            _internal_mearge = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "mearge", oldValue, _internal_mearge));
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

    public function set coupon(value:String) : void
    {
        var oldValue:String = _internal_coupon;
        if (oldValue !== value)
        {
            _internal_coupon = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "coupon", oldValue, _internal_coupon));
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
    public function get _model() : _UrlDataVOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _UrlDataVOEntityMetadata) : void
    {
        var oldValue : _UrlDataVOEntityMetadata = model_internal::_dminternal_model;
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
