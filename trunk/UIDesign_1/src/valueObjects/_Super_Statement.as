/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - Statement.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;
import valueObjects.Connection;
import valueObjects.ResultSet;
import valueObjects.SQLWarning;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_Statement extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("java.sql.Statement") == null)
            {
                flash.net.registerClassAlias("java.sql.Statement", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("java.sql.Statement", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
        valueObjects.Connection.initRemoteClassAliasSingleChild();
        valueObjects.SQLWarning.initRemoteClassAliasSingleChild();
        valueObjects.Throwable.initRemoteClassAliasSingleChild();
        valueObjects.StackTraceElement.initRemoteClassAliasSingleChild();
        valueObjects.SQLException.initRemoteClassAliasSingleChild();
        valueObjects.DatabaseMetaData.initRemoteClassAliasSingleChild();
        valueObjects.ResultSet.initRemoteClassAliasSingleChild();
    }

    model_internal var _dminternal_model : _StatementEntityMetadata;
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
    private var _internal_fetchSize : int;
    private var _internal_connection : valueObjects.Connection;
    private var _internal_resultSetHoldability : int;
    private var _internal_queryTimeout : int;
    private var _internal_resultSetType : int;
    private var _internal_resultSetConcurrency : int;
    private var _internal_fetchDirection : int;
    private var _internal_maxFieldSize : int;
    private var _internal_poolable : Boolean;
    private var _internal_maxRows : int;
    private var _internal_resultSet : valueObjects.ResultSet;
    private var _internal_closed : Boolean;
    private var _internal_updateCount : int;
    private var _internal_warnings : valueObjects.SQLWarning;
    private var _internal_generatedKeys : valueObjects.ResultSet;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_Statement()
    {
        _model = new _StatementEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get fetchSize() : int
    {
        return _internal_fetchSize;
    }

    [Bindable(event="propertyChange")]
    public function get connection() : valueObjects.Connection
    {
        return _internal_connection;
    }

    [Bindable(event="propertyChange")]
    public function get resultSetHoldability() : int
    {
        return _internal_resultSetHoldability;
    }

    [Bindable(event="propertyChange")]
    public function get queryTimeout() : int
    {
        return _internal_queryTimeout;
    }

    [Bindable(event="propertyChange")]
    public function get resultSetType() : int
    {
        return _internal_resultSetType;
    }

    [Bindable(event="propertyChange")]
    public function get resultSetConcurrency() : int
    {
        return _internal_resultSetConcurrency;
    }

    [Bindable(event="propertyChange")]
    public function get fetchDirection() : int
    {
        return _internal_fetchDirection;
    }

    [Bindable(event="propertyChange")]
    public function get maxFieldSize() : int
    {
        return _internal_maxFieldSize;
    }

    [Bindable(event="propertyChange")]
    public function get poolable() : Boolean
    {
        return _internal_poolable;
    }

    [Bindable(event="propertyChange")]
    public function get maxRows() : int
    {
        return _internal_maxRows;
    }

    [Bindable(event="propertyChange")]
    public function get resultSet() : valueObjects.ResultSet
    {
        return _internal_resultSet;
    }

    [Bindable(event="propertyChange")]
    public function get closed() : Boolean
    {
        return _internal_closed;
    }

    [Bindable(event="propertyChange")]
    public function get updateCount() : int
    {
        return _internal_updateCount;
    }

    [Bindable(event="propertyChange")]
    public function get warnings() : valueObjects.SQLWarning
    {
        return _internal_warnings;
    }

    [Bindable(event="propertyChange")]
    public function get generatedKeys() : valueObjects.ResultSet
    {
        return _internal_generatedKeys;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set fetchSize(value:int) : void
    {
        var oldValue:int = _internal_fetchSize;
        if (oldValue !== value)
        {
            _internal_fetchSize = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "fetchSize", oldValue, _internal_fetchSize));
        }
    }

    public function set connection(value:valueObjects.Connection) : void
    {
        var oldValue:valueObjects.Connection = _internal_connection;
        if (oldValue !== value)
        {
            _internal_connection = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "connection", oldValue, _internal_connection));
        }
    }

    public function set resultSetHoldability(value:int) : void
    {
        var oldValue:int = _internal_resultSetHoldability;
        if (oldValue !== value)
        {
            _internal_resultSetHoldability = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "resultSetHoldability", oldValue, _internal_resultSetHoldability));
        }
    }

    public function set queryTimeout(value:int) : void
    {
        var oldValue:int = _internal_queryTimeout;
        if (oldValue !== value)
        {
            _internal_queryTimeout = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "queryTimeout", oldValue, _internal_queryTimeout));
        }
    }

    public function set resultSetType(value:int) : void
    {
        var oldValue:int = _internal_resultSetType;
        if (oldValue !== value)
        {
            _internal_resultSetType = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "resultSetType", oldValue, _internal_resultSetType));
        }
    }

    public function set resultSetConcurrency(value:int) : void
    {
        var oldValue:int = _internal_resultSetConcurrency;
        if (oldValue !== value)
        {
            _internal_resultSetConcurrency = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "resultSetConcurrency", oldValue, _internal_resultSetConcurrency));
        }
    }

    public function set fetchDirection(value:int) : void
    {
        var oldValue:int = _internal_fetchDirection;
        if (oldValue !== value)
        {
            _internal_fetchDirection = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "fetchDirection", oldValue, _internal_fetchDirection));
        }
    }

    public function set maxFieldSize(value:int) : void
    {
        var oldValue:int = _internal_maxFieldSize;
        if (oldValue !== value)
        {
            _internal_maxFieldSize = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxFieldSize", oldValue, _internal_maxFieldSize));
        }
    }

    public function set poolable(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_poolable;
        if (oldValue !== value)
        {
            _internal_poolable = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "poolable", oldValue, _internal_poolable));
        }
    }

    public function set maxRows(value:int) : void
    {
        var oldValue:int = _internal_maxRows;
        if (oldValue !== value)
        {
            _internal_maxRows = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxRows", oldValue, _internal_maxRows));
        }
    }

    public function set resultSet(value:valueObjects.ResultSet) : void
    {
        var oldValue:valueObjects.ResultSet = _internal_resultSet;
        if (oldValue !== value)
        {
            _internal_resultSet = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "resultSet", oldValue, _internal_resultSet));
        }
    }

    public function set closed(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_closed;
        if (oldValue !== value)
        {
            _internal_closed = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "closed", oldValue, _internal_closed));
        }
    }

    public function set updateCount(value:int) : void
    {
        var oldValue:int = _internal_updateCount;
        if (oldValue !== value)
        {
            _internal_updateCount = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "updateCount", oldValue, _internal_updateCount));
        }
    }

    public function set warnings(value:valueObjects.SQLWarning) : void
    {
        var oldValue:valueObjects.SQLWarning = _internal_warnings;
        if (oldValue !== value)
        {
            _internal_warnings = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "warnings", oldValue, _internal_warnings));
        }
    }

    public function set generatedKeys(value:valueObjects.ResultSet) : void
    {
        var oldValue:valueObjects.ResultSet = _internal_generatedKeys;
        if (oldValue !== value)
        {
            _internal_generatedKeys = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "generatedKeys", oldValue, _internal_generatedKeys));
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
    public function get _model() : _StatementEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _StatementEntityMetadata) : void
    {
        var oldValue : _StatementEntityMetadata = model_internal::_dminternal_model;
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
