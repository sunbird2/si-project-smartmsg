/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - MessageVO.as.
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

[Managed]
[ExcludeClass]
public class _Super_MessageVO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("com.m.send.MessageVO") == null)
            {
                flash.net.registerClassAlias("com.m.send.MessageVO", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("com.m.send.MessageVO", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _MessageVOEntityMetadata;
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
    private var _internal_sendMode : String;
    private var _internal_phone : String;
    private var _internal_rsltDate : String;
    private var _internal_idx : int;
    private var _internal_imagePath : String;
    private var _internal_rslt : String;
    private var _internal_msg : String;
    private var _internal_failAddDate : String;
    private var _internal_stat : String;
    private var _internal_urlIdx : String;
    private var _internal_sendDate : String;
    private var _internal_groupKey : int;
    private var _internal_name : String;
    private var _internal_callback : String;
    private var _internal_user_id : String;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_MessageVO()
    {
        _model = new _MessageVOEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get sendMode() : String
    {
        return _internal_sendMode;
    }

    [Bindable(event="propertyChange")]
    public function get phone() : String
    {
        return _internal_phone;
    }

    [Bindable(event="propertyChange")]
    public function get rsltDate() : String
    {
        return _internal_rsltDate;
    }

    [Bindable(event="propertyChange")]
    public function get idx() : int
    {
        return _internal_idx;
    }

    [Bindable(event="propertyChange")]
    public function get imagePath() : String
    {
        return _internal_imagePath;
    }

    [Bindable(event="propertyChange")]
    public function get rslt() : String
    {
        return _internal_rslt;
    }

    [Bindable(event="propertyChange")]
    public function get msg() : String
    {
        return _internal_msg;
    }

    [Bindable(event="propertyChange")]
    public function get failAddDate() : String
    {
        return _internal_failAddDate;
    }

    [Bindable(event="propertyChange")]
    public function get stat() : String
    {
        return _internal_stat;
    }

    [Bindable(event="propertyChange")]
    public function get urlIdx() : String
    {
        return _internal_urlIdx;
    }

    [Bindable(event="propertyChange")]
    public function get sendDate() : String
    {
        return _internal_sendDate;
    }

    [Bindable(event="propertyChange")]
    public function get groupKey() : int
    {
        return _internal_groupKey;
    }

    [Bindable(event="propertyChange")]
    public function get name() : String
    {
        return _internal_name;
    }

    [Bindable(event="propertyChange")]
    public function get callback() : String
    {
        return _internal_callback;
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

    public function set sendMode(value:String) : void
    {
        var oldValue:String = _internal_sendMode;
        if (oldValue !== value)
        {
            _internal_sendMode = value;
        }
    }

    public function set phone(value:String) : void
    {
        var oldValue:String = _internal_phone;
        if (oldValue !== value)
        {
            _internal_phone = value;
        }
    }

    public function set rsltDate(value:String) : void
    {
        var oldValue:String = _internal_rsltDate;
        if (oldValue !== value)
        {
            _internal_rsltDate = value;
        }
    }

    public function set idx(value:int) : void
    {
        var oldValue:int = _internal_idx;
        if (oldValue !== value)
        {
            _internal_idx = value;
        }
    }

    public function set imagePath(value:String) : void
    {
        var oldValue:String = _internal_imagePath;
        if (oldValue !== value)
        {
            _internal_imagePath = value;
        }
    }

    public function set rslt(value:String) : void
    {
        var oldValue:String = _internal_rslt;
        if (oldValue !== value)
        {
            _internal_rslt = value;
        }
    }

    public function set msg(value:String) : void
    {
        var oldValue:String = _internal_msg;
        if (oldValue !== value)
        {
            _internal_msg = value;
        }
    }

    public function set failAddDate(value:String) : void
    {
        var oldValue:String = _internal_failAddDate;
        if (oldValue !== value)
        {
            _internal_failAddDate = value;
        }
    }

    public function set stat(value:String) : void
    {
        var oldValue:String = _internal_stat;
        if (oldValue !== value)
        {
            _internal_stat = value;
        }
    }

    public function set urlIdx(value:String) : void
    {
        var oldValue:String = _internal_urlIdx;
        if (oldValue !== value)
        {
            _internal_urlIdx = value;
        }
    }

    public function set sendDate(value:String) : void
    {
        var oldValue:String = _internal_sendDate;
        if (oldValue !== value)
        {
            _internal_sendDate = value;
        }
    }

    public function set groupKey(value:int) : void
    {
        var oldValue:int = _internal_groupKey;
        if (oldValue !== value)
        {
            _internal_groupKey = value;
        }
    }

    public function set name(value:String) : void
    {
        var oldValue:String = _internal_name;
        if (oldValue !== value)
        {
            _internal_name = value;
        }
    }

    public function set callback(value:String) : void
    {
        var oldValue:String = _internal_callback;
        if (oldValue !== value)
        {
            _internal_callback = value;
        }
    }

    public function set user_id(value:String) : void
    {
        var oldValue:String = _internal_user_id;
        if (oldValue !== value)
        {
            _internal_user_id = value;
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
    public function get _model() : _MessageVOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _MessageVOEntityMetadata) : void
    {
        var oldValue : _MessageVOEntityMetadata = model_internal::_dminternal_model;
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
