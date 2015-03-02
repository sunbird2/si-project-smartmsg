/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - Connection.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;
import valueObjects.DatabaseMetaData;
import valueObjects.SQLWarning;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_Connection extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("java.sql.Connection") == null)
            {
                flash.net.registerClassAlias("java.sql.Connection", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("java.sql.Connection", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
        valueObjects.SQLWarning.initRemoteClassAliasSingleChild();
        valueObjects.Throwable.initRemoteClassAliasSingleChild();
        valueObjects.StackTraceElement.initRemoteClassAliasSingleChild();
        valueObjects.SQLException.initRemoteClassAliasSingleChild();
        valueObjects.DatabaseMetaData.initRemoteClassAliasSingleChild();
        valueObjects.ResultSet.initRemoteClassAliasSingleChild();
        valueObjects.Connection.initRemoteClassAliasSingleChild();
    }

    model_internal var _dminternal_model : _ConnectionEntityMetadata;
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
    private var _internal_schema : String;
    private var _internal_networkTimeout : int;
    private var _internal_autoCommit : Boolean;
    private var _internal_holdability : int;
    private var _internal_readOnly : Boolean;
    private var _internal_typeMap : Object;
    private var _internal_catalog : String;
    private var _internal_closed : Boolean;
    private var _internal_clientInfo : Object;
    private var _internal_transactionIsolation : int;
    private var _internal_warnings : valueObjects.SQLWarning;
    private var _internal_metaData : valueObjects.DatabaseMetaData;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_Connection()
    {
        _model = new _ConnectionEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get schema() : String
    {
        return _internal_schema;
    }

    [Bindable(event="propertyChange")]
    public function get networkTimeout() : int
    {
        return _internal_networkTimeout;
    }

    [Bindable(event="propertyChange")]
    public function get autoCommit() : Boolean
    {
        return _internal_autoCommit;
    }

    [Bindable(event="propertyChange")]
    public function get holdability() : int
    {
        return _internal_holdability;
    }

    [Bindable(event="propertyChange")]
    public function get readOnly() : Boolean
    {
        return _internal_readOnly;
    }

    [Bindable(event="propertyChange")]
    public function get typeMap() : Object
    {
        return _internal_typeMap;
    }

    [Bindable(event="propertyChange")]
    public function get catalog() : String
    {
        return _internal_catalog;
    }

    [Bindable(event="propertyChange")]
    public function get closed() : Boolean
    {
        return _internal_closed;
    }

    [Bindable(event="propertyChange")]
    public function get clientInfo() : Object
    {
        return _internal_clientInfo;
    }

    [Bindable(event="propertyChange")]
    public function get transactionIsolation() : int
    {
        return _internal_transactionIsolation;
    }

    [Bindable(event="propertyChange")]
    public function get warnings() : valueObjects.SQLWarning
    {
        return _internal_warnings;
    }

    [Bindable(event="propertyChange")]
    public function get metaData() : valueObjects.DatabaseMetaData
    {
        return _internal_metaData;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set schema(value:String) : void
    {
        var oldValue:String = _internal_schema;
        if (oldValue !== value)
        {
            _internal_schema = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "schema", oldValue, _internal_schema));
        }
    }

    public function set networkTimeout(value:int) : void
    {
        var oldValue:int = _internal_networkTimeout;
        if (oldValue !== value)
        {
            _internal_networkTimeout = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "networkTimeout", oldValue, _internal_networkTimeout));
        }
    }

    public function set autoCommit(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_autoCommit;
        if (oldValue !== value)
        {
            _internal_autoCommit = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "autoCommit", oldValue, _internal_autoCommit));
        }
    }

    public function set holdability(value:int) : void
    {
        var oldValue:int = _internal_holdability;
        if (oldValue !== value)
        {
            _internal_holdability = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "holdability", oldValue, _internal_holdability));
        }
    }

    public function set readOnly(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_readOnly;
        if (oldValue !== value)
        {
            _internal_readOnly = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "readOnly", oldValue, _internal_readOnly));
        }
    }

    public function set typeMap(value:Object) : void
    {
        var oldValue:Object = _internal_typeMap;
        if (oldValue !== value)
        {
            _internal_typeMap = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "typeMap", oldValue, _internal_typeMap));
        }
    }

    public function set catalog(value:String) : void
    {
        var oldValue:String = _internal_catalog;
        if (oldValue !== value)
        {
            _internal_catalog = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "catalog", oldValue, _internal_catalog));
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

    public function set clientInfo(value:Object) : void
    {
        var oldValue:Object = _internal_clientInfo;
        if (oldValue !== value)
        {
            _internal_clientInfo = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "clientInfo", oldValue, _internal_clientInfo));
        }
    }

    public function set transactionIsolation(value:int) : void
    {
        var oldValue:int = _internal_transactionIsolation;
        if (oldValue !== value)
        {
            _internal_transactionIsolation = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "transactionIsolation", oldValue, _internal_transactionIsolation));
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

    public function set metaData(value:valueObjects.DatabaseMetaData) : void
    {
        var oldValue:valueObjects.DatabaseMetaData = _internal_metaData;
        if (oldValue !== value)
        {
            _internal_metaData = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "metaData", oldValue, _internal_metaData));
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
    public function get _model() : _ConnectionEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _ConnectionEntityMetadata) : void
    {
        var oldValue : _ConnectionEntityMetadata = model_internal::_dminternal_model;
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
