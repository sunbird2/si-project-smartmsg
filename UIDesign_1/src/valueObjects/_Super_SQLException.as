/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - SQLException.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;
import valueObjects.SQLException;
import valueObjects.StackTraceElement;
import valueObjects.Throwable;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_SQLException extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("java.sql.SQLException") == null)
            {
                flash.net.registerClassAlias("java.sql.SQLException", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("java.sql.SQLException", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
        valueObjects.Throwable.initRemoteClassAliasSingleChild();
        valueObjects.SQLException.initRemoteClassAliasSingleChild();
        valueObjects.StackTraceElement.initRemoteClassAliasSingleChild();
    }

    model_internal var _dminternal_model : _SQLExceptionEntityMetadata;
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
    private var _internal_SQLState : String;
    private var _internal_message : String;
    private var _internal_localizedMessage : String;
    private var _internal_cause : valueObjects.Throwable;
    private var _internal_errorCode : int;
    private var _internal_nextException : valueObjects.SQLException;
    private var _internal_stackTrace : ArrayCollection;
    model_internal var _internal_stackTrace_leaf:valueObjects.StackTraceElement;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_SQLException()
    {
        _model = new _SQLExceptionEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get SQLState() : String
    {
        return _internal_SQLState;
    }

    [Bindable(event="propertyChange")]
    public function get message() : String
    {
        return _internal_message;
    }

    [Bindable(event="propertyChange")]
    public function get localizedMessage() : String
    {
        return _internal_localizedMessage;
    }

    [Bindable(event="propertyChange")]
    public function get cause() : valueObjects.Throwable
    {
        return _internal_cause;
    }

    [Bindable(event="propertyChange")]
    public function get errorCode() : int
    {
        return _internal_errorCode;
    }

    [Bindable(event="propertyChange")]
    public function get nextException() : valueObjects.SQLException
    {
        return _internal_nextException;
    }

    [Bindable(event="propertyChange")]
    public function get stackTrace() : ArrayCollection
    {
        return _internal_stackTrace;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set SQLState(value:String) : void
    {
        var oldValue:String = _internal_SQLState;
        if (oldValue !== value)
        {
            _internal_SQLState = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "SQLState", oldValue, _internal_SQLState));
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

    public function set localizedMessage(value:String) : void
    {
        var oldValue:String = _internal_localizedMessage;
        if (oldValue !== value)
        {
            _internal_localizedMessage = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "localizedMessage", oldValue, _internal_localizedMessage));
        }
    }

    public function set cause(value:valueObjects.Throwable) : void
    {
        var oldValue:valueObjects.Throwable = _internal_cause;
        if (oldValue !== value)
        {
            _internal_cause = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "cause", oldValue, _internal_cause));
        }
    }

    public function set errorCode(value:int) : void
    {
        var oldValue:int = _internal_errorCode;
        if (oldValue !== value)
        {
            _internal_errorCode = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "errorCode", oldValue, _internal_errorCode));
        }
    }

    public function set nextException(value:valueObjects.SQLException) : void
    {
        var oldValue:valueObjects.SQLException = _internal_nextException;
        if (oldValue !== value)
        {
            _internal_nextException = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "nextException", oldValue, _internal_nextException));
        }
    }

    public function set stackTrace(value:*) : void
    {
        var oldValue:ArrayCollection = _internal_stackTrace;
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_stackTrace = value;
            }
            else if (value is Array)
            {
                _internal_stackTrace = new ArrayCollection(value);
            }
            else if (value == null)
            {
                _internal_stackTrace = null;
            }
            else
            {
                throw new Error("value of stackTrace must be a collection");
            }
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "stackTrace", oldValue, _internal_stackTrace));
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
    public function get _model() : _SQLExceptionEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _SQLExceptionEntityMetadata) : void
    {
        var oldValue : _SQLExceptionEntityMetadata = model_internal::_dminternal_model;
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
