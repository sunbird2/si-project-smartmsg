/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this service wrapper you may modify the generated sub-class of this class - Mst.as.
 */
package services
{
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.services.wrapper.RemoteObjectServiceWrapper;
import com.adobe.fiber.valueobjects.IValueObject;
import com.adobe.serializers.utility.TypeUtility;
import mx.collections.ListCollectionView;
import mx.data.DataManager;
import mx.data.IManaged;
import mx.data.ManagedAssociation;
import mx.data.ManagedOperation;
import mx.data.ManagedQuery;
import mx.data.RPCDataManager;
import mx.data.errors.DataServiceError;
import mx.rpc.AbstractOperation;
import mx.rpc.AsyncToken;
import mx.rpc.remoting.Operation;
import mx.rpc.remoting.RemoteObject;
import valueObjects.BooleanAndDescriptionVO;
import valueObjects.MemberVO;
import valueObjects.SentLogVO;
import valueObjects.StatusVO;

import mx.collections.ItemResponder;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

[ExcludeClass]
internal class _Super_Mst extends com.adobe.fiber.services.wrapper.RemoteObjectServiceWrapper
{
    private var _memberVORPCDataManager : mx.data.RPCDataManager;
    private var _sentLogVORPCDataManager : mx.data.RPCDataManager;
    private var managersArray : Array = new Array();

    public const DATA_MANAGER_MEMBERVO : String = "MemberVO";
    public const DATA_MANAGER_SENTLOGVO : String = "SentLogVO";

    public function getDataManager(dataManagerName:String) : mx.data.RPCDataManager
    {
        switch (dataManagerName)
        {
             case (DATA_MANAGER_MEMBERVO):
                return _memberVORPCDataManager;
             case (DATA_MANAGER_SENTLOGVO):
                return _sentLogVORPCDataManager;
            default:
                return null;
        }
    }

    /**
     * Commit all of the pending changes for this DataService, as well as all of the pending changes of all DataServices
     * sharing the same DataStore.  By default, a DataService shares the same DataStore with other DataServices if they have 
     * managed association properties and share the same set of channels. 
     *
     * @see mx.data.DataManager
     * @see mx.data.DataStore
     *
     * @param itemsOrCollections:Array This is an optional parameter which defaults to null when
     *  you want to commit all pending changes.  If you want to commit a subset of the pending
     *  changes use this argument to specify a list of managed ListCollectionView instances
     *  and/or managed items.  ListCollectionView objects are most typically ArrayCollections
     *  you have provided to your fill method.  The items appropriate for this method are
     *  any managed version of the item.  These are any items you retrieve from getItem, createItem
     *  or using the getItemAt method from a managed collection.  Only changes for the
     *  items defined by any of the values in this array will be committed.
     *
     * @param cascadeCommit if true, also commit changes made to any associated
     *  items supplied in this list.
     *
     *  @return AsyncToken that is returned in <code>call</code> property of
     *  either the <code>ResultEvent.RESULT</code> or in the
     *  <code>FaultEvent.FAULT</code>.
     *  Custom data can be attached to this object and inspected later
     *  during the event handling phase.  If no changes have been made
     *  to the relevant items, null is returned instead of an AsyncToken.
     */
    public function commit(itemsOrCollections:Array=null, cascadeCommit:Boolean=false):mx.rpc.AsyncToken
    {
        return _memberVORPCDataManager.dataStore.commit(itemsOrCollections, cascadeCommit);
    }

    /**
     * Reverts all pending (uncommitted) changes for this DataService, as well as all of the pending changes of all DataServics
     * sharing the same DataStore.  By default, a DataService shares the same DataStore with other DataServices if they have 
     * managed association properties and share the same set of channels. 
     *
     * In case you specify a value for itemsOrCollections:Array parameter, only pending (uncommitted) changes for the specified 
     * managed items or collections will be reverted.
     *
     * @see mx.data.DataManager
     * @see mx.data.DataStore
     * 
     * @param itemsOrCollections:Array This is an optional parameter which defaults to null 
     * when you want to revert all pending (uncommitted) changes for all DataServices
     * managed by this DataStore. If you want to revert a subset of the pending changes use 
     * this argument to specify a array of managed items or collections
     *
     * @return true if any changes were reverted.
     * @throws DataServiceError if the passed in array contains non-managed items or collections
     *  
     */
    public function revertChanges(itemsOrCollections:Array=null):Boolean
    {
        if (itemsOrCollections == null)
        {
            // Revert all changes
            return _memberVORPCDataManager.dataStore.revertChanges();
        }
        else
        {
            // Revert passed in items
            var anyChangeItemReverted:Boolean = false;

            // Iterate over array and revert managed item or collection as the case may be
            for each (var changeItem:Object in itemsOrCollections)
            {
                if (changeItem is com.adobe.fiber.valueobjects.IValueObject)
                {
                    var dataMgr:mx.data.DataManager = getDataManager(changeItem._model.getEntityName());
                    anyChangeItemReverted ||= dataMgr.revertChanges(mx.data.IManaged(changeItem))
                }
                else if (changeItem is mx.collections.ListCollectionView)
                {
                    anyChangeItemReverted ||= _memberVORPCDataManager.dataStore.revertChangesForCollection(mx.collections.ListCollectionView(changeItem));
                }
                else
                {
                    throw new mx.data.errors.DataServiceError("revertChanges called on array that contains non-managed items or collections");
                }
            }
            return anyChangeItemReverted;
        }
    }

    // Constructor
    public function _Super_Mst()
    {
        // initialize service control
        _serviceControl = new mx.rpc.remoting.RemoteObject();

        // initialize RemoteClass alias for all entities returned by functions of this service
        valueObjects.MemberVO._initRemoteClassAlias();
        valueObjects.SentLogVO._initRemoteClassAlias();
        valueObjects.StatusVO._initRemoteClassAlias();

        var operations:Object = new Object();
        var operation:mx.rpc.remoting.Operation;

        operation = new mx.rpc.remoting.Operation(null, "getMember_countFiltered");
         operation.resultType = int;
        operations["getMember_countFiltered"] = operation;
        operation = new mx.rpc.remoting.Operation(null, "getMember_pagedFiltered");
         operation.resultElementType = valueObjects.MemberVO;
        operations["getMember_pagedFiltered"] = operation;
        operation = new mx.rpc.remoting.Operation(null, "getSentlog_countFiltered");
         operation.resultType = int;
        operations["getSentlog_countFiltered"] = operation;
        operation = new mx.rpc.remoting.Operation(null, "getSentlog_pagedFiltered");
         operation.resultElementType = valueObjects.SentLogVO;
        operations["getSentlog_pagedFiltered"] = operation;
        operation = new mx.rpc.remoting.Operation(null, "getStatus_day");
         operation.resultElementType = valueObjects.StatusVO;
        operations["getStatus_day"] = operation;
        operation = new mx.rpc.remoting.Operation(null, "getStatus_month");
         operation.resultElementType = valueObjects.StatusVO;
        operations["getStatus_month"] = operation;
        operation = new mx.rpc.remoting.Operation(null, "login");
         operation.resultType = valueObjects.BooleanAndDescriptionVO;
        operations["login"] = operation;
        operation = new mx.rpc.remoting.Operation(null, "setCharge");
         operation.resultType = valueObjects.BooleanAndDescriptionVO;
        operations["setCharge"] = operation;
        operation = new mx.rpc.remoting.Operation(null, "setChargeAuto");
         operation.resultType = valueObjects.BooleanAndDescriptionVO;
        operations["setChargeAuto"] = operation;
        operation = new mx.rpc.remoting.Operation(null, "setMember");
         operation.resultType = valueObjects.BooleanAndDescriptionVO;
        operations["setMember"] = operation;
        operation = new mx.rpc.remoting.Operation(null, "setMemberStop");
         operation.resultType = valueObjects.BooleanAndDescriptionVO;
        operations["setMemberStop"] = operation;
        operation = new mx.rpc.remoting.Operation(null, "setStopSend");
         operation.resultType = valueObjects.BooleanAndDescriptionVO;
        operations["setStopSend"] = operation;

        _serviceControl.operations = operations;
        _serviceControl.convertResultHandler = com.adobe.serializers.utility.TypeUtility.convertResultHandler;
        _serviceControl.endpoint = "http://www.munjanote.com:7837//messagebroker/amf";
        var managedAssociation : mx.data.ManagedAssociation;
        var managedAssocsArray : Array;
        // initialize MemberVO data manager
        _memberVORPCDataManager = new mx.data.RPCDataManager();
        managersArray.push(_memberVORPCDataManager);

        managedAssocsArray = new Array();

        _memberVORPCDataManager.destination = "memberVORPCDataManager";
        _memberVORPCDataManager.service = _serviceControl;        
        _memberVORPCDataManager.identities =  "rownum";      
        _memberVORPCDataManager.itemClass = valueObjects.MemberVO; 


        // initialize SentLogVO data manager
        _sentLogVORPCDataManager = new mx.data.RPCDataManager();
        managersArray.push(_sentLogVORPCDataManager);

        managedAssocsArray = new Array();

        _sentLogVORPCDataManager.destination = "sentLogVORPCDataManager";
        _sentLogVORPCDataManager.service = _serviceControl;        
        _sentLogVORPCDataManager.identities =  "rownum";      
        _sentLogVORPCDataManager.itemClass = valueObjects.SentLogVO; 



        var dmOperation : mx.data.ManagedOperation;
        var dmQuery : mx.data.ManagedQuery;

        dmQuery = new mx.data.ManagedQuery("getMember_pagedFiltered");
        dmQuery.propertySpecifier = "total,passwd,hp,idx,memo,unit_cost,timeJoin,line,leaveYN,rownum,point,start,user_id,timeLogin,end";
        dmQuery.countOperation = "getMember_countFiltered";
        dmQuery.pagingEnabled = true;
        dmQuery.positionalPagingParameters = true;
        dmQuery.pageSize = 20;
        dmQuery.parameters = "arg0,arg1,arg2,arg3";
        _memberVORPCDataManager.addManagedOperation(dmQuery);

        dmQuery = new mx.data.ManagedQuery("getSentlog_pagedFiltered");
        dmQuery.propertySpecifier = "total,ynDel,idx,cnt,line,timeSend,mode,user_ip,message,rownum,timeWrite,start,user_id,method,timeDel,end,delType";
        dmQuery.countOperation = "getSentlog_countFiltered";
        dmQuery.pagingEnabled = true;
        dmQuery.positionalPagingParameters = true;
        dmQuery.pageSize = 20;
        dmQuery.parameters = "arg0,arg1,arg2";
        _sentLogVORPCDataManager.addManagedOperation(dmQuery);

        _serviceControl.managers = managersArray;

         preInitializeService();
         model_internal::initialize();
    }
    
    //init initialization routine here, child class to override
    protected function preInitializeService():void
    {
        destination = "mst";
      
    }
    

    /**
      * This method is a generated wrapper used to call the 'getMember_countFiltered' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function getMember_countFiltered(arg0:String, arg1:String) : mx.rpc.AsyncToken
    {
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getMember_countFiltered");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(arg0,arg1) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'getMember_pagedFiltered' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function getMember_pagedFiltered(arg0:String, arg1:String) : mx.rpc.AsyncToken
    {
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getMember_pagedFiltered");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(arg0,arg1) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'getSentlog_countFiltered' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function getSentlog_countFiltered(arg0:String) : mx.rpc.AsyncToken
    {
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getSentlog_countFiltered");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(arg0) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'getSentlog_pagedFiltered' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function getSentlog_pagedFiltered(arg0:String) : mx.rpc.AsyncToken
    {
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getSentlog_pagedFiltered");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(arg0) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'getStatus_day' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function getStatus_day(arg0:String) : mx.rpc.AsyncToken
    {
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getStatus_day");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(arg0) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'getStatus_month' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function getStatus_month(arg0:String) : mx.rpc.AsyncToken
    {
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("getStatus_month");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(arg0) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'login' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function login(arg0:String, arg1:String) : mx.rpc.AsyncToken
    {
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("login");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(arg0,arg1) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'setCharge' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function setCharge(arg0:String, arg1:int, arg2:int) : mx.rpc.AsyncToken
    {
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("setCharge");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(arg0,arg1,arg2) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'setChargeAuto' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function setChargeAuto(arg0:String, arg1:int) : mx.rpc.AsyncToken
    {
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("setChargeAuto");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(arg0,arg1) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'setMember' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function setMember(arg0:valueObjects.MemberVO) : mx.rpc.AsyncToken
    {
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("setMember");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(arg0) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'setMemberStop' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function setMemberStop(arg0:valueObjects.MemberVO) : mx.rpc.AsyncToken
    {
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("setMemberStop");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(arg0) ;
        return _internal_token;
    }
     
    /**
      * This method is a generated wrapper used to call the 'setStopSend' operation. It returns an mx.rpc.AsyncToken whose 
      * result property will be populated with the result of the operation when the server response is received. 
      * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
      * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
      */
    public function setStopSend() : mx.rpc.AsyncToken
    {
        var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("setStopSend");
		var _internal_token:mx.rpc.AsyncToken = _internal_operation.send() ;
        return _internal_token;
    }
     
}

}
