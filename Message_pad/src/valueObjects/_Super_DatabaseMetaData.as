/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - DatabaseMetaData.as.
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

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_DatabaseMetaData extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
        try
        {
            if (flash.net.getClassByAlias("java.sql.DatabaseMetaData") == null)
            {
                flash.net.registerClassAlias("java.sql.DatabaseMetaData", cz);
            }
        }
        catch (e:Error)
        {
            flash.net.registerClassAlias("java.sql.DatabaseMetaData", cz);
        }
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
        valueObjects.ResultSet.initRemoteClassAliasSingleChild();
        valueObjects.Connection.initRemoteClassAliasSingleChild();
    }

    model_internal var _dminternal_model : _DatabaseMetaDataEntityMetadata;
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
    private var _internal_databaseProductName : String;
    private var _internal_defaultTransactionIsolation : int;
    private var _internal_maxCursorNameLength : int;
    private var _internal_SQLStateType : int;
    private var _internal_typeInfo : valueObjects.ResultSet;
    private var _internal_maxStatements : int;
    private var _internal_userName : String;
    private var _internal_driverName : String;
    private var _internal_maxCatalogNameLength : int;
    private var _internal_catalogSeparator : String;
    private var _internal_catalogAtStart : Boolean;
    private var _internal_databaseProductVersion : String;
    private var _internal_driverMajorVersion : int;
    private var _internal_connection : valueObjects.Connection;
    private var _internal_SQLKeywords : String;
    private var _internal_timeDateFunctions : String;
    private var _internal_maxBinaryLiteralLength : int;
    private var _internal_extraNameCharacters : String;
    private var _internal_maxColumnsInIndex : int;
    private var _internal_databaseMajorVersion : int;
    private var _internal_maxColumnNameLength : int;
    private var _internal_procedureTerm : String;
    private var _internal_catalogTerm : String;
    private var _internal_JDBCMinorVersion : int;
    private var _internal_JDBCMajorVersion : int;
    private var _internal_searchStringEscape : String;
    private var _internal_databaseMinorVersion : int;
    private var _internal_maxProcedureNameLength : int;
    private var _internal_maxTablesInSelect : int;
    private var _internal_maxTableNameLength : int;
    private var _internal_driverMinorVersion : int;
    private var _internal_maxCharLiteralLength : int;
    private var _internal_maxIndexLength : int;
    private var _internal_stringFunctions : String;
    private var _internal_maxColumnsInOrderBy : int;
    private var _internal_maxRowSize : int;
    private var _internal_URL : String;
    private var _internal_clientInfoProperties : valueObjects.ResultSet;
    private var _internal_maxStatementLength : int;
    private var _internal_schemas : valueObjects.ResultSet;
    private var _internal_maxConnections : int;
    private var _internal_maxUserNameLength : int;
    private var _internal_rowIdLifetime : String;
    private var _internal_resultSetHoldability : int;
    private var _internal_schemaTerm : String;
    private var _internal_driverVersion : String;
    private var _internal_maxSchemaNameLength : int;
    private var _internal_identifierQuoteString : String;
    private var _internal_maxColumnsInSelect : int;
    private var _internal_systemFunctions : String;
    private var _internal_maxColumnsInGroupBy : int;
    private var _internal_readOnly : Boolean;
    private var _internal_tableTypes : valueObjects.ResultSet;
    private var _internal_numericFunctions : String;
    private var _internal_catalogs : valueObjects.ResultSet;
    private var _internal_maxColumnsInTable : int;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_DatabaseMetaData()
    {
        _model = new _DatabaseMetaDataEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get databaseProductName() : String
    {
        return _internal_databaseProductName;
    }

    [Bindable(event="propertyChange")]
    public function get defaultTransactionIsolation() : int
    {
        return _internal_defaultTransactionIsolation;
    }

    [Bindable(event="propertyChange")]
    public function get maxCursorNameLength() : int
    {
        return _internal_maxCursorNameLength;
    }

    [Bindable(event="propertyChange")]
    public function get SQLStateType() : int
    {
        return _internal_SQLStateType;
    }

    [Bindable(event="propertyChange")]
    public function get typeInfo() : valueObjects.ResultSet
    {
        return _internal_typeInfo;
    }

    [Bindable(event="propertyChange")]
    public function get maxStatements() : int
    {
        return _internal_maxStatements;
    }

    [Bindable(event="propertyChange")]
    public function get userName() : String
    {
        return _internal_userName;
    }

    [Bindable(event="propertyChange")]
    public function get driverName() : String
    {
        return _internal_driverName;
    }

    [Bindable(event="propertyChange")]
    public function get maxCatalogNameLength() : int
    {
        return _internal_maxCatalogNameLength;
    }

    [Bindable(event="propertyChange")]
    public function get catalogSeparator() : String
    {
        return _internal_catalogSeparator;
    }

    [Bindable(event="propertyChange")]
    public function get catalogAtStart() : Boolean
    {
        return _internal_catalogAtStart;
    }

    [Bindable(event="propertyChange")]
    public function get databaseProductVersion() : String
    {
        return _internal_databaseProductVersion;
    }

    [Bindable(event="propertyChange")]
    public function get driverMajorVersion() : int
    {
        return _internal_driverMajorVersion;
    }

    [Bindable(event="propertyChange")]
    public function get connection() : valueObjects.Connection
    {
        return _internal_connection;
    }

    [Bindable(event="propertyChange")]
    public function get SQLKeywords() : String
    {
        return _internal_SQLKeywords;
    }

    [Bindable(event="propertyChange")]
    public function get timeDateFunctions() : String
    {
        return _internal_timeDateFunctions;
    }

    [Bindable(event="propertyChange")]
    public function get maxBinaryLiteralLength() : int
    {
        return _internal_maxBinaryLiteralLength;
    }

    [Bindable(event="propertyChange")]
    public function get extraNameCharacters() : String
    {
        return _internal_extraNameCharacters;
    }

    [Bindable(event="propertyChange")]
    public function get maxColumnsInIndex() : int
    {
        return _internal_maxColumnsInIndex;
    }

    [Bindable(event="propertyChange")]
    public function get databaseMajorVersion() : int
    {
        return _internal_databaseMajorVersion;
    }

    [Bindable(event="propertyChange")]
    public function get maxColumnNameLength() : int
    {
        return _internal_maxColumnNameLength;
    }

    [Bindable(event="propertyChange")]
    public function get procedureTerm() : String
    {
        return _internal_procedureTerm;
    }

    [Bindable(event="propertyChange")]
    public function get catalogTerm() : String
    {
        return _internal_catalogTerm;
    }

    [Bindable(event="propertyChange")]
    public function get JDBCMinorVersion() : int
    {
        return _internal_JDBCMinorVersion;
    }

    [Bindable(event="propertyChange")]
    public function get JDBCMajorVersion() : int
    {
        return _internal_JDBCMajorVersion;
    }

    [Bindable(event="propertyChange")]
    public function get searchStringEscape() : String
    {
        return _internal_searchStringEscape;
    }

    [Bindable(event="propertyChange")]
    public function get databaseMinorVersion() : int
    {
        return _internal_databaseMinorVersion;
    }

    [Bindable(event="propertyChange")]
    public function get maxProcedureNameLength() : int
    {
        return _internal_maxProcedureNameLength;
    }

    [Bindable(event="propertyChange")]
    public function get maxTablesInSelect() : int
    {
        return _internal_maxTablesInSelect;
    }

    [Bindable(event="propertyChange")]
    public function get maxTableNameLength() : int
    {
        return _internal_maxTableNameLength;
    }

    [Bindable(event="propertyChange")]
    public function get driverMinorVersion() : int
    {
        return _internal_driverMinorVersion;
    }

    [Bindable(event="propertyChange")]
    public function get maxCharLiteralLength() : int
    {
        return _internal_maxCharLiteralLength;
    }

    [Bindable(event="propertyChange")]
    public function get maxIndexLength() : int
    {
        return _internal_maxIndexLength;
    }

    [Bindable(event="propertyChange")]
    public function get stringFunctions() : String
    {
        return _internal_stringFunctions;
    }

    [Bindable(event="propertyChange")]
    public function get maxColumnsInOrderBy() : int
    {
        return _internal_maxColumnsInOrderBy;
    }

    [Bindable(event="propertyChange")]
    public function get maxRowSize() : int
    {
        return _internal_maxRowSize;
    }

    [Bindable(event="propertyChange")]
    public function get URL() : String
    {
        return _internal_URL;
    }

    [Bindable(event="propertyChange")]
    public function get clientInfoProperties() : valueObjects.ResultSet
    {
        return _internal_clientInfoProperties;
    }

    [Bindable(event="propertyChange")]
    public function get maxStatementLength() : int
    {
        return _internal_maxStatementLength;
    }

    [Bindable(event="propertyChange")]
    public function get schemas() : valueObjects.ResultSet
    {
        return _internal_schemas;
    }

    [Bindable(event="propertyChange")]
    public function get maxConnections() : int
    {
        return _internal_maxConnections;
    }

    [Bindable(event="propertyChange")]
    public function get maxUserNameLength() : int
    {
        return _internal_maxUserNameLength;
    }

    [Bindable(event="propertyChange")]
    public function get rowIdLifetime() : String
    {
        return _internal_rowIdLifetime;
    }

    [Bindable(event="propertyChange")]
    public function get resultSetHoldability() : int
    {
        return _internal_resultSetHoldability;
    }

    [Bindable(event="propertyChange")]
    public function get schemaTerm() : String
    {
        return _internal_schemaTerm;
    }

    [Bindable(event="propertyChange")]
    public function get driverVersion() : String
    {
        return _internal_driverVersion;
    }

    [Bindable(event="propertyChange")]
    public function get maxSchemaNameLength() : int
    {
        return _internal_maxSchemaNameLength;
    }

    [Bindable(event="propertyChange")]
    public function get identifierQuoteString() : String
    {
        return _internal_identifierQuoteString;
    }

    [Bindable(event="propertyChange")]
    public function get maxColumnsInSelect() : int
    {
        return _internal_maxColumnsInSelect;
    }

    [Bindable(event="propertyChange")]
    public function get systemFunctions() : String
    {
        return _internal_systemFunctions;
    }

    [Bindable(event="propertyChange")]
    public function get maxColumnsInGroupBy() : int
    {
        return _internal_maxColumnsInGroupBy;
    }

    [Bindable(event="propertyChange")]
    public function get readOnly() : Boolean
    {
        return _internal_readOnly;
    }

    [Bindable(event="propertyChange")]
    public function get tableTypes() : valueObjects.ResultSet
    {
        return _internal_tableTypes;
    }

    [Bindable(event="propertyChange")]
    public function get numericFunctions() : String
    {
        return _internal_numericFunctions;
    }

    [Bindable(event="propertyChange")]
    public function get catalogs() : valueObjects.ResultSet
    {
        return _internal_catalogs;
    }

    [Bindable(event="propertyChange")]
    public function get maxColumnsInTable() : int
    {
        return _internal_maxColumnsInTable;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set databaseProductName(value:String) : void
    {
        var oldValue:String = _internal_databaseProductName;
        if (oldValue !== value)
        {
            _internal_databaseProductName = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "databaseProductName", oldValue, _internal_databaseProductName));
        }
    }

    public function set defaultTransactionIsolation(value:int) : void
    {
        var oldValue:int = _internal_defaultTransactionIsolation;
        if (oldValue !== value)
        {
            _internal_defaultTransactionIsolation = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "defaultTransactionIsolation", oldValue, _internal_defaultTransactionIsolation));
        }
    }

    public function set maxCursorNameLength(value:int) : void
    {
        var oldValue:int = _internal_maxCursorNameLength;
        if (oldValue !== value)
        {
            _internal_maxCursorNameLength = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxCursorNameLength", oldValue, _internal_maxCursorNameLength));
        }
    }

    public function set SQLStateType(value:int) : void
    {
        var oldValue:int = _internal_SQLStateType;
        if (oldValue !== value)
        {
            _internal_SQLStateType = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "SQLStateType", oldValue, _internal_SQLStateType));
        }
    }

    public function set typeInfo(value:valueObjects.ResultSet) : void
    {
        var oldValue:valueObjects.ResultSet = _internal_typeInfo;
        if (oldValue !== value)
        {
            _internal_typeInfo = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "typeInfo", oldValue, _internal_typeInfo));
        }
    }

    public function set maxStatements(value:int) : void
    {
        var oldValue:int = _internal_maxStatements;
        if (oldValue !== value)
        {
            _internal_maxStatements = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxStatements", oldValue, _internal_maxStatements));
        }
    }

    public function set userName(value:String) : void
    {
        var oldValue:String = _internal_userName;
        if (oldValue !== value)
        {
            _internal_userName = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "userName", oldValue, _internal_userName));
        }
    }

    public function set driverName(value:String) : void
    {
        var oldValue:String = _internal_driverName;
        if (oldValue !== value)
        {
            _internal_driverName = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "driverName", oldValue, _internal_driverName));
        }
    }

    public function set maxCatalogNameLength(value:int) : void
    {
        var oldValue:int = _internal_maxCatalogNameLength;
        if (oldValue !== value)
        {
            _internal_maxCatalogNameLength = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxCatalogNameLength", oldValue, _internal_maxCatalogNameLength));
        }
    }

    public function set catalogSeparator(value:String) : void
    {
        var oldValue:String = _internal_catalogSeparator;
        if (oldValue !== value)
        {
            _internal_catalogSeparator = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "catalogSeparator", oldValue, _internal_catalogSeparator));
        }
    }

    public function set catalogAtStart(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_catalogAtStart;
        if (oldValue !== value)
        {
            _internal_catalogAtStart = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "catalogAtStart", oldValue, _internal_catalogAtStart));
        }
    }

    public function set databaseProductVersion(value:String) : void
    {
        var oldValue:String = _internal_databaseProductVersion;
        if (oldValue !== value)
        {
            _internal_databaseProductVersion = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "databaseProductVersion", oldValue, _internal_databaseProductVersion));
        }
    }

    public function set driverMajorVersion(value:int) : void
    {
        var oldValue:int = _internal_driverMajorVersion;
        if (oldValue !== value)
        {
            _internal_driverMajorVersion = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "driverMajorVersion", oldValue, _internal_driverMajorVersion));
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

    public function set SQLKeywords(value:String) : void
    {
        var oldValue:String = _internal_SQLKeywords;
        if (oldValue !== value)
        {
            _internal_SQLKeywords = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "SQLKeywords", oldValue, _internal_SQLKeywords));
        }
    }

    public function set timeDateFunctions(value:String) : void
    {
        var oldValue:String = _internal_timeDateFunctions;
        if (oldValue !== value)
        {
            _internal_timeDateFunctions = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "timeDateFunctions", oldValue, _internal_timeDateFunctions));
        }
    }

    public function set maxBinaryLiteralLength(value:int) : void
    {
        var oldValue:int = _internal_maxBinaryLiteralLength;
        if (oldValue !== value)
        {
            _internal_maxBinaryLiteralLength = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxBinaryLiteralLength", oldValue, _internal_maxBinaryLiteralLength));
        }
    }

    public function set extraNameCharacters(value:String) : void
    {
        var oldValue:String = _internal_extraNameCharacters;
        if (oldValue !== value)
        {
            _internal_extraNameCharacters = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "extraNameCharacters", oldValue, _internal_extraNameCharacters));
        }
    }

    public function set maxColumnsInIndex(value:int) : void
    {
        var oldValue:int = _internal_maxColumnsInIndex;
        if (oldValue !== value)
        {
            _internal_maxColumnsInIndex = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxColumnsInIndex", oldValue, _internal_maxColumnsInIndex));
        }
    }

    public function set databaseMajorVersion(value:int) : void
    {
        var oldValue:int = _internal_databaseMajorVersion;
        if (oldValue !== value)
        {
            _internal_databaseMajorVersion = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "databaseMajorVersion", oldValue, _internal_databaseMajorVersion));
        }
    }

    public function set maxColumnNameLength(value:int) : void
    {
        var oldValue:int = _internal_maxColumnNameLength;
        if (oldValue !== value)
        {
            _internal_maxColumnNameLength = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxColumnNameLength", oldValue, _internal_maxColumnNameLength));
        }
    }

    public function set procedureTerm(value:String) : void
    {
        var oldValue:String = _internal_procedureTerm;
        if (oldValue !== value)
        {
            _internal_procedureTerm = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "procedureTerm", oldValue, _internal_procedureTerm));
        }
    }

    public function set catalogTerm(value:String) : void
    {
        var oldValue:String = _internal_catalogTerm;
        if (oldValue !== value)
        {
            _internal_catalogTerm = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "catalogTerm", oldValue, _internal_catalogTerm));
        }
    }

    public function set JDBCMinorVersion(value:int) : void
    {
        var oldValue:int = _internal_JDBCMinorVersion;
        if (oldValue !== value)
        {
            _internal_JDBCMinorVersion = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "JDBCMinorVersion", oldValue, _internal_JDBCMinorVersion));
        }
    }

    public function set JDBCMajorVersion(value:int) : void
    {
        var oldValue:int = _internal_JDBCMajorVersion;
        if (oldValue !== value)
        {
            _internal_JDBCMajorVersion = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "JDBCMajorVersion", oldValue, _internal_JDBCMajorVersion));
        }
    }

    public function set searchStringEscape(value:String) : void
    {
        var oldValue:String = _internal_searchStringEscape;
        if (oldValue !== value)
        {
            _internal_searchStringEscape = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "searchStringEscape", oldValue, _internal_searchStringEscape));
        }
    }

    public function set databaseMinorVersion(value:int) : void
    {
        var oldValue:int = _internal_databaseMinorVersion;
        if (oldValue !== value)
        {
            _internal_databaseMinorVersion = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "databaseMinorVersion", oldValue, _internal_databaseMinorVersion));
        }
    }

    public function set maxProcedureNameLength(value:int) : void
    {
        var oldValue:int = _internal_maxProcedureNameLength;
        if (oldValue !== value)
        {
            _internal_maxProcedureNameLength = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxProcedureNameLength", oldValue, _internal_maxProcedureNameLength));
        }
    }

    public function set maxTablesInSelect(value:int) : void
    {
        var oldValue:int = _internal_maxTablesInSelect;
        if (oldValue !== value)
        {
            _internal_maxTablesInSelect = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxTablesInSelect", oldValue, _internal_maxTablesInSelect));
        }
    }

    public function set maxTableNameLength(value:int) : void
    {
        var oldValue:int = _internal_maxTableNameLength;
        if (oldValue !== value)
        {
            _internal_maxTableNameLength = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxTableNameLength", oldValue, _internal_maxTableNameLength));
        }
    }

    public function set driverMinorVersion(value:int) : void
    {
        var oldValue:int = _internal_driverMinorVersion;
        if (oldValue !== value)
        {
            _internal_driverMinorVersion = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "driverMinorVersion", oldValue, _internal_driverMinorVersion));
        }
    }

    public function set maxCharLiteralLength(value:int) : void
    {
        var oldValue:int = _internal_maxCharLiteralLength;
        if (oldValue !== value)
        {
            _internal_maxCharLiteralLength = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxCharLiteralLength", oldValue, _internal_maxCharLiteralLength));
        }
    }

    public function set maxIndexLength(value:int) : void
    {
        var oldValue:int = _internal_maxIndexLength;
        if (oldValue !== value)
        {
            _internal_maxIndexLength = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxIndexLength", oldValue, _internal_maxIndexLength));
        }
    }

    public function set stringFunctions(value:String) : void
    {
        var oldValue:String = _internal_stringFunctions;
        if (oldValue !== value)
        {
            _internal_stringFunctions = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "stringFunctions", oldValue, _internal_stringFunctions));
        }
    }

    public function set maxColumnsInOrderBy(value:int) : void
    {
        var oldValue:int = _internal_maxColumnsInOrderBy;
        if (oldValue !== value)
        {
            _internal_maxColumnsInOrderBy = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxColumnsInOrderBy", oldValue, _internal_maxColumnsInOrderBy));
        }
    }

    public function set maxRowSize(value:int) : void
    {
        var oldValue:int = _internal_maxRowSize;
        if (oldValue !== value)
        {
            _internal_maxRowSize = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxRowSize", oldValue, _internal_maxRowSize));
        }
    }

    public function set URL(value:String) : void
    {
        var oldValue:String = _internal_URL;
        if (oldValue !== value)
        {
            _internal_URL = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "URL", oldValue, _internal_URL));
        }
    }

    public function set clientInfoProperties(value:valueObjects.ResultSet) : void
    {
        var oldValue:valueObjects.ResultSet = _internal_clientInfoProperties;
        if (oldValue !== value)
        {
            _internal_clientInfoProperties = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "clientInfoProperties", oldValue, _internal_clientInfoProperties));
        }
    }

    public function set maxStatementLength(value:int) : void
    {
        var oldValue:int = _internal_maxStatementLength;
        if (oldValue !== value)
        {
            _internal_maxStatementLength = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxStatementLength", oldValue, _internal_maxStatementLength));
        }
    }

    public function set schemas(value:valueObjects.ResultSet) : void
    {
        var oldValue:valueObjects.ResultSet = _internal_schemas;
        if (oldValue !== value)
        {
            _internal_schemas = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "schemas", oldValue, _internal_schemas));
        }
    }

    public function set maxConnections(value:int) : void
    {
        var oldValue:int = _internal_maxConnections;
        if (oldValue !== value)
        {
            _internal_maxConnections = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxConnections", oldValue, _internal_maxConnections));
        }
    }

    public function set maxUserNameLength(value:int) : void
    {
        var oldValue:int = _internal_maxUserNameLength;
        if (oldValue !== value)
        {
            _internal_maxUserNameLength = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxUserNameLength", oldValue, _internal_maxUserNameLength));
        }
    }

    public function set rowIdLifetime(value:String) : void
    {
        var oldValue:String = _internal_rowIdLifetime;
        if (oldValue !== value)
        {
            _internal_rowIdLifetime = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "rowIdLifetime", oldValue, _internal_rowIdLifetime));
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

    public function set schemaTerm(value:String) : void
    {
        var oldValue:String = _internal_schemaTerm;
        if (oldValue !== value)
        {
            _internal_schemaTerm = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "schemaTerm", oldValue, _internal_schemaTerm));
        }
    }

    public function set driverVersion(value:String) : void
    {
        var oldValue:String = _internal_driverVersion;
        if (oldValue !== value)
        {
            _internal_driverVersion = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "driverVersion", oldValue, _internal_driverVersion));
        }
    }

    public function set maxSchemaNameLength(value:int) : void
    {
        var oldValue:int = _internal_maxSchemaNameLength;
        if (oldValue !== value)
        {
            _internal_maxSchemaNameLength = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxSchemaNameLength", oldValue, _internal_maxSchemaNameLength));
        }
    }

    public function set identifierQuoteString(value:String) : void
    {
        var oldValue:String = _internal_identifierQuoteString;
        if (oldValue !== value)
        {
            _internal_identifierQuoteString = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "identifierQuoteString", oldValue, _internal_identifierQuoteString));
        }
    }

    public function set maxColumnsInSelect(value:int) : void
    {
        var oldValue:int = _internal_maxColumnsInSelect;
        if (oldValue !== value)
        {
            _internal_maxColumnsInSelect = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxColumnsInSelect", oldValue, _internal_maxColumnsInSelect));
        }
    }

    public function set systemFunctions(value:String) : void
    {
        var oldValue:String = _internal_systemFunctions;
        if (oldValue !== value)
        {
            _internal_systemFunctions = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "systemFunctions", oldValue, _internal_systemFunctions));
        }
    }

    public function set maxColumnsInGroupBy(value:int) : void
    {
        var oldValue:int = _internal_maxColumnsInGroupBy;
        if (oldValue !== value)
        {
            _internal_maxColumnsInGroupBy = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxColumnsInGroupBy", oldValue, _internal_maxColumnsInGroupBy));
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

    public function set tableTypes(value:valueObjects.ResultSet) : void
    {
        var oldValue:valueObjects.ResultSet = _internal_tableTypes;
        if (oldValue !== value)
        {
            _internal_tableTypes = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "tableTypes", oldValue, _internal_tableTypes));
        }
    }

    public function set numericFunctions(value:String) : void
    {
        var oldValue:String = _internal_numericFunctions;
        if (oldValue !== value)
        {
            _internal_numericFunctions = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "numericFunctions", oldValue, _internal_numericFunctions));
        }
    }

    public function set catalogs(value:valueObjects.ResultSet) : void
    {
        var oldValue:valueObjects.ResultSet = _internal_catalogs;
        if (oldValue !== value)
        {
            _internal_catalogs = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "catalogs", oldValue, _internal_catalogs));
        }
    }

    public function set maxColumnsInTable(value:int) : void
    {
        var oldValue:int = _internal_maxColumnsInTable;
        if (oldValue !== value)
        {
            _internal_maxColumnsInTable = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxColumnsInTable", oldValue, _internal_maxColumnsInTable));
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
    public function get _model() : _DatabaseMetaDataEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _DatabaseMetaDataEntityMetadata) : void
    {
        var oldValue : _DatabaseMetaDataEntityMetadata = model_internal::_dminternal_model;
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
