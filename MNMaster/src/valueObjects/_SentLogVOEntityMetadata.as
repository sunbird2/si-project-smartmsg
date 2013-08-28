
/**
 * This is a generated class and is not intended for modification.  
 */
package valueObjects
{
import com.adobe.fiber.styles.IStyle;
import com.adobe.fiber.styles.Style;
import com.adobe.fiber.valueobjects.AbstractEntityMetadata;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IModelType;
import mx.events.PropertyChangeEvent;

use namespace model_internal;

[ExcludeClass]
internal class _SentLogVOEntityMetadata extends com.adobe.fiber.valueobjects.AbstractEntityMetadata
{
    private static var emptyArray:Array = new Array();

    model_internal static var allProperties:Array = new Array("total", "ynDel", "idx", "cnt", "line", "timeSend", "mode", "user_ip", "message", "rownum", "timeWrite", "start", "user_id", "method", "timeDel", "end", "delType");
    model_internal static var allAssociationProperties:Array = new Array();
    model_internal static var allRequiredProperties:Array = new Array("rownum");
    model_internal static var allAlwaysAvailableProperties:Array = new Array("total", "ynDel", "idx", "cnt", "line", "timeSend", "mode", "user_ip", "message", "rownum", "timeWrite", "start", "user_id", "method", "timeDel", "end", "delType");
    model_internal static var guardedProperties:Array = new Array();
    model_internal static var dataProperties:Array = new Array("total", "ynDel", "idx", "cnt", "line", "timeSend", "mode", "user_ip", "message", "rownum", "timeWrite", "start", "user_id", "method", "timeDel", "end", "delType");
    model_internal static var sourceProperties:Array = emptyArray
    model_internal static var nonDerivedProperties:Array = new Array("total", "ynDel", "idx", "cnt", "line", "timeSend", "mode", "user_ip", "message", "rownum", "timeWrite", "start", "user_id", "method", "timeDel", "end", "delType");
    model_internal static var derivedProperties:Array = new Array();
    model_internal static var collectionProperties:Array = new Array();
    model_internal static var collectionBaseMap:Object;
    model_internal static var entityName:String = "SentLogVO";
    model_internal static var dependentsOnMap:Object;
    model_internal static var dependedOnServices:Array = new Array();
    model_internal static var propertyTypeMap:Object;


    model_internal var _instance:_Super_SentLogVO;
    model_internal static var _nullStyle:com.adobe.fiber.styles.Style = new com.adobe.fiber.styles.Style();

    public function _SentLogVOEntityMetadata(value : _Super_SentLogVO)
    {
        // initialize property maps
        if (model_internal::dependentsOnMap == null)
        {
            // dependents map
            model_internal::dependentsOnMap = new Object();
            model_internal::dependentsOnMap["total"] = new Array();
            model_internal::dependentsOnMap["ynDel"] = new Array();
            model_internal::dependentsOnMap["idx"] = new Array();
            model_internal::dependentsOnMap["cnt"] = new Array();
            model_internal::dependentsOnMap["line"] = new Array();
            model_internal::dependentsOnMap["timeSend"] = new Array();
            model_internal::dependentsOnMap["mode"] = new Array();
            model_internal::dependentsOnMap["user_ip"] = new Array();
            model_internal::dependentsOnMap["message"] = new Array();
            model_internal::dependentsOnMap["rownum"] = new Array();
            model_internal::dependentsOnMap["timeWrite"] = new Array();
            model_internal::dependentsOnMap["start"] = new Array();
            model_internal::dependentsOnMap["user_id"] = new Array();
            model_internal::dependentsOnMap["method"] = new Array();
            model_internal::dependentsOnMap["timeDel"] = new Array();
            model_internal::dependentsOnMap["end"] = new Array();
            model_internal::dependentsOnMap["delType"] = new Array();

            // collection base map
            model_internal::collectionBaseMap = new Object();
        }

        // Property type Map
        model_internal::propertyTypeMap = new Object();
        model_internal::propertyTypeMap["total"] = "int";
        model_internal::propertyTypeMap["ynDel"] = "String";
        model_internal::propertyTypeMap["idx"] = "int";
        model_internal::propertyTypeMap["cnt"] = "int";
        model_internal::propertyTypeMap["line"] = "String";
        model_internal::propertyTypeMap["timeSend"] = "String";
        model_internal::propertyTypeMap["mode"] = "String";
        model_internal::propertyTypeMap["user_ip"] = "String";
        model_internal::propertyTypeMap["message"] = "String";
        model_internal::propertyTypeMap["rownum"] = "int";
        model_internal::propertyTypeMap["timeWrite"] = "String";
        model_internal::propertyTypeMap["start"] = "int";
        model_internal::propertyTypeMap["user_id"] = "String";
        model_internal::propertyTypeMap["method"] = "String";
        model_internal::propertyTypeMap["timeDel"] = "String";
        model_internal::propertyTypeMap["end"] = "int";
        model_internal::propertyTypeMap["delType"] = "String";

        model_internal::_instance = value;
    }

    override public function getEntityName():String
    {
        return model_internal::entityName;
    }

    override public function getProperties():Array
    {
        return model_internal::allProperties;
    }

    override public function getAssociationProperties():Array
    {
        return model_internal::allAssociationProperties;
    }

    override public function getRequiredProperties():Array
    {
         return model_internal::allRequiredProperties;   
    }

    override public function getDataProperties():Array
    {
        return model_internal::dataProperties;
    }

    public function getSourceProperties():Array
    {
        return model_internal::sourceProperties;
    }

    public function getNonDerivedProperties():Array
    {
        return model_internal::nonDerivedProperties;
    }

    override public function getGuardedProperties():Array
    {
        return model_internal::guardedProperties;
    }

    override public function getUnguardedProperties():Array
    {
        return model_internal::allAlwaysAvailableProperties;
    }

    override public function getDependants(propertyName:String):Array
    {
       if (model_internal::nonDerivedProperties.indexOf(propertyName) == -1)
            throw new Error(propertyName + " is not a data property of entity SentLogVO");
            
       return model_internal::dependentsOnMap[propertyName] as Array;  
    }

    override public function getDependedOnServices():Array
    {
        return model_internal::dependedOnServices;
    }

    override public function getCollectionProperties():Array
    {
        return model_internal::collectionProperties;
    }

    override public function getCollectionBase(propertyName:String):String
    {
        if (model_internal::collectionProperties.indexOf(propertyName) == -1)
            throw new Error(propertyName + " is not a collection property of entity SentLogVO");

        return model_internal::collectionBaseMap[propertyName];
    }
    
    override public function getPropertyType(propertyName:String):String
    {
        if (model_internal::allProperties.indexOf(propertyName) == -1)
            throw new Error(propertyName + " is not a property of SentLogVO");

        return model_internal::propertyTypeMap[propertyName];
    }

    override public function getAvailableProperties():com.adobe.fiber.valueobjects.IPropertyIterator
    {
        return new com.adobe.fiber.valueobjects.AvailablePropertyIterator(this);
    }

    override public function getValue(propertyName:String):*
    {
        if (model_internal::allProperties.indexOf(propertyName) == -1)
        {
            throw new Error(propertyName + " does not exist for entity SentLogVO");
        }

        return model_internal::_instance[propertyName];
    }

    override public function setValue(propertyName:String, value:*):void
    {
        if (model_internal::nonDerivedProperties.indexOf(propertyName) == -1)
        {
            throw new Error(propertyName + " is not a modifiable property of entity SentLogVO");
        }

        model_internal::_instance[propertyName] = value;
    }

    override public function getMappedByProperty(associationProperty:String):String
    {
        switch(associationProperty)
        {
            default:
            {
                return null;
            }
        }
    }

    override public function getPropertyLength(propertyName:String):int
    {
        switch(propertyName)
        {
            default:
            {
                return 0;
            }
        }
    }

    override public function isAvailable(propertyName:String):Boolean
    {
        if (model_internal::allProperties.indexOf(propertyName) == -1)
        {
            throw new Error(propertyName + " does not exist for entity SentLogVO");
        }

        if (model_internal::allAlwaysAvailableProperties.indexOf(propertyName) != -1)
        {
            return true;
        }

        switch(propertyName)
        {
            default:
            {
                return true;
            }
        }
    }

    override public function getIdentityMap():Object
    {
        var returnMap:Object = new Object();
        returnMap["rownum"] = model_internal::_instance.rownum;

        return returnMap;
    }

    [Bindable(event="propertyChange")]
    override public function get invalidConstraints():Array
    {
        if (model_internal::_instance.model_internal::_cacheInitialized_isValid)
        {
            return model_internal::_instance.model_internal::_invalidConstraints;
        }
        else
        {
            // recalculate isValid
            model_internal::_instance.model_internal::_isValid = model_internal::_instance.model_internal::calculateIsValid();
            return model_internal::_instance.model_internal::_invalidConstraints;        
        }
    }

    [Bindable(event="propertyChange")]
    override public function get validationFailureMessages():Array
    {
        if (model_internal::_instance.model_internal::_cacheInitialized_isValid)
        {
            return model_internal::_instance.model_internal::_validationFailureMessages;
        }
        else
        {
            // recalculate isValid
            model_internal::_instance.model_internal::_isValid = model_internal::_instance.model_internal::calculateIsValid();
            return model_internal::_instance.model_internal::_validationFailureMessages;
        }
    }

    override public function getDependantInvalidConstraints(propertyName:String):Array
    {
        var dependants:Array = getDependants(propertyName);
        if (dependants.length == 0)
        {
            return emptyArray;
        }

        var currentlyInvalid:Array = invalidConstraints;
        if (currentlyInvalid.length == 0)
        {
            return emptyArray;
        }

        var filterFunc:Function = function(element:*, index:int, arr:Array):Boolean
        {
            return dependants.indexOf(element) > -1;
        }

        return currentlyInvalid.filter(filterFunc);
    }

    /**
     * isValid
     */
    [Bindable(event="propertyChange")] 
    public function get isValid() : Boolean
    {
        if (model_internal::_instance.model_internal::_cacheInitialized_isValid)
        {
            return model_internal::_instance.model_internal::_isValid;
        }
        else
        {
            // recalculate isValid
            model_internal::_instance.model_internal::_isValid = model_internal::_instance.model_internal::calculateIsValid();
            return model_internal::_instance.model_internal::_isValid;
        }
    }

    [Bindable(event="propertyChange")]
    public function get isTotalAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isYnDelAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isIdxAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isCntAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isLineAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isTimeSendAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isModeAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isUser_ipAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isMessageAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isRownumAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isTimeWriteAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isStartAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isUser_idAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isMethodAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isTimeDelAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isEndAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isDelTypeAvailable():Boolean
    {
        return true;
    }


    /**
     * derived property recalculation
     */

    model_internal function fireChangeEvent(propertyName:String, oldValue:Object, newValue:Object):void
    {
        this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, propertyName, oldValue, newValue));
    }

    [Bindable(event="propertyChange")]   
    public function get totalStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get ynDelStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get idxStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get cntStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get lineStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get timeSendStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get modeStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get user_ipStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get messageStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get rownumStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get timeWriteStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get startStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get user_idStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get methodStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get timeDelStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get endStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get delTypeStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }


     /**
     * 
     * @inheritDoc 
     */ 
     override public function getStyle(propertyName:String):com.adobe.fiber.styles.IStyle
     {
         switch(propertyName)
         {
            default:
            {
                return null;
            }
         }
     }
     
     /**
     * 
     * @inheritDoc 
     *  
     */  
     override public function getPropertyValidationFailureMessages(propertyName:String):Array
     {
         switch(propertyName)
         {
            default:
            {
                return emptyArray;
            }
         }
     }

}

}
